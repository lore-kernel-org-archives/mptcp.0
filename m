Content-Type: multipart/mixed; boundary="===============3012629276425728481=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 1/5] mptcp: drop argument port
 from mptcp_pm_announce_addr
Date: Wed, 24 Feb 2021 11:56:54 +0800
Message-ID: <21d743ca1bee501e0515d23896c16c87d929c3f4.1614138509.git.geliangtang@gmail.com>
In-Reply-To: cover.1614138509.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7928

--===============3012629276425728481==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Drop the redundant argument 'port' from mptcp_pm_announce_addr, use the
port field of another argument 'addr' instead.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm.c         | 6 +++---
 net/mptcp/pm_netlink.c | 9 +++------
 net/mptcp/protocol.h   | 2 +-
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index db2ce84d250a..51534bed5dbe 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -14,7 +14,7 @@
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-			   bool echo, bool port)
+			   bool echo)
 {
 	u8 add_addr =3D READ_ONCE(msk->pm.addr_signal);
 =

@@ -33,7 +33,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_ECHO);
 	if (addr->family =3D=3D AF_INET6)
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_IPV6);
-	if (port)
+	if (addr->port)
 		add_addr |=3D BIT(MPTCP_ADD_ADDR_PORT);
 	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	return 0;
@@ -187,7 +187,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
 	spin_lock_bh(&pm->lock);
 =

 	if (!READ_ONCE(pm->accept_addr)) {
-		mptcp_pm_announce_addr(msk, addr, true, addr->port);
+		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote =3D *addr;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 55fdcb1b5281..2441b23e2021 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -308,7 +308,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 =

 	if (!mptcp_pm_should_add_signal(msk)) {
 		pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
-		mptcp_pm_announce_addr(msk, &entry->addr, false, entry->addr.port);
+		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
 		entry->retrans_times++;
 	}
@@ -417,7 +417,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 		if (local) {
 			if (mptcp_pm_alloc_anno_list(msk, local)) {
 				msk->pm.add_addr_signaled++;
-				mptcp_pm_announce_addr(msk, &local->addr, false, local->addr.port);
+				mptcp_pm_announce_addr(msk, &local->addr, false);
 				mptcp_pm_nl_add_addr_send_ack(msk);
 			}
 		} else {
@@ -468,7 +468,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_=
sock *msk)
 	struct mptcp_addr_info remote;
 	struct mptcp_addr_info local;
 	unsigned int subflows_max;
-	bool use_port =3D false;
 =

 	add_addr_accept_max =3D mptcp_pm_get_add_addr_accept_max(msk);
 	subflows_max =3D mptcp_pm_get_subflows_max(msk);
@@ -488,8 +487,6 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_=
sock *msk)
 	remote =3D msk->pm.remote;
 	if (!remote.port)
 		remote.port =3D sk->sk_dport;
-	else
-		use_port =3D true;
 	memset(&local, 0, sizeof(local));
 	local.family =3D remote.family;
 =

@@ -497,7 +494,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_=
sock *msk)
 	__mptcp_subflow_connect(sk, &local, &remote);
 	spin_lock_bh(&msk->pm.lock);
 =

-	mptcp_pm_announce_addr(msk, &remote, true, use_port);
+	mptcp_pm_announce_addr(msk, &msk->pm.remote, true);
 	mptcp_pm_nl_add_addr_send_ack(msk);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6af3e259fa05..7f3a29bdce46 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -665,7 +665,7 @@ mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 =

 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-			   bool echo, bool port);
+			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, struct mptcp_rm_list rm_l=
ist);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, struct mptcp_rm_list r=
m_list);
 =

-- =

2.29.2

--===============3012629276425728481==--
