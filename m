Content-Type: multipart/mixed; boundary="===============1847739038868173903=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 3/4] selftests: mptcp: set addr
 id for removing testcases
Date: Tue, 09 Feb 2021 22:55:03 +0800
Message-ID: <66417cc815ca140958142581d5b9c3c97b8ab703.1612882099.git.geliangtang@gmail.com>
In-Reply-To: a61310ffcf001700a2c5446ad53212c0f7577c61.1612882099.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7712

--===============1847739038868173903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The removing testcases can only delete the addresses from id 1, this
patch added the support for deleting the addresses from any id that user
set.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
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

2.29.2

--===============1847739038868173903==--
