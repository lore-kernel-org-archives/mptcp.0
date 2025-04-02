Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000991F4C8D;
	Wed,  2 Apr 2025 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633493; cv=none; b=bWUfyHyeZq9xjTB8sHVpCPOmbYjRaTKwJXM5qfVHWTrXlCWaO8mDATmZS6CtLU7v8P1F4QLd6ufc53eBbZGWRY7iROLXBk3NIXt0pCjLSDSq0Vh76dC8rZW8dK0YLFAl1b9PYKyOrpC+/CU3ijs0qkfVxQcj5Z4L+CGPE8nopKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633493; c=relaxed/simple;
	bh=QyMAccHArRFUEMA0ZybJ2ZRJgcMsQGUttmrvj+2dU/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuMUelS0RMuWK9LR0xYPyLrFrkOvHBMAkz85Xp+bchVQCMQSCkv9aLqZkzV5NCmoyxL2cWs90nzIiLIcQTWHXoxHqDHBl0H2PeJ25jcU2Dqon3nhbsCAfgIgcyVqdrQSSzksdtFp5ZRKgFjrwD+8QUBbGYwlQA19tAOM1Vsb7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOo0exzn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOo0exzn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso1221255e9.3;
        Wed, 02 Apr 2025 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743633489; x=1744238289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1diHKPEGc7Id8XYuf2IxnytcV75OMWkcSNy9CRfawY=;
        b=WOo0exznnXeqj+sOGhass6iCZK/STLIWc4xdoBFc+8ID2bXTTI9dOqicjmN/ZIvKeF
         T6UhtgmahTVGa0OpctfTY+BWka8Zz0rd1F9G265wRrVy4ZPc5ncJGQurmcH4qSCCWC6P
         qM0dpO7BzkyBjXYa+SBDpVAd3Gq1Nwabsr3sFfCTLdvmKpvwEHqAR1LYFGkbr+xF/tL2
         7ay6eKRP2rHT2HpOGcvwg6dYva2Kr2++FISVeYZzhl2yqo513dHiwM1+p7i/gfkg7ykC
         ZaiPihR4GDmnTaxm0gaveLAIvXrBlwpA9H9g5v2eYZKMk2mD3Yr3veFXSFB5FZBYzD3V
         IMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743633489; x=1744238289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1diHKPEGc7Id8XYuf2IxnytcV75OMWkcSNy9CRfawY=;
        b=VYYPE8qlCm1m4uUgWWHtQBCPr9x1aZAazioiKyHqdZHXesIfq8OHnWT+N3JJu18Q69
         44kHmHv7erQyG8gtYdRtq3Abd4BsAwVxR7v5ixMj9NRWrth2OYN+ibScQlw3iDc3SWcv
         wk8pdyJOcXLXHzkTnbLE43Q8wpDtmgJYfmoYfx4pTTtyMFr2efT685F5OQLnzIwrutRB
         /iL7i7nmFkQOxshZSY9ErE6tsN5HPlroA8hoyNNtd9aVrFDTFJJpnOUmQ4xbX4leoEa2
         F/3JY5z+qXXIaGXhk81yQuS50BlF+8/k2ftHRNAs3uEiHnIK6wmjBkKNOVNi5FQFTI5m
         a5hg==
X-Forwarded-Encrypted: i=1; AJvYcCUoJUoOh6J0dAyKDJHOWW+4zrHybpI+MhXjZloBM1CVRG/ohFDVY4e/0cx2I/rF3LXpI7kRizu33ml2v4ld5oY=@lists.linux.dev, AJvYcCWFtizP2B1ZPTocrReOND3VhgABlFRsEyNggoQ4p5JEsychTSUWY0jVlT095Q/oaHzyfRSVBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YygDv1cNwcLCybkq2aNeuVbcD7IbA12Ic9A/6qyO4jdi8KF1PbP
	MAoqfj2Ecfn90h28KFFCxo3nT3JHXcj7kftgohpM+wTxudLA7d/l
