Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC10173
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 09:14:52 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:35304.1563350684
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-5115ca8f26c14b9a91d0dcf6ea180cd4 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id EB6C92800ED;
	Thu, 17 Jun 2021 17:14:49 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id ea32a81f2b8d4011b8375dd7456ae2f3 for mptcp@lists.linux.dev;
	Thu Jun 17 17:14:51 2021
X-Transaction-ID: ea32a81f2b8d4011b8375dd7456ae2f3
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v3 1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
Date: Thu, 17 Jun 2021 17:14:33 +0800
Message-Id: <1623921276-97178-2-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
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
index 9d00fa6..611bb2c7 100644
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
+	add_addr = msk->pm.addr_signal & BIT(MPTCP_RM_ADDR_SIGNAL);
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
 
+	rm_addr = msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
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

