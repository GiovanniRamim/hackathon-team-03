---
name: RAG Design
description: "Use when building a retrieval-augmented generation system, choosing a chunking strategy, or evaluating retrieval quality. Triggers on 'RAG', 'retrieval-augmented', 'vector search', 'chunking', 'embeddings', 'hallucination'."
---

# RAG Design

## When to invoke
- "Design a RAG pipeline for our docs."
- "Which chunk size should we use?"
- "How do we evaluate retrieval quality?"
- "Reduce hallucinations in our assistant."

## Architecture checklist
1. **Source of truth** - which documents, who owns them, how often they change, access control requirements.
2. **Ingestion** - parse (PDF, HTML, Office), normalize, strip boilerplate, preserve section structure.
3. **Chunking** - semantic boundaries (headings, paragraphs) beat fixed-size. Typical: 300–800 tokens with 10–15% overlap. Store chunk metadata (source URL, section, updated_at).
4. **Embedding** - pick a model evaluated on your domain (MTEB leaderboard ≠ your data). Re-embed when you change the model.
5. **Index** - hybrid (BM25 + vector) beats vector-only on most enterprise corpora. Re-rank top-K with a cross-encoder.
6. **Retrieval** - query rewriting / HyDE for short user queries; metadata filters for access control.
7. **Generation** - cite sources in the response; refuse when retrieval confidence is low.
8. **Eval harness** - golden Q&A set maintained in version control.

## Evaluation dimensions
- **Retrieval** - recall@K, MRR against a labeled set. Fix retrieval before tuning the LLM.
- **Answer faithfulness** - does the answer only use retrieved context? (LLM-as-judge or NLI model)
- **Answer relevance** - does it answer the actual question?
- **Citation accuracy** - do the cited chunks actually support each claim?
- **Refusal rate** - does it say "I don't know" when it should?

Ragas and TruLens both implement these out of the box.

## Hallucination mitigation (ranked by impact)
1. Improve retrieval - most hallucinations are retrieval failures dressed up as generation failures.
2. Prompt the model to answer *only* from context and quote verbatim when possible.
3. Require inline citations; post-validate that citations resolve.
4. Add a refusal path with a confidence threshold.
5. Re-rank with a cross-encoder before passing to the LLM.

## Anti-patterns
- Vector-only retrieval on domains full of acronyms and exact names.
- Chunks that split sentences mid-thought.
- Evaluating only the final answer - you'll blame the LLM for bad retrieval.
- No access control on retrieval - the model will leak documents a user shouldn't see.

## References
- [Anthropic - Contextual Retrieval](https://www.anthropic.com/news/contextual-retrieval)
- [Ragas - RAG evaluation](https://docs.ragas.io/)
- [Pinecone - RAG evaluation guide](https://www.pinecone.io/learn/series/vector-databases-in-production-for-busy-engineers/rag-evaluation/)
- [MTEB leaderboard](https://huggingface.co/spaces/mteb/leaderboard)
