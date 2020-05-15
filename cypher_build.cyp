/// Cypher Commands

/// Following line creates the classification of Clostridium which is what all bactteria in the list are
CREATE (Clostridium:Bacteria { name:"Clostridium" })

/// Following 6 commands are for creating nodes for the clostridium bacteria found in the Gut Microbiome
CREATE (indolis:Microbiome { name:"Clostridium indulis", acc_num:"NZ_AZUI01000001.1", bp:6383701, size_kb:6313 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
CREATE (clostridioforme:Microbiome { name:"Clostridium clostridioforme", acc_num:"NZ_KB850936.1", bp:2393545, size_kb:5594 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
CREATE (orbiscindents:Microbiome { name:"Clostridium orbiscindents", acc_num:"NZ_CP015406.2", bp:3818478, size_kb:3776 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
CREATE (disporicum:Microbiome { name:"Clostridium disporicum", acc_num:"NZ_CYZX01000001.1", bp:253314, size_kb:3417 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
CREATE (glycolicus:Microbiome { name:"Clostridium glycolicum", acc_num:"NZ_KE392228.1", bp:2636478, size_kb:3978 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)
CREATE (symbiosum:Microbiome { name:"Clostridium symbiosum", acc_num:"NZ_GL834305.1", bp:907173, size_kb:5298 })-[:FOUND_IN { location: ["Gut"]}]->(Clostridium)

/// Following 2 commands are for creating nodes for clostridium bacteria that are considered Foodborne
CREATE (botulinum:Foodborne { name:"Clostridium botulinum", acc_num:"NC_009495.1", bp:3886916, size_kb:3860 })-[:FOUND_IN { location: ["Food"]}]->(Clostridium)
CREATE (perfringens:Foodborne { name:"Clostridium perfringens", acc_num:"NC_008261.1", bp:3256683, size_kb:3221 })-[:FOUND_IN { location: ["Food"]}]->(Clostridium)

/// Following 2 commands are for creatings nodes for clostridium bacteria that are used Drugs
CREATE (histolytica:Drug { name:"Clostridium histolytica", acc_num:"NZ_LR590481.1", bp:2740791, size_kb:2711 })-[:FOUND_IN { location: ["Drug"]}]->(Clostridium)
CREATE (butyricum:Drug { name:"Clostridium butyricum", acc_num:"NZ_CP013252.1", bp:3824894, size_kb:4577 })-[:FOUND_IN { location: ["Drug"]}]->(Clostridium)

///----------------------------------------------------------------------------------------------------------------------------------------------------------------

/// The following lines are to perform some sample queries from the graph database that has been made

/// 1) Return the name and accession numbers of the bacteria only found in the microbiome
MATCH (m:Microbiome)-[:FOUND_IN]-(:Bacteria)
RETURN m.name AS NAME, m.acc_num AS ACCESSION NUMBER

/// 2) Return the name and length (in bp) of all the bacteria in descending order
MATCH (n)
RETURN n.name AS NAME, n.bp AS BASE_PAIRS
ORDER BY n.bp DESC
SKIP 1'