X-Gm-Gg: ASbGncs9G2AhveNQkL+EKMz24x/6fvd9jE7gjAdIx33X7T11izCy8yiYltetpu8ohGp
	8gy1WFNu1eqrSQHdSEBbk8fC1bSKU6J3QbCNNMGeWhnlhFo/atb0nEbPvl5EaCxK8PF1QdsVdGu
	7Io8PAs8nKVfS0gsDHNupLidT2V46js8tSprLXqJEQI9cjmMLLSCf7QWM6LsWtUfCULA0is11oh
	bIeE+ud3JllFJ3L27PhND50EFGp5ig1qw/v9mYb7P3mTxBYj+giIFYYWu43JWGjjSKUa39SzkoE
	QA5DcPWwa2ELPHrnAEajs5+gAMJtyodramLJwPEQWyrJjfyE1EsRHPgVTJxGnwcv48GlVRROL60
	uYausx5U=
X-Google-Smtp-Source: AGHT+IGixqzhC2Qwqifdf8ByyftQ6fOugkJkfimMCdWUSausF3MeJcw4pdlkoqCsjupr2prYcZ0FYA==
X-Received: by 2002:a05:600c:6d45:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43eb63d417dmr27754705e9.19.1743633488458;
        Wed, 02 Apr 2025 15:38:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020da17sm69168f8f.64.2025.04.02.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 15:38:07 -0700 (PDT)
Date: Wed, 2 Apr 2025 23:38:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stefan Metzmacher <metze@samba.org>, Breno Leitao <leitao@debian.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe
 <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, Karsten Keil
 <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de
 Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, Neal Cardwell <ncardwell@google.com>, Joerg Reuter
 <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, Oleksij
 Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Alexandra Winter
 <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, James
 Chapman <jchapman@katalix.com>, Jeremy Kerr <jk@codeconstruct.com.au>, Matt
 Johnston <matt@codeconstruct.com.au>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Remi Denis-Courmont
 <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>,
 David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan
 Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Tony
 Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Jon Maloy
 <jmaloy@redhat.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
 <jonathan.lemon@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org,
 linux-s390@vger.kernel.org, mptcp@lists.linux.dev,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net,
 virtualization@lists.linux.dev, linux-x25@vger.kernel.org,
 bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
 io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via
 optlen_t to proto[_ops].getsockopt()
Message-ID: <20250402233805.464ed70e@pumpkin>
In-Reply-To: <Z-2qX_N2-jpMYSIy@mini-arch>
References: <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org>
	<ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
	<Z+wH1oYOr1dlKeyN@gmail.com>
	<Z-wKI1rQGSgrsjbl@mini-arch>
	<0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
	<Z-xi7TH83upf-E3q@mini-arch>
	<4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
	<20250402132906.0ceb8985@pumpkin>
	<Z-1Hgv4ImjWOW8X2@mini-arch>
	<20250402214638.0b5eed55@pumpkin>
	<Z-2qX_N2-jpMYSIy@mini-arch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2025 14:21:35 -0700
Stanislav Fomichev <stfomichev@gmail.com> wrote:

> On 04/02, David Laight wrote:
> > On Wed, 2 Apr 2025 07:19:46 -0700
> > Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >  =20
> > > On 04/02, David Laight wrote: =20
> > > > On Wed, 2 Apr 2025 00:53:58 +0200
> > > > Stefan Metzmacher <metze@samba.org> wrote:
> > > >    =20
> > > > > Am 02.04.25 um 00:04 schrieb Stanislav Fomichev:   =20
> > > > > > On 04/01, Stefan Metzmacher wrote:     =20
> > > > > >> Am 01.04.25 um 17:45 schrieb Stanislav Fomichev:     =20
> > > > > >>> On 04/01, Breno Leitao wrote:     =20
> > > > > >>>> On Tue, Apr 01, 2025 at 03:48:58PM +0200, Stefan Metzmacher =
wrote:     =20
> > > > > >>>>> Am 01.04.25 um 15:37 schrieb Stefan Metzmacher:     =20
> > > > > >>>>>> Am 01.04.25 um 10:19 schrieb Stefan Metzmacher:     =20
> > > > > >>>>>>> Am 31.03.25 um 23:04 schrieb Stanislav Fomichev:     =20
> > > > > >>>>>>>> On 03/31, Stefan Metzmacher wrote:     =20
> > > > > >>>>>>>>> The motivation for this is to remove the SOL_SOCKET lim=
itation
> > > > > >>>>>>>>> from io_uring_cmd_getsockopt().
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> The reason for this limitation is that io_uring_cmd_get=
sockopt()
> > > > > >>>>>>>>> passes a kernel pointer as optlen to do_sock_getsockopt=
()
> > > > > >>>>>>>>> and can't reach the ops->getsockopt() path.
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> The first idea would be to change the optval and optlen=
 arguments
