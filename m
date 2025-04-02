Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D9219DF81;
	Wed,  2 Apr 2025 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743626805; cv=none; b=TAYSNUDW8+qvnoG9T4dJ/CHhViGuweNohJlPUolYMABpMBTEjiiRBS7dHB1WZ1zlu0jUSAmP8mFQ6ei49QJDLN7UMFwAzV5bI1fzmfWJ4ZEvbuuknhEV3mFoJNx215vhrrRIzBrOjEVk/T7IG91o5L+TD7DWPF8nYoq6nshYLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743626805; c=relaxed/simple;
	bh=PKGTgi9QWnge9UnME9l0A0i0pYjaHTX2Zev3svNmQjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBx22HTpI6dCjmTTD12/k18dh8HBOye0FNCpZcww4SOQz7n4mTkrqnZIxarniihNRmn5z/yz6nflH5vuDluuuvtqn264reGFxqX0H80PFY45x/0F44riPucaOu/+Q3q2SJLE3HzB8uMDSvIUg2VQLO+NRwBqqWhVKQSNlm7PHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR6iRcft; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR6iRcft"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso159194f8f.2;
        Wed, 02 Apr 2025 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743626801; x=1744231601; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QB6tB3QSmBxZpkdKe0uri2nAQPKUcYpNq9Fg3nhGjCE=;
        b=nR6iRcft3S5QALyDU8m6WtTlOCkNnebgqavBn4wULKqmKoz4Xd2YDO4qGqGJ6tL1lD
         tqGJ65Sf3d8Pq4UhgzTDPl3iFqrQRfpM5RGpYlcncjfqelbtsOMsSNoKamsWJMVLCPzW
         kb+B9P1a0fb4RCH3cCASRvTN7W+QPfh9Dm117NwiRXd/Pw0i5Y5WELKaskP1EyUaOHrU
         2XvVR5gC9ztDC6CS/4ybLASp7vDJYiYKlZzZM0/XTcfEVg5VaieaThIQmnGxJb1jbyfv
         Nsb9llEZr9YtAjCjGuT8UgqkY+U/u3BpfqjMSL2f0S+7Z1Dpv3CIeSm4sgAaFoJzknhE
         M39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743626801; x=1744231601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB6tB3QSmBxZpkdKe0uri2nAQPKUcYpNq9Fg3nhGjCE=;
        b=qgIsQPHb28lRjHceBpREpZVM2aWqDaZltyOeGRCoszpEg/lDbpYevWEmx1OW2iWBTe
         KBXwBLPjOvsmRDJ/52zxItzwY+KcWvxXdIZXyvjGTUsRaJjqKo7vLRpBk0qAXEX5Rn4b
         NSZxOeYPalt9OEc6c6Nq5mwKo32x9KADby+wMHsWyHoWMxLfHTqMY+TIJ5E9p4YmQt3J
         Rja6Gkj/ifebyGCaorGH7pL/hM6edYWLk+LLQOAvEbdVjngJP6qoGO7s9ZTNmQMPNtbR
         XuxDZy4TxHczuv/2lOv7J3rqLP7Tre9e2W6L3B/ihKdmHbM4TV1SlLHQ1TZ8VO2JEJ1G
         /nZw==
X-Forwarded-Encrypted: i=1; AJvYcCUta0LEEZsOwnoGQ5V+rmAyZTQ8BRRosj27VsZrgTb4j9WC4H8ivmA4t9JOtOuhKNa+qM8zPQ==@lists.linux.dev, AJvYcCVx4ZEU6iKIG+Mib4fYZ12o+lwwvkk2Bq+AjVEGX1v64uZvO9EMrm8x3YP4TE0bmzQn1gCir8ufNk3hERWNH2E=@lists.linux.dev
X-Gm-Message-State: AOJu0YzO/9EijbOfR1gLWGYRzp7pl/8XQh344z8nYY6+67RRsL3PDuAi
	Epj85H/uCXvRqoVO/tnly1VAuLdrP5gt870dG2chS/e5d897kk4k
