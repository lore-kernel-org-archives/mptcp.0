Content-Type: multipart/mixed; boundary="===============9018362551711228849=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] selftests/mptcp: Capture pcap on both
 sender and receiver
Date: Tue, 16 Jun 2020 08:49:24 -0700
Message-ID: <20200616154924.17949-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 4702

--===============9018362551711228849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When investigating performance issues that involve
latency/loss/reordering it is useful to have the pcap from the
sender-side as it allows to easier infer the state of the sender's
congestion-control, loss-recovery,...

Allow the selftests to capture a pcap on both sides so that this
information is not lost when reproducing.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index acf02e156d20..faf636d1639f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -386,9 +386,11 @@ do_transfer()
 		fi
 =

 		local capfile=3D"${listener_ns}-${connector_ns}-${cl_proto}-${srv_proto}=
-${connect_addr}.pcap"
-
 		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -=
w $capfile > "$capout" 2>&1 &
-		local cappid=3D$!
+		local cappid_listener=3D$!
+		local capfile=3D"${connector_ns}-${listener_ns}-${cl_proto}-${srv_proto}=
-${connect_addr}.pcap"
+		ip netns exec ${connector_ns} tcpdump -i any -s 65535 -B 32768 $capuser =
-w $capfile > "$capout" 2>&1 &
+		local cappid_connector=3D$!
 =

 		sleep 1
 	fi
@@ -413,7 +415,8 @@ do_transfer()
 =

 	if $capture; then
 		sleep 1
-		kill $cappid
+		kill $cappid_listener
+		kill $cappid_connector
 	fi
 =

 	local duration
-- =

2.23.0

--===============9018362551711228849==--
