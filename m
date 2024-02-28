Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0F2E635
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111622; cv=none; b=JGXlhKvXUAm3mxUCw9qmEBow1QxXTWzNHFa5gpuVX+QmaCkD9Uz84bfJ5kDfHnYXu0Ze/NbOS5S/npKEbRG61RTe4JHltW1naY4Sdz2tKviX/2V0dD8jsIrSMtq0Ghy4LJgWz8iVq+ORZcVcfqNvKGdqTrCbET+DzfJAi7kxFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111622; c=relaxed/simple;
	bh=TPxkI0Y3bymRJOmMPmm+aC00TEzHo4GwdVX7SjExR8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DnLY9CSji2UU/hf2Q45iOrX9rRGrYxGaAvRu3pRGF7szvIdujUo0s0ehlWOPBN9WWzstyXkFClwhnKKhiUmxM0dLYzesEAtxOiQS4HccdOVOUV5Wxl7oXxddS1RlElvRviBUHtYFGcjTXFQdkD9E2QMdBOEixA+Wzjvsn1K9YSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtmqjJiW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtmqjJiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3F6C433F1;
	Wed, 28 Feb 2024 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709111622;
	bh=TPxkI0Y3bymRJOmMPmm+aC00TEzHo4GwdVX7SjExR8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dtmqjJiWqWhCt986OYUhGGOSOy7FXQLAd6Hp2CwV6hHhEWWembuSSUBLDE7peyRH2
	 NgmTcySA/VheY4QCtZftbEkI32EBACUGlARZQi+fmgqPg3KKcYU5w8cTPEBAgo6rt2
	 LHWyslKmkf+WilnzSwKWR1kzp2EeS5sAdrb7/AVrEAqxuLK5abEgatYmOTOx9lyIDm
	 ptKMYDBBY1HJGjzx21FCmtczlj9KTXONw2p4LBtxMx8wP5gKZ/Y3l0wG7SiiFR97HK
	 Pm4UCnu1Aq9zDkwzUFPfQT22xYwFWA11Vws3vmQrtI5QtQhdW8Z4M5N5X9bI+u2yYy
	 B2PNgTk39iGDw==
Message-ID: <7ff17cb1-0c1f-45ac-b797-17594a00a215@kernel.org>
Date: Wed, 28 Feb 2024 10:13:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 02/12] selftests: mptcp: sockopt: print
 every test result
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
 <1aa6a9af7ebd8690e595bfbbdde5f54f684f51e8.1708939962.git.tanggeliang@kylinos.cn>
 <405e2ab8-7483-4bf7-a9a5-a94c631af404@kernel.org>
 <0118dbd0fbf33d5a1f4ea98dc606b3be91af49db.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0118dbd0fbf33d5a1f4ea98dc606b3be91af49db.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 28/02/2024 08:57, Geliang Tang wrote:
> On Mon, 2024-02-26 at 13:40 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 26/02/2024 10:43, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Only total test results are printed out in mptcp_sockopt.sh:
>>>
>>>  PASS: all packets had packet mark set
>>>  PASS: SOL_MPTCP getsockopt has expected information
>>>  PASS: TCP_INQ cmsg/ioctl -t tcp
>>>  PASS: TCP_INQ cmsg/ioctl -6 -t tcp
>>>  PASS: TCP_INQ cmsg/ioctl -r tcp
>>>  PASS: TCP_INQ cmsg/ioctl -6 -r tcp
>>>
>>> This patch prints more info for every test result in each test
>>> group:
>>>
>>> transfer ipv4                                                [ OK ]
>>> mark ipv4                                                    [ OK ]
>>> transfer ipv6                                                [ OK ]
>>> mark ipv6                                                    [ OK ]
>>> PASS: all packets had packet mark set
>>> sockopt v4                                                   [ OK ]
>>> sockopt v6                                                   [ OK ]
>>> PASS: SOL_MPTCP getsockopt has expected information
>>> TCP_INQ: -t tcp                                              [ OK ]
>>> PASS: TCP_INQ cmsg/ioctl -t tcp
>>> TCP_INQ: -6 -t tcp                                           [ OK ]
>>> PASS: TCP_INQ cmsg/ioctl -6 -t tcp
>>> TCP_INQ: -r tcp                                              [ OK ]
>>> PASS: TCP_INQ cmsg/ioctl -r tcp
>>> TCP_INQ: -6 -r tcp                                           [ OK ]
>>> PASS: TCP_INQ cmsg/ioctl -6 -r tcp
>>> TCP_INQ: -r tcp -t tcp                                       [ OK ]
>>
>> Please clearly explain why this is interesting, even if it looks
>> obvious.
>>
>> Here, I don't know if this patch makes sense or not: to me, the
>> output
>> is now confusing because there is a mix of '[ OK ]' and 'PASS'.
>> Maybe:
>>
>> - remove all the "PASS: xxx"? → I don't see what it brings more
>> - (or convert existing "PASS: xxx" and "FAIL: xxx" to use "[ OK ]"?
>> But
>> there are fewer details)
> 
> This patch uses to match the output of this script:
> 
> INFO: PASS: all packets had packet mark set
> INFO: PASS: SOL_MPTCP getsockopt has expected information
> INFO: PASS: TCP_INQ cmsg/ioctl -t tcp
> INFO: PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> INFO: PASS: TCP_INQ cmsg/ioctl -r tcp
> INFO: PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> INFO: PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp
> 
> with the test results of it:
> 
> ok 1 - mptcp_sockopt: mark ipv4
> ok 2 - mptcp_sockopt: transfer ipv4
> ok 3 - mptcp_sockopt: mark ipv6
> ok 4 - mptcp_sockopt: transfer ipv6
> ok 5 - mptcp_sockopt: sockopt v4
> ok 6 - mptcp_sockopt: sockopt v6
> ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
> ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
> ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
> ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
> ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp
> 
> This patch is prepared for the coming printing counter patch, otherwise
> the two output results may have different serial numbers, which can be
> confusing.

Yes, I agree that it makes sense to print the individual results. But
what I wanted to say is that maybe we no longer need these "INFO: PASS:"
lines in the output?

e.g. only printing this:

# 01 Transfer ipv4                                     [ OK ]
# 02 Mark ipv4                                         [ OK ]
# 03 Transfer ipv6                                     [ OK ]
# 04 Mark ipv6                                         [ OK ]
# 05 SOL_MPTCP sockopt v4                              [ OK ]
# 06 SOL_MPTCP sockopt v6                              [ OK ]
# 07 TCP_INQ: -t tcp                                   [ OK ]
# 08 TCP_INQ: -6 -t tcp                                [ OK ]
# 09 TCP_INQ: -r tcp                                   [ OK ]
# 10 TCP_INQ: -6 -r tcp                                [ OK ]
# 11 TCP_INQ: -r tcp -t tcp                            [ OK ]

I think these 'INFO: PASS:' lines don't bring more info, no? If they do,
we can always modify what is printed above.

(While at it, it might look nicer to do: s/ipv4/IPv4/ (or s/ipv4/v4) if
we easily control that, I didn't check)


BTW, thank you for the replies on the different patches, it helps here
because there were a lot of comments on this v5.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
