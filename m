Content-Type: multipart/mixed; boundary="===============0957145676718440474=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/4] mptcp:ipv6: fix code style
Date: Thu, 17 Oct 2019 16:50:47 +0200
Message-ID: <20191017145047.8900-5-matthieu.baerts@tessares.net>
In-Reply-To: 20191017145047.8900-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2223

--===============0957145676718440474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: Add ADD_ADDR handling"

 net/mptcp/basic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/basic.c b/net/mptcp/basic.c
index 5520aae3a6e7..d2fd0560c136 100644
--- a/net/mptcp/basic.c
+++ b/net/mptcp/basic.c
@@ -72,13 +72,15 @@ static int proc_parse_addr(struct ctl_table *ctl, int w=
rite,
 			snprintf(tmp, INET_ADDRSTRLEN, "%pI4",
 				 &pernet->announce_v4_addr);
 			tbl.data =3D tmp;
+		}
 #if IS_ENABLED(CONFIG_IPV6)
-		} else if (pernet->has_announce_v6) {
+		else if (pernet->has_announce_v6) {
 			snprintf(tmp, INET6_ADDRSTRLEN, "%pI6c",
 				 &pernet->announce_v6_addr);
 			tbl.data =3D tmp;
+		}
 #endif
-		} else {
+		else {
 			tbl.data =3D none;
 		}
 		tbl.maxlen =3D strlen(tbl.data);
-- =

2.20.1

--===============0957145676718440474==--
