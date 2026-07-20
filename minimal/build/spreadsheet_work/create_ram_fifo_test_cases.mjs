import fs from "node:fs/promises";
import path from "node:path";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const outputDir = path.resolve("integration");
await fs.mkdir(outputDir, { recursive: true });

const workbook = Workbook.create();
const tests = workbook.worksheets.add("Test Cases");
const insights = workbook.worksheets.add("Behavior Insights");

const navy = "#002060";
const blue = "#D9E1F2";
const green = "#CCFFCC";
const gray = "#F3F3F3";
const border = "#C7CFDC";

// Test case matrix.
tests.showGridLines = false;
tests.getRange("A1:H1").merge();
tests.getRange("A1").values = [["RAM + FIFO Basic Test Cases"]];
tests.getRange("A1:H1").format = {
  fill: navy,
  font: { bold: true, color: "#FFFFFF", size: 18 },
  horizontalAlignment: "center",
  verticalAlignment: "center",
};
tests.getRange("A1:H1").format.rowHeight = 34;

tests.getRange("A2:H2").values = [[
  "Total", 14, "Passed", 14, "Failed", 0, "Coverage", 1,
]];
tests.getRange("B2").formulas = [["=COUNTA(A6:A19)"]];
tests.getRange("D2").formulas = [["=COUNTIF(G6:G19,\"PASS\")"]];
tests.getRange("F2").formulas = [["=COUNTIF(G6:G19,\"FAIL\")"]];
tests.getRange("H2").formulas = [["=IFERROR(D2/B2,0)"]];
tests.getRange("H2").format.numberFormat = "0%";
tests.getRange("A2:H2").format = {
  fill: blue,
  font: { bold: true, color: navy },
  horizontalAlignment: "center",
};

tests.getRange("A4:H4").merge();
tests.getRange("A4").values = [[
  "Verified on 2026-07-20 | DW=8, AW=4, DEPTH=16 | Icarus Verilog",
]];
tests.getRange("A4:H4").format = {
  fill: gray,
  font: { italic: true, color: "#404040" },
  horizontalAlignment: "center",
};

tests.getRange("A5:H5").values = [[
  "Test ID", "Level", "Behavior", "Simple Stimulus",
  "Expected Result", "Trace", "Result", "Main Insight",
]];

