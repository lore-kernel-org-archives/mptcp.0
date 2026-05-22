Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BAC3A7195
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439642; cv=none; b=uHdZy7JLDKDa9YUBIikWE7ReRWbl51wc834itkIaoIaTlscqf8DYoYuYbv+cktDLQ/CcXbrpaDJ6roJk1Wl8KxhbRgNQcsMU8+9IYXgRQ/GverxhK0l/aHPthtaDbUtgyoW11TFEgEbaH81JVXRDWWn+LqwpiMz5OV+vm42cebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439642; c=relaxed/simple;
	bh=w8kG+BZAkNk12BoAp3SgBOnt2z5hH4pvCgIGQPUzh0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSOWoujTGbgZIi9QB9GihG9Jyr/RFd2dFhfyLm4/NfkCSWVdWoqn3GHmDQYk/6LunDLm9lMcAubUblFBhkqvQYHL3Q2nSyIIBY8912hwpPm5TfR8YrOJNi2Y6kI3P37gUICY9GcNLsCNILvQeSjPEoPGCeLoWPXfiEt4JKD+hLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d3c6daf055ba11f1aa26b74ffac11d73-20260522
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
X-CID-O-INFO: VERSION:1.3.12,REQID:584c03b8-2817-4754-accc-ed9c7351d1a2,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:584c03b8-2817-4754-accc-ed9c7351d1a2,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:0621e6e34cf7371cc5ba97da65eb0625,BulkI
	D:260522164716STI5BR1W,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d3c6daf055ba11f1aa26b74ffac11d73-20260522
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 728842292; Fri, 22 May 2026 16:47:13 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: matttbe@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH mptcp-net v4 0/2] mptcp: pm: fix extra_subflows underflow for userspace PM
Date: Fri, 22 May 2026 16:46:56 +0800
Message-ID: <20260522084658.1896374-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v4 of the series that fixes extra_subflows u8 underflow bugs
in the MPTCP userspace path manager.

extra_subflows is a u8 field in struct mptcp_pm_data. The userspace PM
increments it after __mptcp_subflow_connect() succeeds, but
__mptcp_subflow_connect() calls mptcp_pm_close_subflow() on failure to
roll back the pre-increment done by the kernel PM. Because the userspace
PM hasn't incremented yet at that point, this decrement is spurious and
causes extra_subflows to underflow from 0 to 255.

Patch 1 fixes the underflow by aligning the userspace PM with the kernel
PM: increment extra_subflows before calling __mptcp_subflow_connect(),
so the existing error path in subflow.c correctly rolls it back on
failure. This also eliminates the race window described in v3 patch 2
where the worker could decrement before the user thread increments.

Patch 2 adds a selftest to validate that subflow creation failure with
an unreachable address does not corrupt the extra_subflows counter.

Tao Cui (2):
  mptcp: pm: fix extra_subflows underflow on userspace PM subflow
    creation
  selftests: mptcp: add test for extra_subflows underflow on userspace
    PM

 net/mptcp/pm_userspace.c                        | 14 ++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++++
 2 files changed, 12 insertions(+), 6 deletions(-)

---
Changes in v4:
  - Rework patch 1 per Mat's review: instead of gating
    mptcp_pm_close_subflow() on the PM type in subflow.c, move
    extra_subflows++ before __mptcp_subflow_connect() in the userspace
    PM to align with the kernel PM behavior. No changes to subflow.c.
  - Simplify error handling in userspace PM: take pm.lock only on
    failure for cleanup.
  - Add selftest (patch 2) as suggested by Mat.
  - Drop the previous race fix (v3 patch 2), as it is no longer needed
    once the increment is moved before the call.

Changes in v3:
  - Patch 2: move extra_subflows++ before release_sock(sk) to close
    the race window, instead of relying solely on the underflow guard.

Changes in v2:
  - Dropped the use-after-free fix.
  - Split the underflow fix into two patches, one per code path.

v1:
  https://lore.kernel.org/all/20260509075629.217791-2-cuitao@kylinos.cn/
v3:
  https://lore.kernel.org/all/20260514132925.410184-1-cuitao@kylinos.cn/

-- 
2.43.0

