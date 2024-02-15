Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E776129A98
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997407; cv=none; b=p9rHe8xts35mOzz+L8I3OPObLFTGFoLN9olPlvQ/dm+tdcJpGAiiCquVswDBzSlwU3FETUyQjRRKcL838lilz0W4EC9uQwSKmPdheIcONWj9Wq9hQ4Pv/x5AC6MCYjhlJPMv0p6e2OCnnRovn+r5a1P5BLj+S3tRSsnI2VwKUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997407; c=relaxed/simple;
	bh=e1XjQKWZNI9DlpWQGvK0LjtHPVM0VlfF5MC3ddesMD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExQmTR0/FIb+ZbMkSOjFvgsf6LPovrxZeHaIuDP5ItgfOCQrJHDNoz5z9ujFhcCOm5B6KlsRGKmT51Cifw6mwJ0MBgt+GQS1YAwANKWc3lIhE++JzPnHvoy434OcIlsPqTNrxhepo8MrQNUEBBRsI5EHtqd9kx0SgcOfx/n7KcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojdvbRt6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojdvbRt6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20885C433F1;
	Thu, 15 Feb 2024 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997406;
	bh=e1XjQKWZNI9DlpWQGvK0LjtHPVM0VlfF5MC3ddesMD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ojdvbRt6WMrTFMgctVcftT8xzqhFURrF+F6AQiSskayPAOMBRe9jJdewLz33Sul0Q
	 tAl5S3EyeThxaVIxuaUbDHpmPg+DoR8rG4D2ZfZw1B98C9TJ4Qn8y2lahhSNVTYwMN
	 QHxFDTIv73OF3tnwUKT3mMVqXc2YQ1nYJ5jtreiCp7uLG+/gOKkj27AlEKreNw3s3x
	 hpBv/Zee4PB10q6Yhd096kESOgKucCJXhfQLzENFMW0mjWQ4s9niMZ0+Rx1IhlU+gn
	 X63genZElyegEonRFezkSPzyEpkXZBTdCxYaw2BF4RJkx4R1hgf6jLW3F3xsT8Ar2h
	 sgApltHAGfW9Q==
Message-ID: <321b24d9-f947-4fad-893e-6958e4f6f1f4@kernel.org>
Date: Thu, 15 Feb 2024 12:42:45 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: check the protocol in tcp_sk()
 with DEBUG_NET
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
References: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org>
 <20240207-mptcp-check-protocol-v3-2-77c69c596f55@kernel.org>
 <b8171406-f8f8-4bd9-b762-25aaccfb3647@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b8171406-f8f8-4bd9-b762-25aaccfb3647@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 14/02/2024 20:03, Mat Martineau wrote:
> On Wed, 7 Feb 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Fuzzers and static checkers might not detect when tcp_sk() is used with
>> a non tcp_sock structure.
>>
>> This kind of mistake already happened a few times with MPTCP: when
>> wrongly using TCP-specific helpers with mptcp_sock pointers. On the
>> other hand, there are many 'tcp_xxx()' helpers that are taking a 'struct
>> sock' pointer as arguments, and some of them are only looking at fields
>> from 'struct sock', and nothing from 'struct tcp_sock'. It is then
>> tempting to use them with a 'struct mptcp_sock'.
>>
>> So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
>> kernel devs when a non-TCP socket is being used as a TCP one. 'tcp_sk()'
>> macro is then re-defined to add a WARN when an unexpected socket is
>> being used.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>  - v2:
>>    - Move from include/linux/tcp.h to net/mptcp/protocol.h: specific
>>      to TCP (Paolo)
>>    - Use a macro instead of an inlined function (Paolo)
>>    - Adapt the commit message after the recent changes.
>>  - v3:
>>    - add parenthesis around 'ptr' (checkpatch)
>>    - there is still this check from checkpatch but I guess that's fine:
>>      Macro argument reuse 'ptr' - possible side-effects?
>> ---
>> net/mptcp/protocol.h | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index eefd1397106d..6b62a7f35dd9 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -348,6 +348,15 @@ static inline void msk_owned_by_me(const struct
>> mptcp_sock *msk)
>>     sock_owned_by_me((const struct sock *)msk);
>> }
>>
>> +#ifdef CONFIG_DEBUG_NET
>> +/* MPTCP-specific: we might (indirectly) call this helper with the
>> wrong sk */
>> +#undef tcp_sk
>> +#define tcp_sk(ptr) ({                                \
>> +    WARN_ON((ptr)->sk_protocol != IPPROTO_TCP);                \
>> +    container_of_const(ptr, struct tcp_sock,
>> inet_conn.icsk_inet.sk);    \
>> +})
> 
> Hi Matthieu -
> 
> Could make checkpatch happy with:
> 
> #define tcp_sk(ptr) ({                                \
>     typeof(ptr) _ptr = (ptr);                        \
>     WARN_ON((_ptr)->sk_protocol != IPPROTO_TCP);                \
>     container_of_const(_ptr, struct tcp_sock, inet_conn.icsk_inet.sk);    \
> })
> 
> (same idea for patch 3)

Good idea! Better be safe than sorry :)

I just sent a v4. While at it, I also removed the extra parenthesis
around '_ptr' in 'WARN_ON((_ptr)...)': they are no longer needed now.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
