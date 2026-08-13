Received: from mta0.migadu.com (out-15.mta0.migadu.com [91.218.175.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A08399377
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610732; cv=none; b=bw4B7kAzfpaBmJFRbJuRZnLZcv+imJPSeCCXDS0guBHwvy3uo5Yh7+nwHPgQAlTtee3dayllxDoxLj3zHuiAyctYgL44/KQrG0Z/wmf4rhj3ucbqoTTZPZzCs60FP53ZdUBTNgYNxpDqf1Zgm7h/iMSkIgG+k50pra5VfK4vqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610732; c=relaxed/simple;
	bh=ifiVMqOkXtNphlxW5SlCB4CGfeBWa9jEjdfW4+DOETI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6Ix878aVy8AZWBiasqTG7qTVuUcazeKPrzQuI8JtSaYbufKjyV21oG+11/3+F+IDJxu3dQi9A5VVvDL1PhT51Yk8OvPPJvFGXXBovxacKILD3sVUnYsoUIs58WnKHi9cxG+ubMtqMbnfuW9xIzu7C3lqvV0nnyHcCy86a39h0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FcB/uBGh; arc=none smtp.client-ip=91.218.175.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FcB/uBGh"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ifiVMqOkXtNphlxW5SlCB4CGfeBWa9jEjdfW4+DOETI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786610728; v=1; x=1787215528;
 b=FcB/uBGhGviIN8lPblFkJojW0hLGIb6YlA4ZYmW5jQ4Zl2HMhrS6HynU1NJCNK1Kjd5hVgkF
 P1QXC8pq+72c4lq328pEj7g1piCpRl1+Epq6if4CM1/0ZlSk0SmyF5Hm7Ju6BoyEp/HKf4Yen9P
 irXc7ErpF2llLiquWGy4PtDo=
X-Envelope-To: mptcp@lists.linux.dev
Received: from [192.168.109.30] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id de676900cfac29ae;
	Thu, 13 Aug 2026 08:45:28 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <abfac5d9-83ae-4499-b4dc-1ee857a02613@linux.dev>
Date: Thu, 13 Aug 2026 16:45:38 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 3/4] mptcp: reset subflow on MP_FAIL when OoO
 queue is non-empty
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-4-chenguang.zhao@linux.dev>
 <b41cfc9c-065e-474c-ae1a-c79983e4a932@redhat.com>
Content-Language: en-US
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <b41cfc9c-065e-474c-ae1a-c79983e4a932@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/8/12 18:02, Paolo Abeni 写道:
> On 8/12/26 7:46 AM, Chenguang Zhao wrote:
>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>
>> Infinite mapping needs contiguous data. If the MPTCP OoO queue is not
>> empty, reset the subflow instead of falling back.
> Why? the RFC says:
>
> """if all unacknowledged data in flight is contiguous"""
>
> That statement can be true even when the RTX queue is not empty.
>
> It will become false if/when some mptcp-level retransmission will happen.
>
> __mptcp_push_retrans() atomically sets `allow_infinite_fallback` to
> false when such retransmission happen. The code just before the newly
> added one checks such condition under the relevant lock.
>
> I don't think this change is needed.
>
> /P
>
Hi Paolo

I misread the RFC here. "If all unacknowledged data in flight is
contiguous" is about send-side in-flight data, not about the MPTCP
receive OoO queue being empty. Contiguous in-flight data can still
hold when the RTX queue is not empty; it only becomes false after an
MPTCP-level retransmission.

That is already tracked by allow_infinite_fallback, which
__mptcp_push_retrans() clears under fallback_lock. The existing
check of that flag at the start of mptcp_pm_mp_fail_received()
covers the RFC condition.

I will drop this patch in the next revision.

Thanks,
Chenguang
