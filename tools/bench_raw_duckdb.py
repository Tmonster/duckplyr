import duckdb
import time

main_con = duckdb.connect()


main_con.execute('install tpch;')
main_con.execute('load tpch;')

main_con.execute('call dbgen(sf=5);')

pkg = "raw-duckdb"

results = []

import pdb
pdb.set_trace()

for i in range(1,23):
    q = f"pragma tpch({i});"
    start = time.time()
    df_result = main_con.execute(q).fetchall()
    end = time.time()
    pdb.set_trace()
    query_time = float(end - start)
    results.append([str(i), pkg, str(i), str(query_time)])
    

f = open(f"res-{pkg}.csv", "w")
for line in results:
    to_write = line[0] + "," + line[1] + "," + line[2] + "," + line[3] + "\n"
    f.write(to_write)

f.close()

print("all done")