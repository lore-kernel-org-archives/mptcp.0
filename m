Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4372
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 08:52:20 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:40052.999822468
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-f7c5a0468a3942f1a4a4b00055d3061f (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 4C9752800E2;
	Thu, 10 Jun 2021 16:52:13 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 6f3eb042546b45f4b7b7708382d63b0d for mptcp@lists.linux.dev;
	Thu Jun 10 16:52:13 2021
X-Transaction-ID: 6f3eb042546b45f4b7b7708382d63b0d
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
Subject: [PATCH 1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
Date: Thu, 10 Jun 2021 16:51:55 +0800
Message-Id: <1623315118-57936-2-git-send-email-liyonglong@chinatelecom.cn>
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

ADD_ADDR share pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
done we should not clean ADD_ADDR/RM_ADDR's addr_signal.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9d00fa6..74886a3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -252,6 +252,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
 {
+	u8 add_addr;
 	int ret = false;
 
 	spin_lock_bh(&msk->pm.lock);
@@ -267,7 +268,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 		goto out_unlock;
 
 	*saddr = msk->pm.local;
-	WRITE_ONCE(msk->pm.addr_signal, 0);
+	add_addr = READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	ret = true;
 
 out_unlock:
@@ -278,6 +280,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list)
 {
+	u8 rm_addr;
 	int ret = false, len;
 
 	spin_lock_bh(&msk->pm.lock);
@@ -286,16 +289,17 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (!mptcp_pm_should_rm_signal(msk))
 		goto out_unlock;
 
+	rm_addr = READ_ONCE(msk->pm.addr_signal) & ~BIT(MPTCP_RM_ADDR_SIGNAL);
 	len = mptcp_rm_addr_len(&msk->pm.rm_list_tx);
 	if (len < 0) {
-		WRITE_ONCE(msk->pm.addr_signal, 0);
+		WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 		goto out_unlock;
 	}
 	if (remaining < len)
 		goto out_unlock;
 
 	*rm_list = msk->pm.rm_list_tx;
-	WRITE_ONCE(msk->pm.addr_signal, 0);
+	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
 	ret = true;
 
 out_unlock:
-- 
1.8.3.1

