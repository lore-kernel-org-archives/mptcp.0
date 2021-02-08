Content-Type: multipart/mixed; boundary="===============5722479322170322943=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 1/9] mptcp: add rm_list in
 mptcp_out_options
Date: Mon, 08 Feb 2021 22:54:09 +0800
Message-ID: <428b26338731f85b705a42ceb52d63376d432444.1612795651.git.geliangtang@gmail.com>
In-Reply-To: cover.1612795651.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7674

--===============5722479322170322943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch defined a new struct mptcp_rm_list, the ids field was an
array of the removing address ids, the nr field was the valid number of
removing address ids in the array. The array size was definced as a new
macro MPTCP_RM_IDS_MAX. Changed the member rm_id of struct
mptcp_out_options to rm_list.

In mptcp_established_options_rm_addr, invoked mptcp_pm_rm_addr_signal to
get the rm_list. According the number of addresses in it, calculated
the padded RM_ADDR suboption length. And saved the ids array in struct
mptcp_out_options's rm_list member.

In mptcp_write_options, iterated each address id from struct
mptcp_out_options's rm_list member, set the invalid ones as TCPOPT_NOP,
then filled them into the RM_ADDR suboption.

Changed TCPOLEN_MPTCP_RM_ADDR_BASE from 4 to 3.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/mptcp.h  |  9 ++++++++-
 net/mptcp/options.c  | 37 +++++++++++++++++++++++++++++--------
 net/mptcp/pm.c       |  4 ++--
 net/mptcp/protocol.h |  4 ++--
 4 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 5694370be3d4..cea69c801595 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -34,6 +34,13 @@ struct mptcp_ext {
 	/* one byte hole */
 };
 =

+#define MPTCP_RM_IDS_MAX	8
+
+struct mptcp_rm_list {
+	u8 ids[MPTCP_RM_IDS_MAX];
+	u8 nr;
+};
+
 struct mptcp_out_options {
 #if IS_ENABLED(CONFIG_MPTCP)
 	u16 suboptions;
@@ -48,7 +55,7 @@ struct mptcp_out_options {
 	u8 addr_id;
 	u16 port;
 	u64 ahmac;
-	u8 rm_id;
+	struct mptcp_rm_list rm_list;
 	u8 join_id;
 	u8 backup;
 	u32 nonce;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1c5c99c06951..9e9bbe88b58f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -671,20 +671,27 @@ static bool mptcp_established_options_rm_addr(struct =
sock *sk,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-	u8 rm_id;
+	struct mptcp_rm_list rm_list;
+	u8 i, align;
 =

 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_id)))
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
 		return false;
 =

-	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
+	if (rm_list.nr > 1)
+		align =3D 5;
+	if (rm_list.nr > 5)
+		align =3D 9;
+
+	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE + align)
 		return false;
 =

-	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE;
+	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE + align;
 	opts->suboptions |=3D OPTION_MPTCP_RM_ADDR;
-	opts->rm_id =3D rm_id;
+	opts->rm_list =3D rm_list;
 =

-	pr_debug("rm_id=3D%d", opts->rm_id);
+	for (i =3D 0; i < opts->rm_list.nr; i++)
+		pr_debug("rm_list_ids[%d]=3D%d", i, opts->rm_list.ids[i]);
 =

 	return true;
 }
@@ -1213,9 +1220,23 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 	}
 =

 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
+		u8 i;
+
+		for (i =3D opts->rm_list.nr; i < MPTCP_RM_IDS_MAX; i++)
+			opts->rm_list.ids[i] =3D TCPOPT_NOP;
 		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
-				      TCPOLEN_MPTCP_RM_ADDR_BASE,
-				      0, opts->rm_id);
+				      TCPOLEN_MPTCP_RM_ADDR_BASE + opts->rm_list.nr,
+				      0, opts->rm_list.ids[0]);
+		if (opts->rm_list.nr > 1) {
+			put_unaligned_be32(opts->rm_list.ids[1] << 24 | opts->rm_list.ids[2] <<=
 16 |
+					   opts->rm_list.ids[3] << 8 | opts->rm_list.ids[4], ptr);
+			ptr +=3D 1;
+		}
+		if (opts->rm_list.nr > 5) {
+			put_unaligned_be32(opts->rm_list.ids[5] << 24 | opts->rm_list.ids[6] <<=
 16 |
+					   opts->rm_list.ids[7] << 8 | TCPOPT_NOP, ptr);
+			ptr +=3D 1;
+		}
 	}
 =

 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index a6d068d801d0..bc68d886c31d 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -273,7 +273,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 }
 =

 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
-			     u8 *rm_id)
+			     struct mptcp_rm_list *rm_list)
 {
 	int ret =3D false;
 =

@@ -286,7 +286,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
 		goto out_unlock;
 =

-	*rm_id =3D msk->pm.rm_id;
+	rm_list->ids[0] =3D msk->pm.rm_id;
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7ad0dfef36bd..8f5dede1de81 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -60,7 +60,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
 #define TCPOLEN_MPTCP_PORT_LEN		4
-#define TCPOLEN_MPTCP_RM_ADDR_BASE	4
+#define TCPOLEN_MPTCP_RM_ADDR_BASE	3
 #define TCPOLEN_MPTCP_PRIO		3
 #define TCPOLEN_MPTCP_PRIO_ALIGN	4
 #define TCPOLEN_MPTCP_FASTCLOSE		12
@@ -722,7 +722,7 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y, bool echo, bool port)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
 			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
-			     u8 *rm_id);
+			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 =

 void __init mptcp_pm_nl_init(void);
-- =

2.29.2

--===============5722479322170322943==--
