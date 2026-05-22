Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08527356743
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439872; cv=none; b=HEJ2w73wbGyIwZ9M3B4VZmls7lb5kHbImKkmQYurNpZvKXW2nxhdt5pCFcbhiLruNBMb7WrU+5P1EPvegBcBEmjN4GIEO8NwwSnSaonQdfXkFFxKOc7yx93JfClX9G3qjQfc5AttIKE3w//SD5lKtW272eLvDo7ZBzIMsLHo/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439872; c=relaxed/simple;
	bh=l9K2Xglkw8Xbw4iWP0iMJHqbJs9D3Ul3GGCHEDQ87eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULlFMmUVafctO16pXez3mNKSSV5n2/jf4j7veK60EDgAQcc+xyU1tVzhiOxQe6xd6hwgaSAQzl+DHS7lZNLvrXfGmbHKo7A2Ne7GjkD5GDBQtRBQ/PgxR0DEjp6VrvJUCYtH4mqaDffqcs84tV57F42NBMOIkBZQiJKD0i3vDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5cb94c1255bb11f1aa26b74ffac11d73-20260522
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:55eb771e-d2ef-452d-b837-5b8d2c6bfd29,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:55eb771e-d2ef-452d-b837-5b8d2c6bfd29,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:430c4b44c71885b0b6089c4079ed1d69,BulkI
	D:260522165104FAL3ACSQ,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5cb94c1255bb11f1aa26b74ffac11d73-20260522
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1841512658; Fri, 22 May 2026 16:51:02 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: matttbe@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH mptcp-next] mptcp: pm: add WARN_ON_ONCE guards on extra_subflows underflow
Date: Fri, 22 May 2026 16:50:49 +0800
Message-ID: <20260522085049.1896537-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extra_subflows is a u8 counter that can underflow if a decrement races
with or precedes an increment. While the recently fixed userspace PM
subflow creation path eliminated the primary cause, add defensive
WARN_ON_ONCE guards at both decrement sites to catch any remaining edge
cases rather than silently wrapping to 255.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm.c       | 3 ++-
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3c152bf66cd5..aa987366fb24 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -655,7 +655,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	if (mptcp_pm_is_userspace(msk)) {
 		if (update_subflows) {
 			spin_lock_bh(&pm->lock);
-			pm->extra_subflows--;
+			if (!WARN_ON_ONCE(pm->extra_subflows == 0))
+				pm->extra_subflows--;
 			spin_unlock_bh(&pm->lock);
 		}
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4f5aba24da7..2cf6e3f66a95 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1276,7 +1276,8 @@ u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
 {
-	if (--msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk))
+	if (!WARN_ON_ONCE(msk->pm.extra_subflows == 0) &&
+	    --msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk))
 		WRITE_ONCE(msk->pm.accept_subflow, true);
 }
 
-- 
2.43.0