X-Gm-Gg: ASbGncvoHkXByZUatLNKeesXXY7Nnq3OV3CKFWM4SwSEEsxdFJZD0gDjudCyvnrWJw9
	BidTZz/hzg2R1oP5jHJwPdz0bvCmORhm41b1BCinZ0jNVLR04yrHyaPSmJFkhcUddqHizzOWdv9
	0hyKLJBjaDObFn68fR3YVSoHyv2lDQoQwYSjfattlXjh63LroCBoYm4TPUYvwJ/B5qIlDzOaI+L
	EenyF6gsuWsIwoqf/HC5LkIeO4V6ktYZyuHra1sRD/mGRa0gLEYFIEFVPZnFsxICCcgkxe6C3KK
	hcxxVQnW+dL3MyhiOuI+kvyyBgjpjhVgOB4tpu30g/eT/Y9kVCELJe7o+3O/CX2E0Oo8v1AK1UY
	dPSlQR/U=
X-Google-Smtp-Source: AGHT+IHcd/s47n4mhaLkzaRKd9KHI3oRCRbcz47LBrXEngi/54WIx6VVT2D8nfUOsk1IcA15HqF7/w==
X-Received: by 2002:a05:6000:4205:b0:39c:2690:fe0a with SMTP id ffacd0b85a97d-39c29737d37mr3787672f8f.10.1743626801159;
        Wed, 02 Apr 2025 13:46:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb6137148sm31336885e9.35.2025.04.02.13.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 13:46:40 -0700 (PDT)
Date: Wed, 2 Apr 2025 21:46:38 +0100
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
Message-ID: <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <Z-1Hgv4ImjWOW8X2@mini-arch>
References: <Z-sDc-0qyfPZz9lv@mini-arch>
	<39515c76-310d-41af-a8b4-a814841449e3@samba.org>
	<407c1a05-24a7-430b-958c-0ca78c467c07@samba.org>
	<ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
	<Z+wH1oYOr1dlKeyN@gmail.com>
	<Z-wKI1rQGSgrsjbl@mini-arch>
	<0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
	<Z-xi7TH83upf-E3q@mini-arch>
	<4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
	<20250402132906.0ceb8985@pumpkin>
	<Z-1Hgv4ImjWOW8X2@mini-arch>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2025 07:19:46 -0700
Stanislav Fomichev <stfomichev@gmail.com> wrote:

> On 04/02, David Laight wrote:
> > On Wed, 2 Apr 2025 00:53:58 +0200
> > Stefan Metzmacher <metze@samba.org> wrote:
> >  =20
> > > Am 02.04.25 um 00:04 schrieb Stanislav Fomichev: =20
> > > > On 04/01, Stefan Metzmacher wrote:   =20
> > > >> Am 01.04.25 um 17:45 schrieb Stanislav Fomichev:   =20
> > > >>> On 04/01, Breno Leitao wrote:   =20
> > > >>>> On Tue, Apr 01, 2025 at 03:48:58PM +0200, Stefan Metzmacher wrot=
e:   =20
> > > >>>>> Am 01.04.25 um 15:37 schrieb Stefan Metzmacher:   =20
> > > >>>>>> Am 01.04.25 um 10:19 schrieb Stefan Metzmacher:   =20
> > > >>>>>>> Am 31.03.25 um 23:04 schrieb Stanislav Fomichev:   =20
> > > >>>>>>>> On 03/31, Stefan Metzmacher wrote:   =20
> > > >>>>>>>>> The motivation for this is to remove the SOL_SOCKET limitat=
ion
> > > >>>>>>>>> from io_uring_cmd_getsockopt().
> > > >>>>>>>>>
> > > >>>>>>>>> The reason for this limitation is that io_uring_cmd_getsock=
opt()
> > > >>>>>>>>> passes a kernel pointer as optlen to do_sock_getsockopt()
> > > >>>>>>>>> and can't reach the ops->getsockopt() path.
> > > >>>>>>>>>
> > > >>>>>>>>> The first idea would be to change the optval and optlen arg=
uments
> > > >>>>>>>>> to the protocol specific hooks also to sockptr_t, as that
> > > >>>>>>>>> is already used for setsockopt() and also by do_sock_getsoc=
kopt()
> > > >>>>>>>>> sk_getsockopt() and BPF_CGROUP_RUN_PROG_GETSOCKOPT().
> > > >>>>>>>>>
> > > >>>>>>>>> But as Linus don't like 'sockptr_t' I used a different appr=
oach.
> > > >>>>>>>>>
> > > >>>>>>>>> @Linus, would that optlen_t approach fit better for you?   =
=20
> > > >>>>>>>>
> > > >>>>>>>> [..]
> > > >>>>>>>>   =20
> > > >>>>>>>>> Instead of passing the optlen as user or kernel pointer,
> > > >>>>>>>>> we only ever pass a kernel pointer and do the
> > > >>>>>>>>> translation from/to userspace in do_sock_getsockopt().   =20
> > > >>>>>>>>
> > > >>>>>>>> At this point why not just fully embrace iov_iter? You have =
the size
> > > >>>>>>>> now + the user (or kernel) pointer. Might as well do
> > > >>>>>>>> s/sockptr_t/iov_iter/ conversion?   =20
> > > >>>>>>>
> > > >>>>>>> I think that would only be possible if we introduce
> > > >>>>>>> proto[_ops].getsockopt_iter() and then convert the implementa=
tions
> > > >>>>>>> step by step. Doing it all in one go has a lot of potential t=
o break
> > > >>>>>>> the uapi. I could try to convert things like socket, ip and t=
cp myself, but
> > > >>>>>>> the rest needs to be converted by the maintainer of the speci=
fic protocol,
> > > >>>>>>> as it needs to be tested. As there are crazy things happening=
 in the existing
