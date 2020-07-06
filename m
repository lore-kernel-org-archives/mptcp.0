Content-Type: multipart/mixed; boundary="===============7773933648366271738=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] selftests: mptcp: capture pcap on both sides
Date: Mon, 06 Jul 2020 14:44:08 +0200
Message-ID: <20200706124408.3118005-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4926

--===============7773933648366271738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When investigating performance issues that involve latency / loss /
reordering it is useful to have the pcap from the sender-side as it
allows to easier infer the state of the sender's congestion-control,
loss-recovery, etc.

Allow the selftests to capture a pcap on both sender and receiver so
that this information is not lost when reproducing.

This patch also improves the file names. Instead of:

  ns4-5ee79a56-X4O6gS-ns3-5ee79a56-X4O6gS-MPTCP-MPTCP-10.0.3.1.pcap

We now have something like for the same test:

  5ee79a56-X4O6gS-ns3-ns4-MPTCP-MPTCP-10.0.3.1-10030-connector.pcap
  5ee79a56-X4O6gS-ns3-ns4-MPTCP-MPTCP-10.0.3.1-10030-listener.pcap

It was a connection from ns3 to ns4, better to start with ns3 then. The
port is also added, easier to find the trace we want.

Co-developed-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 8f7145c413b9..c0589e071f20 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -395,10 +395,14 @@ do_transfer()
 			capuser=3D"-Z $SUDO_USER"
 		fi
 =

-		local capfile=3D"${listener_ns}-${connector_ns}-${cl_proto}-${srv_proto}=
-${connect_addr}.pcap"
+		local capfile=3D"${rndh}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_pro=
to}-${srv_proto}-${connect_addr}-${port}"
+		local capopt=3D"-i any -s 65535 -B 32768 ${capuser}"
 =

-		ip netns exec ${listener_ns} tcpdump -i any -s 65535 -B 32768 $capuser -=
w $capfile > "$capout" 2>&1 &
-		local cappid=3D$!
+		ip netns exec ${listener_ns}  tcpdump ${capopt} -w "${capfile}-listener.=
pcap"  >> "${capout}" 2>&1 &
+		local cappid_listener=3D$!
+
+		ip netns exec ${connector_ns} tcpdump ${capopt} -w "${capfile}-connector=
.pcap" >> "${capout}" 2>&1 &
+		local cappid_connector=3D$!
 =

 		sleep 1
 	fi
@@ -423,7 +427,8 @@ do_transfer()
 =

 	if $capture; then
 		sleep 1
-		kill $cappid
+		kill ${cappid_listener}
+		kill ${cappid_connector}
 	fi
 =

 	local duration
-- =

2.27.0

--===============7773933648366271738==--
