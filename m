Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198513E2772
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765419; cv=none; b=C37mLLTzjNk21SRXun3dnYsi5fDslfR4gE9zKXjv9sO8IFlunVOIoRUu+5OSggO6whf0KBFcfWk4Tt2B9tUBlzIopCODQxmBjUg/TZ4BwMAUkzH/P1ybi4yd/zVmLT1mah/ciz0tJmMKI6FFif4dQdZTN74l17iUuHVemj4r2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765419; c=relaxed/simple;
	bh=48EDdeEz79jTJsYDo7PkIk1eG83NmDnlnUdmIz0wDTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwroRAYHfVCVGWhJJprrOapE1KH7yurA8g01VBxaj5A5XGJ+leUzCAMhlqxSio4LhHVDHzrPDfzNby2goWB0X2FOpY5cpN0acHgSucH/a5EO4Inp2/qCGqSz1OFdsGcuy8ya8Sf8tJJgSqnYgi9FFQF1s5u6lDuS4P8w3tszYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 042208f04f9911f1aa26b74ffac11d73-20260514
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
X-CID-O-INFO: VERSION:1.3.12,REQID:5cdc5a4d-f3df-4716-ab2c-c3669f873b39,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:5cdc5a4d-f3df-4716-ab2c-c3669f873b39,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:ac23dadb5dcf5ac907c63339f5e45373,BulkI
	D:260514175024319CNESW,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:4
	1,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 042208f04f9911f1aa26b74ffac11d73-20260514
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1891778853; Thu, 14 May 2026 21:30:04 +0800
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
Subject: [PATCH mptcp-next v3 1/2] mptcp: pm: fix extra_subflows underflow on userspace PM connect failure
Date: Thu, 14 May 2026 21:29:24 +0800
Message-ID: <20260514132925.410184-2-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514132925.410184-1-cuitao@kylinos.cn>
References: <20260514132925.410184-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__mptcp_subflow_connect() calls mptcp_pm_close_subflow() on failure
to roll back the pre-increment done by kernel PM's fill_*() helpers.
The userspace PM does not pre-increment — it only increments after
__mptcp_subflow_connect() succeeds — so this decrement is spurious.

Fix it by gating mptcp_pm_close_subflow() on the PM type.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