> > > >>>>>>> implementations, e.g. some getsockopt() implementations use o=
ptval as in and out
> > > >>>>>>> buffer.
> > > >>>>>>>
> > > >>>>>>> I first tried to convert both optval and optlen of getsockopt=
 to sockptr_t,
> > > >>>>>>> and that showed that touching the optval part starts to get c=
omplex very soon,
> > > >>>>>>> see https://git.samba.org/?p=3Dmetze/linux/wip.git;a=3Dcommit=
diff;h=3D141912166473bf8843ec6ace76dc9c6945adafd1
> > > >>>>>>> (note it didn't converted everything, I gave up after hitting
> > > >>>>>>> sctp_getsockopt_peer_addrs and sctp_getsockopt_local_addrs.
> > > >>>>>>> sctp_getsockopt_context, sctp_getsockopt_maxseg, sctp_getsock=
opt_associnfo and maybe
> > > >>>>>>> more are the ones also doing both copy_from_user and copy_to_=
user on optval)
> > > >>>>>>>
> > > >>>>>>> I come also across one implementation that returned -ERANGE b=
ecause *optlen was
> > > >>>>>>> too short and put the required length into *optlen, which mea=
ns the returned
> > > >>>>>>> *optlen is larger than the optval buffer given from userspace.
> > > >>>>>>>
> > > >>>>>>> Because of all these strange things I tried to do a minimal c=
hange
> > > >>>>>>> in order to get rid of the io_uring limitation and only conve=
rted
> > > >>>>>>> optlen and leave optval as is.
> > > >>>>>>>
> > > >>>>>>> In order to have a patchset that has a low risk to cause regr=
essions.
> > > >>>>>>>
> > > >>>>>>> But as alternative introducing a prototype like this:
> > > >>>>>>>
> > > >>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*gets=
ockopt_iter)(struct socket *sock, int level, int optname,
> > > >>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iov_iter *opt=
val_iter);
> > > >>>>>>>
> > > >>>>>>> That returns a non-negative value which can be placed into *o=
ptlen
> > > >>>>>>> or negative value as error and *optlen will not be changed on=
 error.
> > > >>>>>>> optval_iter will get direction ITER_DEST, so it can only be w=
ritten to.
> > > >>>>>>>
> > > >>>>>>> Implementations could then opt in for the new interface and
> > > >>>>>>> allow do_sock_getsockopt() work also for the io_uring case,
> > > >>>>>>> while all others would still get -EOPNOTSUPP.
> > > >>>>>>>
> > > >>>>>>> So what should be the way to go?   =20
> > > >>>>>>
> > > >>>>>> Ok, I've added the infrastructure for getsockopt_iter, see bel=
ow,
> > > >>>>>> but the first part I wanted to convert was
> > > >>>>>> tcp_ao_copy_mkts_to_user() and that also reads from userspace =
before
> > > >>>>>> writing.
> > > >>>>>>
> > > >>>>>> So we could go with the optlen_t approach, or we need
> > > >>>>>> logic for ITER_BOTH or pass two iov_iters one with ITER_SRC an=
d one
> > > >>>>>> with ITER_DEST...
> > > >>>>>>
> > > >>>>>> So who wants to decide?   =20
> > > >>>>>
> > > >>>>> I just noticed that it's even possible in same cases
> > > >>>>> to pass in a short buffer to optval, but have a longer value in=
 optlen,
