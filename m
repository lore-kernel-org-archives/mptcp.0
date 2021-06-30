Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.227])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D629D6
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 10:24:29 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:42528.526440819
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-820477ffa95041328a8565b948a69907 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id DEB2028008E;
	Wed, 30 Jun 2021 18:24:24 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 100f569115984627aa0a015ccd15904e for mptcp@lists.linux.dev;
	Wed Jun 30 18:24:23 2021
X-Transaction-ID: 100f569115984627aa0a015ccd15904e
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
Subject: [PATCH v7 1/5] mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
Date: Wed, 30 Jun 2021 18:24:09 +0800
Message-Id: <1625048653-6825-2-git-send-email-liyonglong@chinatelecom.cn>
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

ADD_ADDR share pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
done we should not clean ADD_ADDR/RM_ADDR's addr_signal.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9d00fa6..50079e5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -253,6 +253,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
 {
 	int ret = false;
+	u8 add_addr;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -267,7 +268,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 		goto out_unlock;
 
 	*saddr = msk->pm.local;
-	WRITE_ONCE(msk->pm.addr_signal, 0);
+	add_addr = msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
+	WRITE_ONCE(msk->pm.addr_signal, add_addr);
 	ret = true;
 
 out_unlock:
@@ -279,6 +281,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list)
 {
 	int ret = false, len;
+	u8 rm_addr;
 
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