const rows = [
  ["TC-RAM-01", "RAM", "Read/write every address", "Write 0xA0..0xAF to addresses 0..15, then read all.", "Each address returns its written value after a rising edge.", "individual/ram/tb_sync_ram.v:38", "PASS", "RAM read is synchronous."],
  ["TC-RAM-02", "RAM", "Write enable", "Apply 0xFF to address 5 while we=0.", "Address 5 keeps 0xA5.", "individual/ram/tb_sync_ram.v:62", "PASS", "Data changes only when we=1."],

  ["TC-FIFO-01", "FIFO", "Reset flags", "Hold rst=1 for two clock edges.", "empty=1 and full=0.", "individual/fifo/tb_sync_fifo.v:54", "PASS", "FIFO begins empty."],
  ["TC-FIFO-02", "FIFO", "Full boundary", "Write exactly 16 words.", "full becomes 1 after the 16th write.", "individual/fifo/tb_sync_fifo.v:63", "PASS", "Depth is 2^AW."],
  ["TC-FIFO-03", "FIFO", "Overflow protection", "Try one extra write while full.", "Extra data is blocked and full stays 1.", "individual/fifo/tb_sync_fifo.v:70", "PASS", "Full protects existing data."],
  ["TC-FIFO-04", "FIFO", "Order and empty", "Read all 16 words.", "Words leave in order; empty becomes 1.", "individual/fifo/tb_sync_fifo.v:86", "PASS", "First in means first out."],
  ["TC-FIFO-05", "FIFO", "Underflow protection", "Try one read while empty.", "Read is blocked and empty stays 1.", "individual/fifo/tb_sync_fifo.v:106", "PASS", "Empty protects the read pointer."],

  ["TC-INT-01", "Integration", "Integrated reset", "Reset FIFO controller connected to RAM.", "empty=1 and full=0.", "integration/ram_and_fifo/tb/tb_sync_fifo_ram.v:78", "PASS", "Controller and RAM start safely."],
  ["TC-INT-02", "Integration", "Fill RAM-backed FIFO", "Write 16 words through the FIFO interface.", "full becomes 1 after RAM stores all words.", "integration/ram_and_fifo/tb/tb_sync_fifo_ram.v:86", "PASS", "Writes reach the RAM correctly."],
  ["TC-INT-03", "Integration", "Integrated overflow", "Try 0xEE while the RAM-backed FIFO is full.", "0xEE is blocked.", "integration/ram_and_fifo/tb/tb_sync_fifo_ram.v:91", "PASS", "Full gating works across the connection."],
  ["TC-INT-04", "Integration", "RAM readback order", "Drain all stored words.", "RAM data returns in FIFO order; empty becomes 1.", "integration/ram_and_fifo/tb/tb_sync_fifo_ram.v:95", "PASS", "Read pointer selects the right RAM address."],
  ["TC-INT-05", "Integration", "Integrated underflow", "Try a read while empty.", "No read is accepted.", "integration/ram_and_fifo/tb/tb_sync_fifo_ram.v:100", "PASS", "Empty gating works end to end."],
  ["TC-INT-06", "Integration", "Pointer wrap", "After a full cycle, write and read 0x5A.", "0x5A returns correctly.", "integration/ram_and_fifo/tb/tb_sync_fifo_ram.v:107", "PASS", "RAM addresses wrap and remain reusable."],
  ["TC-INT-07", "Integration", "Read and write together", "Queue A1,A2; read while writing A3; then drain.", "Output order is A1,A2,A3.", "integration/ram_and_fifo/tb/tb_sync_fifo_ram.v:112", "PASS", "One word enters while one leaves."],
];
tests.getRange("A6:H19").values = rows;

tests.getRange("A5:H5").format = {
  fill: navy,
  font: { bold: true, color: "#FFFFFF" },
  horizontalAlignment: "center",
  verticalAlignment: "center",
  wrapText: true,
};
tests.getRange("A5:H19").format.borders = {
  insideHorizontal: { style: "thin", color: border },
  bottom: { style: "thin", color: border },
  left: { style: "thin", color: border },
  right: { style: "thin", color: border },
};
tests.getRange("A6:H19").format.wrapText = true;
tests.getRange("A6:H19").format.verticalAlignment = "top";
tests.getRange("A6:A19").format.font = { bold: true, color: navy };
tests.getRange("B6:B19").format = {
  fill: blue,
  font: { bold: true, color: navy },
  horizontalAlignment: "center",
};
tests.getRange("G6:G19").format = {
  fill: green,
  font: { bold: true, color: "#006100" },
  horizontalAlignment: "center",
};
tests.getRange("G6:G19").dataValidation = {
  rule: { type: "list", values: ["PASS", "FAIL", "NOT RUN"] },
};

const table = tests.tables.add("A5:H19", true, "RamFifoBasicTests");
table.style = "TableStyleMedium2";
table.showFilterButton = true;

const widths = [14, 13, 24, 40, 40, 47, 12, 31];
for (let c = 0; c < widths.length; c += 1)
  tests.getRangeByIndexes(0, c, 19, 1).format.columnWidth = widths[c];
tests.getRange("A5:H5").format.rowHeight = 32;
tests.getRange("A6:H19").format.rowHeight = 56;
tests.freezePanes.freezeRows(5);
tests.freezePanes.freezeColumns(2);

// Short behavior guide.
insights.showGridLines = false;
insights.getRange("A1:D1").merge();
insights.getRange("A1").values = [["Behavior Insights"]];
insights.getRange("A1:D1").format = {
  fill: navy,
  font: { bold: true, color: "#FFFFFF", size: 18 },
  horizontalAlignment: "center",
  verticalAlignment: "center",
};
insights.getRange("A1:D1").format.rowHeight = 34;