> > > > > >>>>>>>>> to the protocol specific hooks also to sockptr_t, as th=
at
> > > > > >>>>>>>>> is already used for setsockopt() and also by do_sock_ge=
tsockopt()
> > > > > >>>>>>>>> sk_getsockopt() and BPF_CGROUP_RUN_PROG_GETSOCKOPT().
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> But as Linus don't like 'sockptr_t' I used a different =
approach.
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> @Linus, would that optlen_t approach fit better for you=
?     =20
> > > > > >>>>>>>>
> > > > > >>>>>>>> [..]
> > > > > >>>>>>>>     =20
> > > > > >>>>>>>>> Instead of passing the optlen as user or kernel pointer,
> > > > > >>>>>>>>> we only ever pass a kernel pointer and do the
> > > > > >>>>>>>>> translation from/to userspace in do_sock_getsockopt(). =
    =20
> > > > > >>>>>>>>
> > > > > >>>>>>>> At this point why not just fully embrace iov_iter? You h=
ave the size
> > > > > >>>>>>>> now + the user (or kernel) pointer. Might as well do
> > > > > >>>>>>>> s/sockptr_t/iov_iter/ conversion?     =20
> > > > > >>>>>>>
> > > > > >>>>>>> I think that would only be possible if we introduce
> > > > > >>>>>>> proto[_ops].getsockopt_iter() and then convert the implem=
entations
> > > > > >>>>>>> step by step. Doing it all in one go has a lot of potenti=
al to break
> > > > > >>>>>>> the uapi. I could try to convert things like socket, ip a=
nd tcp myself, but
> > > > > >>>>>>> the rest needs to be converted by the maintainer of the s=
pecific protocol,
> > > > > >>>>>>> as it needs to be tested. As there are crazy things happe=
ning in the existing
> > > > > >>>>>>> implementations, e.g. some getsockopt() implementations u=
se optval as in and out
> > > > > >>>>>>> buffer.
> > > > > >>>>>>>
> > > > > >>>>>>> I first tried to convert both optval and optlen of getsoc=
kopt to sockptr_t,
> > > > > >>>>>>> and that showed that touching the optval part starts to g=
et complex very soon,
> > > > > >>>>>>> see https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dco=
mmitdiff;h=3D141912166473bf8843ec6ace76dc9c6945adafd1
> > > > > >>>>>>> (note it didn't converted everything, I gave up after hit=
ting
> > > > > >>>>>>> sctp_getsockopt_peer_addrs and sctp_getsockopt_local_addr=
s.
> > > > > >>>>>>> sctp_getsockopt_context, sctp_getsockopt_maxseg, sctp_get=
sockopt_associnfo and maybe
> > > > > >>>>>>> more are the ones also doing both copy_from_user and copy=
_to_user on optval)
> > > > > >>>>>>>
> > > > > >>>>>>> I come also across one implementation that returned -ERAN=
GE because *optlen was
> > > > > >>>>>>> too short and put the required length into *optlen, which=
 means the returned
