Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596349;
	b=uD2NooDx9RUUWADKsfmMmhJAyKN0FkH966GaxfyzlaUNkf/1uJoReTSl4h2Rp1rKIdUA
	 aQLVG3afnpcIf5oF7xGKAlFXT5IP7bTpInlt2VMZRwTDl1X510a6BiCRZEC+CV4C7H0uI
	 fm/a2263ss1qP4ZaSNaRwK77XV4zcPK3S0CCst9UenLqcq25SOZ+CF97gC9UYEA+szspO
	 RgcenQGQ9posGOZUMgStMzagq2GAMNMA9W5yVbCZhVIIS3qxb5d2sv5QgEqac/x5jj8jZ
	 LdGAuh3tTifsvltldIYqAGGUQj8aKCxSAm0Ww+IkTUq0fabGQIl87F0nm/70tpjobZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596349;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ryoqsrjoXubEgpswsBR+23g/2lrkh3bv49o6yJigIik=;
	b=CbtD5683e5IQnL7iHRx+kxkQ1APV5ixDwxFJjabwVV34y9XfzVr9O+AXNYsWENCP1cyx
	 wK+Sy77uVQZFN7K5rxUCZ9mz/HvqlZkPmKpbaKirSofR9LPEuiUWGJ7EtOX6XZdE40LG6
	 DFMQOn/5YPBTlSVio6xxalx7/Jvq2qMHIxkS/LYDMv/TkDLDBllPrFt+9J2HwOV9NCj0u
	 K8JiaSNaln7Ec/0U4mhjNuD+OKnLKwL0lEUGRpR1NqwhQFCXZulaV6t0WGdgg0mgXfkWT
	 VUZ4+caWpPa+v/yyeKpxFeJxqEAAqBhdFdnzjfk8CooDQtc4e8B5VugAbz4WDs1PMcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7azc6BU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE0606A31E;
	Wed, 25 Nov 2026 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7azc6BU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C151F000CA;
	Wed, 25 Nov 2026 08:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596348;
	bh=ryoqsrjoXubEgpswsBR+23g/2lrkh3bv49o6yJigIik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=M7azc6BUPwINZU77PSf79ayyBtOJ9PbEQJ3Klaj8/Y+qcl+idFE7qRwwbRdYEfYyv
	 P6Z5Xlzyb/+y0D4BbO0jiMisEGZpKuuq0+qT6bW3Wp6OwiQ5iFZi+4baAMeeUjr0ko
	 5xU887gtjgTM15EeuH/gESoJnTK+c1Kjzz9wpVBSGubyx/rBOj+FOJw/+BtbCfVhsP
	 Q/Wrg99Utw9o8Wyd2GzW3Oo3Ytfv2+j+alTqMZBFFs/ic4WSS28rrNDW1BLQDKRapS
	 9Mj9aqmHz3kIrWxeo2fgIXMfFtpuez4Kdv3rQia/q4YH78Z5joENdHmwKuEWc05nFC
	 6IxGmLZ2bZmRg==
Message-ID: <b2d353ed-d684-4327-a2e7-5042a07a2927@kernel.org>
Date: Wed, 25 Nov 2026 09:45:42 +0100
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
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: Dominik Maier <dmnk@google.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 mptcp <mptcp@lists.linux.dev>, netdev <netdev@vger.kernel.org>,
 dmnk+artist <dmnk+artist@google.com>,
 Shardul B <shardul.b@mpiricsoftware.com>,
 Mpiric Private Limited <janak@mpiric.us>
References: <20261119192159.2646113-1-dmnk@google.com>
 <a9526d12-87db-466d-aac8-ae575559e010@kernel.org>
 <1a2110afc5e.30756196125300.3918439705196063429@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1a2110afc5e.30756196125300.3918439705196063429@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 25/11/2026 05:51, Kalpan Jani wrote:
> Hi Matt, Hi Dominik,
> 
> I tested the proposed change on a locally built kernel with MPTCP enabled.
> 
> Runtime testing passed for both client and server sockets:
> - Privileged Netlink requests return the actual sequence counters, matching getsockopt(MPTCP_INFO).
> - Unprivileged Netlink requests return zero for mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt.
> - Other diagnostic information remains available to unprivileged users.
> 
> The full kernel build and runtime tests completed successfully.
> 
> Tested-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Thank you for having tested that and your previous work!

Dominik's patch looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

@netdev maintainers: I see this patch is still listed on Suie, can you
please apply it in -net directly?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

