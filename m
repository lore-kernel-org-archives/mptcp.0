Content-Type: multipart/mixed; boundary="===============0131170544594910966=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/5] mptcp: pm nl: reduce variable scope
Date: Mon, 25 Jan 2021 10:59:02 -0800
Message-ID: <20210125185904.6997-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210125185904.6997-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7479

--===============0131170544594910966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

To avoid confusions like when working on the previous patch, better to
declare and assign this variable only where it is needed.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm_netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f0afff6ba015..83976b9ee99b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -325,7 +325,6 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 =

 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
-	struct mptcp_addr_info remote =3D { 0 };
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_pm_addr_entry *local;
 	struct pm_nl_pernet *pernet;
@@ -359,13 +358,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
 	/* check if should create a new subflow */
 	if (msk->pm.local_addr_used < msk->pm.local_addr_max &&
 	    msk->pm.subflows < msk->pm.subflows_max) {
-		remote_address((struct sock_common *)sk, &remote);
-
 		local =3D select_local_address(pernet, msk);
 		if (local) {
+			struct mptcp_addr_info remote =3D { 0 };
+
 			msk->pm.local_addr_used++;
 			msk->pm.subflows++;
 			check_work_pending(msk);
+			remote_address((struct sock_common *)sk, &remote);
 			spin_unlock_bh(&msk->pm.lock);
 			__mptcp_subflow_connect(sk, &local->addr, &remote);
 			spin_lock_bh(&msk->pm.lock);
-- =

2.30.0

--===============0131170544594910966==--
