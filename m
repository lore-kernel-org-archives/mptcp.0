Content-Type: multipart/mixed; boundary="===============9009202560140739074=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: add the incoming RM_ADDR support"
Date: Thu, 03 Sep 2020 18:38:23 +0800
Message-ID: <f5882b944b7f71bc36dbb378209c6e3162a42d1d.1599128137.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5712

--===============9009202560140739074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This squash-to patch fixed three issues in "mptcp: add the incoming RM_ADDR
support":

1. We will use another function mptcp_pm_nl_rm_subflow_received to remove a
local subflow, so the mptcp_pm_nl_rm_addr_received function only need to
deal with remote address removing. Thus we only need to check
subflow->remote_id in mptcp_pm_nl_rm_addr_received.

2. Update PM counters in the right place.

3. Drop the remot_id fixing code here, since another new patch will deal wi=
th
subflow's remote_id and local_id fixing.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 16 ++++++++--------
 net/mptcp/subflow.c    |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 544adfe66454..b1ce74bc589d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -173,7 +173,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 {
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_pm_addr_entry *local;
-	struct mptcp_addr_info remote =3D { 0 };
+	struct mptcp_addr_info remote;
 	struct pm_nl_pernet *pernet;
 =

 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
@@ -266,7 +266,7 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *ms=
k)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct sock *sk =3D (struct sock *)msk;
 =

-	pr_debug("rm_id %d", msk->pm.rm_id);
+	pr_debug("address rm_id %d", msk->pm.rm_id);
 =

 	if (!msk->pm.rm_id)
 		return;
@@ -274,23 +274,23 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *=
msk)
 	if (list_empty(&msk->conn_list))
 		return;
 =

-	msk->pm.add_addr_accepted--;
-	msk->pm.subflows--;
-	WRITE_ONCE(msk->pm.accept_addr, true);
-
 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
 		int how =3D RCV_SHUTDOWN | SEND_SHUTDOWN;
 		long timeout =3D 0;
 =

-		if (msk->pm.rm_id !=3D subflow->remote_id &&
-		    msk->pm.rm_id !=3D subflow->local_id)
+		if (msk->pm.rm_id !=3D subflow->remote_id)
 			continue;
 =

 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, how);
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 		spin_lock_bh(&msk->pm.lock);
+
+		msk->pm.add_addr_accepted--;
+		msk->pm.subflows--;
+		WRITE_ONCE(msk->pm.accept_addr, true);
+
 		break;
 	}
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8464170e8dc1..535a3f9f8cfc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1094,7 +1094,6 @@ int __mptcp_subflow_connect(struct sock *sk, int ifin=
dex,
 	subflow->remote_key =3D msk->remote_key;
 	subflow->local_key =3D msk->local_key;
 	subflow->token =3D msk->token;
-	subflow->remote_id =3D remote->id;
 	mptcp_info2sockaddr(loc, &addr);
 =

 	addrlen =3D sizeof(struct sockaddr_in);
-- =

2.17.1

--===============9009202560140739074==--
