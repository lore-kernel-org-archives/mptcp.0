Content-Type: multipart/mixed; boundary="===============6905218988921032670=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 3/4] mptcp: add the RM_ADDR
 option parsing
Date: Wed, 22 Jul 2020 16:42:30 +0800
Message-ID: <5236563860251c88b7f7b723f1515ef9b13d56b4.1595407078.git.geliangtang@gmail.com>
In-Reply-To: cover.1595407078.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5172

--===============6905218988921032670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the RM_ADDR option parsing logic.

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c    |  5 +++++
 net/mptcp/pm.c         | 12 ++++++++++++
 net/mptcp/pm_netlink.c | 20 ++++++++++++++++++++
 net/mptcp/protocol.c   |  8 ++++++--
 net/mptcp/protocol.h   |  5 +++++
 net/mptcp/subflow.c    |  1 +
 6 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 38685e0e06db..b9e6e67ed195 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -875,6 +875,11 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb,
 		mp_opt.add_addr =3D 0;
 	}
 =

+	if (mp_opt.rm_addr) {
+		mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
+		mp_opt.rm_addr =3D 0;
+	}
+
 	if (!mp_opt.dss)
 		return;
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 91b74ca47fa1..84fad1fec28b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -149,6 +149,18 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 =

+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
+{
+	struct mptcp_pm_data *pm =3D &msk->pm;
+
+	pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
+
+	spin_lock_bh(&pm->lock);
+	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
+	pm->rm_id =3D rm_id;
+	spin_unlock_bh(&pm->lock);
+}
+
 /* path manager helpers */
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c8820c4156e6..2ee7227f5f2b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -261,6 +261,26 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *=
msk)
 	spin_lock_bh(&msk->pm.lock);
 }
 =

+void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+
+	pr_debug("remote_id %d", msk->pm.rm_id);
+
+	msk->pm.add_addr_accepted--;
+	msk->pm.subflows--;
+	WRITE_ONCE(msk->pm.accept_addr, true);
+
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
+
+		if (msk->pm.rm_id =3D=3D subflow->remote_id) {
+			mptcp_subflow_shutdown(tcp_sk, 1, 1, msk->write_seq);
+			list_del(&subflow->node);
+		}
+	}
+}
+
 static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 {
 	return (entry->flags &
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f0b0b503c262..fcd16e815aa5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1225,6 +1225,10 @@ static void pm_work(struct mptcp_sock *msk)
 		pm->status &=3D ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
 		mptcp_pm_nl_add_addr_received(msk);
 	}
+	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
+		pm->status &=3D ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
+		mptcp_pm_nl_rm_addr_received(msk);
+	}
 	if (pm->status & BIT(MPTCP_PM_ESTABLISHED)) {
 		pm->status &=3D ~BIT(MPTCP_PM_ESTABLISHED);
 		mptcp_pm_nl_fully_established(msk);
@@ -1381,8 +1385,8 @@ static void mptcp_cancel_work(struct sock *sk)
 		sock_put(sk);
 }
 =

-static void mptcp_subflow_shutdown(struct sock *ssk, int how,
-				   bool data_fin_tx_enable, u64 data_fin_tx_seq)
+void mptcp_subflow_shutdown(struct sock *ssk, int how,
+			    bool data_fin_tx_enable, u64 data_fin_tx_seq)
 {
 	lock_sock(ssk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7bd8d08c8fc0..fb09b6fb854e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -150,6 +150,7 @@ struct mptcp_addr_info {
 =

 enum mptcp_pm_status {
 	MPTCP_PM_ADD_ADDR_RECEIVED,
+	MPTCP_PM_RM_ADDR_RECEIVED,
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 };
@@ -346,6 +347,8 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow=
_context *subflow)
 int mptcp_is_enabled(struct net *net);
 bool mptcp_subflow_data_available(struct sock *sk);
 void __init mptcp_subflow_init(void);
+void mptcp_subflow_shutdown(struct sock *ssk, int how,
+			    bool data_fin_tx_enable, u64 data_fin_tx_seq);
 =

 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, int ifindex,
@@ -423,6 +426,7 @@ void mptcp_pm_subflow_established(struct mptcp_sock *ms=
k,
 void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr);
@@ -457,6 +461,7 @@ void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
 void mptcp_pm_nl_fully_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk);
 void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
+void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *s=
kc);
 =

 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 519122e66f17..2864b8d20dbd 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -990,6 +990,7 @@ int __mptcp_subflow_connect(struct sock *sk, int ifinde=
x,
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
+	subflow->remote_id =3D remote->id;
 	mptcp_info2sockaddr(loc, &addr);
 =

 	addrlen =3D sizeof(struct sockaddr_in);
-- =

2.17.1

--===============6905218988921032670==--
