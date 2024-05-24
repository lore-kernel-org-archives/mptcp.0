Received: from chinatelecom.cn (smtpnm6-01.21cn.com [182.42.159.233])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B586EB4B
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.159.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544500; cv=none; b=islM5d7MGqWHp5lwfSfhuMYcxeoQB251/JXCF7oBZUhTIbmk3hAZgTLPRpiZ1+o/uL6gKOO6Dz3mbN1bRxzfsvM+vstKJkIx7zkMETCaiIDaY/2ddQYmKIu5fwgbqjjB1Z5E59g+66d92iRWeyJH1p0RhqDcRcAEEuwQTdopoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544500; c=relaxed/simple;
	bh=FOQO0wzvNm/XE0EEQ19Fuao2fbO9wVQBa9d8Rt0yRQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ii9ME5cfYjKU13raO6iaMSbzrUHsvektNJLu1lF4JEOO9XmQu1a/KxaW7W83vchWMJNVIY0Bpi6KgB2PkuFZeRua/CUzdOIJlZL6NrKcGMk+weB0+g/J/2LhvVmzurq3RDeCCcc96XeZt8L0CvfxWxtEdLxvjuYp4zkc/HnmDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.159.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:192.168.138.117:53773.517287112
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9 (unknown [192.168.138.117])
	by chinatelecom.cn (HERMES) with SMTP id 6E238100111F5;
	Fri, 24 May 2024 17:44:53 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([36.111.140.9])
	by gateway-ssl-dep-84c6c6b769-jsnsj with ESMTP id 6653b6e79970460eba8664609a517762 for mptcp@lists.linux.dev;
	Fri, 24 May 2024 17:44:56 CST
X-Transaction-ID: 6653b6e79970460eba8664609a517762
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 36.111.140.9
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	pabeni@redhat.com,
	geliang@kernel.org,
	liyonglong@chinatelecom.cn
Subject: [PATCH] mptcp: update add_addr_accepted and accept_add after subflow added
Date: Fri, 24 May 2024 17:44:25 +0800
Message-Id: <1716543865-37448-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: YonglongLi <liyonglong@chinatelecom.cn>

receive RM_ADDR will update pm.add_addr_accepted and pm.add_addr_accepted
only if remove id match remote id of subflow. so receive ADD_ADDR should
update pm.add_addr_accepted and pm.add_addr_accepted after subflow added
to conn_list.

Fixes: f7d6a237d742 ("mptcp: fix per socket endpoint accounting")

Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
---
 net/mptcp/pm_netlink.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 766a840..117cc7b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -676,6 +676,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
+	bool subflow_added = false;
 	unsigned int subflows_max;
 	int i, nr;
 
@@ -704,15 +705,18 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	if (nr == 0)
 		return;
 
-	msk->pm.add_addr_accepted++;
-	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-	    msk->pm.subflows >= subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
-
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
-		__mptcp_subflow_connect(sk, &addrs[i], &remote);
+		if (!__mptcp_subflow_connect(sk, &addrs[i], &remote))
+			subflow_added = true;
 	spin_lock_bh(&msk->pm.lock);
+
+	if (subflow_added) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		    msk->pm.subflows >= subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
 }
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
-- 
1.8.3.1

