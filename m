Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBB0189F20
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453400; cv=none; b=pULnlypQf2V/nGnjxRUvrEvW1Wj0aKb2ZgnDgYTAYDfJh/joWp0olSKsM5H3uOxO0RLLDvzqx5oh688n5TuoII2EbxDwNJPPjMocdjZlz2ey5t5OTRLJ0++uPKWfmO33w5kSEVdY6vICeBNUl9DI56HOfKdl/KykLe9MfHNSm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453400; c=relaxed/simple;
	bh=d1mlV6zQCgCyxHwYY1PXH9w0PynEoomgfBQSdBZwFno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKEBnZ2x75D5Swc5B40t1p7m0EbDemLUdminF8JlPYMOUd1Nhr6LSt1TeGLgxMJmkH+I1Dv7NijQxWzMyjWsS8k1ewIYedqPKEYm02WVYq8Skp31CPY/slAldl5dqub73RRDoQ6PaYuzTMnZhhFlCqNT7x8dx0LwnMn2c4DmN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUaJEZuh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUaJEZuh"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so1385724a91.3
        for <mptcp@lists.linux.dev>; Thu, 05 Dec 2024 18:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733453398; x=1734058198; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFcBusQAgop/cJ9zHlAC34d6C2cvFm40FRSAV1uCAPY=;
        b=GUaJEZuhPc+cCgs73TIw90PvMIDP7114Z78OsV2gog0EXmuEZM6f8kHlr82LgyBbQc
         3SfHzyodHPV6m88ibqpBgbBAo9rBjiwGhrO3XgKsd0lRuSptK1lGetIU0tehAQCO62+V
         uheGgAX5PaQRIkFviPjpY6S9sBabgzXTXu9wvlaJInvPHj9fyGQ0lwPzVcrhgcy2JZ+X
         P6zHzROFJ1TERTPNQbotafkyLpjlrNJz55HNloFelCJxAYEbL5sSkkHasynSIofIgvi0
         1C+OaC0LHryJx7a461NHt3Ooip7lXy2uGiYfAnc2V/+XY+mtq/aVGpWi6DD9O1hr8ME6
         t2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733453398; x=1734058198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFcBusQAgop/cJ9zHlAC34d6C2cvFm40FRSAV1uCAPY=;
        b=VtfiUqAaO+5EOrA9Rce30cGgjZBXsr1kINp7/AoElEufDyqz5eeLqkRoQyi32ONWc2
         FX2QNZj/Fxa0AvtN/BZF4knDYq3em0xystowj1bthQPAiLGIOwtQhcToelsDEs5ZxgY1
         8kyTxRFX7zM800dJmzTUasyLNnbNmiOvrf2dcXKx5NcUdm0X/Go2qAiumC8VI7BJBy2D
         df1nfGtd5p2ra94NpSAFjP1gn5MKMHsV4hvDfis0MiDSJAM3wu9cQNCCSxNcOPgA/0AU
         dlYCwknx200pWJNOaPvYcegyA0SMWBP5lO+52l0Cx+eXcwA5c0TvJgXQF1xHuHQUrK3P
         XhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWEzko53W+ukv6IcCLNfy3seJt/XRiGdORbu1SUK54FDkuvcd4ThTcrezRXod1DhlhD7w3l5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb8s8Qh3zR+i0qhT1JPVti3cXtJoVIcnPXNBKOCMHW5eglqj8n
	/k6LTf//rPq91SVKV0PwJeYtumH5/zwpuzwe1WRg1NhWgazQQ2yyF6MBkErF/meCenjLCgjvpe/
	chyLeOBFibTc/lhZLL5SZoAcDd+k=
X-Gm-Gg: ASbGnct7ZtJlrW9irJznL3gV5vosfgsbzxvy5QUw5mf6vXudX9Vpwz2w5VedrRbSxYS
	pZfLjgCeQCoRBmN0x8VvVarU31t3Z3g==
X-Google-Smtp-Source: AGHT+IEA11huRP+Trp19deRlrQWYZoOM5ceG9+1zVCv7r7Tsw6HHVVGPX/+z5mIMkkizPeSriAQ8V5bZRdiioL1KesA=
X-Received: by 2002:a17:90b:33c4:b0:2ee:863e:9fff with SMTP id
 98e67ed59e1d1-2ef69e15339mr2443280a91.10.1733453397711; Thu, 05 Dec 2024
 18:49:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241204171351.52b8bb36@kernel.org> <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
In-Reply-To: <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 6 Dec 2024 02:49:46 +0000
Message-ID: <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub, Eric,

On Thu, 5 Dec 2024 at 09:09, Eric Dumazet <edumazet@google.com> wrote:
> On Thu, Dec 5, 2024 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > Hi Eric!
> >
> > This was posted while you were away -- any thoughts or recommendation o=
n
> > how to address the required nl message size changing? Or other problems
> > pointed out by Dmitry? My suggestion in the subthread is to re-dump
> > with a fixed, large buffer on EMSGSIZE, but that's not super clean..
>
> Hi Jakub
>
> inet_diag_dump_one_icsk() could retry, doubling the size until the
> ~32768 byte limit is reached ?
>
> Also, we could make sure inet_sk_attr_size() returns at least
> NLMSG_DEFAULT_SIZE, there is no
> point trying to save memory for a single skb in inet_diag_dump_one_icsk()=
.

Starting from NLMSG_DEFAULT_SIZE sounds like a really sane idea! :-)

[..]
> @@ -585,8 +589,14 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *ha=
shinfo,
>
>         err =3D sk_diag_fill(sk, rep, cb, req, 0, net_admin);
>         if (err < 0) {
> -               WARN_ON(err =3D=3D -EMSGSIZE);
>                 nlmsg_free(rep);
> +               if (err =3D=3D -EMSGSIZE) {
> +                       attr_size <<=3D 1;
> +                       if (attr_size + NLMSG_HDRLEN <=3D
> SKB_WITH_OVERHEAD(32768)) {
> +                               cond_resched();
> +                               goto retry;
> +                       }
> +               }
>                 goto out;
>         }
>         err =3D nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).por=
tid);

To my personal taste on larger than 327 md5 keys scale, I'd prefer to
see "dump may be inconsistent, retry if you need consistency" than
-EMSGSIZE fail, yet userspace potentially may use the errno as a
"retry" signal.

Do you plan to re-send it as a proper patch? Or I can send it with my
next patches for TCP-MD5-diag issues (1), (3), (4) and TCP-AO-diag.

Thanks,
             Dmitry
