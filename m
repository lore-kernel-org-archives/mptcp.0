Content-Type: multipart/mixed; boundary="===============8699405025161085383=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 1/7] mptcp: pm: add lockdep assertions
Date: Thu, 14 Jan 2021 18:36:48 +0100
Message-ID: <20210114173654.7618-2-fw@strlen.de>
In-Reply-To: 20210114173654.7618-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7382

--===============8699405025161085383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a few assertions to make sure functions are called with the needed
locks held.
Two functions gain might_sleep annotations because they contain conditional
calls to functions that sleep.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/pm.c         |  2 ++
 net/mptcp/pm_netlink.c | 13 +++++++++++++
 net/mptcp/protocol.c   |  4 ++++
 net/mptcp/protocol.h   |  5 +++++
 4 files changed, 24 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 0a6ebd0642ec..192ebd424cd6 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -20,6 +20,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 =

 	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
 =

+	lockdep_assert_held(&msk->pm.lock);
+
 	if (add_addr) {
 		pr_warn("addr_signal error, add_addr=3D%d", add_addr);
 		return -EINVAL;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9b1f6298bbdb..fabe431f256e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -138,6 +138,8 @@ select_local_address(const struct pm_nl_pernet *pernet,
 {
 	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
 =

+	msk_owned_by_me(msk);
+
 	rcu_read_lock();
 	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -195,6 +197,8 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 {
 	struct mptcp_pm_add_entry *entry;
 =

+	lockdep_assert_held(&msk->pm.lock);
+
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
 		if (addresses_equal(&entry->addr, addr, false))
 			return entry;
@@ -270,6 +274,8 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 	struct sock *sk =3D (struct sock *)msk;
 	struct net *net =3D sock_net(sk);
 =

+	lockdep_assert_held(&msk->pm.lock);
+
 	if (lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
 =

@@ -412,6 +418,9 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *m=
sk)
 {
 	struct mptcp_subflow_context *subflow;
 =

+	msk_owned_by_me(msk);
+	lockdep_assert_held(&msk->pm.lock);
+
 	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
 	    !mptcp_pm_should_add_signal_port(msk))
 		return;
@@ -484,6 +493,8 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *ms=
k)
 =

 	pr_debug("address rm_id %d", msk->pm.rm_id);
 =

+	msk_owned_by_me(msk);
+
 	if (!msk->pm.rm_id)
 		return;
 =

@@ -519,6 +530,8 @@ void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock =
*msk, u8 rm_id)
 =

 	pr_debug("subflow rm_id %d", rm_id);
 =

+	msk_owned_by_me(msk);
+
 	if (!rm_id)
 		return;
 =

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d538f5a6810c..61d138a571b0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2170,6 +2170,8 @@ static void __mptcp_close_subflow(struct mptcp_sock *=
msk)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
 =

+	might_sleep();
+
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 =

@@ -2517,6 +2519,8 @@ static void __mptcp_destroy_sock(struct sock *sk)
 =

 	pr_debug("msk=3D%p", msk);
 =

+	might_sleep();
+
 	/* dispose the ancillatory tcp socket, if any */
 	if (msk->subflow) {
 		iput(SOCK_INODE(msk->subflow));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 871534df6140..dfd96b790f43 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -291,6 +291,11 @@ struct mptcp_sock {
 #define mptcp_for_each_subflow(__msk, __subflow)			\
 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
 =

+static inline void msk_owned_by_me(const struct mptcp_sock *msk)
+{
+	sock_owned_by_me((const struct sock *)msk);
+}
+
 static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
 {
 	return (struct mptcp_sock *)sk;
-- =

2.26.2

--===============8699405025161085383==--
