Content-Type: multipart/mixed; boundary="===============2649488333695989857=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/3] selftests: mptcp: init nstat history
Date: Wed, 24 Feb 2021 17:49:27 +0100
Message-ID: <20210224164928.2409821-3-matthieu.baerts@tessares.net>
In-Reply-To: 20210224164928.2409821-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7943

--===============2649488333695989857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not to be impacted by packets sent between sub-tests.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 9b437d9f3cce..99d744a5bf13 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -426,6 +426,13 @@ do_transfer()
 		sleep 1
 	fi
 =

+	NSTAT_HISTORY=3D/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
+		nstat -n
+	if [ ${listener_ns} !=3D ${connector_ns} ]; then
+		NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns}=
 \
+			nstat -n
+	fi
+
 	local stat_synrx_last_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPC=
apableSYNRX")
 	local stat_ackrx_last_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPC=
apableACKRX")
 	local stat_cookietx_last=3D$(get_mib_counter "${listener_ns}" "TcpExtSync=
ookiesSent")
-- =

2.30.0

--===============2649488333695989857==--
