Content-Type: multipart/mixed; boundary="===============4492201340776086278=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 1/3] mptcp: add add_addr_echo sysctl
Date: Tue, 22 Sep 2020 16:12:51 +0800
Message-ID: <8d5a4bc3ef6b50f38e829f2cd5db881a30d41d5d.1600762109.git.geliangtang@gmail.com>
In-Reply-To: cover.1600762109.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5980

--===============4492201340776086278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new sysctl, named add_addr_echo, to control the ADD_ADDR
echo ability.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/ctrl.c       | 14 ++++++++++++++
 net/mptcp/pm.c         |  9 ++++++---
 net/mptcp/pm_netlink.c |  4 +++-
 net/mptcp/protocol.h   |  1 +
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 54b888f94009..2a250f2047a7 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -18,6 +18,7 @@ struct mptcp_pernet {
 	struct ctl_table_header *ctl_table_hdr;
 =

 	int mptcp_enabled;
+	int add_addr_echo;
 };
 =

 static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
@@ -30,6 +31,11 @@ int mptcp_is_enabled(struct net *net)
 	return mptcp_get_pernet(net)->mptcp_enabled;
 }
 =

+int mptcp_add_addr_echo_is_enabled(struct net *net)
+{
+	return mptcp_get_pernet(net)->add_addr_echo;
+}
+
 static struct ctl_table mptcp_sysctl_table[] =3D {
 	{
 		.procname =3D "enabled",
@@ -40,12 +46,19 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		 */
 		.proc_handler =3D proc_dointvec,
 	},
+	{
+		.procname =3D "add_addr_echo",
+		.maxlen =3D sizeof(int),
+		.mode =3D 0644,
+		.proc_handler =3D proc_dointvec,
+	},
 	{}
 };
 =

 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled =3D 1;
+	pernet->add_addr_echo =3D 1;
 }
 =

 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pe=
rnet)
@@ -61,6 +74,7 @@ static int mptcp_pernet_new_table(struct net *net, struct=
 mptcp_pernet *pernet)
 	}
 =

 	table[0].data =3D &pernet->mptcp_enabled;
+	table[1].data =3D &pernet->add_addr_echo;
 =

 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7e81f53d1e5d..01663ec0c7e2 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -143,6 +143,7 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8=
 id)
 void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr)
 {
+	struct net *net =3D sock_net((struct sock *)msk);
 	struct mptcp_pm_data *pm =3D &msk->pm;
 =

 	pr_debug("msk=3D%p remote_id=3D%d accept=3D%d", msk, addr->id,
@@ -150,10 +151,12 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
 =

 	spin_lock_bh(&pm->lock);
 =

-	if (!READ_ONCE(pm->accept_addr))
-		mptcp_pm_announce_addr(msk, addr, true);
-	else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
+	if (!READ_ONCE(pm->accept_addr)) {
+		if (mptcp_add_addr_echo_is_enabled(net))
+			mptcp_pm_announce_addr(msk, addr, true);
+	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote =3D *addr;
+	}
 =

 	spin_unlock_bh(&pm->lock);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5a0e4d11bcc3..d45f2320355a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -369,6 +369,7 @@ void mptcp_pm_nl_subflow_established(struct mptcp_sock =
*msk)
 void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
+	struct net *net =3D sock_net(sk);
 	struct mptcp_addr_info remote;
 	struct mptcp_addr_info local;
 =

@@ -394,7 +395,8 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 =

-	mptcp_pm_announce_addr(msk, &remote, true);
+	if (mptcp_add_addr_echo_is_enabled(net))
+		mptcp_pm_announce_addr(msk, &remote, true);
 }
 =

 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cfe52aeb2b8..e0b00cc8bfaf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -361,6 +361,7 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow=
_context *subflow)
 }
 =

 int mptcp_is_enabled(struct net *net);
+int mptcp_add_addr_echo_is_enabled(struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool mptcp_subflow_data_available(struct sock *sk);
-- =

2.17.1

--===============4492201340776086278==--