> > > > > >>>>>>> *optlen is larger than the optval buffer given from users=
pace.
> > > > > >>>>>>>
> > > > > >>>>>>> Because of all these strange things I tried to do a minim=
al change
> > > > > >>>>>>> in order to get rid of the io_uring limitation and only c=
onverted
> > > > > >>>>>>> optlen and leave optval as is.
> > > > > >>>>>>>
> > > > > >>>>>>> In order to have a patchset that has a low risk to cause =
regressions.
> > > > > >>>>>>>
> > > > > >>>>>>> But as alternative introducing a prototype like this:
> > > > > >>>>>>>
> > > > > >>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*=
getsockopt_iter)(struct socket *sock, int level, int optname,
> > > > > >>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iov_iter *=
optval_iter);
> > > > > >>>>>>>
> > > > > >>>>>>> That returns a non-negative value which can be placed int=
o *optlen
> > > > > >>>>>>> or negative value as error and *optlen will not be change=
d on error.
> > > > > >>>>>>> optval_iter will get direction ITER_DEST, so it can only =
be written to.
> > > > > >>>>>>>
> > > > > >>>>>>> Implementations could then opt in for the new interface a=
nd
> > > > > >>>>>>> allow do_sock_getsockopt() work also for the io_uring cas=
e,
> > > > > >>>>>>> while all others would still get -EOPNOTSUPP.
> > > > > >>>>>>>
> > > > > >>>>>>> So what should be the way to go?     =20
> > > > > >>>>>>
> > > > > >>>>>> Ok, I've added the infrastructure for getsockopt_iter, see=
 below,
> > > > > >>>>>> but the first part I wanted to convert was
> > > > > >>>>>> tcp_ao_copy_mkts_to_user() and that also reads from usersp=
ace before
> > > > > >>>>>> writing.
> > > > > >>>>>>
> > > > > >>>>>> So we could go with the optlen_t approach, or we need
> > > > > >>>>>> logic for ITER_BOTH or pass two iov_iters one with ITER_SR=
C and one
> > > > > >>>>>> with ITER_DEST...
> > > > > >>>>>>
> > > > > >>>>>> So who wants to decide?     =20
> > > > > >>>>>
> > > > > >>>>> I just noticed that it's even possible in same cases
> > > > > >>>>> to pass in a short buffer to optval, but have a longer valu=
e in optlen,
> > > > > >>>>> hci_sock_getsockopt() with SOL_BLUETOOTH completely ignores=
 optlen.
