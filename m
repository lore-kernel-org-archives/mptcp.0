Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069C1DE3B5
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171938; cv=none; b=ijjUuGa6Qjf+ZY9xzKU10NdouPrCTAjdZs7Wge8WlJysWRIR8wE2Bvq1+D7yqH4hp1WU8TI+M3NFexy2p0aurINnGXQhB2gMGKFg4Mjme+qH5mzpNOkVsuNqlNUbuGHSYIUKTurIiY9XyHREbANp3FHX7Fo/UVbdVcfcPUxvYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171938; c=relaxed/simple;
	bh=Iryw2+JB4Cb+vnXtXjzgKkysQGFENh/oXa7kZtXnYyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VSiTnXyh6UewHMTf5B9uQEg0XsFpVPMLOFnAokUfKg8ZX8wsQywlfjxoVFPP7erOfp9cZdfgEWjxpAAmh6ONm8twUIdv7qBocmQ1dw2Ub3xsqt7gm8luPnrP46CJiooYK+/puR2zM2y9igCjBPN3mmcXU3hFtWSs7Sv2Geb/r3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unYiGOmc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unYiGOmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3970C4CEE7;
	Mon,  3 Nov 2025 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762171938;
	bh=Iryw2+JB4Cb+vnXtXjzgKkysQGFENh/oXa7kZtXnYyQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=unYiGOmcnE/mBN+f+7/8P+oz95dmAXO+o6NuEnt1w+/zblZtaqTQdr2urDNs/B+sl
	 Q2dE13pGYG+4+XZdLMi3LV5UEP8SaBV/iLHIz3lP+GRLr6lsGvU2D5HX06Kn3Q08aj
	 eIpyKYzs/o8rmG8rnzWrC2GCacMmigJLYbWLCE62Cp/Epwve79mZ4YoRL1OCvZ+nTG
	 FpqC1A8chtDyg8a7efB7lo0nBOQ7thgaRuFspMgipf4+zEz+/53zIpzP42gVfaO0h7
	 Wz9KfG5oNKxCWPv3/TVE3OERjR2DGQ/HsFA0GQhvx98vLpRI6+ad7zniN1L0JUYPIx
	 Kqs/VD0HBBjbA==
Message-ID: <2e71345d-fe2a-4ae7-ba28-26e5d4fab726@kernel.org>
Date: Mon, 3 Nov 2025 13:12:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 6/6] selftests: mptcp: connect: trunc: read
 all recv data
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
 <20251102-slft-join-inst-v2-6-b4f3ba15a7c4@kernel.org>
 <d94c0f0850c8985324956cfdfef900bde3f2b377.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d94c0f0850c8985324956cfdfef900bde3f2b377.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/11/2025 08:13, Geliang Tang wrote:
> Hi Matt,
> 
> On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
>> MPTCP Join "fastclose server" selftest is sometimes failing because
>> the
>> client output file doesn't have the expected size, e.g. 296B instead
>> of
>> 1024B.
> 
> Thanks for this fix. After repeatedly running the fastclose tests,
> patches 5 and 6 have indeed eliminated the flaky failures.

Thank you for the tests.

>> When looking at a packet trace when this happens, the server sent the
>> expected 1024B in two parts -- 100B, then 924B -- then the
>> MP_FASTCLOSE.
>> It is then strange to see the client only receiving 296B, which would
>> mean it only got a part of the second packet. The problem is then not
>> on
>> the networking side, but rather on the data reception side.
>>
>> When mptcp_connect is launched with '-f -1', it means the connection
>> might stop before having sent everything, because a reset has been
>> received. When this happens, the program was directly stopped. But it
>> is
>> also possible there are still some data to read, simply because the
>> previous 'read' step was done with a buffer smaller than the pending
>> data, see do_rnd_read(). In this case, it is important to read what's
>> left in the kernel buffers before stopping without error like before.
>>
>> SIGPIPE is now ignored, not to quit the app before having read
>> everything.
>>
>> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose
>> test-cases")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v2:
>>  - Also catch EPIPE, and ignore SIGPIPE
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 18
>> +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> index c030b08a7195..404a77bf366a 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> @@ -710,8 +710,14 @@ static int copyfd_io_poll(int infd, int peerfd,
>> int outfd,
>>  
>>  				bw = do_rnd_write(peerfd, winfo->buf
>> + winfo->off, winfo->len);
>>  				if (bw < 0) {
>> -					if (cfg_rcv_trunc)
>> -						return 0;
>> +					/* expected reset, continue
>> to read */
>> +					if (cfg_rcv_trunc &&
>> +					    (errno == ECONNRESET ||
>> +					     errno == EPIPE)) {
>> +						fds.events &=
>> ~POLLOUT;
>> +						continue;
>> +					}
> 
> We're adjusting the behavior of the falseclose tests here and need to
> ensure it doesn't affect other tests. I'm considering adding a new
> config like cfg_rcv_ign to encapsulate these changes within an if
> (cfg_rcv_ign) block, and only enable this new config in the falseclose
> tests.
> 
> WDYT?

I don't think we need an extra option. For the moment, when one side
truncates the output ("-f XXX", which will cause a fastclose), the other
side will be launched with "-f -1". In this case, "cfg_rcv_trunc" will
be set, and we only change the behaviour for that.

It looks like this "-f" option is only use for the fastclose tests, and
both peers have a "-f". So we can keep this as it is, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

