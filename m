Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D529207DFD
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498113; cv=none; b=AK2QR/xxSIMfL84dhb0iiAJW9GA4rnXQac78isHAB7vbvtBHnjlgLjBmfzVyYHWs7SJ48dRACqbztKsGM7DXL+WvEn5Ox5TC0zvYEmQej/nxrnVzUsWqQwQkK14YAsSyoCN0J34dvRHZFu/jCMZo1V4fW+bZtOsDaXlJM9ALzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498113; c=relaxed/simple;
	bh=Rf6UKchEYwEj7kWnfy7/GJwdbAaaF5fK63RIngHucuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5sVsSNvDO6Gign4yhg1aqUVmNis9I25Gm52ZBrHvmW95vsvLAnc453i7qYGxS6/8IeEkO/mNl2SpVchb37qAzMRDW1svbGiJEfJTtAzfq+Cf+4AshIojwioGLp+tD+UgjQbpwEQxjC3+7hNKMoZnqgcxA3s4tvhbq5WIZG0Z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4pBF4iz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4pBF4iz"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e2121112eso2984711e87.3
        for <mptcp@lists.linux.dev>; Fri, 06 Dec 2024 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733498109; x=1734102909; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bi85J4Anbz4KnoI5R1OFbqEq2YSaUnMErItaEKHBxE=;
        b=L4pBF4iz9wB81AkEltIFUdlKp1cJXbZZdwfPvKpxVHAiA34BB9VmT0+Wjoy2xaRk1x
         iueXtnMf6MoX1drGmwYeml7lCRA2rvIP148bgL153QMv6QN3fHCS4JdILkTblGXuQQPz
         vqRm463Dy+rO94BeZjj12zrshuSBcIZwNfTY/6OkM4OsNejdd6gPik6h3D+OxQ2o8cvr
         Vds2HGRPeIP18M4R4SlrYcPLN7/3YRuSmPldAfbU4ASkCFyhJZLTO6JYM6bDw/rCC7Re
         vPjOHPLoSkHsKdcKdQ3B6YlbJLT9ux+oidOUJccbppleDtwzurmEoAe9QWDmBBK+zeeR
         aCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498109; x=1734102909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bi85J4Anbz4KnoI5R1OFbqEq2YSaUnMErItaEKHBxE=;
        b=Ac2X+j45mwIyMvcWpv37+Xt1F4hrNUL5NP18fer0wflGbZ/s+0h+Oe2QdvlwOEY2xr
         laLoNGzqya0xgcSYXLpRBIqhMzyv5tEzJ9orqu8eCiqxQ/FgvILp8AxPdH02nwhiAx1f
         +ppjJ2whYAQMI6uAeIODsucUmH8cCJKHZA9HZTiaJM3fJTCxdwv7Jwmg842qI76A6BuA
         Gi5h9ZZpbwrHgkdqxt6zQ1msw1+Z+NIOBQvJfWbVxEXYSFVbdecwOdlAyAMXUpEtIqgB
         56idlX/TrILXL0UfwGAEKnMXIgEiM4Wsc6fRkOueJTLmp4EkYolr2/EcXuvWynd0QSs2
         qd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8PTLaUhkupUtcJZAHfNGju/utuCFpp4NwbMDeDNjIxfbMEyOxWFo/lMj8zIovZbH4AXR+5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+XrlCuq7FHq1o31/Ia1hpT3uifoJ93tsLO3iWxHedzETm4izd
	or0c9MtKGLXb614n0OObhQVA456Lv5yScgr2HpFEh8v3RxfyK5hEpW6tUd3dCno5K1J8l3Gw2cL
	ViCFQmLYqb8bMWrjWlINj10zRkJELeFMhkxAH
X-Gm-Gg: ASbGnct2maQ7afrCqfUiWCJ7UxX95RkGm7DztwD1Ec8lAdIHZvqFMdSdx3BF6Ek3mHx
	FVbHq24oXxmup1Ly5XP/hwG9rYVxeg+w=
X-Google-Smtp-Source: AGHT+IE1cwLWlIj1GpiqN0fNBxkpgemnySZUfP6KDIPqY4kGmA+U/DT/8PsZJRBrjehxVuks6Jtd7XQt1GDre3GD9fE=
X-Received: by 2002:a05:6512:3b0b:b0:53d:e669:e7d4 with SMTP id
 2adb3069b0e04-53e2c2b8efemr2131796e87.16.1733498109407; Fri, 06 Dec 2024
 07:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241204171351.52b8bb36@kernel.org> <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
 <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com>
In-Reply-To: <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 16:14:58 +0100
Message-ID: <CANn89iJzwe+Wds=otY-iFL9C9eNFVqGi62q085AehnYa3sET7w@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Dmitry Safonov <0x7f454c46@gmail.com>
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

On Fri, Dec 6, 2024 at 3:49=E2=80=AFAM Dmitry Safonov <0x7f454c46@gmail.com=
> wrote:
>
> Hi Jakub, Eric,
>
> On Thu, 5 Dec 2024 at 09:09, Eric Dumazet <edumazet@google.com> wrote:
> > On Thu, Dec 5, 2024 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > Hi Eric!
> > >
> > > This was posted while you were away -- any thoughts or recommendation=
 on
> > > how to address the required nl message size changing? Or other proble=
ms
> > > pointed out by Dmitry? My suggestion in the subthread is to re-dump
> > > with a fixed, large buffer on EMSGSIZE, but that's not super clean..
> >
> > Hi Jakub
> >
> > inet_diag_dump_one_icsk() could retry, doubling the size until the
> > ~32768 byte limit is reached ?
> >
> > Also, we could make sure inet_sk_attr_size() returns at least
> > NLMSG_DEFAULT_SIZE, there is no
> > point trying to save memory for a single skb in inet_diag_dump_one_icsk=
().
>
> Starting from NLMSG_DEFAULT_SIZE sounds like a really sane idea! :-)

There is a consensus for this one, I will cook a patch with this part only.

>
> [..]
> > @@ -585,8 +589,14 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo *=
hashinfo,
> >
> >         err =3D sk_diag_fill(sk, rep, cb, req, 0, net_admin);
> >         if (err < 0) {
> > -               WARN_ON(err =3D=3D -EMSGSIZE);
> >                 nlmsg_free(rep);
> > +               if (err =3D=3D -EMSGSIZE) {
> > +                       attr_size <<=3D 1;
> > +                       if (attr_size + NLMSG_HDRLEN <=3D
> > SKB_WITH_OVERHEAD(32768)) {
> > +                               cond_resched();
> > +                               goto retry;
> > +                       }
> > +               }
> >                 goto out;
> >         }
> >         err =3D nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).p=
ortid);
>
> To my personal taste on larger than 327 md5 keys scale, I'd prefer to
> see "dump may be inconsistent, retry if you need consistency" than
> -EMSGSIZE fail, yet userspace potentially may use the errno as a
> "retry" signal.
>

I do not yet understand this point. I will let you send a patch for
further discussion.

Thanks.
