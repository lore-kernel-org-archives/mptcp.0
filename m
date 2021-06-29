Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78970
	for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 01:42:03 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:33510.417183281
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-5a0c242f35f34769876aa48fc24ed7bb (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id B9772280109;
	Tue, 29 Jun 2021 09:41:59 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id f82f81f5382d4dd9a627412ee2eddff8 for mptcp@lists.linux.dev;
	Tue Jun 29 09:41:58 2021
X-Transaction-ID: f82f81f5382d4dd9a627412ee2eddff8
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v6 2/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
Date: Tue, 29 Jun 2021 09:41:37 +0800
Message-Id: <1624930899-99623-3-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
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
 net/mptcp/pm.c         | 16 ++++++++++------
 net/mptcp/pm_netlink.c |  4 ++--
 net/mptcp/protocol.h   |  6 ++++++
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6c427c8..cf873e9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -18,19 +18,23 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 {
 	u8 add_addr = READ_ONCE(msk->pm.addr_signal);
 
-	pr_debug("msk=%p, local_id=%d", msk, addr->id);
+	pr_debug("msk=%p, local_id=%d, echo:%d", msk, addr->id, echo);
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	if (add_addr) {
-		pr_warn("addr_signal error, add_addr=%d", add_addr);
+	if (add_addr &
+	    (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL))) {
+		pr_warn("addr_signal error, add_addr=%d, echo=%d", add_addr, echo);
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
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d4732a4..0f302d2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -317,14 +317,14 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (!entry->addr.id)
 		return;
 
-	if (mptcp_pm_should_add_signal(msk)) {
+	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
 	}
 
 	spin_lock_bh(&msk->pm.lock);
 
-	if (!mptcp_pm_should_add_signal(msk)) {
+	if (!mptcp_pm_should_add_signal_addr(msk)) {
 		pr_debug("retransmit ADD_ADDR id=%d", entry->addr.id);
 		mptcp_pm_announce_addr(msk, &entry->addr, false);
 		mptcp_pm_add_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 160c2ab..a0b0ec0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -708,6 +708,12 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
+	return READ_ONCE(msk->pm.addr_signal) &
+		(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
+}
+
+static inline bool mptcp_pm_should_add_signal_addr(struct mptcp_sock *msk)
+{
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
 }
 
-- 
1.8.3.1

