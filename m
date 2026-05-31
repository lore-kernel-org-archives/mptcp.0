Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A2332635
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780208083; cv=none; b=j8ju2xi8xlYFcz1Wgxh1vxXJYlr1jUe7htrQULKaPae9I6lJUSqueEDBM40+PQ5ccbOrSpj5Tkabqd1vlNYwb9r+KkDsh6Jelw1wXN/LYT7qoAyKRySo8gJm5pkt7928Uiu+2LZn6UGGdEi4B6Jc6w3pkcwCbcPfIg63HR8m7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780208083; c=relaxed/simple;
	bh=FyYwgi6PpYaR3nNb3Ttb3ZDx8brQx1K/+RwcoPbUWKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFVK2tWDoTbMznaoNEGRS4h9706fnPyD+WrTWZv53fvCXbCXL3/PYgZnoVkpYxu+mvO8cqC9hmgKm+DOiaIMuT3l7Q3i+3BiqPrizIyb4Nn4auu01EWOQvMm06JYFiQJQIK4v6DX8se6sJeeN0VgGwPQDQEJNbjk+ePXXgN6FXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrJIu3pT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrJIu3pT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD61F00893;
	Sun, 31 May 2026 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780208082;
	bh=amRauYozMOa+SrSMuhsDqk8P584s6TAv+ezbdMtr/qY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JrJIu3pTt049UUmdWFaTJ/KiBOI4GuQGjUGyrMTHSy7J/75aw+e4YH9dT8qZiGU56
	 ZRc2t8Y+io9afqWHlaUPmwUuMGO14qUX/iiVP3HsYhDqxXweVgS8J1hmIr4B5RBheo
	 0nOWCwBcimh1vN2rlAp/nnD+ctVcR01VkZM9+UFma7ai+8b4UzZdVHetP6oiCkzOnT
	 23soQzrxj6lN6FE6juJwnd1LIQ3EIZ0fW7oddSws2BRyMYiFgojkaYovTQL2+xeYoL
	 hH31LfyHUx5UlGDssA3RcrY7+ykohmh6HzoE9Su2QFM8qlnngzWzZu8sSeD3f+nmoG
	 HShXHtFxCInog==
Message-ID: <43d9232a-77f9-4678-85e6-59c93417a334@kernel.org>
Date: Sun, 31 May 2026 16:14:36 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow
 close
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>,
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp <mptcp@lists.linux.dev>
Cc: "shardul.b" <shardul.b@mpiricsoftware.com>, janak <janak@mpiric.us>,
 kalpanjani009 <kalpanjani009@gmail.com>
References: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
 <19e67fb067f.1c11e928628417.8560610860929896581@mpiricsoftware.com>
 <08d590f7-b825-47ce-bc68-c3ad2bd78bc2@redhat.com>
 <c3ae1aed-0ff6-4255-91c4-b0e18ea7dae7@kernel.org>
 <b95faee7-e32b-40ac-8010-eb57948a3fbb@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b95faee7-e32b-40ac-8010-eb57948a3fbb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 29/05/2026 20:38, Paolo Abeni wrote:
> On 5/27/26 1:31 PM, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> Thank you for your review!
>>
>> On 27/05/2026 19:40, Paolo Abeni wrote:
>>> On 5/27/26 7:49 AM, Kalpan Jani wrote:
>>>> Gentle ping on this patch sent on 19 May 2026 — I haven't seen any review feedback yet. If anyone has had a chance to look, I'd appreciate comments; otherwise I'm happy to rebase or resend if it slipped through.
>>>
>>> Note that maintainers are under an ever increasing influx of AI
>>> generated contents that make processing incoming patches more
>>> challenging every day.
>>
>> +1
>>
>>> FTR this revision LGTM.
>>
>> Just to be sure, does it mean that Sashiko was wrong?
>>
>>  https://sashiko.dev/#/patchset/20260519092243.1242351-1-kalpan.jani%40mpiricsoftware.com
> 
> AFAICS, yes: the msk socket is set to TCP_CLOSE status before calling
> mptcp_backlog_purge(): __mptcp_add_backlog() can't add anything to the
> backlog.

Thank you for having checked!

The code then looks good, but it seems the commit message is no longer
correct with the last version (and a Fixes tag is still missing). I sent
a dedicated message for that.

>> If yes, can I convert this "LGTM" as an Acked-by? :)
> 
> There is already my Suggested-by: tag, I think the latter would be
> redundant?!?

Personally, I think it is clearer with an extra Acked-by, just to say
that what you had in mind (the suggestion) is what is actually done in
the patch. But if you prefer without, fine by me :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

