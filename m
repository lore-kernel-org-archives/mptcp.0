Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE632B987
	for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042279; cv=none; b=U3BIOYx6JLvwbI8CcuiKuhdg6cByqwSnRIUeFNNmv4GIrLRGiw71U/FNXr4sltY4+/xMQSinZZTriX3hqhcI1apiUpjp1cYq3tKQt8CEMvhFh/m+8nqeF+gurLXA7wZRCv9r1EfifcsAMa+f1p1NSLbmEhmrb5ZQP1oKzQXAbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042279; c=relaxed/simple;
	bh=B3s7ZSl86JD4ZLrcy7v2rLerojZVW4rI6JyJqxX2Opw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzB8YTPdi5JoC3NyZ0fgW3w3GX5pd14U50QcK9aKlXvVHSjqVHrZTap2Sg8Ho6lGi04oi3ASZAeXIEQHHL54j2ZT2XlwkxuAVuY+yN3X6MPgtoRfmOVyJ6RjjKZ84AeVJD9mNj1zOoH6MmhDDKCFyuEHlvffIl1ZkWVV827UqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Gnm0DzJZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Gnm0DzJZ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so6197411a12.2
        for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761042276; x=1761647076; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JcFCzEhSLG+mhX1K/VGxSMuzwAex5vT0vkcdh5aIy+o=;
        b=Gnm0DzJZAjFO0gyIc/S6nTKi59SLLc1W7iVyXIQHhVDRRUw4NtmRXC6fS5KFYpMPdz
         JEQ0TDavkwVTknuEmBPXtqSzLIebYYngGE6DtOAG/4kq2UaX2GQRWmHC7jQcIXeY4EhG
         nC5VjDH9W/s8m/rF5KTFzcwmFuLMy849UYd5BOsdUDqBS2SnGXom1gvtVPNQ4YaY7g6/
         e2Z4ZtpdkIoHUEhwygAq52bhCxPtSY3QI8sVP8hmX2lQAzBar8mwfGYLUzd73sLRpDWY
         kD0BOqGQGZCZYymOnvZKeASH78VN9fwSBF2y7hQlCwPMhhUxcxHWwdXoSGlPUZi4x+2O
         XgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761042276; x=1761647076;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcFCzEhSLG+mhX1K/VGxSMuzwAex5vT0vkcdh5aIy+o=;
        b=HEyGHJ4s9Xg5C/eKcliKj3CjZehiht+apJUNlEEnBFmlC+kIu7mlwSNd2Ywc2c5q5l
         akMO+ecrTPAFiMgQ9q6w4i2uD/YDpl2JpuSANrE2BNy27MyW4FpLzQ5+/S0aBew1kgye
         sk9+EiA0z7djecFmRnseh9dHGWw2zhyZfsAfppuUVpINzhJcBXHquo2tUgaXrBWe0MKI
         Xe0+UMDmZukKCzXL2f7zCmvZ/Rlo196d3Tt6agOarLoAmZ4umg2iVqTGuCypgxg92NgT
         CCNjqpgGD4VhD/PavOXkLrNVEX3+R6O1rRvdWZaRC+C2Iy3d+JYdt6xNMldLwkrCD2Xu
         Ai5w==
X-Gm-Message-State: AOJu0YyIHGQMhX32sUslmimi41Vav9820EtFd3q8YMNGpVzOFvK/NT6g
	RsOz9ivgssFDODyFKLdhHa39tAGMXumaIEMpgzTm54YTKysh4qqqBBKxoUr5WL8b8J8=
X-Gm-Gg: ASbGncvFXWOavP9Ha/C3D2DF1B1Be+mKFE0DbsY2/xQ3HQh8LLGeKAaRFe/IiYSgJyf
	ohn54Xy8fFSpDhATRtg3oBq/N7HtOIjmEQDpKf0I9J/xleq8fKtW7n8Nn6us8CmivydRkBrvcBT
	P3q52YyctjfIv8WxQgYxq6+zpoOD4jhTK+d+EsinaAz//EO2pAhcrmXW4ScTodn+86sS7YggI4N
	I6L+lvK6R997TF1Igq0h+4ltvn9mLMBxU00ubzpCTHq2OV/0+ql/ag4xkXI1J9tMxc8eMIWKaoG
	CG+0nEBwUAcq2vJoGEvaVBc0+YkEZF/KwjIFmLlO/wqCRmurDa7oeG1KhzyIpoFu12suUGjnw+b
	0I2fPvLNwVpOzMbIaB8HnQYjP5bIvD+cb3ZuG4MWcIllO0d2poYLLj8PWZFp3iHslOZqhHqW6kG
	odamE=
X-Google-Smtp-Source: AGHT+IHkXRt1bvA2nq78V9v3smCUF/mdE6nd/jsrFec9VaW89MGSq10bqEG5Bj4znCDYslvVrucVQw==
X-Received: by 2002:a05:6402:254b:b0:634:9121:7a2d with SMTP id 4fb4d7f45d1cf-63c1f6e5309mr17096839a12.26.1761042276183;
        Tue, 21 Oct 2025 03:24:36 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945efebsm8971783a12.32.2025.10.21.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:24:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  John Fastabend <john.fastabend@gmail.com>,  Eric Dumazet
 <edumazet@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,  "David
 S. Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
  Simon Horman <horms@kernel.org>,  Matthieu Baerts <matttbe@kernel.org>,
  Mat Martineau <martineau@kernel.org>,  Geliang Tang <geliang@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Florian Westphal <fw@strlen.de>,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net,mptcp: fix incorrect IPv4/IPv6 fallback
 detection with BPF Sockmap
In-Reply-To: <20251020060503.325369-2-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Mon, 20 Oct 2025 14:04:46 +0800")
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
	<20251020060503.325369-2-jiayuan.chen@linux.dev>
Date: Tue, 21 Oct 2025 12:24:34 +0200
Message-ID: <87h5vswo0t.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20, 2025 at 02:04 PM +08, Jiayuan Chen wrote:
> When the server has MPTCP enabled but receives a non-MP-capable request
> from a client, it calls mptcp_fallback_tcp_ops().
>
> Since non-MPTCP connections are allowed to use sockmap, which replaces
> sk->sk_prot, using sk->sk_prot to determine the IP version in
> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
> incorrect ops to sk->sk_socket->ops.
>
> Additionally, when BPF Sockmap modifies the protocol handlers, the
> original WARN_ON_ONCE(sk->sk_prot != &tcp_prot) check would falsely
> trigger warnings.
>
> Fix this by using the more stable sk_family to distinguish between IPv4
> and IPv6 connections, ensuring correct fallback protocol operations are
> selected even when BPF Sockmap has modified the socket protocol handlers.
>
> Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/mptcp/protocol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0292162a14ee..c2d1513615ae 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -61,11 +61,14 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
>  
>  static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
>  {
> +	/* When BPF Sockmap is used, it replaces sk->sk_prot.
> +	 * Using sk_family is a reliable way to determine the IP version.
> +	 */
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	if (sk->sk_prot == &tcpv6_prot)
> +	if (sk->sk_family == AF_INET6)
>  		return &inet6_stream_ops;
>  #endif
> -	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
> +	WARN_ON_ONCE(sk->sk_family != AF_INET);
>  	return &inet_stream_ops;
>  }

Should probably be a READ_ONCE(sk->sk_family) based on what I see in
IPV6_ADDRFORM:

https://elixir.bootlin.com/linux/v6.18-rc1/source/net/ipv6/ipv6_sockglue.c#L607

Nit: It's BPF sockmap, cpumap, etc. We don't treat it as a proper noun.

Other than that:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
