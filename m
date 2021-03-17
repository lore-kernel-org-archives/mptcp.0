Content-Type: multipart/mixed; boundary="===============3490855199530010263=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 1/7] mptcp: move flags and
 ifindex out of mptcp_addr_info
Date: Wed, 17 Mar 2021 15:36:16 +0800
Message-ID: <468e80774d427c36d69d3927b2ed4e8bbf81fdef.1615966219.git.geliangtang@gmail.com>
In-Reply-To: cover.1615966219.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8180

--===============3490855199530010263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch moved the flags and ifindex fields from struct mptcp_addr_info
to struct mptcp_pm_addr_entry. Add the flags and ifindex values as two new
parameters to __mptcp_subflow_connect.

In mptcp_pm_create_subflow_or_signal_addr, pass the local address entry's
flags and ifindex fields to __mptcp_subflow_connect.

In mptcp_pm_nl_add_addr_received, just pass two zeros to it.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 41 ++++++++++++++++++++++-------------------
 net/mptcp/protocol.h   |  5 ++---
 net/mptcp/subflow.c    |  7 ++++---
 3 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a62f887c5198..745073ddded8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -25,6 +25,8 @@ static int pm_nl_pernet_id;
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
+	u8			flags;
+	int			ifindex;
 	struct rcu_head		rcu;
 	struct socket		*lsk;
 };
@@ -168,7 +170,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	rcu_read_lock();
 	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 =

 		if (entry->addr.family !=3D sk->sk_family) {
@@ -206,7 +208,7 @@ select_signal_address(struct pm_nl_pernet *pernet, unsi=
gned int pos)
 	 * can lead to additional addresses not being announced.
 	 */
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 		if (i++ =3D=3D pos) {
 			ret =3D entry;
@@ -459,7 +461,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			check_work_pending(msk);
 			remote_address((struct sock_common *)sk, &remote);
 			spin_unlock_bh(&msk->pm.lock);
-			__mptcp_subflow_connect(sk, &local->addr, &remote);
+			__mptcp_subflow_connect(sk, &local->addr, &remote,
+						local->flags, local->ifindex);
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
@@ -514,7 +517,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_=
sock *msk)
 	local.family =3D remote.family;
 =

 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect(sk, &local, &remote);
+	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
 	spin_lock_bh(&msk->pm.lock);
 =

 add_addr_echo:
@@ -683,7 +686,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk)
 =

 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 {
-	return (entry->addr.flags &
+	return (entry->flags &
 		(MPTCP_PM_ADDR_FLAG_SIGNAL | MPTCP_PM_ADDR_FLAG_SUBFLOW)) =3D=3D
 		MPTCP_PM_ADDR_FLAG_SIGNAL;
 }
@@ -735,11 +738,11 @@ static int mptcp_pm_nl_append_new_local_addr(struct p=
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
@@ -841,10 +844,10 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
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
@@ -959,14 +962,14 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, s=
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
@@ -1218,11 +1221,11 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *sk=
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
@@ -1338,10 +1341,10 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
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
@@ -1569,7 +1572,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 =

-	if (addr.addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup =3D 1;
 =

 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
@@ -1579,9 +1582,9 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb=
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
index e53a9568d587..9005ccc2bc7d 100644
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
@@ -557,7 +555,8 @@ struct socket *__mptcp_nmpc_socket(const struct mptcp_s=
ock *msk);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
-			    const struct mptcp_addr_info *remote);
+			    const struct mptcp_addr_info *remote,
+			    u8 flags, int ifindex);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6af443a18bac..5fc3cada11dd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1251,7 +1251,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info=
 *info,
 }
 =

 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
-			    const struct mptcp_addr_info *remote)
+			    const struct mptcp_addr_info *remote,
+			    u8 flags, int ifindex)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
@@ -1295,7 +1296,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	if (addr.ss_family =3D=3D AF_INET6)
 		addrlen =3D sizeof(struct sockaddr_in6);
 #endif
-	ssk->sk_bound_dev_if =3D loc->ifindex;
+	ssk->sk_bound_dev_if =3D ifindex;
 	err =3D kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
 		goto failed;
@@ -1307,7 +1308,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	subflow->local_id =3D local_id;
 	subflow->remote_id =3D remote_id;
 	subflow->request_join =3D 1;
-	subflow->request_bkup =3D !!(loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->request_bkup =3D !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 =

 	mptcp_add_pending_subflow(msk, subflow);
-- =

2.30.2

--===============3490855199530010263==--
