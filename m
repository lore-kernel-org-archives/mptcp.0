Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B82FAD
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 10:24:37 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:42528.526440819
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-820477ffa95041328a8565b948a69907 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 1FCA62800A6;
	Wed, 30 Jun 2021 18:24:38 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 8376d38ef4504457813ddbfc8e84abb7 for mptcp@lists.linux.dev;
	Wed Jun 30 18:24:36 2021
X-Transaction-ID: 8376d38ef4504457813ddbfc8e84abb7
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v7 4/5] mptcp: remove some double-check
Date: Wed, 30 Jun 2021 18:24:12 +0800
Message-Id: <1625048653-6825-5-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

remove some double-check in mptcp_established_options_add_addr() and
mptcp_established_options_rm_addr()

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/options.c  | 14 ++------------
 net/mptcp/pm.c       | 21 +++++++++++----------
 net/mptcp/protocol.h |  4 ++--
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cceff0a..0711fc1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -659,7 +659,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	int len = 0;
 
 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr))
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr, &len))
 		return false;
 
 	if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
@@ -674,10 +674,6 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		drop_other_suboptions = true;
 	}
 
-	len = mptcp_add_addr_len(msk, opts);
-	if (remaining < len)
-		return false;
-
 	*size = len;
 	if (drop_other_suboptions)
 		*size -= opt_size;
@@ -707,13 +703,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	int i, len;
 
 	if (!mptcp_pm_should_rm_signal(msk) ||
-	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
-		return false;
-
-	len = mptcp_rm_addr_len(&rm_list);
-	if (len < 0)
-		return false;
-	if (remaining < len)
+	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, &len)))
 		return false;
 
 	*size = len;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9c5b15c..2311ea5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -255,9 +255,9 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts,  u8 *add_addr)
+			      struct mptcp_out_options *opts,  u8 *add_addr, int *len)
 {
-	int ret = false, len;
+	int ret = false;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -276,8 +276,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 		remaining += opt_size;
 	}
 
-	len = mptcp_add_addr_len(msk, opts);
-	if (remaining < len)
+	*len = mptcp_add_addr_len(msk, opts);
+	if (remaining < *len)
 		goto out_unlock;
 
 	if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
@@ -287,17 +287,18 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 
 	ret = true;
 out_unlock:
+	spin_unlock_bh(&msk->pm.lock);
+
 	if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_add_signal_addr(msk)))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 
-	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
 
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list)
+			     struct mptcp_rm_list *rm_list, int *len)
 {
-	int ret = false, len;
+	int ret = false;
 	u8 rm_addr;
 
 	spin_lock_bh(&msk->pm.lock);
@@ -307,12 +308,12 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 		goto out_unlock;
 
 	rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
-	len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
-	if (len < 0) {
+	*len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
+	if (*len < 0) {
 		WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 		goto out_unlock;
 	}
-	if (remaining < len)
+	if (remaining < *len)
 		goto out_unlock;
 
 	*rm_list = msk->pm.rm_list_tx;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index caa4a60..5d7c9d7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -770,9 +770,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 			      unsigned int opt_size, unsigned int remaining,
-			      struct mptcp_out_options *opts,  u8 *add_addr);
+			      struct mptcp_out_options *opts,  u8 *add_addr, int *len);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			     struct mptcp_rm_list *rm_list);
+			     struct mptcp_rm_list *rm_list, int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 
 void __init mptcp_pm_nl_init(void);
-- 
1.8.3.1

