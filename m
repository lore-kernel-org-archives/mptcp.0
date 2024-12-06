Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3B1C549F
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517336; cv=none; b=HKa9PrbOfsA7wckBQUerI3rpMAUSr7ZYl2D2HkPYeCucOJG1ZUBjSd2krOHBfIbgiQJcyu6RPhFWnTX3shktSJTxMyvfSPGp1kx8vT33RpF/ZXOUY37+21SMGiz6FTqzmOfkd8YzUAGE3iyaEIgnlYI9S0r+06eF2CSZx53l32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517336; c=relaxed/simple;
	bh=KfHWQu6liIdf7TzsYbc9sbR4p1miYi4VnYm5haG6c2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpEon6TM6Sm8/hPwUxNx6ydppQl3uocH5sG4DNS1EUqcrOh0Itw27kQE29hMKg38ccmEbuUQjccsw18AMrv0zkPXHLeRowIx1spi9Ay/zkJ3uek35FyfCkiRS/wHkz+6JFY2NkcdUr4+vuZWMqqiASvez5qJYXOVGinMaFqEI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHrn3Zmw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHrn3Zmw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so2089792a91.3
        for <mptcp@lists.linux.dev>; Fri, 06 Dec 2024 12:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733517334; x=1734122134; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WSYKgnoISSMoL6c1SM0OSo8i8y8ZqVOfOOSDtnT9Wo=;
        b=EHrn3ZmwCgJzwKH74eZwPo7QEHdCc1fBRrMRKk/cq9Okn/roAeSLwnYv48yioi/48a
         yTvTQT/HgobI3MXEZ9UjHb32gY49TtYUrZdgKEnyTEy7cHfHFqJdM5Q5AMU3gSwA4Pav
         JZrFR5YeN5jF6sezGrHxPRCb9yzRt1fEDOCMaTSzNoY67KT59B6zmbt68ncdYVbtIZ1q
         gNFYnDfIVOSByCeH7G5li1NbBxJW0zx8xXHxbHdeaQb0vJSuZmDgsWf45hTBLdOOhbKa
         hRQ78fj+Q/NFSxXrvr9h2m07mzbPSnsxVYF/h11YkeiDwaLWn83xBEptxbUz6JF91NLm
         7zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517334; x=1734122134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WSYKgnoISSMoL6c1SM0OSo8i8y8ZqVOfOOSDtnT9Wo=;
        b=sWFfnDZ7Nbx0jcoRpCLZQcIyeu80W2zvRIp4z6HIPJHWwbtiqG0dqbUn99QhWfzk1D
         JfDcceWD0r6iV3ytw8rjMX8asZu4Fqi+03kaNiv7z+RgygkCcZdsebujUatmUUOCZiUL
         VlSEZzYHhgFDt3w4DWTbUccjtA4hInr/l0uh/0PZeIgU+Q17YdLV1PGGVnS8PVCKzOmF
         EBt7D5xd4Hw0AtCmRVgoKwdlfk3+vhpmM7HLcSXHQr2pF0Kvejpm2RYdm6ExhqslKw8n
         y8+eUjAVICB6Yjjt1BMxnlACZt/exWwTnnYucMzMMH5WrVwz8ry8GbsTjezhjHsPapZf
         7Yjg==
X-Forwarded-Encrypted: i=1; AJvYcCUS/FCg2gmUSQ5Jy6e/bHm4DVVeqOPygsUHtq8nAaF8nOq/Ju8En4Nyv7c3GbUsMKh2ywaytw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKtFi+wvdaxHfz2pabruKqdyeCOuKOLjEn79+j1LYcLODBVFEG
	UXIdEx9D3eEdAncKHKB7ydQb9E1h8nx2HNEBCJv4K7NXPLfTQxx/IKL1afw2RkTyE++NXhuZ2eB
	K4ipC4m18le+AWnz2XdSk94U2OAA=
X-Gm-Gg: ASbGncv2YFpBfKcF7lElNblAk6yUbz0LDkIUJqbjblGSVWmHfwP68Y+ZHyquv3H/OGs
	BjNHsAIQtPMByY3Bdb4LUEOXb3/zpow==
