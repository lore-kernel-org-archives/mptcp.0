Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098521EA73
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080172; cv=none; b=WmzH1eiu5mWCwH72atBGHvzT8crb3HyTa5f8UU6wON8zcYGLfdigMOLtaQMNIFhVsF7E4m3QLs0q8tACXokMsmQbxmEAn91GtsXBPstSjojeaUid2CTX0uriHNbFZThb4Syj6JJ5v0z6c19i8U7/m9g0JmlycO9kP1Wi8cDC25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080172; c=relaxed/simple;
	bh=LA8xkXBGtLkPniavxt/bfoHPnYxp8TQq+zVMZ885EJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPINMFC61v9fdWZsOldWk8ly/I4033EFTCRVr9OPW6kTz7RWeYf4dMKUHFkuJhwV4knIaoNMCuogkMvT5ukeHbM7Bf3Ag3XSWJ6cP0oacKad70W7kWJwqyBlJ+Jc848+3m7yGLRDo5uvSkzIFU0dQ0S5D02I7qxFQ0LxCMcoPWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/OMBzWk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/OMBzWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82169C433F1;
	Fri, 16 Feb 2024 10:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708080171;
	bh=LA8xkXBGtLkPniavxt/bfoHPnYxp8TQq+zVMZ885EJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y/OMBzWkIoIUt5zKjgz7/FF2wAXmU9ZDdF7BFsNfE3cz83exgMn66q7zAowaNUeaH
	 UALqaXorV8hpEkEEXiIn2fOl2WQlw4VrPlaAW43Ey+VN9NjGkTfRFgmZxqS1oaTHV9
	 LTxFnJz3PJcR76DPOKVWBnE7OPXF9+VOd7Ql8YoC28ex+2r66cB1VmgTygcTRyd1h1
	 ks9g64+HEhwlO+qRwF+TZIx795acV4+I8u7VNZkFcg4Opdqrzc9kTpTes8bpUMzx8Z
	 cxlGiEOJukn8Ba4OsoX+LRGQSvQlAbs70HanyDBtrQh5ahMYU7TNMeXyyT+pn6XG4x
	 HM6NOV3iJO55A==
Message-ID: <6b9c4a3e-3c30-4e7b-ab99-ed2e34e24015@kernel.org>
Date: Fri, 16 Feb 2024 11:42:48 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: avoid printing warning once on client
 side
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
 <9502e96c-8a72-a6d4-ca2d-1c75c536bfa3@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9502e96c-8a72-a6d4-ca2d-1c75c536bfa3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 16/02/2024 00:25, Mat Martineau wrote:
> On Thu, 15 Feb 2024, Matthieu Baerts (NGI0) wrote:
> 
>> After the 'Fixes' commit mentioned below, the client side might print
>> the following warning once when a subflow is fully established at the
>> reception of any valid additional ack:
>>
>>  MPTCP: bogus mpc option on established client sk
>>
>> That's a normal situation, and no warning should be printed for that. We
>> can then skip the check when the label is used.
>>
>> Fixes: e4a0fa47e816 ("mptcp: corner case locking for rx path fields
>> initialization")
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Looks good to me:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

>> ---
>> Notes:
>> - Should we convert this pr_warn_once() to a WARN_ONCE()? Or just in
>>   our tree? Or just in DEBUG mode?
> 
> I think it makes sense to keep this patch minimal for -net and stable
> (just moving the label).
> 
> Also given the consequences of panic_on_warn, would be better to make
> any changes to WARN_ONCE() in mptcp-next/net-next. I don't see extra
> complexity to modify this warning in our tree or debug mode as being
> worth it, do you think it would be valuable?

Sorry, I'm a bit confused by your reply. For the moment, our CI
complains when a "Call Trace:" is printed, but it doesn't complain when
there is a pr_warn().

If the warning here can be caused by interactions with a buggy host, it
makes sense not to have a WARN() when used in production, but it would
be good for our CI can catch that. If the warning can only be caused by
an internal bug, then easier to use a WARN_ONCE().

So I think here, we could maybe convert it to a DEBUG_NET_WARN_ON_ONCE()
and upstream that. WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
