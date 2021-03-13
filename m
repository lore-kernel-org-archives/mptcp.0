Content-Type: multipart/mixed; boundary="===============7088148534544618864=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 01/11] mptcp: add rm_list in mptcp_out_options
Date: Fri, 12 Mar 2021 17:16:11 -0800
Message-ID: <20210313011621.211661-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8135

--===============7088148534544618864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

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
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/mptcp.h  |  9 ++++++++-
 net/mptcp/options.c  | 35 +++++++++++++++++++++++++++--------
 net/mptcp/pm.c       |  5 +++--
 net/mptcp/protocol.h | 12 ++++++++++--
 4 files changed, 48 insertions(+), 13 deletions(-)

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
index 444a38681e93..e74d0513187f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -674,20 +674,25 @@ static bool mptcp_established_options_rm_addr(struct =
sock *sk,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-	u8 rm_id;
+	struct mptcp_rm_list rm_list;
+	int i, len;
 =

 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_id)))
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
 		return false;
 =

-	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
+	len =3D mptcp_rm_addr_len(&rm_list);
+	if (len < 0)
+		return false;
+	if (remaining < len)
 		return false;
 =

-	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE;
+	*size =3D len;
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
@@ -1217,9 +1222,23 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 	}
 =

 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
+		u8 i =3D 1;
+
 		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
-				      TCPOLEN_MPTCP_RM_ADDR_BASE,
-				      0, opts->rm_id);
+				      TCPOLEN_MPTCP_RM_ADDR_BASE + opts->rm_list.nr,
+				      0, opts->rm_list.ids[0]);
+
+		while (i < opts->rm_list.nr) {
+			u8 id1, id2, id3, id4;
+
+			id1 =3D opts->rm_list.ids[i];
+			id2 =3D i + 1 < opts->rm_list.nr ? opts->rm_list.ids[i + 1] : TCPOPT_NO=
P;
+			id3 =3D i + 2 < opts->rm_list.nr ? opts->rm_list.ids[i + 2] : TCPOPT_NO=
P;
+			id4 =3D i + 3 < opts->rm_list.nr ? opts->rm_list.ids[i + 3] : TCPOPT_NO=
P;
+			put_unaligned_be32(id1 << 24 | id2 << 16 | id3 << 8 | id4, ptr);
+			ptr +=3D 1;
+			i +=3D 4;
+		}
 	}
 =

 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6fd4b2c1b076..0654c86cd5ff 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -258,7 +258,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
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

@@ -271,7 +271,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, un=
signed int remaining,
 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
 		goto out_unlock;
 =

-	*rm_id =3D msk->pm.rm_id;
+	rm_list->ids[0] =3D msk->pm.rm_id;
+	rm_list->nr =3D 1;
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	ret =3D true;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e21a5bc36cf0..c896bcf3e70f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -61,7 +61,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	22
 #define TCPOLEN_MPTCP_PORT_LEN		2
 #define TCPOLEN_MPTCP_PORT_ALIGN	2
-#define TCPOLEN_MPTCP_RM_ADDR_BASE	4
+#define TCPOLEN_MPTCP_RM_ADDR_BASE	3
 #define TCPOLEN_MPTCP_PRIO		3
 #define TCPOLEN_MPTCP_PRIO_ALIGN	4
 #define TCPOLEN_MPTCP_FASTCLOSE		12
@@ -709,10 +709,18 @@ static inline unsigned int mptcp_add_addr_len(int fam=
ily, bool echo, bool port)
 	return len;
 }
 =

+static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
+{
+	if (rm_list->nr =3D=3D 0 || rm_list->nr > MPTCP_RM_IDS_MAX)
+		return -EINVAL;
+
+	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
+}
+
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

2.30.2

--===============7088148534544618864==--
