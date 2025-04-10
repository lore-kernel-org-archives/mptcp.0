Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A374690
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282648; cv=none; b=IBzOEca6G0fW+oRAj1/VMSvqf5bt1oWeHYtM6V0XYMQx5Zjil7Yavaa5wLfzXxOlBt8dOIb8CFLeTPEl5FgZbxPvxbYOqI1VKw5rdxz/en6M4k3hQZ0eoiUmIRPBU6gMDfOAf57/wJUxks+MMobPSyKVPvuxXeC5/zT+1BFSemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282648; c=relaxed/simple;
	bh=zbvOO5yCbyv0trc/iA+iFbYNIAzSkw+Z2bgSJop81AM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NpOliDP057g7rr5DDkqhX6IDDP4pl3uNW1jjhQZBiIHtIVXh6xDcYfTiVKt01x5xAhZF6dtF6u1LKxaMYsX5mqNno5NxQqk4BW0tVmTc7sB0PNo9rOsSM7y6Yfpyn5b5yy2Razi0iiLTmfCsplKmbKrJg8m32yhZ0f8V5DYUnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuEH7oA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuEH7oA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FACC4CEE9;
	Thu, 10 Apr 2025 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744282648;
	bh=zbvOO5yCbyv0trc/iA+iFbYNIAzSkw+Z2bgSJop81AM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=UuEH7oA7Cem2vfiffI6Uk14CMSCc6YsqQo+cE+UhEP3d/zRRGq8M2BojpTi+AtX8C
	 ehRTMKZ/r+G3fk0R6XEaD1Dbt1S9TvBHQcaL4Pp9AQb3rVheWusONz924DfBqGd6Oe
	 yQMhlPR5SsIVqL5twhgDQzvQEuQzfBNSF57oYFBX2SqAmIdAOblurqySijI5aACf5r
	 R5WZAupFb7RR08RPAxlkq4MKiyzoGwrZDaKWO3FKWBdEIK8HIvGCqZ/A0ueBJCC/8P
	 ZCXZjRFu80Rigp/Aitimo1XT0blPi29LrNqBYAdLucdvybEEwEWJ+Ay2BxWcON6B/a
	 gF8vxy99idMbg==
Message-ID: <428cfb27-7608-4039-a97f-5164d52cc73f@kernel.org>
Date: Thu, 10 Apr 2025 12:57:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH AUTOSEL 6.14 20/54] mptcp: move the whole rx path under
 msk socket lock protection
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20250403190209.2675485-1-sashal@kernel.org>
 <20250403190209.2675485-20-sashal@kernel.org>
 <2336cd34-d6d5-4db1-9d60-6ca7c398cbe7@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2336cd34-d6d5-4db1-9d60-6ca7c398cbe7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 08/04/2025 19:18, Matthieu Baerts wrote:
> Hi Paolo,
> 
> (MPTCP list only)
> 
> On 03/04/2025 21:01, Sasha Levin wrote:
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> [ Upstream commit bc68b0efa1bf923cef1294a631d8e7416c7e06e4 ]
>>
>> After commit c2e6048fa1cf ("mptcp: fix race in release_cb") we can
>> move the whole MPTCP rx path under the socket lock leveraging the
>> release_cb.
>>
>> We can drop a bunch of spin_lock pairs in the receive functions, use
>> a single receive queue and invoke __mptcp_move_skbs only when subflows
>> ask for it.
>>
>> This will allow more cleanup in the next patch.
>>
>> Some changes are worth specific mention:
>>
>> The msk rcvbuf update now always happens under both the msk and the
>> subflow socket lock: we can drop a bunch of ONCE annotation and
>> consolidate the checks.
>>
>> When the skbs move is delayed at msk release callback time, even the
>> msk rcvbuf update is delayed; additionally take care of such action in
>> __mptcp_move_skbs().
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-3-4a47d90d7998@kernel.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> It is not clear to me why this patch has been selected by AUTOSEL for up
> to 6.6, this is clearly not a fix. Do you think we should ask the stable
> team to drop this patch?
> 
> Having this patch in stable might help for future backports, but I don't
> know if it depends on others.

After discussing this patch with Mat yesterday, we think it would be
safer to ask to drop it from stable. If later we see it is really
needed, this patch can be backported (and probably others from the
series) and properly tested.

I hope there are no objections on that :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

