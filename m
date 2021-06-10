Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA12FB2
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 08:52:21 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:40052.999822468
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-f7c5a0468a3942f1a4a4b00055d3061f (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 6533B280105;
	Thu, 10 Jun 2021 16:52:18 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 13aea64d4fa64d90815c86d34bd803b0 for mptcp@lists.linux.dev;
	Thu Jun 10 16:52:20 2021
X-Transaction-ID: 13aea64d4fa64d90815c86d34bd803b0
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH 2/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
Date: Thu, 10 Jun 2021 16:51:56 +0800
Message-Id: <1623315118-57936-3-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623315118-57936-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1623315118-57936-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

MPTCP_ADD_ADDR_SIGNAL only for action of sending ADD_ADDR
MPTCP_ADD_ADDR_ECHO only for action of sending echo ADD_ADDR
add a mptcp_addr_info in struct mptcp_out_options for echo ADD_ADDR

to prepare for the next patch.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 include/net/mptcp.h    |  1 +
 net/mptcp/pm.c         | 13 ++++++++-----
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.h   |  6 ++++++
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d61bbbf..637e90b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -62,6 +62,7 @@ struct mptcp_out_options {
 	u64 rcvr_key;
 	u64 ahmac;
 	struct mptcp_addr_info addr;
+	struct mptcp_addr_info remote;
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
 	u8 backup;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 74886a3..9966ed1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -18,7 +18,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d", msk, addr->id);
+	pr_debug("msk=%p, local_id=%d, echo:%d", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -27,10 +27,13 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 		return -EINVAL;
 	}
 
-	msk->pm.local = *addr;
-	add_addr |= BIT(MPTCP_ADD_ADDR_SIGNAL);
-	if (echo)
+	if (echo) {
+		msk->pm.remote = *addr;
 		add_addr |= BIT(MPTCP_ADD_ADDR_ECHO);
+	} else {
+		msk->pm.local = *addr;
+		add_addr |= BIT(MPTCP_ADD_ADDR_SIGNAL);
+	}
 	if (addr->family == AF_INET6)
 		add_addr |= BIT(MPTCP_ADD_ADDR_IPV6);
 	if (addr->port)
@@ -214,7 +217,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
-	if (!mptcp_pm_should_add_signal(msk))
+	if (!mptcp_pm_should_add_signal_echo(msk))
 		return;
 
 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c53e500..ae700bd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -317,14 +317,14 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
-	if (mptcp_pm_should_add_signal(msk)) {
+	if (mptcp_pm_should_add_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
 	}
 
 	spin_lock_bh(&msk->pm.lock);
 
-	if (!mptcp_pm_should_add_signal(msk)) {
+	if (!mptcp_pm_should_add_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6c2322e..d14d03e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -708,6 +708,12 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
+	return READ_ONCE(msk->pm.addr_signal) &
+		(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
+}
+
+static inline bool mptcp_pm_should_add_addr(struct mptcp_sock *msk)
+{
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
 }
 
-- 
1.8.3.1

