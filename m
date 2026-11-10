Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337843;
	b=zFkxdRijq94cQk5VbBBQTdU3D5jhLX4TSJrIWS8DXYEB/bksfJzZjNCdOBdmRxlTzJez
	 1pnnsyGIMLDtYhLtsufUFRlO/ZEScPc9fhOYIquZUBeogikgb7d7XzkM0kGcNAb3h9AXh
	 fLtmrSuNiJ4GZgx1CjsG5owEzYPQcoPPYRtJYv7Hio44aEnbM5LvdDZKvtqZi/MqnIHXq
	 kPBridsZOuivcNB9aKnwIIDUIEg8EJezuW3aJiV/T8X54E1qfIxue3HoiUMw3jnGqVXUP
	 3znZMLZwL+FvAXWUef+EKBOKxj9S/2X0iUp0tA2SL4r87NKmaQrH6CnPpQtfMI2S4Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337843;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rX5bGHGHbQdz2HJQU94iTFz4MzHCw+66W5HX4woLxJU=;
	b=HEtMXaTXTyVmh3+Erxe5WUn9L0vIAMfwYTIHTTm/Em0CkZsvIBXBi0QlX9vF29ifX0kX
	 /gIqnCpx7YjV3umT+4KwijJWLDQQ8zCh8l6RRDaTcYagvZC6YezOcgpfGBR65skkRcIwe
	 qUUMDqLPvAbjK1NxqhLCxdWsscFzdB4Mz/A5E19qiw4ypspUPA9CGP9FrgFJ+05I1t7L1
	 3TD6ob541tfRa5qNCSoYVdLvXjtKuA36yFCqkTUN8TcCBHWGcrw4Ir0f6UJZNl1CUlXiI
	 UT5ei6pR5Ou2ksEIXnYVb+qL6BDgTGAc6NvZZDqyEmgciT7ecMHWoOJg069l1HdfZnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISpOO8YU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F940606A320;
	Tue, 10 Nov 2026 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISpOO8YU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B889E1F0089F;
	Tue, 10 Nov 2026 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337843;
	bh=rX5bGHGHbQdz2HJQU94iTFz4MzHCw+66W5HX4woLxJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ISpOO8YUBuHYjih4u0J5MiALoBs+CBneFpjwVn33ld/A/qtonhrUKQ1RAQBdZJ0Bd
	 UjkHxRsNoBD85cugGJKFEVKEvHj2rrfgrqNqmDeY59Dd2EtpDH5aQGCJeppLDtlhQ0
	 ChC1KQlXWKWQnKroWllU9JMv5fpToz6YeZ5lRV/i5JDRkUF9iRmbsztp8cPysj7irZ
	 wE7GhOQ9B21hdo1+6bW97u4mhOegjtW3bLgc99E3JNjxGxk3bzkF8UdaMeG2gmW62v
	 Ds5U887ir9Tb6dwuwEuJfXefE7NbezaX8vKAOcR17j6GBJROsWQ4ZHGc6LKdhpRF8d
	 4GOIJqZsbgT0A==
Message-ID: <aaf8b538-7897-40ae-ba2c-7eede4bef819@kernel.org>
Date: Tue, 10 Nov 2026 20:10:37 +0100
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
Subject: Re: [PATCH net] mptcp: reject DATA_ACKs against a reversed send
 interval
Content-Language: fr
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, Kyle Zeng <kylebot@openai.com>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20261104130747.1045741-1-edumazet@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261104130747.1045741-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

(+cc MPTCP list)

On 04/11/2026 14:07, Eric Dumazet wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> ack_update_msk() samples snd_nxt before taking the data lock, but reads
> snd_una after taking it. Concurrent transmission and ACK processing can
> therefore leave the sampled upper bound behind snd_una. Active-open
> completion also exposes a reversed interval when it initializes snd_una
> to IDSN + 1 while the socket-owned state synchronization is deferred.
> 
> A peer-supplied 64-bit Data ACK half a sequence space away can pass both
> wraparound comparisons against such an interval. The resulting snd_una
> can make __mptcp_retrans() inflate a fragment's already_sent field. Later
> ACKs can then underflow data_len and cause out-of-bounds page fragments
> to be passed to TCP.
> 
> Read snd_nxt after acquiring the data lock and reject reversed intervals
> before checking the received Data ACK. This keeps the interval shorter
> than half the sequence space, so the existing upper-bound check cannot
> accept an advance beyond snd_nxt. Preserve the existing handling of old
> ACKs and keep the transmit fields under their existing socket locking.

Sorry, I missed this patch (the MPTCP CI didn't get it).

It looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

While at it:

Cc: stable@vger.kernel.org

@Net Maintainers: this patch can be applied to the net tree directly,
thank you! (Or did I miss my review window?)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

