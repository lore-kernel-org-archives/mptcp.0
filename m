Content-Type: multipart/mixed; boundary="===============6750731240981898501=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/8] mptcp: remove multi addrs on
 outgoing path
Date: Fri, 29 Jan 2021 18:26:45 +0800
Message-ID: <39063864f13dfbaf09623e0eeec9556503584dc5.1611914854.git.geliangtang@gmail.com>
In-Reply-To: cover.1611914854.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7524

--===============6750731240981898501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changed the type of rm_id in struct mptcp_out_options from u8
to u64, and renamed it to rm_ids. It was used as a map of address ids
that need to be removed. Up to 8 address ids could be encoded in it.

Added a new macro named mptcp_for_each_id to iterate out each address
id form the ids map.

In mptcp_established_options_rm_addr, invoked mptcp_pm_rm_addr_signal to
get the ids map. According the number of addresses in the ids map,
calculated the padded RM_ADDR suboption length. And saved the ids map in
struct mptcp_out_options's rm_ids member.

In mptcp_write_options, used mptcp_for_each_id to iterate out each
address id, then filled them into the RM_ADDR suboption.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/mptcp.h  |  2 +-
 net/mptcp/options.c  | 40 ++++++++++++++++++++++++++++++++--------
 net/mptcp/pm.c       |  4 ++--
 net/mptcp/protocol.h |  9 +++++++--
 4 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5694370be3d4..21232c4e15fe 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -48,7 +48,7 @@ struct mptcp_out_options {
 	u8 addr_id;
 	u16 port;
 	u64 ahmac;
-	u8 rm_id;
+	u64 rm_ids;
 	u8 join_id;
 	u8 backup;
 	u32 nonce;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 775f0576592e..11f6182b8319 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -671,20 +671,29 @@ static bool mptcp_established_options_rm_addr(struct =
sock *sk,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-	u8 rm_id;
+	u8 *ptr, id, nr;
+	u64 rm_ids;
 =

 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_id)))
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_ids)))
 		return false;
 =

-	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
+	mptcp_for_each_id(rm_ids, nr, ptr, id)
+		;
+
+	if (nr > 1)
+		nr =3D 5;
+	if (nr > 5)
+		nr =3D 9;
+
+	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE + nr)
 		return false;
 =

-	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE;
+	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE + nr;
 	opts->suboptions |=3D OPTION_MPTCP_RM_ADDR;
-	opts->rm_id =3D rm_id;
+	opts->rm_ids =3D rm_ids;
 =

-	pr_debug("rm_id=3D%d", opts->rm_id);
+	pr_debug("rm_ids=3D%llu", opts->rm_ids);
 =

 	return true;
 }
@@ -1211,9 +1220,24 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 	}
 =

 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
+		u8 rm_ids[8] =3D { 0 };
+		u8 *tmp, id, nr;
+
+		mptcp_for_each_id(opts->rm_ids, nr, tmp, id)
+			rm_ids[nr] =3D id;
 		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
-				      TCPOLEN_MPTCP_RM_ADDR_BASE,
-				      0, opts->rm_id);
+				      TCPOLEN_MPTCP_RM_ADDR_BASE + nr,
+				      0, rm_ids[0]);
+		if (nr > 1) {
+			put_unaligned_be32(rm_ids[1] << 24 | rm_ids[2] << 16 |
+					   rm_ids[3] << 8 | rm_ids[4], ptr);
+			ptr +=3D 1;
+		}
+		if (nr > 5) {
+			put_unaligned_be32(rm_ids[5] << 24 | rm_ids[6] << 16 |
+					   rm_ids[7] << 8 | TCPOPT_NOP, ptr);
+			ptr +=3D 1;
+		}
 	}
 =

 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6fd4b2c1b076..7ec1d2a1582b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -258,7 +258,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 }
 =

 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
-			     u8 *rm_id)
+			     u64 *rm_ids)
 {
 	int ret =3D false;
 =

@@ -271,7 +271,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
 		goto out_unlock;
 =

-	*rm_id =3D msk->pm.rm_id;
+	*rm_ids =3D msk->pm.rm_id;
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 447ce4631b43..962cc1b4dd48 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -60,7 +60,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
 #define TCPOLEN_MPTCP_PORT_LEN		4
-#define TCPOLEN_MPTCP_RM_ADDR_BASE	4
+#define TCPOLEN_MPTCP_RM_ADDR_BASE	3
 #define TCPOLEN_MPTCP_PRIO		4
 #define TCPOLEN_MPTCP_FASTCLOSE		12
 =

@@ -288,6 +288,11 @@ struct mptcp_sock {
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 =

+#define mptcp_for_each_id(ids, nr, ptr, id)				\
+	for ((nr) =3D 0, (ptr) =3D (u8 *)&(ids);				\
+	     (nr) < 8 && (id =3D *(ptr));					\
+	     (nr)++, (ptr)++)
+
 static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 {
 	sock_owned_by_me((const struct sock *)msk);
@@ -713,7 +718,7 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y, bool echo, bool port)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
 			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
-			     u8 *rm_id);
+			     u64 *rm_ids);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 =

 void __init mptcp_pm_nl_init(void);
-- =

2.29.2

--===============6750731240981898501==--
