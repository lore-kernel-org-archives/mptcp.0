Content-Type: multipart/mixed; boundary="===============7215960091864720937=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/7] mptcp: move ifindex and flags
 out of mptcp_addr_info
Date: Sun, 14 Mar 2021 22:22:51 +0800
Message-ID: <e63ba1ef541610f4730705c571d2d5f8f2c77a4f.1615731165.git.geliangtang@gmail.com>
In-Reply-To: cover.1615731165.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8149

--===============7215960091864720937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch moved the ifindex and flags fields from struct mptcp_addr_info
to struct mptcp_pm_addr_entry.

It changed the type of __mptcp_subflow_connect's parameter loc from
struct mptcp_addr_info to struct mptcp_pm_addr_entry too.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 47 ++++++++++++++++++------------------------
 net/mptcp/protocol.h   | 13 +++++++++---
 net/mptcp/subflow.c    |  6 +++---
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c73b7cfc7ae9..812e0874e276 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -22,13 +22,6 @@ static struct genl_family mptcp_genl_family;
 =

 static int pm_nl_pernet_id;
 =

-struct mptcp_pm_addr_entry {
-	struct list_head	list;
-	struct mptcp_addr_info	addr;
-	struct rcu_head		rcu;
-	struct socket		*lsk;
-};
-
 struct mptcp_pm_add_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
@@ -170,7 +163,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	rcu_read_lock();
 	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 =

 		if (entry->addr.family !=3D sk->sk_family) {
@@ -208,7 +201,7 @@ select_signal_address(struct pm_nl_pernet *pernet, unsi=
gned int pos)
 	 * can lead to additional addresses not being announced.
 	 */
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 		if (i++ =3D=3D pos) {
 			ret =3D entry;
@@ -461,7 +454,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			check_work_pending(msk);
 			remote_address((struct sock_common *)sk, &remote);
 			spin_unlock_bh(&msk->pm.lock);
-			__mptcp_subflow_connect(sk, &local->addr, &remote);
+			__mptcp_subflow_connect(sk, local, &remote);
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
@@ -486,8 +479,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_=
sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	unsigned int add_addr_accept_max;
+	struct mptcp_pm_addr_entry local;
 	struct mptcp_addr_info remote;
-	struct mptcp_addr_info local;
 	unsigned int subflows_max;
 =

 	add_addr_accept_max =3D mptcp_pm_get_add_addr_accept_max(msk);
@@ -513,7 +506,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_=
sock *msk)
 	if (!remote.port)
 		remote.port =3D sk->sk_dport;
 	memset(&local, 0, sizeof(local));
-	local.family =3D remote.family;
+	local.addr.family =3D remote.family;
 =

 	spin_unlock_bh(&msk->pm.lock);
 	__mptcp_subflow_connect(sk, &local, &remote);
@@ -691,7 +684,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 =

 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 {
-	return (entry->addr.flags &
+	return (entry->flags &
 		(MPTCP_PM_ADDR_FLAG_SIGNAL | MPTCP_PM_ADDR_FLAG_SUBFLOW)) =3D=3D
 		MPTCP_PM_ADDR_FLAG_SIGNAL;
 }
@@ -743,11 +736,11 @@ static int mptcp_pm_nl_append_new_local_addr(struct p=
m_nl_pernet *pernet,
 	if (entry->addr.id > pernet->next_id)
 		pernet->next_id =3D entry->addr.id;
 =

-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		addr_max =3D pernet->add_addr_signal_max;
 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
 	}
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 		addr_max =3D pernet->local_addr_max;
 		WRITE_ONCE(pernet->local_addr_max, addr_max + 1);
 	}
@@ -849,10 +842,10 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
struct sock_common *skc)
 		return -ENOMEM;
 =

 	entry->addr =3D skc_local;
-	entry->addr.ifindex =3D 0;
-	entry->addr.flags =3D 0;
 	entry->addr.id =3D 0;
 	entry->addr.port =3D 0;
+	entry->ifindex =3D 0;
+	entry->flags =3D 0;
 	entry->lsk =3D NULL;
 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
@@ -967,14 +960,14 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, s=
truct genl_info *info,
 	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX]) {
 		u32 val =3D nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
 =

-		entry->addr.ifindex =3D val;
+		entry->ifindex =3D val;
 	}
 =

 	if (tb[MPTCP_PM_ADDR_ATTR_ID])
 		entry->addr.id =3D nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
 =

 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->addr.flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
 =

 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
 		entry->addr.port =3D htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
@@ -1224,11 +1217,11 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *sk=
b, struct genl_info *info)
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
 	}
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		addr_max =3D pernet->add_addr_signal_max;
 		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
 	}
-	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 		addr_max =3D pernet->local_addr_max;
 		WRITE_ONCE(pernet->local_addr_max, addr_max - 1);
 	}
@@ -1344,10 +1337,10 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 		goto nla_put_failure;
 	if (nla_put_u8(skb, MPTCP_PM_ADDR_ATTR_ID, addr->id))
 		goto nla_put_failure;
-	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->addr.flags))
+	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->flags))
 		goto nla_put_failure;
-	if (entry->addr.ifindex &&
-	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->addr.ifindex))
+	if (entry->ifindex &&
+	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->ifindex))
 		goto nla_put_failure;
 =

 	if (addr->family =3D=3D AF_INET &&
@@ -1575,7 +1568,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 =

-	if (addr.addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup =3D 1;
 =

 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
@@ -1585,9 +1578,9 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
 				return ret;
 =

 			if (bkup)
-				entry->addr.flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
+				entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
 			else
-				entry->addr.flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
+				entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
 		}
 	}
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0e301ae56b0..6f7b1bafad9e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -173,8 +173,6 @@ struct mptcp_addr_info {
 	sa_family_t		family;
 	__be16			port;
 	u8			id;
-	u8			flags;
-	int			ifindex;
 	union {
 		struct in_addr addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -183,6 +181,15 @@ struct mptcp_addr_info {
 	};
 };
 =

+struct mptcp_pm_addr_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	u8			flags;
+	int			ifindex;
+	struct rcu_head		rcu;
+	struct socket		*lsk;
+};
+
 enum mptcp_pm_status {
 	MPTCP_PM_ADD_ADDR_RECEIVED,
 	MPTCP_PM_ADD_ADDR_SEND_ACK,
@@ -556,7 +563,7 @@ void mptcp_sock_graft(struct sock *sk, struct socket *p=
arent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
 =

 /* called with sk socket lock held */
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_en=
try *loc,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6af443a18bac..192361d07323 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1250,14 +1250,14 @@ void mptcp_info2sockaddr(const struct mptcp_addr_in=
fo *info,
 #endif
 }
 =

-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_en=
try *loc,
 			    const struct mptcp_addr_info *remote)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
 	struct sockaddr_storage addr;
 	int remote_id =3D remote->id;
-	int local_id =3D loc->id;
+	int local_id =3D loc->addr.id;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
@@ -1288,7 +1288,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
-	mptcp_info2sockaddr(loc, &addr, ssk->sk_family);
+	mptcp_info2sockaddr(&loc->addr, &addr, ssk->sk_family);
 =

 	addrlen =3D sizeof(struct sockaddr_in);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-- =

2.30.2

--===============7215960091864720937==--
