Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8AA6FE14
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520879; cv=none; b=nkZyOkc5qh/9Do0X9EVCrXPFRnswO/VQ7w35YrEbZEnlF6effF+1b0Ipd5BY+/f/T2RAODDYDov4k5m9VXeIWSBO7Vbi3/umBSyxStEQM6oi84M5bimULZPGhVqhS1Zsah8J8vr/Ss2GlyiXBM5Zwga6HAj/n2Xa4boQaLaOg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520879; c=relaxed/simple;
	bh=vPOZJvCm+mMuCdPnTpkyELNpbfQUdGPSSYjAEfSBMyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuvmjCvzXYc0aHhqnkWzdOTzAEcIROUgzzxNLsuU8Mcb8ldpHwF/E2tTL9xLO/Ru4w/T/I9Teqrv34Qf+9GDwshQd//NiELCThLtFyta2+Y5Uau38LRjeH5oG99ClDXfTKu/nj82UhRnEyBbhJXlcuJcdv85dkrh1ZikB4CAh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PW8AbBS7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PW8AbBS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C921CC072AA;
	Fri, 19 Apr 2024 10:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713520879;
	bh=vPOZJvCm+mMuCdPnTpkyELNpbfQUdGPSSYjAEfSBMyg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PW8AbBS7KctTUMWYYR6nRxTCZF9xStTF6RdeyUKdsMUXdFQ3J9g2Bd2lH5txflwAu
	 aRi1wgw+d5CVqrB+AQRCW21lOtA8uKdTmHFZHIIjtZkCNgESGyVJFO57oJ4kdUdQbx
	 g0t2qqAO8fbwywpnsC6Nd1zgL36uZSq/QZcY0NZPp36GhJhvYjewdlZ3TZk6m/4Bz8
	 coO378hSaYNjo1IoIxe1N/E9HsW3JLNlE2wyqkBpgDcV061Ki8BR4JmQDzlnuYdkkC
	 8s3ojn810lWBzDCpj758/UKA8Hi/6R7db1WSeU83UAwH/6r8Gflpw1NAb6PRyLCqu0
	 kUTheVLvrGmSQ==
Message-ID: <e6e208de-3739-4b7f-b5e2-c72adf87f416@kernel.org>
Date: Fri, 19 Apr 2024 12:01:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: info: stop early if no buffer
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org>
 <e10a438b-a286-3bb5-4818-b2537acecf65@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e10a438b-a286-3bb5-4818-b2537acecf65@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 18/04/2024 19:06, Mat Martineau wrote:
> On Thu, 18 Apr 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Up to recently, it has been recommended to use getsockopt(MPTCP_INFO) on
>> an 'accept'ed socket, for a server app to check if the client requested
>> to use MPTCP.
>>
>> In this case, the userspace app is only interested by the returned value
>> of the getsocktop() call, and can then give 0 for the option lenght, and
>> NULL for the buffer address. An easy optimisation is then to stop early,
>> and avoid filling a local buffer -- which now requires two different
>> locks -- if it is not needed.
>>
>> Note that userspace apps should use getsockopt(SO_PROTOCOL) in such case
>> instead: it looks less like a workaround, and it works with any kernel
>> versions, while the MPTCP_INFO method requires kernels >= v5.16.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/sockopt.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index 1fea43f5b6f3..b0d1dc4df0c1 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -960,6 +960,12 @@ static int mptcp_getsockopt_info(struct
>> mptcp_sock *msk, char __user *optval, in
>>     if (get_user(len, optlen))
>>         return -EFAULT;
>>
>> +    /* Opti when used to check if a fallback to TCP happened on an
>> 'accept'
>> +     * socket. Userspace apps should use getsockopt(SO_PROTOCOL)
>> instead.
>> +     */
>> +    if (len == 0)
>> +        return 0;
>> +
> 
> Makes sense to skip the work, LGTM:
> 
> Reviewed by: Mat Martineau <martineau@kernel.org>

Thank you for the quick review!

Now in our tree (without a typo: s/lenght/length/)

New patches for t/upstream:
- 1131e79ff7b0: mptcp: sockopt: info: stop early if no buffer
- Results: f0f388aa6196..b88f530f98b9 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/0347b4edc15cbbeaf0d16118ffa43fecc9b51e2c/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

