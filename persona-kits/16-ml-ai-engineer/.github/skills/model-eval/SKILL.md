---
name: Model Evaluation
description: "Use when evaluating an ML model, choosing metrics, designing offline/online tests, or checking fairness. Triggers on 'evaluate model', 'model metrics', 'A/B test model', 'fairness', 'holdout', 'confusion matrix'."
---

# Model Evaluation

## When to invoke
- "Is this model ready for production?"
- "Which metric should we optimize?"
- "Design an A/B test for the new model."
- "Check this model for bias."

## Metric selection by task
| Task | Primary metric | Watch also |
|------|----------------|------------|
| Binary classification (balanced) | ROC-AUC | Precision@K, recall |
| Binary (imbalanced) | PR-AUC, F1 | Recall at fixed precision |
| Multi-class | Macro-F1 | Per-class recall, confusion matrix |
| Regression | RMSE or MAE | Calibration, residual plots |
| Ranking / recsys | NDCG, MAP | Coverage, diversity, CTR lift |
| LLM / generative | Task-specific eval (exact match, BLEU, LLM-as-judge) | Hallucination rate, latency, cost |

Accuracy alone is almost never the right metric.

## Offline evaluation
1. **Holdout** must be **temporal** for any time-series or user-behavior model - random splits leak.
2. **Evaluate slices**, not only global: by segment (geo, device, cohort), by freshness (new vs returning users), by class.
3. **Compare to a baseline**: heuristic, previous model, or trivial predictor. "Better than nothing" is not sufficient.
4. **Calibration**: predicted probabilities should match observed rates. Plot a reliability diagram.
5. **Fairness / bias**: compute primary metric per protected group. Document gaps. Decide acceptable threshold before launch.

## Online evaluation
- **Shadow** first - score live traffic without affecting decisions, compare distributions.
- **A/B test** with pre-registered hypothesis, minimum detectable effect, and duration calculated from power analysis.
- **Guardrail metrics** (latency, error rate, revenue, abuse) must not regress even if the primary metric improves.
- **Ramp** 1% → 10% → 50% → 100%, with automated rollback on guardrail breach.

## Anti-patterns
- Tuning hyperparameters on the test set.
- Reporting only the headline number.
- Deploying without a rollback plan.
- "The model is 95% accurate" when base rate is 97%.

## References
- [Google - Rules of Machine Learning](https://developers.google.com/machine-learning/guides/rules-of-ml)
- [Chip Huyen - Designing Machine Learning Systems](https://www.oreilly.com/library/view/designing-machine-learning/9781098107956/)
- [Fairlearn](https://fairlearn.org/)
