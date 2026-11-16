Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832166;
	b=C6GHegEWJdphTI4FsM8x2andEdd/kAPZq7F2j8UNuXDzvJ9movyi1OqUihb7BHHmosTC
	 Gb6xZF2bzYnGzNkUwY57E8zla9/tjWrEW6DbvHNS08Z7YwuYxefykiWzzi6t5ILSoBHyr
	 f7xIgxaqGjzvdacPTbFWUcs02qVa7PK/xXS7l801B+L0poOr46c/3Yc4R80myjNnVxmK6
	 TlL0MW8NIjnxtwvjYS1QBmXZy7TsgsNs6GsYmQYJSqHoUxq9wkC47HeXI5pZbwkMdGnkG
	 VGYSNcylBdv/xml2Khq5Yd49iObEoe1do0IGdxhXZQ2CE7gvhxSawdbxTCfiq+S/ozg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832166;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8lfPLp5TsXisntpYB62MidRhzh2xJrWLldHNeL5CnQ0=;
	b=fnW3vG80xqYyyS2iylLh2mxyxfgFDB2Jh7ZZHT4oQ6YxcE4+MiLz/dKhWjMjDIJsK0/1
	 gtsxjTzc40XF0nt9uXLVDR3rrltMTKa5GgMHO2ugNcqESlruHeCEPfnXwn/5E7Fqoz6HO
	 C6j+WOhhm+KcMTr8df3Cn/ylZKdEFdw02fFWQztuZB2AonXg3Mr4klpQdh2DHo5tfeOJe
	 7UwYEinaG98GBnlsrRLtaVSqJkAJuMayL3hkCZv+EHQrvpK+1mbwRDJMNoMESredN+v94
	 /2yhNZ7khgtOL0qa8r/QdhwYonoZW2rceAhg18foa6MteL9p5Iqwh7ItuildPQcigZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE+d2nl1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14089606A31C;
	Mon, 16 Nov 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UE+d2nl1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7891F000C4;
	Mon, 16 Nov 2026 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794832165;
	bh=8lfPLp5TsXisntpYB62MidRhzh2xJrWLldHNeL5CnQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UE+d2nl1xi6laQEmxqVBp1nbZvKivGZcX3T+WcUMQEyhPX9vydA/kPqnjWR7x4o8S
	 6FbvMdQm89jWMAJaXEOMlaXP9U32npYEzs58NCczfW06r67tMRnHsC7ugrJQTVEyp3
	 MGAx9AXzTGBbh6O1Fbf9TbqUkpgios7I7QK4RGZCI+AYhfzQjIvKik9eKIIOi4VG/e
	 Pj2kD5TLt7Oi7S8Wef289Pj2nGM5ACzT1uQKIvlLb27AlYnzUP9sP6PpUi42va2Fbr
	 TybgYldR63kCqaF9SVJ14lUVxJaqs0syNdKyKpR2dh0Dwt7hpi6u9WXGOpPUUclBgo
	 qgrFA/QtkAaXw==
Message-ID: <9af16bc6-f44a-4585-8d19-6be3f637a12e@kernel.org>
Date: Mon, 16 Nov 2026 13:29:17 +0100
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
Subject: Re: [PATCH net v2 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Content-Language: fr
To: Eric Dumazet <edumazet@kernel.org>, Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "gang.yan@linux.dev" <gang.yan@linux.dev>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "martineau@kernel.org" <martineau@kernel.org>,
 "geliang@kernel.org" <geliang@kernel.org>,
 "ycheng@google.com" <ycheng@google.com>,
 "weiwan@google.com" <weiwan@google.com>
References: <cover.1794672619.git.x-professor@outlook.com>
 <CAL4WiirENP_SBccpu3qq51f6u4E7BwFoadEARZctwm0CGNCusg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAL4WiirENP_SBccpu3qq51f6u4E7BwFoadEARZctwm0CGNCusg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric, Yingjie,

On 15/11/2026 09:24, Eric Dumazet wrote:
> Le sam. 14 nov. 2026 à 17:12, Yingjie Wang <x-professor@outlook.com> a écrit :
>>
>> The TCP Fast Open and MPTCP blackhole handlers multiply writable timeout
>> sysctl values before adding the result to a jiffies timestamp. The
>> multiplication is performed in 32-bit unsigned arithmetic, so a large
>> value can wrap into a short delay even on a 64-bit kernel.
>>
>> With HZ=1000, a timeout of 6912213 seconds and the maximum multiplier of
>> 64 should produce 442,381,632,000 jiffies, but the current calculations
>> truncate the result to 512 jiffies. Both patches compute the delay in u64
>> and cap it at MAX_JIFFY_OFFSET before adding it to the saved timestamp.
>>
>> The issues were found using a static analysis tool. In the v1 arithmetic
>> A/B tests, loopback reproducers induced 12 blackholes, waited 1.2 seconds,
>> and then made a new connection:
>>
>>   TFO:   base probe 1.026 s, TCPFastOpenActiveFail +1;
>>          fixed probe 0.000 s, TCPFastOpenActiveFail +0.
>>   MPTCP: base probe 3.087 s, MPCapableSYNTXDisabled +0;
>>          fixed probe 0.000 s, MPCapableSYNTXDisabled +1.
>>
>> The TFO counter records another failed active Fast Open attempt. The
>> MPTCP counter records a connection that skips MP_CAPABLE and falls back to
>> TCP while active MPTCP is disabled.
>>
>> Changes since v1:
>>
>> - Add a reasonable upper bound for the TCP Fast Open sysctl, as requested
>>   by Kuniyuki Iwashima. This version proposes one day (86400 seconds),
>>   using the existing IPv4 one_day_secs bound, and documents that limit.
>>   Keep the existing MPTCP sysctl input range.
> 
> The one day limit, the u64 computation and the clamp look fine to me
> for the TCP side: with HZ=1000, 64 * 86400 * HZ still does not fit in
> 32 bits, and 32-bit kernels need the interval to stay below 2^31 jiffies
> for time_before().
> 
> Why is MPTCP left alone? Kuniyuki's remark applies equally to
> net.mptcp.blackhole_timeout: nobody needs a multi-day initial timeout
> there either. I will let MPTCP maintainers decide, but having the two
> sysctls behave differently looks odd.

I agree with Eric: these two "blackhole" sysctl knobs are similar, and
the behaviour shouldn't differentiate then.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

