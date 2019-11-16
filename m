Content-Type: multipart/mixed; boundary="===============1463338594171602197=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 01/10] selftests:mptcp: fix typo
Date: Sat, 16 Nov 2019 13:59:27 +0100
Message-ID: <20191116125936.3563275-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191116125936.3563275-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2562

--===============1463338594171602197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This parameter is only used in case of error.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index b5367fe2c6ea..b51cea35e5c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -466,7 +466,7 @@ for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns3" $sender 10.0.3.2
 	$ipv6 && do_ping "$ns3" $sender dead:beef:3::2
 =

-	do_ping ns4 $sender 10.0.3.1
+	do_ping "$ns4" $sender 10.0.3.1
 	$ipv6 && do_ping "$ns4" $sender dead:beef:3::1
 done
 =

-- =

2.24.0

--===============1463338594171602197==--
