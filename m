Content-Type: multipart/mixed; boundary="===============5282743472511904909=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 1/3] mptcp: create subflow or
 signal addr for newly added address
Date: Fri, 18 Dec 2020 23:24:54 +0800
Message-ID: <63f5c119fbf75f9089b7097915523cd3c57f41f0.1608304480.git.geliangtang@gmail.com>
In-Reply-To: cover.1608304480.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7218

--===============5282743472511904909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, when a new MPTCP endpoint is added, the existing MPTCP sockets
are not affected.

This patch implemented a new function mptcp_nl_add_subflow_or_signal_addr,
invoked when an address is added from PM netlink. This function traversed
the MPTCP sockets list and invoked mptcp_pm_create_subflow_or_signal_addr
to try to create a subflow or signal an address for the newly added
address, if local constraint allows that.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 43 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9c688023f494..96993ded911c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -316,17 +316,21 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
 	struct mptcp_addr_info remote =3D { 0 };
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_pm_addr_entry *local;
+	unsigned int add_addr_signal_max;
+	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 =

 	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
+	add_addr_signal_max =3D READ_ONCE(pernet->add_addr_signal_max);
+	local_addr_max =3D READ_ONCE(pernet->local_addr_max);
 =

 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
-		 msk->pm.local_addr_used, msk->pm.local_addr_max,
-		 msk->pm.add_addr_signaled, msk->pm.add_addr_signal_max,
+		 msk->pm.local_addr_used, local_addr_max,
+		 msk->pm.add_addr_signaled, add_addr_signal_max,
 		 msk->pm.subflows, msk->pm.subflows_max);
 =

 	/* check first for announce */
-	if (msk->pm.add_addr_signaled < msk->pm.add_addr_signal_max) {
+	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
 		local =3D select_signal_address(pernet,
 					      msk->pm.add_addr_signaled);
 =

@@ -338,14 +342,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
 			}
 		} else {
 			/* pick failed, avoid fourther attempts later */
-			msk->pm.local_addr_used =3D msk->pm.add_addr_signal_max;
+			msk->pm.local_addr_used =3D add_addr_signal_max;
 		}
 =

 		check_work_pending(msk);
 	}
 =

 	/* check if should create a new subflow */
-	if (msk->pm.local_addr_used < msk->pm.local_addr_max &&
+	if (msk->pm.local_addr_used < local_addr_max &&
 	    msk->pm.subflows < msk->pm.subflows_max) {
 		remote_address((struct sock_common *)sk, &remote);
 =

@@ -361,7 +365,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 		}
 =

 		/* lookup failed, avoid fourther attempts later */
-		msk->pm.local_addr_used =3D msk->pm.local_addr_max;
+		msk->pm.local_addr_used =3D local_addr_max;
 		check_work_pending(msk);
 	}
 }
@@ -793,6 +797,31 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct gen=
l_info *info)
 	return net_generic(genl_info_net(info), pm_nl_pernet_id);
 }
 =

+static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
+{
+	struct mptcp_sock *msk;
+	long s_slot =3D 0, s_num =3D 0;
+
+	while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D NULL) {
+		struct sock *sk =3D (struct sock *)msk;
+
+		if (!READ_ONCE(msk->fully_established))
+			goto next;
+
+		lock_sock(sk);
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_create_subflow_or_signal_addr(msk);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock(sk);
+
+next:
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return 0;
+}
+
 static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *in=
fo)
 {
 	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
@@ -818,6 +847,8 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, s=
truct genl_info *info)
 		return ret;
 	}
 =

+	mptcp_nl_add_subflow_or_signal_addr(sock_net(skb->sk));
+
 	return 0;
 }
 =

-- =

2.29.2

--===============5282743472511904909==--
