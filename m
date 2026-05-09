Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3272E7F0A
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313415; cv=none; b=cRpKN4hXf0gp5bTiBUsez6JxcFHYxI9THe3UnV6i6AIVkoL10/01BgEzlw64ErCSSe8eaJhS25DPbE4TTmm01y5Lxx0I8zbkhwuyQsGhCeAgSc3jIQPojvtq4KWpBJCuZvbiIhlNb253JmZFNqEcZwGv1Jw5pxkAv3nrGJvoycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313415; c=relaxed/simple;
	bh=rIVH7cDBjz/q5Kyh+qXhU8997I1bDzQgiFNDV/gAFQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/8g81sNS0gOeltVX9peUYR5EDPd4T5eq4cw9ENU/QBrWeip0Bfq1KIrPxK5MG9Oq9pZ8CoocVTUdFstrHkSPWRs0RDc14k3kioNm0bjuCJGSaHBk/OojFxjmYyDrSb00eHuE6X292sju9+MGxctoTznDILpMw8ao1RawBUSmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9ff3cf324b7c11f1aa26b74ffac11d73-20260509
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9d2403f0-7b5f-4112-afa7-4739e8623667,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:9d2403f0-7b5f-4112-afa7-4739e8623667,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:201b7ac8af546f06dcca06694c32631b,BulkI
	D:26050915564886K0D7KU,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9ff3cf324b7c11f1aa26b74ffac11d73-20260509
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1581625184; Sat, 09 May 2026 15:56:45 +0800
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
Subject: [PATCH mptcp-next 2/2] mptcp: pm: fix extra_subflows u8 underflow in userspace PM
Date: Sat,  9 May 2026 15:56:29 +0800
Message-ID: <20260509075629.217791-2-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509075629.217791-1-cuitao@kylinos.cn>
References: <20260509075629.217791-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

extra_subflows is a u8 field in struct mptcp_pm_data.  Two paths in the
userspace PM can cause it to underflow from 0 to 255, after which the
counter is permanently corrupted and future subflow creation is blocked.

1) __mptcp_subflow_connect() calls mptcp_pm_close_subflow() on failure
   to roll back the pre-increment done by kernel PM's fill_*() helpers.
   The userspace PM does not pre-increment — it only increments after
   __mptcp_subflow_connect() succeeds — so this decrement is spurious.

2) mptcp_pm_subflow_check_next() decrements unconditionally for the
   userspace PM without checking that the counter is non-zero.

Fix (1) by gating mptcp_pm_close_subflow() on the PM type and fix (2)
by adding an underflow guard.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm.c      | 3 ++-
 net/mptcp/subflow.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d562e149606f..c45ad67cb650 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1716,7 +1716,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	/* we account subflows before the creation, and this failures will not
 	 * be caught by sk_state_change()
 	 */
-	mptcp_pm_close_subflow(msk);
+	if (!mptcp_pm_is_userspace(msk))
+		mptcp_pm_close_subflow(msk);
 	return err;
 }
 
-- 
2.43.0

