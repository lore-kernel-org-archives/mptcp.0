Content-Type: multipart/mixed; boundary="===============6748592187950526644=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/3] mptcp: add add_addr_timeout
 sysctl
Date: Tue, 22 Sep 2020 16:12:52 +0800
Message-ID: <42aa4bc355cb51f90e1cd6748baf08ddab4627c8.1600762109.git.geliangtang@gmail.com>
In-Reply-To: cover.1600762109.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5981

--===============6748592187950526644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new sysctl, named add_addr_timeout, to control the
timeout value (in seconds) of the ADD_ADDR retransmission.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/ctrl.c       | 14 ++++++++++++++
 net/mptcp/pm_netlink.c |  8 ++++++--
 net/mptcp/protocol.h   |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 2a250f2047a7..4131f496cd84 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -19,6 +19,7 @@ struct mptcp_pernet {
 =

 	int mptcp_enabled;
 	int add_addr_echo;
+	u32 add_addr_timeout;
 };
 =

 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -36,6 +37,11 @@ int mptcp_add_addr_echo_is_enabled(struct net *net)
 	return mptcp_get_pernet(net)->add_addr_echo;
 }
 =

+unsigned long mptcp_get_add_addr_timeout(struct net *net)
+{
+	return jiffies + mptcp_get_pernet(net)->add_addr_timeout * HZ;
+}
+
 static struct ctl_table mptcp_sysctl_table[] =3D {
 	{
 		.procname =3D "enabled",
@@ -52,6 +58,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		.mode =3D 0644,
 		.proc_handler =3D proc_dointvec,
 	},
+	{
+		.procname =3D "add_addr_timeout",
+		.maxlen =3D sizeof(u32),
+		.mode =3D 0644,
+		.proc_handler =3D proc_douintvec,
+	},
 	{}
 };
 =

@@ -59,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet=
 *pernet)
 {
 	pernet->mptcp_enabled =3D 1;
 	pernet->add_addr_echo =3D 1;
+	pernet->add_addr_timeout =3D TCP_RTO_MAX / HZ;
 }
 =

 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pe=
rnet)
@@ -75,6 +88,7 @@ static int mptcp_pernet_new_table(struct net *net, struct=
 mptcp_pernet *pernet)
 =

 	table[0].data =3D &pernet->mptcp_enabled;
 	table[1].data =3D &pernet->add_addr_echo;
+	table[2].data =3D &pernet->add_addr_timeout;
 =

 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d45f2320355a..1d6d2840be7a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -206,6 +206,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk =3D entry->sock;
 	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
+	unsigned long timeout =3D mptcp_get_add_addr_timeout(net);
 =

 	pr_debug("msk=3D%p", msk);
 =

@@ -232,7 +234,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	}
 =

 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX);
+		sk_reset_timer(sk, timer, timeout);
 =

 	spin_unlock_bh(&msk->pm.lock);
 =

@@ -264,6 +266,8 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 {
 	struct mptcp_pm_add_entry *add_entry =3D NULL;
 	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
+	unsigned long timeout =3D mptcp_get_add_addr_timeout(net);
 =

 	if (lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
@@ -279,7 +283,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock =
*msk,
 	add_entry->retrans_times =3D 0;
 =

 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer, jiffies + TCP_RTO_MAX);
+	sk_reset_timer(sk, &add_entry->add_timer, timeout);
 =

 	return true;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e0b00cc8bfaf..d922884a1f96 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -362,6 +362,7 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow=
_context *subflow)
 =

 int mptcp_is_enabled(struct net *net);
 int mptcp_add_addr_echo_is_enabled(struct net *net);
+unsigned long mptcp_get_add_addr_timeout(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- =

2.17.1

--===============6748592187950526644==--