insights.getRange("A3:D3").values = [["Watch", "What Happens", "Meaning", "Tests"]];
insights.getRange("A4:D9").values = [
  ["RAM dout", "Changes just after the rising edge.", "Read is synchronous; set raddr before the edge.", "TC-RAM-01"],
  ["RAM we", "When we=0, the old value stays stored.", "we is the write permission.", "TC-RAM-02"],
  ["full", "Rises at 16 stored words and blocks another write.", "The FIFO cannot overwrite unread data.", "TC-FIFO-02/03"],
  ["empty", "Rises after the last read and blocks another read.", "There is no valid output word left.", "TC-FIFO-04/05"],
  ["Pointers", "After address 15 they return to address 0.", "RAM space is reused as a circular buffer.", "TC-INT-06"],
  ["wr_en + rd_en", "One old word exits while one new word enters.", "Middle occupancy stays unchanged.", "TC-INT-07"],
];
insights.getRange("A3:D3").format = {
  fill: navy,
  font: { bold: true, color: "#FFFFFF" },
  horizontalAlignment: "center",
};
insights.getRange("A3:D9").format.borders = {
  insideHorizontal: { style: "thin", color: border },
  bottom: { style: "thin", color: border },
  left: { style: "thin", color: border },
  right: { style: "thin", color: border },
};
insights.getRange("A4:D9").format.wrapText = true;
insights.getRange("A4:A9").format = { fill: blue, font: { bold: true, color: navy } };

insights.getRange("A11:D11").merge();
insights.getRange("A11").values = [["Run from repository root"]];
insights.getRange("A11:D11").format = { fill: navy, font: { bold: true, color: "#FFFFFF" } };
insights.getRange("A12:D17").merge();
insights.getRange("A12").values = [[
  "RAM: iverilog -g2012 -s tb_sync_ram -o minimal/build/simv_ram_basic individual/ram/tb_sync_ram.v individual/ram/sync_ram.v\nFIFO: iverilog -g2012 -s tb_sync_fifo -o minimal/build/simv_fifo_basic individual/fifo/tb_sync_fifo.v individual/fifo/sync_fifo.v\nIntegration: iverilog -g2012 -s tb_sync_fifo_ram -o minimal/build/simv_sync integration/ram_and_fifo/tb/tb_sync_fifo_ram.v integration/ram_and_fifo/rtl/sync_fifo_ram.v individual/ram/sync_ram.v\nThen run the matching output with vvp.",
]];
insights.getRange("A12:D17").format = {
  fill: gray,
  font: { name: "Consolas", color: "#1F2937", size: 10 },
  wrapText: true,
  verticalAlignment: "center",
  borders: { preset: "outside", style: "thin", color: border },
};

const insightWidths = [23, 44, 48, 18];
for (let c = 0; c < insightWidths.length; c += 1)
  insights.getRangeByIndexes(0, c, 17, 1).format.columnWidth = insightWidths[c];
insights.getRange("A4:D9").format.rowHeight = 42;
insights.freezePanes.freezeRows(3);

const matrix = await workbook.inspect({
  kind: "table",
  range: "Test Cases!A1:H19",
  include: "values,formulas",
  tableMaxRows: 20,
  tableMaxCols: 8,
  tableMaxCellChars: 80,
});
console.log("TEST_MATRIX");
console.log(matrix.ndjson);

const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 100 },
  summary: "formula error scan",
});
console.log("FORMULA_ERRORS");
console.log(errors.ndjson);

for (const sheetName of ["Test Cases", "Behavior Insights"]) {
  const preview = await workbook.render({ sheetName, autoCrop: "all", scale: 1, format: "png" });
  const fileName = `${sheetName.toLowerCase().replaceAll(" ", "_")}.png`;
  await fs.writeFile(path.join(outputDir, fileName), new Uint8Array(await preview.arrayBuffer()));
}

const output = await SpreadsheetFile.exportXlsx(workbook);
const outputPath = path.join(outputDir, "RAM_FIFO_Test_Cases.xlsx");
await output.save(outputPath);
console.log(`OUTPUT=${outputPath}`);