> > > > > >>>>>
> > > > > >>>>> This makes it really hard to believe that trying to use iov=
_iter for this
> > > > > >>>>> is a good idea :-(     =20
> > > > > >>>>
> > > > > >>>> That was my finding as well a while ago, when I was planning=
 to get the
> > > > > >>>> __user pointers converted to iov_iter. There are some weird =
ways of
> > > > > >>>> using optlen and optval, which makes them non-trivial to cov=
ert to
> > > > > >>>> iov_iter.     =20
> > > > > >>>
> > > > > >>> Can we ignore all non-ip/tcp/udp cases for now? This should c=
over +90%
> > > > > >>> of useful socket opts. See if there are any obvious problems =
with them
> > > > > >>> and if not, try converting. The rest we can cover separately =
when/if
> > > > > >>> needed.     =20
> > > > > >>
> > > > > >> That's what I tried, but it fails with
> > > > > >> tcp_getsockopt ->
> > > > > >>     do_tcp_getsockopt ->
> > > > > >>       tcp_ao_get_mkts ->
> > > > > >>          tcp_ao_copy_mkts_to_user ->
> > > > > >>             copy_struct_from_sockptr
> > > > > >>       tcp_ao_get_sock_info ->
> > > > > >>          copy_struct_from_sockptr
> > > > > >>
> > > > > >> That's not possible with a ITER_DEST iov_iter.
> > > > > >>
> > > > > >> metze     =20
> > > > > >=20
> > > > > > Can we create two iterators over the same memory? One for ITER_=
SOURCE and
> > > > > > another for ITER_DEST. And then make getsockopt_iter accept opt=
val_in and
> > > > > > optval_out. We can also use optval_out position (iov_offset) as=
 optlen output
> > > > > > value. Don't see why it won't work, but I agree that's gonna be=
 a messy
> > > > > > conversion so let's see if someone else has better suggestions.=
     =20
> > > > >=20
> > > > > Yes, that might work, but it would be good to get some feedback
> > > > > if this would be the way to go:
> > > > >=20
> > > > >            int (*getsockopt_iter)(struct socket *sock,
> > > > > 				 int level, int optname,
> > > > > 				 struct iov_iter *optval_in,
> > > > > 				 struct iov_iter *optval_out);
> > > > >=20
> > > > > And *optlen =3D optval_out->iov_offset;
> > > > >=20
> > > > > Any objection or better ideas? Linus would that be what you had i=
n mind?   =20
> > > >=20
> > > > I'd worry about performance - yes I know 'iter' are used elsewhere =
but...
> > > > Also look at the SCTP code.   =20
> > >=20
> > > Performance usually does not matter for set/getsockopts, there
> > > are a few exceptions that I know (TCP_ZEROCOPY_RECEIVE) =20
> >=20
> > That might be the one that is really horrid and completely abuses
> > the 'length' parameter. =20
>=20
> It is reading and writing, yes, but it's not a huge problem. And it
> does enforce the optlen (to copy back the same amount of bytes). It's
> not that bad, it's just an example of where we need to be extra
> careful.
>=20
> > > and maybe recent
> > > devmem sockopts; we can special-case these if needed, or keep sockptr=
_t,
> > > idk. I'm skeptical we can convert everything though, that's why the
> > > suggestion to start with sk/ip/tcp/udp.
> > >  =20
> > > > How do you handle code that wants to return an updated length (ofte=
n longer
> > > > than the one provided) and an error code (eg ERRSIZE or similar).
> > > >
> > > > There is also a very strange use (I think it is a sockopt rather th=
an an ioctl)
> > > > where the buffer length the application provides is only that of th=
e header.
> > > > The actual buffer length is contained in the header.
> > > > The return length is the amount written into the full buffer.   =20
> > >=20
> > > Let's discuss these special cases as they come up? Worst case these
> > > places can always re-init iov_iter with a comment on why it is ok.
> > > But I do agree in general that there are a few places that do wild
> > > stuff. =20
> >=20
> > The problem is that the generic code has to deal with all the 'wild stu=
ff'. =20
>=20
> getsockopt_iter will have optval_in for the minority of socket options
> (like TCP_ZEROCOPY_RECEIVE) that want to read user's value as well
> as optval_out. The latter is what the majority of socket options
> will use to write their value. That doesn't seem too complicated to
> handle?
>=20
> > It is also common to do non-sequential accesses - so iov_iter doesn't m=
atch
> > at all. =20
>=20
> I disagree that it's 'common'. Searching for copy_from_sockptr_offset
> returns a few cases and they are mostly using read-with-offset because
> there is no sequential read (iterator) semantics with sockptr_t.
>=20
> > There also isn't a requirement for scatter-gather.
> >=20
> > For 'normal' getsockopt (and setsockopt) with short lengths it actually=
 makes
> > sense for the syscall wrapper to do the user copies.
> > But it would need to pass the user ptr+len as well as the kernel ptr+len
> > to give the required flexibilty.
> > Then you have to work out whether the final copy to user is needed or n=
ot.
> > (not that hard, but it all adds complication). =20
>=20
> Not sure I understand what's the problem. The user vs kernel part will
> be abstracted by iov_iter. The callers will have to write the optlen
> back. And there are two call sites we care about: io_uring and regular
> system call. What's your suggestion? Maybe I'm missing something. Do you
> prefer get_optlen/put_optlen?

I think the final aim should be to pass the user supplied length to the
per-protocol code and have it return the length/error to be passed back to =
the
user.

But in a lot of cases the syscall wrapper can do the buffer copies (as well
as the length copies).
That would be restricted to short length (on stack).
So code that needed a long buffer (like some of the sctp options)
would need to directly access the user buffer (or a long buffer provided
by an in-kernel user).

But you'll find code that reads/writes well beyond the apparent size of
the user buffer.
(And not just code that accesses 4 bytes without checking the length).

	David