> > > >>>>> hci_sock_getsockopt() with SOL_BLUETOOTH completely ignores opt=
len.
> > > >>>>>
> > > >>>>> This makes it really hard to believe that trying to use iov_ite=
r for this
> > > >>>>> is a good idea :-(   =20
> > > >>>>
> > > >>>> That was my finding as well a while ago, when I was planning to =
get the
> > > >>>> __user pointers converted to iov_iter. There are some weird ways=
 of
> > > >>>> using optlen and optval, which makes them non-trivial to covert =
to
> > > >>>> iov_iter.   =20
> > > >>>
> > > >>> Can we ignore all non-ip/tcp/udp cases for now? This should cover=
 +90%
> > > >>> of useful socket opts. See if there are any obvious problems with=
 them
> > > >>> and if not, try converting. The rest we can cover separately when=
/if
> > > >>> needed.   =20
> > > >>
> > > >> That's what I tried, but it fails with
> > > >> tcp_getsockopt ->
> > > >>     do_tcp_getsockopt ->
> > > >>       tcp_ao_get_mkts ->
> > > >>          tcp_ao_copy_mkts_to_user ->
> > > >>             copy_struct_from_sockptr
> > > >>       tcp_ao_get_sock_info ->
> > > >>          copy_struct_from_sockptr
> > > >>
> > > >> That's not possible with a ITER_DEST iov_iter.
> > > >>
> > > >> metze   =20
> > > >=20
> > > > Can we create two iterators over the same memory? One for ITER_SOUR=
CE and
> > > > another for ITER_DEST. And then make getsockopt_iter accept optval_=
in and
> > > > optval_out. We can also use optval_out position (iov_offset) as opt=
len output
> > > > value. Don't see why it won't work, but I agree that's gonna be a m=
essy
> > > > conversion so let's see if someone else has better suggestions.   =
=20
> > >=20
> > > Yes, that might work, but it would be good to get some feedback
> > > if this would be the way to go:
> > >=20
> > >            int (*getsockopt_iter)(struct socket *sock,
> > > 				 int level, int optname,
> > > 				 struct iov_iter *optval_in,
> > > 				 struct iov_iter *optval_out);
> > >=20
> > > And *optlen =3D optval_out->iov_offset;
> > >=20
> > > Any objection or better ideas? Linus would that be what you had in mi=
nd? =20
> >=20
> > I'd worry about performance - yes I know 'iter' are used elsewhere but.=
..
> > Also look at the SCTP code. =20
>=20
> Performance usually does not matter for set/getsockopts, there
> are a few exceptions that I know (TCP_ZEROCOPY_RECEIVE)

That might be the one that is really horrid and completely abuses
the 'length' parameter.

> and maybe recent
> devmem sockopts; we can special-case these if needed, or keep sockptr_t,
> idk. I'm skeptical we can convert everything though, that's why the
> suggestion to start with sk/ip/tcp/udp.
>=20
> > How do you handle code that wants to return an updated length (often lo=
nger
> > than the one provided) and an error code (eg ERRSIZE or similar).
> >
> > There is also a very strange use (I think it is a sockopt rather than a=
n ioctl)
> > where the buffer length the application provides is only that of the he=
ader.
> > The actual buffer length is contained in the header.
> > The return length is the amount written into the full buffer. =20
>=20
> Let's discuss these special cases as they come up? Worst case these
> places can always re-init iov_iter with a comment on why it is ok.
> But I do agree in general that there are a few places that do wild
> stuff.

The problem is that the generic code has to deal with all the 'wild stuff'.
It is also common to do non-sequential accesses - so iov_iter doesn't match
at all.
There also isn't a requirement for scatter-gather.

For 'normal' getsockopt (and setsockopt) with short lengths it actually mak=
es
sense for the syscall wrapper to do the user copies.
But it would need to pass the user ptr+len as well as the kernel ptr+len
to give the required flexibilty.
Then you have to work out whether the final copy to user is needed or not.
(not that hard, but it all adds complication).

	David
