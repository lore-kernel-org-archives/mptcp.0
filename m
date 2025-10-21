Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302AAAD24
	for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043764; cv=none; b=CzXC9Jfpdr97WAC/bDkDxj+ub0gtueHpRijPlonKWHkZVKyzAGdIDk5LAy+RVy7JVsO/SCQfDnW8aR+altFNLx1yjEBKp6R/gTKF9tCjQsr8qZB+POjLD0zNOiOyWaXMmvS8n7GTOKNRbvzrnpYmnnS7nfn+CAGknlLFtKHbQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043764; c=relaxed/simple;
	bh=hrF0LCmElQ4WpX5W62bYMJ+jvZnpkYWbqiea2O+smAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qiiSduWKeLxwETxkDk0u2urek0CZql1fkw8zE72iEyM/f2qeoMayETkI2bd5qg5CLdUkZmynE8FVWWZvkhHhMRxNX6LWG/YnzLPDCgMDDEIimfp5ZhnxliqbTDDQnB1d77FAmimOgWDpn5C2BcYhk+TCczCL0U982KUpKgpvRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EEC4LWjB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EEC4LWjB"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4c89df6145so891778666b.3
        for <mptcp@lists.linux.dev>; Tue, 21 Oct 2025 03:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761043761; x=1761648561; darn=lists.linux.dev;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EOHmK2OfLfwzNiHBksUI9w2NZOUojlK5wP3wAwmdUc=;
        b=EEC4LWjBCMtgczEFOPL51kphGqMcOegmNlRzWvTzQy7RL5D2AzXQKeK7eSRU/PMnyG
         /n50ffgZ31E3Ey9m4AFmHo1H0zNx3ThjS4G/gHtddHLT1rPEbs05v2A7C1/ZXsFdvlo/
         9MHm0bICGhqXMbPMqvBlbC9lTeRwzPZdG8v7tTpRX2nkbDadGsFJttq3i6Z5kZJziqyA
         EWAdmYahkETVog4Khry3utuUWJacag9R74C9uayX0glRn8F7407HmsJGAd4l1LBOVi+e
         cplaObIWZTa7JKgBy9OUrAyGwikjDCxYaK9GG/RZ8GoTGnVe5zawt6KZ2THZfPaH2hzV
         Au4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043761; x=1761648561;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EOHmK2OfLfwzNiHBksUI9w2NZOUojlK5wP3wAwmdUc=;
        b=ssMOK+etXTKUAM2UdZz+8hxwxfrE0KU1HfyAhWdioCT07S7LYLjehiBstnmLCtooci
         cCRr7T+DtObBoTHyfsoflpIf0alNUhpqy2hbnVv0WIm6nAVH19bbYrEbpqmmiUer3aFD
         0zx8VYXU8I37AxfFp1kbKcSf2S9PKVVqXttdblQy/BhOAhKCzQ26m8lXlfTHGr/imNBG
         3zxi+n2ZCKjly7EOCK3f/IbmNjAFZkvgXJpF3NBL8WdM7FI5mAQ3KMA2yaUjUEq4w6gH
         WpA5UW94WzZKyf8oC4T0VfyT4JMIiKuoHkj4AQytUHx1OYHJ1MpOsOtOKzbqflH1AuEm
         lrcw==
X-Gm-Message-State: AOJu0YxqlASXNuCDuUZGz7J3DaXhBtUrVH7zIFjUogx4ZZCnlC9OWHDO
	3lzAByGEqLuG5rdIIrY/ABM7TRwnqh5/lYouAhgR4XqA4nF0Nmg0Hvq4aU7zKCunOMwfVfAju4D
	C5M/JZBY=
X-Gm-Gg: ASbGncs6voA2BNHT3SnhsniIw9EWrARSazj7TtionDjbOSTU0XCDOl0zgcZp1ODebTo
	l34H+VWaIIZKQJNnrYbJDVxbHiIwRqqJqhEYv4R2H8Mb2ps9Xk2LRLGHhw7JezG7zg53vMM4FBp
	JgzL4S0FmKXk9dTFe3PUZ5UiMNuijGa2V9oItEXVZrnJrHFnVtCZVmf8fmmx3aCv9NTo0ib+dNY
	MlFgHddX7yTZeIrx34lhouVxVPRYMPsot/sRBKCJN/BNFdts0++MZgiQ0vfzFJ/IuG1aEy7Orcj
	nrc0ZxJlTtHbM5d8x0QF5YyZXi/b7zZ0d2KVyk4zfmAKToVPZMYZ8S2zWUgSTTsxqILsgh/+oe7
	IGijpCYrlAI7iYVLUdXbrQlVXoYkbZlq5g6ZcLoHZxRx17WWvCD7jTMwWwBxYd9/qhQ/4oPd14G
	eQLFM=
X-Google-Smtp-Source: AGHT+IHy8op2SrI/lJue90xZTdUE8jYPVJKT9x3Xt5nh13yYcQucOr2Oqx/NtzVh356uT2+TUQAh8g==
X-Received: by 2002:a17:907:3f11:b0:b42:7c2:1f9f with SMTP id a640c23a62f3a-b6475706f53mr1757165566b.62.1761043761371;
        Tue, 21 Oct 2025 03:49:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036a3esm1068920266b.46.2025.10.21.03.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:49:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  Eric Dumazet <edumazet@google.com>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemb@google.com>,  John Fastabend <john.fastabend@gmail.com>,  "David
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
Subject: Re: [PATCH net v2 2/3] bpf,sockmap: disallow MPTCP sockets from
 sockmap updates
In-Reply-To: <20251020060503.325369-3-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Mon, 20 Oct 2025 14:04:47 +0800")
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
	<20251020060503.325369-3-jiayuan.chen@linux.dev>
Date: Tue, 21 Oct 2025 12:49:19 +0200
Message-ID: <87cy6gwmvk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20, 2025 at 02:04 PM +08, Jiayuan Chen wrote:
> MPTCP creates subflows for data transmission, and these sockets should not
> be added to sockmap because MPTCP sets specialized data_ready handlers
> that would be overridden by sockmap.
>
> Additionally, for the parent socket of MPTCP subflows (plain TCP socket),
> MPTCP sk requires specific protocol handling that conflicts with sockmap's
> operation(mptcp_prot).
>
> This patch adds proper checks to reject MPTCP subflows and their parent
> sockets from being added to sockmap, while preserving compatibility with
> reuseport functionality for listening MPTCP sockets.
>
> Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/core/sock_map.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 5947b38e4f8b..da21deb970b3 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -535,6 +535,15 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
>  
>  static bool sock_map_sk_is_suitable(const struct sock *sk)
>  {
> +	if ((sk_is_tcp(sk) && sk_is_mptcp(sk)) /* subflow */ ||
> +	    (sk->sk_protocol == IPPROTO_MPTCP && sk->sk_state != TCP_LISTEN)) {
> +		/* Disallow MPTCP subflows and their parent socket.
> +		 * However, a TCP_LISTEN MPTCP socket is permitted because
> +		 * sockmap can also serve for reuseport socket selection.
> +		 */
> +		pr_err_once("sockmap: MPTCP sockets are not supported\n");
> +		return false;
> +	}
>  	return !!sk->sk_prot->psock_update_sk_prot;
>  }

You're checking sk_state without sk_lock held. That doesn't seem right.
Take a look how we always call sock_map_sk_state_allowed() after
grabbing the lock.

Same might apply to sk_is_mptcp(). Please double check.
