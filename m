Content-Type: multipart/mixed; boundary="===============8628240837159134539=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 3/7] mptcp: drop
 OPTION_MPTCP_ADD_ADDR6
Date: Wed, 17 Mar 2021 15:36:18 +0800
Message-ID: <666cf05ae98c7be040adeac64c10c0e348723ff6.1615966219.git.geliangtang@gmail.com>
In-Reply-To: 48a821dc73542f7d4729015eb4c10ad95370dfb1.1615966219.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8182

--===============8628240837159134539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the family field was added in struct mptcp_out_options, no need to
use OPTION_MPTCP_ADD_ADDR6 to identify the IPv6 address. Drop it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 15 +++++----------
 net/mptcp/protocol.h |  9 ++++-----
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7e01f44ed885..5b8103668e9a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -652,8 +652,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	*size =3D len;
 	if (drop_other_suboptions)
 		*size -=3D opt_size;
+	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
 	if (opts->addr.family =3D=3D AF_INET) {
-		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
 		if (!echo) {
 			opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
 							     msk->remote_key,
@@ -664,7 +664,6 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 	}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else if (opts->addr.family =3D=3D AF_INET6) {
-		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
 		if (!echo) {
 			opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
 							      msk->remote_key,
@@ -1198,16 +1197,12 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 	}
 =

 mp_capable_done:
-	if ((OPTION_MPTCP_ADD_ADDR
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	     | OPTION_MPTCP_ADD_ADDR6
-#endif
-	    ) & opts->suboptions) {
+	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
 		u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo =3D MPTCP_ADDR_ECHO;
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions)
+		if (opts->addr.family =3D=3D AF_INET6)
 			len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 #endif
 =

@@ -1221,12 +1216,12 @@ void mptcp_write_options(__be32 *ptr, const struct =
tcp_sock *tp,
 =

 		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
 				      len, echo, opts->addr.id);
-		if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		if (opts->addr.family =3D=3D AF_INET) {
 			memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
 			ptr +=3D 1;
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
+		else if (opts->addr.family =3D=3D AF_INET6) {
 			memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
 			ptr +=3D 4;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b993e372c4ad..f004fcbfec11 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -22,11 +22,10 @@
 #define OPTION_MPTCP_MPJ_SYNACK	BIT(4)
 #define OPTION_MPTCP_MPJ_ACK	BIT(5)
 #define OPTION_MPTCP_ADD_ADDR	BIT(6)
-#define OPTION_MPTCP_ADD_ADDR6	BIT(7)
-#define OPTION_MPTCP_RM_ADDR	BIT(8)
-#define OPTION_MPTCP_FASTCLOSE	BIT(9)
-#define OPTION_MPTCP_PRIO	BIT(10)
-#define OPTION_MPTCP_RST	BIT(11)
+#define OPTION_MPTCP_RM_ADDR	BIT(7)
+#define OPTION_MPTCP_FASTCLOSE	BIT(8)
+#define OPTION_MPTCP_PRIO	BIT(9)
+#define OPTION_MPTCP_RST	BIT(10)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
-- =

2.30.2

--===============8628240837159134539==--
