Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCF1429E
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902310; cv=none; b=hfzeurfUytT9MDWTZJRWG6rQ7miM0Ei2hg8vDrvHfhraIgpHLTxYSbOYDy0qee9fg6XFoEzPm4wnNF2uwLCiHh1fMACXZmL50omkWi/A02EsYOiCa6jH8alDoLhGB331uTuD1yL0sandwwZxYIuE13KOXLTHVaNrYlptEosPObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902310; c=relaxed/simple;
	bh=LzJWnD345e/TSnWMXwsnCzIAp9EATcd2Az2CODBO2Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B83iSTvmiYbpGfrJm3nC1rniYSb7rOl4dFK/w9IcYpH+dvG547IH7X0ORsg/FZ+4Ng3exSBp6cl+Glvs4Q9AZWyeH/ldqJShaC8TR5exzMfSx7jl4/yYGbGF0nWQ6MNtYIvuoXXoXLNkhNiiPWdd+K33Bcn9MkkdOeyy+LtROb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IdRP0Ga4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IdRP0Ga4"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so15021a12.0
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 04:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709902307; x=1710507107; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wFxcRKzixSphhwxyAsaZYfo58Ol0VCtNiJzKLN7/S0=;
        b=IdRP0Ga4dIQJJFGZQraWW1bv5/SA4YrmbYXbhkDCokgf99empSkUm2OQV5HsNFTnoB
         aRzxdUWx7SdfVfSq51jcl6mdL+BX46l+MK40EE+TLLQKIgjiYa7y91bOEX7QeOEJjnNk
         llslM7NbagNxaDYxvqqyTKf7KI5a1MzHNxdbt9RLM4kb+KT8BR1lJ9ngUpTSFny2GZvC
         gUfHU5rUpapkuyiwkZ6mQH3JyPbaou6oX01txwe1uE4HuBRWVHOUYlnbWtNeTiYcxFsV
         0uoObNeMBfpUQyJb4WLaIS0V/KgGZipyMgrAbFn2kO7EG/1MdJnpna5EHO04p5hVzVSG
         8x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709902307; x=1710507107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wFxcRKzixSphhwxyAsaZYfo58Ol0VCtNiJzKLN7/S0=;
        b=rTlDXp/nm5TwipkupZlE2xehHQGAMZtM7QOuC4L3S3+ACZ2k6VXSD3A1WUqIEH6p76
         ILj8j7yAwotPV6PGqyGzxieUdgu67m0BQeHwNHjg6YQmz4+KLeAwdDjVKwy48aT9J8E5
         4DTYXvRKNZNC38mJwzIXovz1maghs3X4OKMsLa4J6/0Yw6bm6pI+FncpHTsgUP7jf67W
         Fgv4tvQi2eEO0MwbA4YKVqI3Ngljls1h/kTNnmUK7HKGyyE6/sVE6ZimmObJHITq1vOM
         HxXSL7WhKCKj16M67mWbGNJD3+ChSjKG5oo0UBNwo9Mtp7U7y8tdwLg/F3VT5Bf9t8ry
         swPA==
X-Forwarded-Encrypted: i=1; AJvYcCUobirDssNqYnwlDnKKhKwIWC4rlJAdtFbqG0o67tHjXrMyEvo3eCuVB4sH0sLkTSyhoPruJwz3orV8qlXZDzKi7te8gpI=
X-Gm-Message-State: AOJu0Yw14T2bbqUl2UHEi37gd5ivErnYyIYGZf3p/HbXeAuyJGrl80Jl
	qLuylgRGXOa4BBuoOirUPdhAQffne2jBjSd8WONY/rYfhd0ZglsmEY+Cyv82RErRjSOeVRA5bl6
	mRGw+s5nT8USY4i6QTM3giGE6BSs3FC7wlKn3
X-Google-Smtp-Source: AGHT+IEFIF41DVJKRfWSOGlQA5QraR0feuXtqNSe+bwfu8uemjBwZSGFloqujZg3mDGCaQoDzKpp08nVvDRu/6VHVe8=
X-Received: by 2002:a05:6402:349:b0:568:257a:482f with SMTP id
 r9-20020a056402034900b00568257a482fmr225008edw.3.1709902306583; Fri, 08 Mar
 2024 04:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240308112504.29099-1-kerneljasonxing@gmail.com> <20240308112504.29099-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240308112504.29099-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 13:51:35 +0100
Message-ID: <CANn89iLtRYt6U+q_VHb_3Vj2ydmnwsSon4uwPX3+yTJDgoDenQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: annotate a data-race around sysctl_tcp_wmem[0]
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When reading wmem[0], it could be changed concurrently without
> READ_ONCE() protection. So add one annotation here.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c5b83875411a..e3904c006e63 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -975,7 +975,7 @@ int tcp_wmem_schedule(struct sock *sk, int copy)
>          * Use whatever is left in sk->sk_forward_alloc and tcp_wmem[0]
>          * to guarantee some progress.
>          */
> -       left =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[0] - sk->sk_wmem_queu=
ed;
> +       left =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]) - sk->s=
k_wmem_queued;

SGTM, you could have split the long line...

Reviewed-by: Eric Dumazet <edumazet@google.com>
