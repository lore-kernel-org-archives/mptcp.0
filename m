Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8E2222A5
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645320; cv=none; b=q8bPrnD/ILmpQYzKnv4u1697/a1SQcGlEC3oCjo+K26l4rdNoIgzjHBE+C9W3BVwpPf9JCN/bGSFsHGHGabhl1OFshIgR6crS8o8A4DKMMQnYqmF1dE9qW60jFCcw1egT3oo2xjVrL/hvU5FsdsAV99hByCLTrbWWGHaFkGmSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645320; c=relaxed/simple;
	bh=xPMrcZXlyzkOROzTylH2sE2WQhKnhPRp81sgczS0BDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7hD4gMnS1uZgLaabScxQAAKHPpSH8+waUqfLUCzbminpzw76BVMGZrb1JwbGWtIawxoxjOsuLwojVbhisYBKuezRN2Zhj/AsRmwuOuxNB83dp5kapiOAPPoUdOzyQwUr/6CxYzQ26NKayCRnnT+a7mJLARUSVrQAirtIgXurUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=no6ei9Lg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="no6ei9Lg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46c8474d8daso5911701cf.3
        for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 00:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740645317; x=1741250117; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbUNq4GyX64nqzEmvp+umfuZHI26ffw9v99H9Suo7JE=;
        b=no6ei9LglSQKH1eoX6fqyd7jTdCCcvorSi3VZF5RNzT/70fgzRHsh1BqajUy9jatBb
         DoB04HxPEMJjFhr8X4htYcL+67moHvIhnuq+jOdVTwb/jblKuJy0xox6mwioG4wsYVqF
         0wM5L2QGmjVG+j0DrlfarnZTlBHwkiCko8icbTvckeHUKBoXSBY3AZw9gd9LiXThFBk4
         0H5QuG5wKKdHjA+putQTid+9xt9QbXHPW1xrIMuzP9B138ywIUJHY45hpgiUx0yDF+w2
         wzS/xIjle4jXaoBttCbZduVCociYi7Itslh+u35KOkmIwwcZpSVr1uFdQbDVLgIJKhYo
         +rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645317; x=1741250117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbUNq4GyX64nqzEmvp+umfuZHI26ffw9v99H9Suo7JE=;
        b=G1cce34uIzUJns23YUSqbqEKWjCKrZyUSLtDFTpGThyH1VkGt5B3XM2Bw2FnHMm1RK
         jl0srS/+eJtNLGen7bz3EEkypPw0mmuqXkolFprpj1D/hEh3OgAllhVjqJoveeE63/Bx
         firUj9C1ShjVTznmUKIMrkdwerzOoV+46EGf5BklL7xN1utWBRcXg+nQEYryUlvBwtLQ
         EhxKyolaZx+9ZQJMzj3v5dx+C7mrBK5luq+GVM8q/mhQh59HurmqpNBq+0iatjbLOAyn
         xkrIFa+5lP2RFcAEBhxUrT45rAivwKCeyvWv0JF/UWF5kP9kn9vyx6AZO7xs1USwdV3X
         FVHg==
X-Forwarded-Encrypted: i=1; AJvYcCXSUvhR1m9NIwuv9bvtsgUJxKDX88z91xV+XEDyG8qd3Kq/NPKrvQnpAX4oykkAlvlKzCGfBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTf5FCSf5vg1sk1VsQL5QER/Bk1c1MkXww9mfYhMgWi3iIhXkl
	uufmhveml7y2l9K1cHzYUfvUL5kyp9Dug2YRz5X/1KHZHlmYgWvDYrws8DqQnyPZUO6JLoWDhrZ
	0htLbr+XLIgHqYMePzxTeUCRk1LJsjCFE9XzS
X-Gm-Gg: ASbGncvXAmchLoO1N3IxayptWD5bivsPgOFuy4jivZ1s2LZFaFWXoRXl2WLmYXThuXK
	7tU/B1qLwtLrCOzg9UVWGyDpZMVJ0qAspXy0ZemqOo+0YorI0pctZjPm4urPQpCcbp1zEjzwhAd
	vQgadHyKk=
X-Google-Smtp-Source: AGHT+IF7aj3xZqg1BXSkAfM9Yrb4ohI/2Ky9Ht430sL32q+fWf5c8humNsilGQHX1CYP+rTmJHV5RbiY8qCIFlua/4w=
X-Received: by 2002:ac8:598b:0:b0:472:95f:d25e with SMTP id
 d75a77b69052e-4722473cfb4mr342060211cf.19.1740645316870; Thu, 27 Feb 2025
 00:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1740643844.git.tanggeliang@kylinos.cn> <38054b456a54cc5c7628c81a42816a770f0bff27.1740643844.git.tanggeliang@kylinos.cn>
In-Reply-To: <38054b456a54cc5c7628c81a42816a770f0bff27.1740643844.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Feb 2025 09:35:05 +0100
X-Gm-Features: AQ5f1JryXKMVP6N9LHTCBYmNcUmx9qDszFAnKpx8VGAyOne3EBu3Vo70b-0zGuA
Message-ID: <CANn89i+ZLAPPKVCzAMrchJBvisiOsEZyVN-TqGUkEH8EFApbpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net/tcp_ao: use sock_kmemdup for tcp_ao_key
To: Geliang Tang <geliang@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:24=E2=80=AFAM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Instead of using sock_kmalloc() to allocate a tcp_ao_key "new_key" and
> then immediately duplicate the input "key" to it in tcp_ao_copy_key(),
> the newly added sock_kmemdup() helper can be used to simplify the code.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/ipv4/tcp_ao.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bbb8d5f0eae7..d21412d469cc 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -246,12 +246,11 @@ static struct tcp_ao_key *tcp_ao_copy_key(struct so=
ck *sk,
>  {
>         struct tcp_ao_key *new_key;
>
> -       new_key =3D sock_kmalloc(sk, tcp_ao_sizeof_key(key),
> +       new_key =3D sock_kmemdup(sk, key, tcp_ao_sizeof_key(key),
>                                GFP_ATOMIC);
>         if (!new_key)
>                 return NULL;
>
> -       *new_key =3D *key;

Note that this only copies 'sizeof(struct tcp_ao_key)' bytes, which is
smaller than tcp_ao_sizeof_key(key)
