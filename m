Content-Type: multipart/mixed; boundary="===============5141298783750935694=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v6 3/5] mptcp: pm nl: reduce variable scope
Date: Thu, 14 Jan 2021 18:29:24 +0100
Message-ID: <20210114172926.2563610-4-matthieu.baerts@tessares.net>
In-Reply-To: 20210114172926.2563610-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7378

--===============5141298783750935694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To avoid confusions like when working on the previous patch, better to
declare and assign this variable only where it is needed.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    v5 -> v6:
    - move the declaration of 'remote' to reduce the scope and to do it only
      when needed (dedicated commit). (Geliang)

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

2.29.2

--===============5141298783750935694==--
