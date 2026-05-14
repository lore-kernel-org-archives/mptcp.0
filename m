Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7053D813D
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765425; cv=none; b=QN7USsg+0DGg4Mt9fsSs2jFmiHXeJN6/jdffv0RtBjK3RkaaGsAghvNgY01xXEMvkRmhNTIKBpqVUzQl7RY/fzP2YrhqPt8kpiHFAqn96MVR5xapW1CyiT0n1gp1wTI7qQG7JXOGvh1JPmP294o5B8SdRLNddxsZeEzOo/4L7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765425; c=relaxed/simple;
	bh=InCcSyLlTpt0BxEZmvjjcRCp4cQVW5LPmQtq8l1sAwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+dgvJsQD37JupUr2xnTd1Y111am9XIWJpwHYIqyHldfbauYTL1PXkYoaGFxJ+8vgLlp6QcRZ4GdyiD96L1128B6u4o/RMhgO2MYK2r3hU/Nk1DIUEkPNeLh6TvL7NOcBd5U8fAFAaF6KFl/+9O6THHqOOWUZx1/Iy91OG+N8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0559b39e4f9911f1aa26b74ffac11d73-20260514
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6a94428c-9632-4fca-83af-d818adf95fc6,IP:10,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.3.12,REQID:6a94428c-9632-4fca-83af-d818adf95fc6,IP:10,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:e7bac3a,CLOUDID:72c66b8d8ca8755458554925ace6e89b,BulkI
	D:260514213009AUUL93W0,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0559b39e4f9911f1aa26b74ffac11d73-20260514
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1433802801; Thu, 14 May 2026 21:30:06 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mptcp@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/2] mptcp: pm: fix extra_subflows leak on userspace PM subflow close race
Date: Thu, 14 May 2026 21:29:25 +0800
Message-ID: <20260514132925.410184-3-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514132925.410184-1-cuitao@kylinos.cn>
References: <20260514132925.410184-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the userspace PM subflow creation path, extra_subflows is incremented
after release_sock(sk). If a TCP RST arrives for the newly created
subflow, mptcp_worker can acquire the socket lock during the gap between
release_sock(sk) and the subsequent spin_lock_bh(&msk->pm.lock), close
the subflow via mptcp_pm_subflow_check_next(), and decrement the counter
before it was incremented -- causing a u8 underflow from 0 to 255.

Move extra_subflows++ into the lock_sock(sk) section, before
release_sock(sk), so that the worker always sees a non-zero counter and
decrements correctly. This also eliminates the transient underflow window
visible to lockless readers (e.g. sosockopt READ_ONCE).

Additionally, add an underflow guard in mptcp_pm_subflow_check_next() as
a safety net for other edge cases.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm.c           | 3 ++-
 net/mptcp/pm_userspace.c | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3c152bf66cd5..a83a56b467f9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -655,7 +655,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	if (mptcp_pm_is_userspace(msk)) {
 		if (update_subflows) {
 			spin_lock_bh(&pm->lock);
-			pm->extra_subflows--;
+			if (pm->extra_subflows)
+				pm->extra_subflows--;
 			spin_unlock_bh(&pm->lock);
 		}
 		return;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8cbc1920afb4..61c10ec00be0 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -410,6 +410,11 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
+	if (!err) {
+		spin_lock_bh(&msk->pm.lock);
+		msk->pm.extra_subflows++;
+		spin_unlock_bh(&msk->pm.lock);
+	}
 	release_sock(sk);
 
 	if (err)
@@ -418,8 +423,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
-	else
-		msk->pm.extra_subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
-- 
2.43.0

