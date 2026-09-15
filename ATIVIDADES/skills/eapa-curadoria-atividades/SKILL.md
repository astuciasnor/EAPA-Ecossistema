---
name: eapa-curadoria-atividades
description: "Curate a newly obtained external dataset and turn it into an EAPA learning activity, including provenance, data preparation, and its relationship to EAPADados. Use when a dataset is added for ANOVA, regression, or another EAPA analysis; do not use for ordinary statistical analysis alone."
---

# Curadoria de atividades EAPA

Transform a real external dataset into a reproducible teaching activity without
losing its source, license, or scientific meaning. The activity assesses the
complete cycle: import → prepare → analyze → interpret → report.

For the human-operated search, start with
[GUIA_RAPIDO_BUSCA.md](GUIA_RAPIDO_BUSCA.md). It contains the few prompts and
clicks needed to find a candidate using any AI with web access.

## Where the material lives

`ATIVIDADES/` is the accessible home of the assessment pillar. New or
unapproved material lives in `ATIVIDADES/provisorios/<id>/`; student-facing
files live in `ATIVIDADES/dados/` only after approval. Never overwrite or
silently alter the downloaded original.

Read [the record and folder guide](references/registro-e-estrutura.md) before
creating files, moving a candidate to `dados/`, or registering it.

## Workflow

1. **Inventory before changing.** Identify files, sheets, headers, row counts,
   duplicate presentation areas, calculated summaries, encoding problems,
   missing values, and the plausible unit represented by a row. Keep the
   original intact. A messy workbook is evidence, not a failure.
2. **Establish provenance.** Record the source page, DOI or stable link,
   access date, license, organism/context, study design, unit observational,
   and intended teaching use. If any of those are unknown, mark the candidate
   pending and do not release it as an activity or package dataset.
3. **Check analytical fit.** Design the activity around the study question and
   observational unit, not around a desired p-value. For one-factor ANOVA,
   require a numeric response, a categorical factor with at least three levels,
   real independent experimental units, and replication. For simple linear
   regression, require two numeric variables measured on the same independent
   unit, adequate spread in the predictor, and a scientifically interpretable
   relationship. Flag pseudoreplication, aggregation, repeated measures,
   transformations, and causal limits explicitly.
4. **Prepare two deliberate layers.** Keep a reproducible clean analytic
   version for validation. Separately decide what the student must genuinely
   import and prepare. The activity file may require meaningful tidying, but it
   must not contain irrelevant dashboards, duplicate reports, hidden derived
   results, or errors that make the task ambiguous.
5. **Create the learning activity only after approval.** Use
   `ATIVIDADES/_MOLDE_atividade.md`; state the data source, question,
   hypotheses, expected preparation, assumptions, requested outputs, scientific
   limitations, and rubric. Update the activity index and the matrix that maps
   analysis, EAPADados, and external file.
6. **Decide the EAPADados relationship explicitly.** A formal assessment
   activity uses a real external dataset distinct from the guided package/book
   example. A same-source package copy is allowed only when explicitly chosen
   for technical validation; label it as such rather than treating it as the
   assessed activity.

## Boundaries

- Do not infer a license, organism, unit, treatment meaning, or study design
  from a filename or a chart.
- Do not redistribute material from a commercial book or an unclear source.
- A license covers the deposited work, not a stray copy. When a licensed deposit is
  the source of record, the same dataset may still be downloaded from an unlicensed
  mirror (for example the authors' own GitHub repository) to inspect it or to build
  from it, provided that (a) the provenance record cites the licensed deposit,
  (b) the distributed file comes from that deposit — or from the mirror only after
  the two are verified identical (checksum or line-by-line) — and (c) the mirror is
  never presented as if it were itself licensed.
- Do not turn treatment-level means into independent observations.
- Do not add a dataset to EAPADados, `ATIVIDADES/dados/`, or a public handout
  while its provenance or analytical unit is unresolved.
- Preserve original field names in the provenance record; use clear Portuguese
  names only in a documented clean or student-facing version.

## Excel versions

Name the candidate folder with the analysis followed by its scientific context.
For example, use `anova_tilapia_anestesia` or
`regressao_tilapia_crescimento`. This keeps the user's search, review, and
selection workflow easy to recognize; document other possible analyses inside
`curadoria.md`.

Use four unambiguous pieces:

1. Keep the downloaded filename unchanged inside
   `ATIVIDADES/provisorios/<id>/`.
2. Keep `origem.md` as the single source of truth for link, DOI, license,
   observational unit, and decision.
3. Keep `curadoria.md` for the data dictionary, checks, transformations,
   limitations, and rationale. Do not leave essential metadata only in a vague
   `instrucoes_*.txt` file.
4. Create `<id>_revisao.xlsx` in `provisorios/` for a clean, author-reviewed
   analytic version. After approval, create `ATIVIDADES/dados/<id>.xlsx` for
   the student and name the handout `atividade_<analise>_<id>.md`.

For a human-operated web search, the chosen candidate may arrive with three
AI-assisted companions: `origem.md`, `curadoria.md`, and
`<id>_revisao.xlsx`. The downloaded original remains a fourth, immutable piece.
The AI may draft these companions only from the verified source; it must never
invent observations or turn summaries into raw replicates. The final student
workbook still requires the author review described above.

The review file can be fully clean. The student file should retain only the
preparation that is pedagogically meaningful and clearly requested in the
handout; do not leave accidental dashboards, duplicate summaries, or broken
encoding merely to make it look difficult. Never call a file “final” before the
source, license, analytical variables, and student task have been confirmed.
