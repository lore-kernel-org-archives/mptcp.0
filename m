Content-Type: multipart/mixed; boundary="===============4689008197688175577=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 10/11] selftests: mptcp: set addr id for
 removing testcases
Date: Fri, 12 Mar 2021 17:16:20 -0800
Message-ID: <20210313011621.211661-11-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8141

--===============4689008197688175577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

The removing testcases can only delete the addresses from id 1, this
patch added the support for deleting the addresses from any id that user
set.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 ++++++++++++-------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 15b71ddee615..6782a891b3e7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -284,14 +284,19 @@ do_transfer()
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D1
-			sleep 1
-
-			while [ $counter -le $rm_nr_ns1 ]
-			do
-				ip netns exec ${listener_ns} ./pm_nl_ctl del $counter
+			dump=3D(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
+			if [ ${#dump[@]} -gt 0 ]; then
+				id=3D${dump[1]}
 				sleep 1
-				let counter+=3D1
-			done
+
+				while [ $counter -le $rm_nr_ns1 ]
+				do
+					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
+					sleep 1
+					let counter+=3D1
+					let id+=3D1
+				done
+			fi
 		else
 			sleep 1
 			ip netns exec ${listener_ns} ./pm_nl_ctl flush
@@ -318,14 +323,19 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D1
-			sleep 1
-
-			while [ $counter -le $rm_nr_ns2 ]
-			do
-				ip netns exec ${connector_ns} ./pm_nl_ctl del $counter
+			dump=3D(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
+			if [ ${#dump[@]} -gt 0 ]; then
+				id=3D${dump[1]}
 				sleep 1
-				let counter+=3D1
-			done
+
+				while [ $counter -le $rm_nr_ns2 ]
+				do
+					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
+					sleep 1
+					let counter+=3D1
+					let id+=3D1
+				done
+			fi
 		else
 			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl flush
-- =

2.30.2

--===============4689008197688175577==--
