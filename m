Content-Type: multipart/mixed; boundary="===============7355709500132248212=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 5/5] selftests: mptcp: remove id
 0 address testcases
Date: Wed, 03 Mar 2021 21:13:20 +0800
Message-ID: <753a5900e402e2d133bb28a5e4a5190198f39fd8.1614776769.git.geliangtang@gmail.com>
In-Reply-To: 96af88c9f74f6c75d307d1297d3c7293495b930f.1614776769.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7999

--===============7355709500132248212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the testcases for removing the id 0 subflow and the id 0
address.

In do_transfer, use the removing addresses number '9' for deleting the id
0 address.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 96379ede5925..471a8870c40d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -315,9 +315,12 @@ do_transfer()
 					let id+=3D1
 				done
 			fi
-		else
+		elif [ $rm_nr_ns1 -eq 8 ]; then
 			sleep 1
 			ip netns exec ${listener_ns} ./pm_nl_ctl flush
+		elif [ $rm_nr_ns1 -eq 9 ]; then
+			sleep 1
+			ip netns exec ${listener_ns} ./pm_nl_ctl del 0
 		fi
 	fi
 =

@@ -354,9 +357,12 @@ do_transfer()
 					let id+=3D1
 				done
 			fi
-		else
+		elif [ $rm_nr_ns2 -eq 8 ]; then
 			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl flush
+		elif [ $rm_nr_ns2 -eq 9 ]; then
+			sleep 1
+			ip netns exec ${connector_ns} ./pm_nl_ctl del 0
 		fi
 	fi
 =

@@ -1016,6 +1022,25 @@ remove_tests()
 	chk_join_nr "flush invalid addresses" 1 1 1
 	chk_add_nr 3 3
 	chk_rm_nr 3 1 invert
+
+	# remove id 0 subflow
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+	chk_join_nr "remove id 0 subflow" 1 1 1
+	chk_rm_nr 1 1
+
+	# remove id 0 address
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+	chk_join_nr "remove id 0 address" 1 1 1
+	chk_add_nr 1 1
+	chk_rm_nr 1 1 invert
 }
 =

 add_tests()
-- =

2.29.2

--===============7355709500132248212==--
