Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6B23507A
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746006166; cv=none; b=sIZn0eGSnI2L+54Wb9fWAPNay8wF0qq3jEsSvhvKiV0jqbH7ASZdIiXaw9pKTHm2ph1JOQz5aVTiYaitKXStwfqrjWe9EyTDB6/e8H9ukdduAIwU3iUAaUAYvvkgGG1URuqY/P3/evFODdS2fCO1Nx6VcFWbuufwd5iw1oMsFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746006166; c=relaxed/simple;
	bh=kXiy6qPP3sny1PgM2cHR0w7RhdSAhCDd9arl7UHaIIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gck1IYcvr3TbbzGdimcZZd5oOJt8pE+gkbKJWEbtHcVwc7HYKaR13PEcGH1DUfRLF9NYoAeS2LqeLDBbSDsyNLAq94fnrQmpfH/PoLrGQoeiI+w3m6OTv+C5u/rhLb1RZWFscUJgLo5+HWnyCGLa91xFPuKEFP5/y+wgQk4lwvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPphG8Jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPphG8Jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EE3C4CEEA;
	Wed, 30 Apr 2025 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746006165;
	bh=kXiy6qPP3sny1PgM2cHR0w7RhdSAhCDd9arl7UHaIIE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lPphG8JcqQTK71CozsQ9FJJjhK/VorKrttpgp+e2n4Y7c3lntr0K/3FhmSZ/tfPff
	 sr7/LPki3nQxzdNxNSa28OGj9d4jaxemO/XiFdRoL9E1CCm9bwfAzYzjN5wRmHg89c
	 Twbfb/owlid1mPYLS60K8LIuC0N9h9Ju15gjHlzXr5OJB3JyhvA1JZlWRNi5MfOhEm
	 rOnZ0IVIMg9PRllN17tfa4Th2MnsjJugtBhiIs44IztWASX/T2MUCjWWVmTJceZua1
	 0TkEx6z3b1cC1XHl+9M0K664ZhMzMYP88ElieMpbop3WwVeZynZzEXGhuUL04cRnjv
	 VEkDDkrJEMAiw==
Message-ID: <f5a3b547-d6d8-4448-a679-c638d918c9d6@kernel.org>
Date: Wed, 30 Apr 2025 11:42:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: validate maxseg sockopt
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1745991978.git.geliang@kernel.org>
 <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/04/2025 07:49, Geliang Tang wrote:
> This patch validates the newly added TCP_MAXSEG sockopt.

If you don't mind and have access, do you mind creating a PR on GitHub
instead please?

  https://github.com/multipath-tcp/packetdrill

When you send them here, the CI might think it is a kernel patch and try
to apply it (which can work with new files).

> Signed-off-by: Geliang Tang <geliang@kernel.org>
> ---
>  gtests/net/mptcp/sockopts/sockopt_maxseg.pkt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
> 
> diff --git a/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt b/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
> new file mode 100644
> index 0000000..62492db
> --- /dev/null
> +++ b/gtests/net/mptcp/sockopts/sockopt_maxseg.pkt
> @@ -0,0 +1,20 @@
> +--tolerance_usecs=100000
> +`../common/defaults.sh`
> +
> +0.0  socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
> +
> ++0   bind(3, ..., ...) = 0
> ++0   listen(3, 1) = 0
> +

Here, similar to other sockopt tests, can you check the default value
please? It should be the same as the one for "plain" TCP, 536 I suppose
(min mss).

> ++0   setsockopt(3, SOL_TCP, TCP_MAXSEG, [1000], 4) = 0
> ++0   getsockopt(3, SOL_TCP, TCP_MAXSEG, [1000], [4]) = 0

Can you move this block before the bind()/listen()? It seems to make
more sense to set that before the listen(), no?

> ++0     <  S   0:0(0)         win 8000  <mss 1000, sackOK, nop, nop, nop, wscale 0, mpcapable v1 flags[flag_h] nokey>

Just to avoid confusions, in the inject packet here, please set
something else, e.g. 1460.

> ++0     >  S.  0:0(0)  ack 1            <mss 1000, nop, nop, sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
> ++0.01  <   .  1:1(0)  ack 1  win 8000                                             <mpcapable v1 flags[flag_h] key[ckey=2, skey]>
> ++0   accept(3, ..., ...) = 4

Can you do a getsockopt(4, ..., TCP_MAXSEG) here to check the value? It
should be similar to what you would get with "plain" TCP (is it 988? or
-20B reserved for MPTCP options?).

It might be better to introduce a new test doing the same thing with
"plain" TCP to compare if you don't mind.

> ++0   write(4, ..., 100) = 100

Here, please write more than the MSS you set, e.g. 1250B to see how the
stack will split that in two packets

> +
> ++0     >  P.  1:101(100)  ack 1             <dss dack4=1   dsn8=1 ssn=1 dll=100 nocs, nop, nop>
> ++0.01  <   .  1:1(0)      ack 101  win 256  <dss dack4=101 nocs>
Here, can you change TCP_MAXSEG on the accepted socket (fd = 4)?

e.g. set it to 800, then do a getsockopt(), then write(4, ..., 1250) and
see if you have 2 packets of the expected size.

Then, if you don't mind, please also create a new subflow by injecting
an MP_JOIN with a MSS of 1460, and check that the SYN+ACK+MP_JOIN
generated by the kernel has a MSS of 1000 as expected. For an example,
check mptcp/mp_join/mp_join_server.pkt.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

