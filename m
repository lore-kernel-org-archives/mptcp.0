Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368B264FBD
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021238; cv=none; b=OhJQUPYH91OB+dPKycb4ZRlsZ2RstbzBf/gDPjkQ1CKIohRZ5V5Z7XQmeKRBhTzNWAtZ1MT0uTn2UVEZmbX66nFqogs029QsTTRtY7gxoXF6gjFRYNXsRA0RQaoDFFDNGtjrov7/bqBcPQS70nll5iTcFw86TBBV1rJ8HgHQ4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021238; c=relaxed/simple;
	bh=HO5WACgbN7qNM7ssN2Q9k1W9Rzq7SYXZIM4CDvgPd5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ez3uYACpeg6aQOoJx9j6RjUkyO6+JOZ0lDxATSrBR7ZW0GY2UoCwmnlW7brZsSZFPLEcQgfKwzCcHqG4YKGwZbj6ibINEdKVaiiUHHtqHsl0cj2YSeRCXaYC0gz4cytioaWhpy/QoSQgHQLjQ3U1aaOIdJKIhn+DkxYfBneK8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f02SmsTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f02SmsTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B9B1F000E9;
	Fri, 29 May 2026 02:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780021237;
	bh=gEbRVA4LXfnaEh/yFIi1uH5b+IVo8nxfygSKd2iTDQM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=f02SmsTxu3J/CEe1xAdshyM7ybyZdsAAUtUCVc4wFutdbwGJGFtT6ayQg0IniPKF3
	 VCDFJywe28SYoc3NV1iIC1dITFujjpLCihZfkEYYW6FrWdZr6x4MujZ0ByUV0rKyJr
	 oKMcNBbF89C4m7s77Z3ID9nE6vyAnstdNXl5yY0f4hJsQ38JbTRwh3SCvfmzlbz/VJ
	 tCyAsMLqGTa/MBjObgQDKHC3MYprGkfmiUZR25SW4lzKYq63Ub7epkl7Bz9lQ7NnTi
	 vqCMLK3FxB1iUaltlnTS1sMNcUX56NKmiF6dJmILxZLpLNjbrQj+7L8RGVmlxpxBQY
	 CCAdS5rLQ89lg==
Date: Thu, 28 May 2026 19:20:36 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v3 02/16] mptcp: options: ADD_ADDR size can
 be negative
In-Reply-To: <4e199e8f-6915-4a55-a57f-6defae143c22@kernel.org>
Message-ID: <d2312c14-9a2a-a77c-042a-feccdd2903f6@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org> <20260520-mptcp-add-addr6-port-ts-v3-2-bffa658a7678@kernel.org> <8df0d9e6-7428-9fe5-72f9-da5350053415@kernel.org> <4e199e8f-6915-4a55-a57f-6defae143c22@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-540499199-1780021237=:27334"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-540499199-1780021237=:27334
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 29 May 2026, Matthieu Baerts wrote:

> Hi Mat,
>
> On 29/05/2026 11:56, Mat Martineau wrote:
>> On Wed, 20 May 2026, Matthieu Baerts (NGI0) wrote:
>>
>>> Use a signed int for the returned size, because if other options are
>>> dropped, the size can be negative, e.g. to send an echo ADD_ADDR with a
>>> v4 address, and no port.
>>>
>>> The behaviour is not changed, because it was working as expected with an
>>> overflow. But it is clearer like this, and it will help later on.
>>>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> net/mptcp/options.c | 6 +++---
>>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 4cc583fdc7a9..966f6a867287 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -651,8 +651,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
>>>     return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
>>> }
>>>
>>> -static bool mptcp_established_options_add_addr(struct sock *sk,
>>> struct sk_buff *skb,
>>> -                           unsigned int *size,
>>> +static bool mptcp_established_options_add_addr(struct sock *sk,
>>> +                           struct sk_buff *skb, int *size,
>>>                            unsigned int remaining,
>>>                            struct mptcp_out_options *opts)
>>
>> There are several other static mptcp_established_*() functions in this
>> file that have an unsigned int *size parameter - should update those as
>> well.
> Indeed, but only the ADD_ADDR one can be negative, when other options
> are dropped. Do you think it is worth it to also modified the others
> that cannot be negative?
>

I think it is - it's the pointer that's getting passed around not the 
signed or unsigned integer value, so the code inside those functions 
doesn't know the real meaning of the bits being pointed to.

With the code in those functions today, you're right that there's no 
actual bug with the behavior of the current code. But it's best to stay 
accurate with the type information and maybe sashiko will start noticing 
the type mismatch after the models ingest this email thread :)

- Mat

--0-540499199-1780021237=:27334--
