Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6E6385D60
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752233; cv=none; b=HnWMimxw7sXxTDJeJ7BcUzVlv9+26hbkg2oinFq/+MnSg92O0wTEBqJkYt6rB10XMzE1f/lAmVztiwoouJf4Ok8a8uKrqW2u5KNis0DabbE5+9+9RDJS9evypx7wfKYLQD8nkUTtxIX8eWAIYsMiq4fGmrUAv45SBW9nTWn76N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752233; c=relaxed/simple;
	bh=cy1Z22RQ5GryGeonXE3/v772xJ6IXbWQ6Cagafnelhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfhGucOqQ4B3MGHBM5MGULG149RSvlfdfBXy4mY9GkE0vcQ8ZpGNrb7Sd6eVZKEoNjAaYdxPGNMgsyjZgDEr2m1hTA/3T0IPxmez6NWDAkNR6KMse1REeSnKEnVc5uuq1zTyKHLhUb+yGu9FWuYYlaEWthOx/KSMNkuv+9y2+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 524752164f7a11f1aa26b74ffac11d73-20260514
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
X-CID-O-INFO: VERSION:1.3.12,REQID:49992069-0520-4ee8-91f0-e76117c0f070,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:49992069-0520-4ee8-91f0-e76117c0f070,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:3ff87fc2a52fd419239d4786ec77e9e4,BulkI
	D:26051417502411KUARH5,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,
	QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
	,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 524752164f7a11f1aa26b74ffac11d73-20260514
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 165637875; Thu, 14 May 2026 17:50:21 +0800
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
Subject: [PATCH v2 0/2] mptcp: pm: fix extra_subflows underflow for userspace PM
Date: Thu, 14 May 2026 17:50:05 +0800
Message-ID: <20260514095007.405475-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 of the series that fixes extra_subflows u8 underflow bugs
in the MPTCP userspace path manager.

extra_subflows is a u8 field in struct mptcp_pm_data. Two code paths
in the userspace PM can cause it to underflow from 0 to 255, after
which the counter is permanently corrupted and future subflow
creation is blocked.

Patch 1 skips the spurious mptcp_pm_close_subflow() call in
__mptcp_subflow_connect() when the userspace PM is in use, since it
does not pre-increment extra_subflows before attempting subflow
creation.

Patch 2 adds an underflow guard in mptcp_pm_subflow_check_next() to
avoid decrementing extra_subflows when it is already zero.

Tao Cui (2):
  mptcp: pm: fix extra_subflows underflow on userspace PM connect
    failure
  mptcp: pm: add extra_subflows underflow guard for userspace PM

 net/mptcp/pm.c      | 3 ++-
 net/mptcp/subflow.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

---
Changes in v2:
  - Dropped the use-after-free fix.
  - Split the underflow fix into two patches, one per code path.
v1:
  https://lore.kernel.org/all/20260509075629.217791-2-cuitao@kylinos.cn/
--
2.43.0
