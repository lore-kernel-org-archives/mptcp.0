Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598D18BBB9
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491595; cv=none; b=sktNf/4ZHi4494kzJoYJqb5uzXHeDE9F/INmaWDOvmeocRv2Po0Tt/CuDZjOW3E0afPC32j3IjWNUkp7dIlswmsRVEmgiVh8UUK7Jlu2jnU74O/S2JX0aZ7t68opJGu1ihPzLHcvy1Bt5bsbj5V6ttC5PE26BpdMDWYNFEzxI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491595; c=relaxed/simple;
	bh=lXZueAvEjYs8Ryb/qM/0TwgSS1SwO8TB61QgXAAlVcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atzIh8fqzgf8jFyxti97FAa7UISB0bVcXVHhZmUWVWD5wehOIEshTAl1al0b4PCsTQ3tRfBUMOu08ldXINied2PmtglU9l4jQNm6Kq9xXVNlDhY/M7XVD/yCE2hIjGb61j99C0OLA8nnn4NfMloJ0TJIqu2Jq6H0h0ZmhIRM2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmifXvtA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmifXvtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDD2C4CEE7;
	Wed,  6 Aug 2025 14:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754491594;
	bh=lXZueAvEjYs8Ryb/qM/0TwgSS1SwO8TB61QgXAAlVcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FmifXvtAwerYkxhLg8o+zk14WawE32UIzuSVVCRWRLls+KLW8zItoptxrhpP9L/Dc
	 dkulc1BButOwGMFR+GSmlPZ5Nftf4CvyzkmKVw+PQTb7B3qzSnyc0vKxPTBAtIiOZS
	 jz3CYAv/+zPzihRNnvQU5/yczx9hJXA6KLDLd2bAHZjU0kvmFjDsR6rQf18EomkhRR
	 iiIl38Y0ojVXWWpNJckVE9IWnshSgtIl48sYMadTEhRwquwBU7ksjtylL5v4/7ICrl
	 5/cn7BckqJfv+dXJ9CuMHUCWOApcuxkKHMiwh5+IN1xyn2mzRu3WG12UuR70VCvd0C
	 18fsplp1Rr/qg==
Message-ID: <76c43980-94ca-4bbb-917c-a61021bdd548@kernel.org>
Date: Wed, 6 Aug 2025 16:46:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 0/2] mptcp: TCP_MD5SIG support
To: Geliang Tang <geliang@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1754135958.git.tanggeliang@kylinos.cn>
 <CADg4-L_VUj4xXLWiUAVF0pGvguwTHPbrh4ixFanaqkWJqOfvkg@mail.gmail.com>
 <0567166cba36ca9d7d0181984ae703eea7068712.camel@kernel.org>
 <2370b313-4d83-458a-bfe9-9b0e556e9926@kernel.org>
 <5bb6d1597f1b95fa3e47235092ae8b64209d8bce.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5bb6d1597f1b95fa3e47235092ae8b64209d8bce.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/08/2025 08:14, Geliang Tang wrote:
> On Sun, 2025-08-03 at 09:47 +0200, Matthieu Baerts wrote:

(...)

>> Please provide packetdrill tests: for the client and server side. For
>> the server side, with and without MPTCP in the injected SYN.
> 
> Adding MD5SIG tests to packetdrill is not easy, as packetdrill
> currently does not accept struct tcp_md5sig as a parameter for
> setsockopt calls. This makes it difficult to express the following
> operation in packetdrill:
> 
> setsockopt(sockfd, IPPROTO_TCP, TCP_MD5SIG, &md5sig, sizeof(md5sig))
> 
> Integer parameters for setsockopt, on the other hand, are
> straightforward to represent. For example:
> 
> +0.0  setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> 
> Do I need to extend packetdrill to support struct tcp_md5sig? I'm
> uncertain and would like your advice.

I see that Packetdrill can parse packet with the TCP_MD5 option, see:

  gtests/net/tcp/md5/md5-only-on-client-ack.pkt

But indeed, there is nothing planned to fill tcp_md5sig structure. I
guess you need more than 32 bits.

Could you eventually try to add a new type of optval, similar to others
that have been added in run_system_call.c:syscall_setsockopt()?

If not, maybe we could do the tests in the selftests, but it looks like
that will be a lot of code and infrastructure to test something that
might be quick and short (and easier to maintain) with packetdrill, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

