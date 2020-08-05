Content-Type: multipart/mixed; boundary="===============2406481439148418059=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 09/13] mptcp: move address attribute into
 mptcp_addr_info
Date: Wed, 05 Aug 2020 19:57:08 +0200
Message-ID: <9121aa3ff574670cdd09a7c06dc160d8925e7817.1596649926.git.pabeni@redhat.com>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5488

--===============2406481439148418059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

So that can be accessed easily from subflow creation
helper. No functional change intended.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
RFC -> v1:
 - flags is now u8 (Florian)
---
 net/mptcp/pm_netlink.c | 38 +++++++++++++++++++-------------------
 net/mptcp/protocol.h   |  5 +++--
 net/mptcp/subflow.c    |  5 ++---
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c8820c4156e6..b15fb3c20146 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -23,8 +23,6 @@ static int pm_nl_pernet_id;
 =

 struct mptcp_pm_addr_entry {
 	struct list_head	list;
-	unsigned int		flags;
-	int			ifindex;
 	struct mptcp_addr_info	addr;
 	struct rcu_head		rcu;
 };
@@ -119,7 +117,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	rcu_read_lock();
 	spin_lock_bh(&msk->join_list_lock);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
 =

 		/* avoid any address already in use by subflows and
@@ -150,7 +148,7 @@ select_signal_address(struct pm_nl_pernet *pernet, unsi=
gned int pos)
 	 * can lead to additional addresses not being announced.
 	 */
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 		if (i++ =3D=3D pos) {
 			ret =3D entry;
@@ -210,8 +208,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 			msk->pm.subflows++;
 			check_work_pending(msk);
 			spin_unlock_bh(&msk->pm.lock);
-			__mptcp_subflow_connect(sk, local->ifindex,
-						&local->addr, &remote);
+			__mptcp_subflow_connect(sk, &local->addr, &remote);
 			spin_lock_bh(&msk->pm.lock);
 			return;
 		}
@@ -257,13 +254,13 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock =
*msk)
 	local.family =3D remote.family;
 =

 	spin_unlock_bh(&msk->pm.lock);
-	__mptcp_subflow_connect((struct sock *)msk, 0, &local, &remote);
+	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 }
 =

 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 {
-	return (entry->flags &
+	return (entry->addr.flags &
 		(MPTCP_PM_ADDR_FLAG_SIGNAL | MPTCP_PM_ADDR_FLAG_SUBFLOW)) =3D=3D
 		MPTCP_PM_ADDR_FLAG_SIGNAL;
 }
@@ -293,9 +290,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_=
nl_pernet *pernet,
 			goto out;
 	}
 =

-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
 		pernet->add_addr_signal_max++;
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 		pernet->local_addr_max++;
 =

 	entry->addr.id =3D pernet->next_id++;
@@ -345,8 +342,9 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, st=
ruct sock_common *skc)
 	if (!entry)
 		return -ENOMEM;
 =

-	entry->flags =3D 0;
 	entry->addr =3D skc_local;
+	entry->addr.ifindex =3D 0;
+	entry->addr.flags =3D 0;
 	ret =3D mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -460,14 +458,16 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, s=
truct genl_info *info,
 		entry->addr.addr.s_addr =3D nla_get_in_addr(tb[addr_addr]);
 =

 skip_family:
-	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX])
-		entry->ifindex =3D nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
+	if (tb[MPTCP_PM_ADDR_ATTR_IF_IDX]) {
+		u32 val =3D nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);
+		entry->addr.ifindex =3D val;
+	}
 =

 	if (tb[MPTCP_PM_ADDR_ATTR_ID])
 		entry->addr.id =3D nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
 =

 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
-		entry->flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
+		entry->addr.flags =3D nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
 =

 	return 0;
 }
@@ -535,9 +535,9 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, s=
truct genl_info *info)
 		ret =3D -EINVAL;
 		goto out;
 	}
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)
 		pernet->add_addr_signal_max--;
-	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+	if (entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
 		pernet->local_addr_max--;
 =

 	pernet->addrs--;
@@ -593,10 +593,10 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
 		goto nla_put_failure;
 	if (nla_put_u8(skb, MPTCP_PM_ADDR_ATTR_ID, addr->id))
 		goto nla_put_failure;
-	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->flags))
+	if (nla_put_u32(skb, MPTCP_PM_ADDR_ATTR_FLAGS, entry->addr.flags))
 		goto nla_put_failure;
-	if (entry->ifindex &&
-	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->ifindex))
+	if (entry->addr.ifindex &&
+	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->addr.ifindex))
 		goto nla_put_failure;
 =

 	if (addr->family =3D=3D AF_INET &&
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 26f5f81f3f4c..cfa5e1b9521b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -140,6 +140,8 @@ struct mptcp_addr_info {
 	sa_family_t		family;
 	__be16			port;
 	u8			id;
+	u8			flags;
+	int			ifindex;
 	union {
 		struct in_addr addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -358,8 +360,7 @@ bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
 =

 /* called with sk socket lock held */
-int __mptcp_subflow_connect(struct sock *sk, int ifindex,
-			    const struct mptcp_addr_info *loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c03b448ca000..00cab7d3dbae 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1042,8 +1042,7 @@ static void mptcp_info2sockaddr(const struct mptcp_ad=
dr_info *info,
 #endif
 }
 =

-int __mptcp_subflow_connect(struct sock *sk, int ifindex,
-			    const struct mptcp_addr_info *loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info =
*loc,
 			    const struct mptcp_addr_info *remote)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
@@ -1087,7 +1086,7 @@ int __mptcp_subflow_connect(struct sock *sk, int ifin=
dex,
 	if (loc->family =3D=3D AF_INET6)
 		addrlen =3D sizeof(struct sockaddr_in6);
 #endif
-	ssk->sk_bound_dev_if =3D ifindex;
+	ssk->sk_bound_dev_if =3D loc->ifindex;
 	err =3D kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
 		goto failed;
-- =

2.26.2

--===============2406481439148418059==--
