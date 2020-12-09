Content-Type: multipart/mixed; boundary="===============8898747374634762038=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 07/11] mptcp: add port parameter for
 mptcp_pm_announce_addr
Date: Wed, 09 Dec 2020 15:51:24 -0800
Message-ID: <20201209235128.175473-8-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20201209235128.175473-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7113

--===============8898747374634762038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Geliang Tang <geliangtang(a)gmail.com>

This patch added a new parameter 'port' for mptcp_pm_announce_addr. If
this parameter is true, we set the MPTCP_ADD_ADDR_PORT bit of the
add_addr_signal. That means the announced address is added with a port
number.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/pm.c         | 6 ++++--
 net/mptcp/pm_netlink.c | 9 ++++++---
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d20637860851..ac590274b048 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -14,7 +14,7 @@
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-			   bool echo)
+			   bool echo, bool port)
 {
 	u8 add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
 =

@@ -26,6 +26,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_ECHO);
 	if (addr->family =3D=3D AF_INET6)
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_IPV6);
+	if (port)
+		add_addr |=3D BIT(MPTCP_ADD_ADDR_PORT);
 	WRITE_ONCE(msk->pm.add_addr_signal, add_addr);
 	return 0;
 }
@@ -162,7 +164,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_lock_bh(&pm->lock);
 =

 	if (!READ_ONCE(pm->accept_addr)) {
-		mptcp_pm_announce_addr(msk, addr, true);
+		mptcp_pm_announce_addr(msk, addr, true, addr->port);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote =3D *addr;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7a0f700e34bb..2560c502356b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -227,7 +227,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 =

 	if (!mptcp_pm_should_add_signal(msk)) {
 		pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
-		mptcp_pm_announce_addr(msk, &entry->addr, false);
+		mptcp_pm_announce_addr(msk, &entry->addr, false, entry->addr.port);
 		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
 	}
@@ -328,7 +328,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 		if (local) {
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false);
+				mptcp_pm_announce_addr(msk, &local->addr, false, local->addr.port);
 				mptcp_pm_nl_add_addr_send_ack(msk);
 			}
 		} else {
@@ -376,6 +376,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	struct sock *sk =3D (struct sock *)msk;
 	struct mptcp_addr_info remote;
 	struct mptcp_addr_info local;
+	bool use_port =3D false;
 =

 	pr_debug("accepted %d:%d remote family %d",
 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
@@ -392,6 +393,8 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	remote =3D msk->pm.remote;
 	if (!remote.port)
 		remote.port =3D sk->sk_dport;
+	else
+		use_port =3D true;
 	memset(&local, 0, sizeof(local));
 	local.family =3D remote.family;
 =

@@ -399,7 +402,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *m=
sk)
 	__mptcp_subflow_connect((struct sock *)msk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 =

-	mptcp_pm_announce_addr(msk, &remote, true);
+	mptcp_pm_announce_addr(msk, &remote, true, use_port);
 	mptcp_pm_nl_add_addr_send_ack(msk);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8e8f1f770a8e..cda84b892182 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -553,7 +553,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-			   bool echo);
+			   bool echo, bool port);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id);
 =

-- =

2.29.2

--===============8898747374634762038==--
