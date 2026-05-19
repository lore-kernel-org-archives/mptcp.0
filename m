Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90CE3E7171
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225694; cv=none; b=QV6rw/hxkyQ7YFFsFPXfpdL1pL2JZlZPy4pNaOu/Cy8KzUkOO7hyNy+MKzDnJ0BqyFq9bEZ1aGpENJ5/jWPLsGRQJm9HyWIXfrWptYu8xbTGIo5zERVbVy8OrK0+PECwoMRZLnxPY0s3QYjY/ZYuMHfmBrZDgj4VLMPRlTPyUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225694; c=relaxed/simple;
	bh=dIqwZpRy0Xo0myFI2O5gidzvgiNmWtDyX8cDO3hBxTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9p31qIOML6PNzGT6PTEc+vxKyzgZ9xjJ8RCn08EcRljDlj4bjZ1CBQTfKY7hGlj7lqT1Y+Vr7V++Yc+BFmGWu6/M9+kodMhy4T8JXNMrqD00SvqvWeWLZMxzAVnHk60UI8XXzXcuWg0pMzcPA+BlBoZ7kmp/muTwdcmYYT57mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke0EAO86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke0EAO86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD731F00898;
	Tue, 19 May 2026 21:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225693;
	bh=6Syo5XIkjswgkZQNK0yFvC2bKgZxTHtuZhh0qx3Z9hs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ke0EAO86vjiEaIULcKnBzfR5+BrRwCrDj6iMYPqvfWFIFskK0fcq3rP/ZtG88E7sI
	 tlep4r5OqWk5gl8spp331FxFNFn0OUKD/1x0XQ1oFiNiFTZ73y3CL9gCJuQja03ZWt
	 3Jed+5Aqs+3zKq99hrkIkacJdhIBVdm7Uuzn4MDOY6bhoG7+OKkmC0pTrq0nK1T+0E
	 ivmGPp+s/R0CbWGCly9knaEMpXpSOVtb1Psz1OQq33j7XQ4LuK2q1wwjl3QUb938Ho
	 0XLHYJEQv358QrRr4ncpS2WRDBSRGF6v8ihGldcXrTyA9evgvlYFkmEy21PnConAbm
	 itqi3uyZ4Bjpg==
Message-ID: <415ea393-c2c4-4091-ad11-7113975a2bda@kernel.org>
Date: Wed, 20 May 2026 07:21:29 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [Weekly meetings] Different time this week
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <80db88ea-1e7e-4417-92d7-e2ddc12400af@kernel.org>
 <77f0e560-b51b-9cdf-86d5-a79c7679805f@kernel.org>
 <d53fb871-26f4-451e-a52a-80ecd2bd1776@kernel.org>
 <1e3eb6cf-5157-d1da-3ee7-1c6a09b1f8ec@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1e3eb6cf-5157-d1da-3ee7-1c6a09b1f8ec@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 20/05/2026 02:45, Mat Martineau wrote:
> On Tue, 19 May 2026, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> On 19/05/2026 10:18, Mat Martineau wrote:
>>> On Mon, 18 May 2026, Matthieu Baerts wrote:
>>>
>>>> Hello,
>>>>
>>>> This week, I'm not available at the usual time: 15:30 UTC (8.30am PST,
>>>> 5.30pm CEST, 12.30am CST).
>>>>
>>>> I suggest either having it at a different time, e.g. on Wed/Thu at 0:30
>>>> UTC (Tue/Wed 5.30pm PST, Wed/Thu 2.30am CEST, Wed/Thu 8.30am CST). Or
>>>> cancelling it. WDYT?
>>>
>>> Your suggested 0:30 UTC time works ok for me.
>>
>> Great! Tomorrow or the day after? For you, on Tuesday or Wednesday?
>> (Wed/Thu for me)
> 
> The later one is a little better (Weds for me, Thurs for you). Thanks!

Fine by me!

https://annuel2.framapad.org/p/mptcp_upstreaming_20260521
https://github.com/multipath-tcp/mptcp_net-next/wiki/Meetings

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

