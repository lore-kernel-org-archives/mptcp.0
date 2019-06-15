Content-Type: multipart/mixed; boundary="===============7355941040004651452=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 15/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:58 +0200
Message-ID: <20190615105259.15151-16-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1400

--===============7355941040004651452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - No space is necessary after a cast (2)
 - braces {} are not necessary for single statement blocks

What has not been fixed:

 - /

Fixes: 3daf18dd31c1 (mptcp: Add ADD_ADDR handling)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/options.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d0795015b848..503f0d110494 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -178,7 +178,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
 				 mp_opt->addr.s_addr, mp_opt->addr_id);
 		} else {
-			memcpy(mp_opt->addr6.s6_addr, (u8 *) ptr, 16);
+			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
 			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
 		}
 		break;
@@ -374,9 +374,9 @@ static bool mptcp_established_options_addr(struct sock =
*sk,
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 =

-	if (subflow->fourth_ack) {
+	if (subflow->fourth_ack)
 		return pm_addr_signal(msk, size, remaining, opts);
-	}
+
 	return false;
 }
 =

@@ -506,7 +506,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts)
 			       (MPTCPOPT_ADD_ADDR << 12) |
 			       (MPTCP_ADDR_IPVERSION_6 <<  8) |
 			       (opts->addr_id));
-		memcpy((u8 *) ptr, opts->addr6.s6_addr, 16);
+		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
 		ptr +=3D 4;
 	}
 #endif
-- =

2.20.1


--===============7355941040004651452==--
