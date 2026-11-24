Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519036;
	b=jgduD51jOSid2QSwCSyY/D7+9CSkN8ib4AvoVAfOe0wddI9bzTA1osPn3XuY7Mmyd8Xy
	 dg9g3D1F4dFvQuM38kqgHBTXcOC8r53o9fh0AnpsHzPwD+GgemuEpHNsLqZjufY6RnXfz
	 SyNrc2KBeCI0610LT/Lf9g79/jAEqxCZRysWS2B13lFLDeyWrKEiNFsztHjgTLRW70Nwj
	 rzpQGA/PYusuMouJ1E1+exM6MZdOk3aTnxocHhNuraQ4JUbiPvbvU5zeQ1CiMpAFwdGf0
	 scIr5BbnnvJrWWjKEc+7ZF2Vr4TMQptBpn5kUnBc7YPy2ZgW54yWKwJvJFkB3AAknzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519036;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9b0baDy1DGNiSmksJk8Tx9Zd3z3NuWwMptXJp6zFIqA=;
	b=tQNVwalL1pnHiJ4SYq3Eeog8glprMLJDymnwOEcdQkoKJtFtIvIG0tjGw/qstGsdGc66
	 cazPDuzy07FlBP7Uqs/CmDlU4gP5DawZKa+WycZt4diZ+6YWNpr1S0Z+/D6X1RYLOkWzb
	 HVfKsHIms38/LWoKp/d+8YpA8oj0a6YLGgtAEE1Gw8y8ywm7SCde9AF4RG5sY+CqTmnZK
	 6uVy+w9Ytr9A3pMpOvktTwZI2pn7b/qUwhDBPwaEaDVW/6MMGfOpwvOzlvS5z/Fc2FGqr
	 GGAeHesTBXueqlRRlARHJ8BH4gnvYApTwQYG2ZSH4p6MbZBDBbnbK+J6FVYPCOx/o9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgZS1Q4h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA45606A31E;
	Tue, 24 Nov 2026 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgZS1Q4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D201F000D3;
	Tue, 24 Nov 2026 11:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519035;
	bh=9b0baDy1DGNiSmksJk8Tx9Zd3z3NuWwMptXJp6zFIqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WgZS1Q4hhutTQF9SnsFjOgHtBLtKdJ9TlSBT2lBaIotBuKGkWk4jkQ/nIOHc8txNJ
	 12jRKuTZ6J9LGppXFjWgTzGQfsaoE3Q/8PTErZvEfZz0ckoxqPVZB1udNZNjxntUY0
	 9Op9NZSxXMx/TWy5fOgfrChJbDc6+zkkZ/TrsiL/rgr/Rn3wWVBItfPYzfvdPSfoIb
	 tQBD3PWtlmfux4o94jHEgOX3MdkSuwAsqop628V9SgBRmREic6nahFUdyV2/5SmYzG
	 eku5aINkwB6yPSuvqknVhU8bRkGFGW4PApMM/TvQBT+7QshlPGxlOvWuIAcd8tpIMB
	 eMHNuslHozZfA==
Message-ID: <a9526d12-87db-466d-aac8-ae575559e010@kernel.org>
Date: Tue, 24 Nov 2026 12:17:10 +0100
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
Subject: Re: [PATCH mptcp-net] mptcp: gate diag sequence counters on
 CAP_NET_ADMIN
Content-Language: fr
To: Dominik Maier <dmnk@google.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, dmnk+artist@google.com,
 Kalpan Jani <kalpan.jani@mpiricsoftware.com>
References: <20261119192159.2646113-1-dmnk@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261119192159.2646113-1-dmnk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dominik,

(+cc Kalpan)

On 19/11/2026 20:21, Dominik Maier wrote:
> In net/mptcp/diag.c, subflow_get_info() restricts MPTCP sequence-related
> subflow attributes (rel_write_seq, map_seq, map_subflow_seq, ssn_offset)
> to callers holding CAP_NET_ADMIN in the network namespace.
> 
> However, mptcp_diag_get_info() unconditionally exports mptcpi_write_seq,
> mptcpi_snd_una, and mptcpi_rcv_nxt via INET_DIAG_INFO because
> .idiag_get_info does not receive the caller's net_admin status. Any
> unprivileged local user can therefore dump or query cross-UID MPTCP
> sockets by token via SOCK_DIAG_BY_FAMILY and read live 64-bit MPTCP Data
> Sequence Numbers.

Thank you for this patch!

> Emit INET_DIAG_INFO from an .idiag_get_aux callback in mptcp_diag (which
> already receives net_admin from inet_sk_diag_fill(), while msk never
> sets icsk_ca_ops so netlink attribute ordering is unchanged) and zero
> mptcpi_write_seq, mptcpi_snd_una, and mptcpi_rcv_nxt when !net_admin.
> getsockopt(SOL_MPTCP, MPTCP_INFO) for the socket owner and token-based
> lookup in mptcp_diag_dump_one() remain unchanged.

Oh, that's a good idea, I didn't think about .idiag_get_aux callback.

Kalpan was trying to fix the same thing:


https://lore.kernel.org/20261123054324.561321-1-kalpan.jani@mpiricsoftware.com

@Kalpan: what do you think of this? If it looks good to you, and you
tested it, can you send your Tested-by tag?

We can add:

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/445

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

