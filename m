Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF89CA5A
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765289; cv=none; b=lypRYWhO5Uy5k1cPT+vh/KZz8m7bszJw5zuGWts4B7QPKZ7iSfhP7ZSmgAPB0iFBE5Ut3W1gudldrw7eplibgh6LHW5AbsPyDPUUYnfv3iiJW4aSsilSSIhN6Y4/Yc3vMyP9r7uI5RbTGHePtOlUktmQBAQZMlVpN/cPHj808yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765289; c=relaxed/simple;
	bh=8eIaajRt1GVNgdLqLs+emPy/RoziY8kpN5z+5B8Fz+s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OO0LcL4yllyaoumGGsc0uP1D7mjY4N2nBOB9zk/ovXfuwes1kvoNPU9TsoKXXHYqi07CTw4xc3P24wLG1e15s//z0iDspM+r2rH78+Bl7fcX7QG0wdnb7zo50FQ/85uHTYoEV2pwG3z6OXdEG84vMeJvKrTD9lG01eGCseL1Gik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b8cca1b24f9811f1aa26b74ffac11d73-20260514
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e21fdae8-ab89-49f1-81a1-9d56c106018b,IP:10,
	URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:25
X-CID-INFO: VERSION:1.3.12,REQID:e21fdae8-ab89-49f1-81a1-9d56c106018b,IP:10,UR
	L:25,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:4c8841a849c6db49fa15ba9fea7b14fe,BulkI
	D:260514180045Z0D3LEP4,BulkQuantity:2,Recheck:0,SF:17|19|38|64|66|78|80|81
	|82|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:11|93|82|99
	|1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR
	:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b8cca1b24f9811f1aa26b74ffac11d73-20260514
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 862943662; Thu, 14 May 2026 21:27:57 +0800
Message-ID: <6fcd952e-3990-44fe-bd4e-6a26d0777589@kylinos.cn>
Date: Thu, 14 May 2026 21:27:52 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mptcp: pm: fix extra_subflows underflow for
 userspace PM
From: Tao Cui <cuitao@kylinos.cn>
To: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, mptcp@lists.linux.dev
References: <20260514095007.405475-1-cuitao@kylinos.cn>
 <e658dfbb-cbe7-4d69-be76-806179a902d3@kylinos.cn>
In-Reply-To: <e658dfbb-cbe7-4d69-be76-806179a902d3@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry everyone, please ignore this v2 patch submission.
I missed the review note from Sashiko when preparing this update:

  " sashiko adds some comments here, please address them in v2:
    https://sashiko.dev/#/patchset/20260509075629.217791-2-cuitao@kylinos.cn "

Besides, the race condition scenario pointed out by Sashiko also needs to be handled.
I will send out the v3 patch later to fix all these issues.

在 2026/5/14 18:00, Tao Cui 写道:
> 
> Sorry, I missed adding --subject-prefix="PATCH mptcp-next" when running git format-patch.
> 
> 在 2026/5/14 17:50, Tao Cui 写道:
>> This is v2 of the series that fixes extra_subflows u8 underflow bugs
>> in the MPTCP userspace path manager.
>>
>> extra_subflows is a u8 field in struct mptcp_pm_data. Two code paths
>> in the userspace PM can cause it to underflow from 0 to 255, after
>> which the counter is permanently corrupted and future subflow
>> creation is blocked.
>>
>> Patch 1 skips the spurious mptcp_pm_close_subflow() call in
>> __mptcp_subflow_connect() when the userspace PM is in use, since it
>> does not pre-increment extra_subflows before attempting subflow
>> creation.
>>
>> Patch 2 adds an underflow guard in mptcp_pm_subflow_check_next() to
>> avoid decrementing extra_subflows when it is already zero.
>>
>> Tao Cui (2):
>>   mptcp: pm: fix extra_subflows underflow on userspace PM connect
>>     failure
>>   mptcp: pm: add extra_subflows underflow guard for userspace PM
>>
>>  net/mptcp/pm.c      | 3 ++-
>>  net/mptcp/subflow.c | 3 ++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> ---
>> Changes in v2:
>>   - Dropped the use-after-free fix.
>>   - Split the underflow fix into two patches, one per code path.
>> v1:
>>   https://lore.kernel.org/all/20260509075629.217791-2-cuitao@kylinos.cn/
>> --
>> 2.43.0