X-Google-Smtp-Source: AGHT+IEpzaK/NG2+IvtIdZyl1H8wLBBipy2MsvnS1vHIIgei1Y3hj+929YdX4hnkWtIF7aUOoa4AmVt8HXwZErvXBiE=
X-Received: by 2002:a17:90b:524e:b0:2ea:853b:2761 with SMTP id
 98e67ed59e1d1-2ef6aaddd08mr5902936a91.37.1733517333959; Fri, 06 Dec 2024
 12:35:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241204171351.52b8bb36@kernel.org> <CANn89iL5_2iW5U_8H43g7vXi0Ky=fkwadvTtmT3fvBdbaJ1BAw@mail.gmail.com>
 <CAJwJo6amrAt+uBMWRvwBu=VdcTyDuEMtkAx0=_ittUj0KCa-zw@mail.gmail.com> <CANn89iJzwe+Wds=otY-iFL9C9eNFVqGi62q085AehnYa3sET7w@mail.gmail.com>
In-Reply-To: <CANn89iJzwe+Wds=otY-iFL9C9eNFVqGi62q085AehnYa3sET7w@mail.gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 6 Dec 2024 20:35:22 +0000
Message-ID: <CAJwJo6aeza8omfs+GbVz-KoGV-4vgZzBU1oa+PBTxe+W-YxtJw@mail.gmail.com>
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

On Fri, 6 Dec 2024 at 15:15, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Dec 6, 2024 at 3:49=E2=80=AFAM Dmitry Safonov <0x7f454c46@gmail.c=
om> wrote:
> >
 [..]
> > > @@ -585,8 +589,14 @@ int inet_diag_dump_one_icsk(struct inet_hashinfo=
 *hashinfo,
> > >
> > >         err =3D sk_diag_fill(sk, rep, cb, req, 0, net_admin);
> > >         if (err < 0) {
> > > -               WARN_ON(err =3D=3D -EMSGSIZE);
> > >                 nlmsg_free(rep);
> > > +               if (err =3D=3D -EMSGSIZE) {
> > > +                       attr_size <<=3D 1;
> > > +                       if (attr_size + NLMSG_HDRLEN <=3D
> > > SKB_WITH_OVERHEAD(32768)) {
> > > +                               cond_resched();
> > > +                               goto retry;
> > > +                       }
> > > +               }
> > >                 goto out;
> > >         }
> > >         err =3D nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb)=
.portid);
> >
> > To my personal taste on larger than 327 md5 keys scale, I'd prefer to
> > see "dump may be inconsistent, retry if you need consistency" than
> > -EMSGSIZE fail, yet userspace potentially may use the errno as a
> > "retry" signal.
> >
>
> I do not yet understand this point. I will let you send a patch for
> further discussion.

Let me explain my view. It's based on two points:
(a) TCP-MD5/AO-diag interfaces are mostly used for
debugging/investigating/monitoring by tools alike ss. Without a
side-synchronisation, they can't be used by BGP or other tools/tests
to make decisions as the socket is controlled by another process and
the resulting dump may be incomplete, inconsistent or outdated.
(b) The current default of optmem_max limit (128Kb) allows to allocate
on a socket 655 TCP-AO keys and even more TCP-MD5 keys. Some of
Arista's customers (I'd guess the same for other BGP users) have 1000
peers (for MD5 it's one key per peer on a listen socket, for AO might
be higher).

I think the situation that's being addressed here is a race and
potentially it's rare to hit (I have to run a reproducer in a loop to
hit it). That's why in my view a re-try jump is too big of a hammer.
And failing with -EMSGSIZE on 327+ keys scale sounds slighly worse
than just marking the resulting dump as inconsistent and letting the
user decide if he wants to re-run the dump or if the dump is "good
enough" to get a sense of the situation. I would even say "the dump is
inconsistent" has its value as a signal that the keys on a socket
change right now, which may be useful.

Regarding the patch, my attempt was in this thread:
https://lore.kernel.org/all/20241113-tcp-md5-diag-prep-v2-1-00a2a7feb1fa@gm=
ail.com/

However, I should note that I'm fine with either of the approaches
(userspace to retry on EMSGSIZE or to get an inconsistent dump and
decide what to do with that). I'm somewhat looking forward to
switching to problems (1)/(3)/(4) from the cover-letter and adding
TCP-AO-diag, rather than being stuck arguing about what's the best
solution for quite a rare race :-)

Thanks,
             Dmitry
