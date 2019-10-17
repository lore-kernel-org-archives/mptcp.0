Content-Type: multipart/mixed; boundary="===============2427005203036343276=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 3/4] mptcp:ipv6: fix code style
Date: Thu, 17 Oct 2019 16:50:46 +0200
Message-ID: <20191017145047.8900-4-matthieu.baerts@tessares.net>
In-Reply-To: 20191017145047.8900-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2221

--===============2427005203036343276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: Add ADD_ADDR handling"

 net/mptcp/options.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0b5fd3985e86..a3bf62a6620a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -234,13 +234,14 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
 				 mp_opt->addr.s_addr, mp_opt->addr_id);
+		}
 #if IS_ENABLED(CONFIG_IPV6)
-		} else {
+		else {
 			mp_opt->add_addr =3D 1;
 			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
 			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
-#endif
 		}
+#endif
 		break;
 =

 	/* MPTCPOPT_RM_ADDR
-- =

2.20.1

--===============2427005203036343276==--
