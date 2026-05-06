Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1B2475E3
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077103; cv=none; b=kSuQijflXEzji44Ko2KqUnBCTSli93Bn6CnR02/7ZsZHPwKuyPjkHncYcd3IvMZyyPUxRRSIjFZ4RRtrA5EeMgWf57XF0ftu/OxDuqVZQNuMCAII9cOdbamS2ce43EvhRw/KRRb7823D0TCFX2xF6LABQYjwOxlImIWU1a1SFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077103; c=relaxed/simple;
	bh=OUyylME6LEzU8RnHJ6qJH+n1ofd5u1Twag+oKNHgxYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PyTV5n0EIW7ZE9eJKOVWHi5U4NjJYz4qZzCk5yaNYGxDzmjRvmiWurCsQgtIuLMd1KtqeWDPtFQOF4aGySYL13E3Y2oLJIwNyRjTZrFfZGUUfYYAnwlk7nib+Mmt554wzdBcQH4WYjnvQ9+CMrXVDuk0CmlZLUJEzuv9AMd2C2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6XqGl4/q; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6XqGl4/q; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6XqGl4/q";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6XqGl4/q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HXMKqjss1xQ6rc9p6VG6SCKPy4niohsDHKuyLzrsFOg=;
	b=6XqGl4/q3lnk0jRYpziBezbzWap7zpgEkvP9MSKTJ3nGc2vus9nMN2b+IdIZU8n+jQatMZ6Az
	A40/BvGCSNL9VxtEOxGEqlE6KepfsWoOw8cM/OcF/cJ4GyfINx4V5bIS5m6lIhszaqINgfgLX8y
	4r9BEKWUpc2kLaqOupnMUGc=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4g9cSS515Jz1BFy0
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 21:59:20 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HXMKqjss1xQ6rc9p6VG6SCKPy4niohsDHKuyLzrsFOg=;
	b=6XqGl4/q3lnk0jRYpziBezbzWap7zpgEkvP9MSKTJ3nGc2vus9nMN2b+IdIZU8n+jQatMZ6Az
	A40/BvGCSNL9VxtEOxGEqlE6KepfsWoOw8cM/OcF/cJ4GyfINx4V5bIS5m6lIhszaqINgfgLX8y
	4r9BEKWUpc2kLaqOupnMUGc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4g9cJM2Q8Tz12LDN;
	Wed,  6 May 2026 21:52:19 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 774C720226;
	Wed,  6 May 2026 21:59:28 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 21:59:27 +0800
Message-ID: <17f67626-14a6-442a-9d86-7a81a2bf4d78@huawei.com>
Date: Wed, 6 May 2026 21:59:27 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: fix ADD_ADDR timer infinite
 retry on option space insufficient
To: Matthieu Baerts <matttbe@kernel.org>
CC: "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, "weiyongjun (A)"
	<weiyongjun1@huawei.com>, yuehaibing <yuehaibing@huawei.com>, zhangchangzhong
	<zhangchangzhong@huawei.com>, "xiasong.lee@gmail.com" <xiasong.lee@gmail.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
 <20260430112026.343691-2-lixiasong1@huawei.com>
 <177755524215.1566930.3209225574765644709.b4-review@b4>
 <0430cd33-4d2e-4659-be1e-fada67bb9c6d@gmail.com>
 <4792fa80-2485-47bc-9c50-0526c2f23484@kernel.org>
 <3245a905-81a8-46fb-8eac-8c42d259bb58@huawei.com>
 <4c4fbc89-ecfd-4eaf-b939-50e2d95b1f2b@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <4c4fbc89-ecfd-4eaf-b939-50e2d95b1f2b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj500018.china.huawei.com (7.202.194.48)

On 5/6/2026 9:34 PM, Matthieu Baerts wrote:
> Hi Li,
> 
> On 06/05/2026 15:27, Li Xiasong wrote:
>> Hi Matt,
>>
>> I’m currently preparing the v3 update for this fix.
> 
> Thanks!
> 
>> In mptcp_pm_add_addr_signal(), when TCP option space is insufficient, we
>> cancel the ADD_ADDR retrans timer via mptcp_pm_del_add_timer(). During
>> analysis, I found a race window that can lead to one extra ADD_ADDR send
>> attempt, so I’d like to confirm the intended semantics before posting v3.
>>
>> I see two race cases:
>>
>> Case 1: cancel state applied first (handled by existing counter check)
>>
>> CPU0 (cancel path)                          CPU1 (add_timer callback)
>> --------------------------------------      -----------------------------------
>> option space insufficient                   callback already running
>> call mptcp_pm_del_add_timer()               ...
>> acquire pm.lock                             ...
>> set retrans_times = ADD_ADDR_RETRANS_MAX    ...
>> release pm.lock                             ...
>> stop timer                                  ...
>>                                             acquire pm.lock
>>                                             check retrans_times <
>>                                               ADD_ADDR_RETRANS_MAX ?
>>                                             false -> skip announce/send
>>                                             release pm.lock
>>
>> For this case, gating send by
>> `retrans_times < ADD_ADDR_RETRANS_MAX` prevents stale send.
>>
>>
>> Case 2: callback takes lock first and sends before cancel applies
>>
>> CPU0 (cancel path)                          CPU1 (add_timer callback)
>> --------------------------------------      -----------------------------------
>> option space insufficient                   callback already running
>> call mptcp_pm_del_add_timer()               acquire pm.lock
>> try acquire pm.lock -> blocked              check send conditions
>>                                             announce/send ADD_ADDR  <- send
>>                                             retrans_times++
>>                                             release pm.lock
>> acquire pm.lock                             ...
>> set retrans_times = ADD_ADDR_RETRANS_MAX    ...
>> release pm.lock                             ...
>> stop timer                                  ...
>>
>>
>> I’d like to discuss which semantic target is better for v3:
>>
>> A) best-effort cancel:
>>    race may still allow at-most-one extra send attempt and `ADDADDRTXDROP`
>> send-failure statistics may be incremented one extra time.
> 
> I think that's OK to send an extra attempt, especially here where it is
> quite unlikely to get this race.
> 

Thanks, got it.

>> B) strict cancel semantics:
>>    once cancel is decided, no further ADD_ADDR send action
>>
>> My current understanding:
>> - Case 1 can be covered by the existing retrans_times gate.
>> - Case 2 is the key trade-off between complexity and strictness.
> 
> Case 1 looks fine to me, but do you mind documenting the possible race
> in the code and/or commit message depending on the patch, please?
> 

I’ll document the race consideration in v3 (in the commit message, and
add an in-code note as needed for clarity), then send the updated patch in
the next revision.

Best regards,
Li Xiasong

> Cheers,
> Matt
