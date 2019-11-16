Content-Type: multipart/mixed; boundary="===============8762748274278175414=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 03/10] selftests:mptcp: align v4 and v6 results
Date: Sat, 16 Nov 2019 13:59:29 +0100
Message-ID: <20191116125936.3563275-4-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2564

--===============8762748274278175414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that v6 tests are enabled by default, it annoys me that the
alignement is not OK :-)
Also thanks to this new alignment, I found a strange issue that led to
multiple tests and at the end a crash, see a separated email I sent.

Now the IP:port messages look like that:

  (10.0.1.1:10000      )
  (dead:beef:2::1:10029)

But then the rest is aligned:

  # INFO: Using loss of 0.22% delay 150 ms reorder 94% 20% on ns3eth4
  # ns1-5dcf183d-9ef7pp MPTCP -> ns1-5dcf183d-9ef7pp (10.0.1.1:10000      )=
 MPTCP (duration   128ms) [ OK ]
  # ns1-5dcf183d-9ef7pp MPTCP -> ns1-5dcf183d-9ef7pp (10.0.1.1:10001      )=
 TCP   (duration   127ms) [ OK ]
  # ns1-5dcf183d-9ef7pp TCP   -> ns1-5dcf183d-9ef7pp (10.0.1.1:10002      )=
 MPTCP (duration   110ms) [ OK ]
  # ns1-5dcf183d-9ef7pp MPTCP -> ns1-5dcf183d-9ef7pp (dead:beef:1::1:10003)=
 MPTCP (duration   127ms) [ OK ]
  # ns1-5dcf183d-9ef7pp MPTCP -> ns1-5dcf183d-9ef7pp (dead:beef:1::1:10004)=
 TCP   (duration   113ms) [ OK ]
  # ns1-5dcf183d-9ef7pp TCP   -> ns1-5dcf183d-9ef7pp (dead:beef:1::1:10005)=
 MPTCP (duration   135ms) [ OK ]

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 49b3fb6b042d..74d62a69b6e9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -302,7 +302,8 @@ do_transfer()
 	:> "$sout"
 	:> "$capout"
 =

-	printf "%-4s %-5s -> %-4s (%s:%d) %-5s\t" ${connector_ns} ${cl_proto} ${l=
istener_ns} ${connect_addr} ${port} ${srv_proto}
+	addr_port=3D$(printf "%s:%d" ${connect_addr} ${port})
+	printf "%-4s %-5s -> %-4s (%-20s) %-5s\t" ${connector_ns} ${cl_proto} ${l=
istener_ns} ${addr_port} ${srv_proto}
 =

 	if $capture; then
 	    if [ -z $SUDO_USER ] ; then
-- =

2.24.0

--===============8762748274278175414==--
