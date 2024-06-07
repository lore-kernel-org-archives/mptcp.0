Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B221991D5
	for <mptcp@lists.linux.dev>; Fri,  7 Jun 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775792; cv=none; b=ETL0twaVVbB6jRmmJ94emwXUQC8dPjMF76e20A409oFij0jEsz6wcb0UshNOHyp/kq04QuOWe7D8dmuXdcI1Cs46uUrQv8z6a0giH1f/txAt6PyROIgsgntN+juAoTXYbrhfAhyu7USXW4v35FnelKSYZ571zeI8ZvjkJ8iNUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775792; c=relaxed/simple;
	bh=2RI6uEvQt54v2JJ3Izsb3FXclzaZvUjRq3HvFFlOsKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZbXPyvX999sHzHp/MYdC94TGt1SPGS7+GZx2kOnB18f4UIQz7dUUbFFBm3J+sF+HWJADKrt/0aqix9DJqpOO9hJCxkjavIJ8bsko3tRYwudST8lRBUklPOu0Q1mJtac9qMKP5vtO4xycELYrr8m8vnpuCl11r4ghNMDMrmcCtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoCMCdD9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoCMCdD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4964CC2BBFC;
	Fri,  7 Jun 2024 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717775791;
	bh=2RI6uEvQt54v2JJ3Izsb3FXclzaZvUjRq3HvFFlOsKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LoCMCdD9z10nOWwsY2UPo7mam14XZc68umiXeIrhzlqFiGXjGZqqCfiPwuE9cACZK
	 rqrC/4rN3duKf1aQHqwPmouX750oT9GRDcnALUJFzQosTQKMdkbFibzRHXZms8to9A
	 bSWxWrC1W6ERhLtAYlKEhxMNxG4NcatpJY5au0NgAUfVjkfxEwcDVF+/FN5KsSGHjc
	 Qk1KlmRtseKWjJ4reZUtLPB8DU4ZVRdkKOnTl5c7XPEY7qhvWG/D/NGBw7LWq2MRT0
	 B3StFh6XeVhFvjUWLwxGUzn14xkkqFClSQZ6uq0VD2b/ne94qDRRwplvn3a6jsc/sC
	 1LyJSfocnYHOw==
Message-ID: <ed821f74-95fd-49f2-ae3c-91e2e7bfa395@kernel.org>
Date: Fri, 7 Jun 2024 17:56:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-iproute 3/4] mptcp: warn if 'signal' and 'subflow'
 flags are set
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
 <20240605-mptcp-user-feedback-v1-3-d2dc3b399643@kernel.org>
 <72cb6b39-7de9-b339-12fa-e7a7546e8a60@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <72cb6b39-7de9-b339-12fa-e7a7546e8a60@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 06/06/2024 21:14, Mat Martineau wrote:
> On Wed, 5 Jun 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Setting both the 'signal' and 'subflow' flags is very likely a mistake
>> from the user, and would bring unexpected behaviours as mentioned in
>> some bug reports on the MPTCP project.
>>
>> It is then important to guide the users by printing a warning on stderr.
>> Users can ignore this message if they have an atypical environment where
>> the initiator of a connection might accept the creation of additional
>> subflows from the other peer.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> ip/ipmptcp.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>
>> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
>> index 9847f95b..0f09cf75 100644
>> --- a/ip/ipmptcp.c
>> +++ b/ip/ipmptcp.c
>> @@ -179,6 +179,15 @@ static int mptcp_parse_opt(int argc, char **argv,
>> struct nlmsghdr *n, int cmd)
>>     if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
>>         invarg("flags must have signal when using port", "port");
>>
>> +    if (adding && (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
>> +                  (flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
>> +        fprintf(stderr,
>> +            "Warning: Setting both the 'signal' and 'subflow' flags
>> is usually a mistake:\n"
>> +            "         'signal' is used to announce additional
>> addresses, typically for the\n"
>> +            "         server side, while 'subflow' is used to create
>> new paths, typically\n"
>> +            "         for the client side. It is not typical to both
>> initiate, and accept\n"
>> +            "         new connections with the same peer. Continuing
>> as requested.\n");
>> +
> 
> Hi Matthieu -

Thank you for the review!

> For this patch and the next one, I think it would be better to update
> the man page with information about typical usage rather than printing
> this error message. Seems like the ip tool doesn't have other
> informational run-time messages like this (especially ones this long),
> and there's no '-q' flag to silence them for non-typical cases.
That was my first intension, but I think only adding such info in the
man page will not prevent frustrations, and bug reports. I mean: that
supposes people are (fully and carefully) reading the man pages, and not
just 'ip mptcp help' :)

I thought it was OK to let people ignoring this message, because the
action will still be done. But what about adding a new option
'nowarning' option then?

  ip mptcp endpoint add (...) [ nowarning ]

If people know what they are doing, they can add this not to have the
warning, while not fully ignoring what is printing to stderr.

If not, I'm not sure people will notice what they are doing is very
likely wrong.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

