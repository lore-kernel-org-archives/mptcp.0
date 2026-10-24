Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833892;
	b=wnkLeYXkSZAxwDyWheArz/pIzPdppRTDXA0s7yfuzNurwSvQMSJPEcvQ4+cegPbmo8SE
	 gUchrUrXraUMZ++iwhHIvz0NifVQewxFwayx8qO9HP+YyzYCs3EkpkOHI8HV85RliIwIq
	 2BSc6tVjdzxn/pZvUdZb8qo/diXiGE629OyaoELShMQvV6bxamGRsu0xU6p55Hus3JcIQ
	 p1QhKHy9MjKy/E8TLQpRAvqh7I0sdIbGuDRcFn3wYnEpT3WHzs7f4+uzqCeoxl/LBajOl
	 XJSSfNnn5KTttZBmj7u3ixRIn9MjH0LSfYocQFsIvB6a6FQHJCHuXtkHQguZYQI+TXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833892;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/r+3XZ0QVZqvIz8ZHQOipXOcUhoank7bgo2gUkEXK/c=;
	b=cDKQnYjz7g2LBB/qHKJkz/kD66JNSsvUxNBAEOT422whRh3nU5vNxWfLpv530rxUPoIS
	 r7G28DZ1zKtuMWYNa26eQgESasiNSYDCBDWG9R+loNsdYCu3e++1cMvHbVZaPcUk3ZGRT
	 ZIOT/6SyCfDY99Cz0baPI9wc5Ti34FWzu8whBAsx1XyzBDxGYll8eWNn9plMHuAbDMGB1
	 shhrs5YoEzrKbMvVVpwpQ2XPieICeexGs/R2SApNwuYuMWJU31IrgVdyrTfG6EaiTj73v
	 IjKaetP61CzumMFEAdfj3BTvu0T2BvsdJiwpgz2UKr0zhWD95vZ+3HpqEpOsWltaG+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nlk4lpM8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FE606A31F
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nlk4lpM8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31BF1F031E0;
	Sat, 24 Oct 2026 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792833892;
	bh=/r+3XZ0QVZqvIz8ZHQOipXOcUhoank7bgo2gUkEXK/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Nlk4lpM8H6xYnYq/RZijQ7Z5W8lcPcla3Gv2TGuRu/gTCfUr3ZVfkQQJj2+8z57l7
	 ZMa4S4PuVdBZ9njW2QMz80DfckZK7MWdLh73RF2ttLv7t4qmdwp/WSn0M5m6fweMn8
	 Q3JNuX9ubannyF2b7UPEtXR6a+c4IryNjeHsK8IteEBaNNTMtuXqWuPGGI56otmjgz
	 qm6EFDSRAFFE6dKVB13MPJ1SaZo3bjnup2p+0MDsz+qPCSMkgmB/D/0cPa1BJg98Us
	 RZIMf+AMuXU4SiHsyZfb6q8nzRSBC649Cyk1qXEd8sXghgkVBPv7zwxY8FPMgh4qsG
	 flRDMmx3+TvaQ==
Message-ID: <c6f1f223-f4cd-4545-80af-c902f4dbd460@kernel.org>
Date: Sat, 24 Oct 2026 11:24:47 +0200
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
Subject: Re: [PATCH mptcp-next 1/2] nbd: allow MPTCP sockets
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1792746800.git.tanggeliang@kylinos.cn>
 <1612e1611a1e5d78d651a4c1a69da38fdcf98ca8.1792746800.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1612e1611a1e5d78d651a4c1a69da38fdcf98ca8.1792746800.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/10/2026 11:19, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> MPTCP (Multipath TCP, RFC 8684) is an extension to TCP introduced in
> Linux 5.6 that can combine bandwidth from multiple network interfaces.
> 
> For NBD (Network Block Device), MPTCP provides significant bandwidth
> aggregation in multi-NIC scenarios. Our tests with 4 virtual NICs
> (each limited to 1000 Mbit/s / 125 MB/s) show ~4x improvement,
> TCP achieves ~110 MiB/s while MPTCP achieves ~400 MiB/s for both
> read and write:
> 
>  # ./mptcp_nbd.sh mptcp
>  INFO: nbd-server lacks native MPTCP, using mptcpize
>  INFO: nbd-client lacks native MPTCP, using mptcpize
>  Negotiation: ..size = 256MB
>  Connected /dev/nbd0
>  connected
> 
>  fio-3.41
>  ... ...
>  Run status group 0 (all jobs):
>     READ: bw=406MiB/s (426MB/s), 406MiB/s-406MiB/s (426MB/s-426MB/s), \
> 		io=4063MiB (4261MB), run=10001-10001msec
>  ... ...
>  Run status group 0 (all jobs):
>    WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), \
> 		io=3758MiB (3940MB), run=10001-10001msec
> 
> MPTCP sockets can be created with:
> 
>   fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> 
> Or enabled transparently using the mptcpize tool without modifying
> applications (mptcpize run nbd-server, mptcpize run nbd-client).
> Future patches will add -M (--mptcp) options to nbd-server and
> nbd-client for native MPTCP support.
> 
> Currently, the kernel NBD driver only accepts TCP and UNIX sockets.
> This patch adds MPTCP socket support by adding msk_is_mptcp() check
> in nbd_get_socket().

Just to be sure: are you sure it is safe with just that? We got a bunch
of Syzbot/Syzkaller reports back then before commit:

  9f7c02e03157 ("nbd: restrict sockets to TCP and UDP")

https://github.com/multipath-tcp/mptcp_net-next/issues/599

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

