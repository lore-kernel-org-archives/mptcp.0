Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8B282F15
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782964262; cv=none; b=NtZ94fkTFH5jiAV1uiADdguDCUSL7Drm6MqjMd9MYdSNkL04BbyJNBPpSsh/ZtnTcAwhyyqanZdUNEP3dkEdXmz0MXsiSBCTC3FxUmj1R7BL4GGvETNHRlzU5LachbHPE4LliVYCRidSMmaVOeeHezq8F6eO9emX9+b+4lS3pok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782964262; c=relaxed/simple;
	bh=Ud3Hz8zuxC3vkg4sthASAv7rt8Ilvenn2k1SAb9sUi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o88I0YMtVeXwGYjJeaJyBKU8Misw0neYMh6+tXecm0Kp77tdJG4S5VlnoZfSKJUwSNBPMiQQYHgQ8XIDpNnYpYrrKG66FSQUTUr/TMhj6yNyQAAZHNeuhPIM8z04UMjiXR/wky4OUuCpvIxY1yvbp1o/d00Gq1bj+66Tnb4rNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 37d7f92e75c911f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:17b9ec3f-6ce1-4573-bc52-da7690499d88,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f55ceaded6c20ae5642d1516e1c9d5ce,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850|865|898,TC:nil,C
	ontent:-10|-8|-5|14|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 37d7f92e75c911f1aa26b74ffac11d73-20260702
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 23596206; Thu, 02 Jul 2026 11:50:51 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev
Subject: Re: Re: [PATCH] selftests: mptcp: mptcp_diag: fix stack buffer overflow in get_subflow_info()
Date: Thu,  2 Jul 2026 11:50:48 +0800
Message-Id: <20260702035048.1902515-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3ee58e345f2538099d794c26425a0df33d3e803f.camel@kernel.org>
References: <3ee58e345f2538099d794c26425a0df33d3e803f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Thanks for this patch. MPTCP CI complains:
>> 
>> WARNING: line length of 91 exceeds 80 columns
>> #44: FILE: tools/testing/selftests/net/mptcp/mptcp_diag.c:380:
>> 
>> Also, for the subject prefix, we usually use "selftests: mptcp:
>> diag:"
>> instead of "selftests: mptcp: mptcp_diag:". Please consider updating
>> it
>> if you spin a v2.
>
>Also, when you send v2, please only CC the MPTCP mailing list
>(mptcp@lists.linux.dev); there's no need to CC netdev or other mailing
>lists.
>
>Thanks,
>-Geliang

Hi Geliang,

Thanks for your review!

You're right. I'll fix the line length issue and update the subject
prefix to "selftests: mptcp: diag:" as suggested, then send a v2.

Thanks,
Jiangshan
