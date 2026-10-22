Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655889;
	b=F/eVMpzgRosybhlWvAkUtn9MBIzv69ttAZpec//G/Nm1HvOWpwh0juJKBZt0oc0vauwp
	 oSNsNtiAZIXBBCzxcN3VFqNqS3k9v6dIujseJU74oS4btMYNsfLgxNT8wDl7gwazgf2Rf
	 MnnQTHlcU8+QoQcn13De5sOUlkkQbvqp9CwoLg66m7CTP7N3AWa0SJlq4bZsMrA/15vtC
	 WVDOdXnpy+Dqvr1T6ndw2WrS4Q27gVPg5kyI+NXHTISWXUr5Y3O7nVAkLXZcl1vPAtB96
	 BqSLSpbdTY1a9V2QRjzqOYzcYXcUeMcSKr1RNF/7sabJsCyveTfxmT7K5U71GRiqUqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655889;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+GWQZ0V7URCf8bFtf+N1jbL1CMQRBSC1XXUv+Mx6Iqc=;
	b=4R7foKNr0zOCACxGJzZkZyzLE49iS0nmKKr4xmk4HT+ry2gJFA3U5mLke2SInXAxLNdx
	 hgQ95PXZPxHcr8qy8umj9eNtWgayw5yjw6HJ90I8KTiaOE8Q6QIeR/uUhc/hxnOipHlD2
	 f1LFtE9OJT0HDzauc9sottpj58M+L3olXotQuWTMpv3QD4oH9HRnPb1LKjvTf7y7w55bR
	 lL9ghtcHNwMY6YXTOKpJoJoTXRszc+aTL4I04Wl51T83/rnb9K6uYT4t87YQBNlAG6Ptr
	 PF8iPh+1cYjX4p2g47yVnwg4bfHWVS/YE6V7Au0s5oHEqkHrHgEa748jGzPi7YVRhZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOPbKxi+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784F606A31B
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOPbKxi+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E21F000C8;
	Thu, 22 Oct 2026 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655888;
	bh=+GWQZ0V7URCf8bFtf+N1jbL1CMQRBSC1XXUv+Mx6Iqc=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=eOPbKxi+0THKokQLhcSDURsZqiMQHxVZHpcbRI+Kt34kEOojJ2UTV8r4CaaqCvkah
	 4t8bygBiecArCtFbPjsecrIj6+6rT6/EwWlNoZsOXX1grhGGioxd4ThTLt9G6GP73r
	 53kiDqDA5vvMbVmOu9eJ6DZMt8fB3ZLazBXG2QE8rep5hXn24W1xYjCvjXuQgaCK3g
	 LiwDINwwrZ30cIyb8gRnieNmuCoFjVqi0ZTEN/QmbG8eRDA4dD8BpWwHBhosZgPwTT
	 MCpBmUJt5Dce1kVW/ymU2eTYsjzvnGJJkiFNl/oU/UYDNiywUPEZXwW8BErwSLTFhY
	 sUHR6zQ579rJw==
Message-ID: <6995e688-db92-4291-a94d-18b03e517a73@kernel.org>
Date: Thu, 22 Oct 2026 09:58:06 +0200
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: print stats before socket
 closure
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260815-sft-mptcp-stats-b4-close-v3-1-ccd9af14cf73@kernel.org>
 <24e7da3ea0b33d5dca970449cf615a4c95ecceb8.camel@kernel.org>
 <735a6655-b3ac-4352-8a35-0e54ac2c7ffd@kernel.org>
 <7ad218abd5b68ac34bc34b607af3bb4c7163f60b.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7ad218abd5b68ac34bc34b607af3bb4c7163f60b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for your patience.

On 21/09/2026 09:52, Geliang Tang wrote:
> Hi Matt,
> 
> Sorry for the delayed reply.
> 
> On Tue, 2026-09-08 at 19:52 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 05/09/2026 10:26, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Sat, 2026-08-15 at 00:28 +0200, Matthieu Baerts (NGI0) wrote:
>>>> In case of poll timeout, it might be too late to print the stats
>>>> after
>>>> the socket closure.
>>>>
>>>> Now, in case of poll timeout, 'ss' and 'nstat' are invoked from
>>>> mptcp_connect to print the stats before exiting. This should help
>>>> debugging poll timeout issues.
>>>>
>>>> Note: for this "workaround", system() is used for debugging
>>>> purposes
>>>
>>> This print_err_stats() implementation is basically the same as
>>> mptcp_lib_pr_err_stats() in the shell, right?
>>
>> Correct.
>>
>>> I think it's better to use mptcp_lib_pr_err_stats() in the shell to
>>> print the information. In mptcp_connect.c, when a poll timeout
>>> occurs,
>>> we send a signal to the shell and don't close the socket
>>> immediately -
>>> we wait for the shell to finish printing the information before
>>> closing
>>> it. What do you think of this approach? There's a reference
>>> implementation in the attachment, but I haven't tested it.
>> Thank you for your review. I agree that what you suggested is better
>> for
>> a tool that would be used in production. But here with the selftests,
>> I
>> don't think we need your long patch with a higher complexity, just
>> for
>> the selftests. I think it is fine to have some "system()" calls with
>> the
>> same ss/nstat commands compared to a patch of 50+ lines to get the
>> same
>> result. No?
> 
> I agree with you - simplicity is a plus as well.
> 
> I tested it and it works. So LGTM!
> 
>     Reviewed-by: Geliang Tang <geliang@kernel.org>
> 
> 
> However, we need to handle something in mptcp_connect.sh afterwards.
> Otherwise, when a timeout occurs, we'll get two duplicate outputs: one
> from mptcp_connect, which is the log added by this patch, and one from
> mptcp_connect.sh, which is an invalid log. I think in this case we
> should ignore the latter, for example by adding the following to
> mptcp_connect.sh:
> 
> do_transfer()
> {
>   ...
>   mptcp_lib_pr_fail "client exit code $retc, server $rets"
>   if [ ${rets} -ne 2 ] && [ ${retc} -ne 2 ]; then
>     mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}" "${port}"
>   fi
>   ...
> }
> 
> What do you think? If you don't have time, I can submit this follow-up
> patch as well.

Is it really an issue to have two stats outputs? They are not
duplicated: one is explicitly printing stats before socket closure, and
the other one after.

Ignoring the 2nd output is easy, but this output can be valuable? Also,
I don't think there will be a timeout issue on both the client and the
server. Likely only one of them will timeout, and the additional check
you suggest is not needed.

So OK like that?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

