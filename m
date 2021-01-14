Content-Type: multipart/mixed; boundary="===============5614153654658186202=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 3/5] mptcp: create subflow or
 signal addr for newly added address
Date: Thu, 14 Jan 2021 12:26:21 +0800
Message-ID: <64867c431b0c895f50e0393ffba9767f04a87760.1610597571.git.geliangtang@gmail.com>
In-Reply-To: 547df74bea2b590343f4187ba459b26b4c8d8f3e.1610597571.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7354

--===============5614153654658186202==
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
 net/mptcp/pm_netlink.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 42dd576c7b55..43fb670cabab 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -847,6 +847,31 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct gen=
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
@@ -872,6 +897,8 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, s=
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

--===============5614153654658186202==--
