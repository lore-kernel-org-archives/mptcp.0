Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520441;
	b=EwNr6x7EuQgogcqlE62rBdsS3EKSbON/3JmksEDOjtNR5QvtQX950U2+6qJMFuQ5v2BZ
	 0AQbcjBXAg3WLCngE4TL9me8pTzrbkRSiGw16W3OddQfz3g8/9ewkCpMlTKNGyX0JiQzN
	 eIcPKSBbP6BarFq6lQQw7CgxGOQ73HYSjOlWKIwXVBdlnNgzfjQTv4WLZRZIT8hTC+5ST
	 qW0jpoDNMKGK8RbIRH8ihy+D4Z/Jbhg87zYO6sAO/aj3D3SQ1x/Nokqzd2siFUA0/j/ui
	 arS7e33ENydZEnI8hoMwb3mm+mdj4CRV2y1TH7DGIWZyHQ5B8KDH3/31CvxgTdgxxUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520441;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wjS9Ue2xC7HZMzKTp4xtpVpKUB2zZscFciFeNWKIkTM=;
	b=e+uBrp+evzTJZCTgucxmX2LOq46tejnJAXjixqjtD3TnHPOX+XLqbrWNZ+sy6Z11V/g3
	 tmJmYDtpXAxXPqQhU7jmUtsvsP7Rm+pdT6cR7Zos6a80wnnA2bEFsEgKerR5S8MW64Pvu
	 AZsQ079j2uiKo8Zw+ocRpKSI9kJtqpkA9McaC+YnyPLrnwQ+kQDSAWO+8owl+24j7KTSO
	 aSREgLWZhzi+PCUctJLuKKdgIYxLkmut8lEk55aEm7FWD1KmzAYL+r5be/GPxs34oRnmU
	 Ojn6L8aeRRfEtFH2RsmU3ueJWRuuJQ3ivxaXhiUtVRwLlxFmExYW2vEEf7mrjfD0y1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lg4Eb34T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836A606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lg4Eb34T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B4B1F000CF;
	Tue, 24 Nov 2026 11:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795520440;
	bh=wjS9Ue2xC7HZMzKTp4xtpVpKUB2zZscFciFeNWKIkTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lg4Eb34Te9XgHi2lwgbeiemxf0RX/IWZFJZCYjDvWLbRgdJSxOezDtEndbnVTewgR
	 r2xQ1qyVwet2WpXVXBEYcYRqEiEsv0HxmyQ2sAjJ8cvGEhePnbdscwekODA/DH8sRa
	 Kehigl/pEbeB0VP2VOZdpqSMFl0VrAzUSe4jIL9QKKKCIBtpgddUEKxPmhDGSjNoBH
	 ScjMJvq2VeIcTVUVkmwdelsv0zLuKITGKwKd7VfcAV0brU0hWTQh9pGPIKG+YUcJgh
	 ucd/+3ZaTSOWDs3VAnm/ukcxBQifwvusN0DM25NaCsRZHHtwx0Ke0jk9hI07UyFr7J
	 iiFGHuolTcTSQ==
Message-ID: <710a9876-79c7-49c2-9aec-ef0214632c20@kernel.org>
Date: Tue, 24 Nov 2026 12:40:38 +0100
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
Subject: Re: [PATCH mptcp-net v2 13/62] mptcp: limit an orphan probing a zero
 window
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
References: <20261121-mptcp-cmason-fixes-v2-13-00327fd1de1f@kernel.org>
 <179541554231.3133.10776173874685565@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179541554231.3133.10776173874685565@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/11/2026 07:32, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0

(...)

>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 944c9d11d2116..ff71f19540771 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2886,7 +2912,8 @@ static bool mptcp_orphan_keep(struct sock *sk)
>>  		/* a live peer acks at least the probes, every TCP_RTO_MAX */
>>  		if (__mptcp_subflow_active(subflow) &&
>>  		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
>> -		    2 * TCP_RTO_MAX)
>> +		    2 * TCP_RTO_MAX &&
>> +		    !mptcp_subflow_probe_timed_out(ssk))
>>  			return true;
>>  	}
> 
> [Severity: Medium]
> 
> Can a remote peer still keep this orphan forever if the subflow is idle
> at TCP level?

Only a misbehaving one, acking the data at the TCP level only, and these
orphans are bounded by tcp_max_orphans and tcp_mem since the next patch,
as with TCP.

(...)

> The commit message also says:
> 
>   Two corner cases needing non-default settings are not covered, which is
>   fine: an idle subflow refreshed by keepalives still keeps the orphan
>   when the stale detection is disabled, and tcp_orphan_retries is ignored.
> 
> Is this accurate?

Yes: mptcp_subflow_active(), used by the scheduler, checks
subflow->stale, and the data of a stale subflow is reinjected on the
idle one, which then probes too. I will add a note in v3.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

