Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB32FAD
	for <mptcp@lists.linux.dev>; Wed,  7 Jul 2021 17:02:04 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:54022.267134115
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-436ef2b3ccc547e0a5ea08a54c44f662 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 5B5FB2800DA;
	Thu,  8 Jul 2021 01:01:59 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id cece9fce4d134afe9a3fcbbb4a01584f for mptcp@lists.linux.dev;
	Thu Jul  8 01:02:04 2021
X-Transaction-ID: cece9fce4d134afe9a3fcbbb4a01584f
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
Subject: [PATCH v8 2/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
Date: Thu,  8 Jul 2021 01:01:39 +0800
Message-Id: <1625677301-139357-3-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625677301-139357-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1625677301-139357-1-git-send-email-liyonglong@chinatelecom.cn>
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
 net/mptcp/pm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1b357ea..6a91189 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -271,7 +271,10 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 		goto out_unlock;
 
 	*saddr = msk->pm.local;
-	WRITE_ONCE(msk->pm.addr_signal, 0);
+	if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
+		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO));
+	else
+		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL));
 	ret = true;
 
 out_unlock:
@@ -283,6 +286,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list)
 {
 	int ret = false, len;
+	u8 rm_addr;
 
 	spin_lock_bh(&msk->pm.lock);
 
@@ -290,16 +294,17 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
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

