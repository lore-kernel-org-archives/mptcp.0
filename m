Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D5F19E73
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:06:38 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-456e4f4ea83so229080e0c.3
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030797; x=1687622797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTQjVZFJMl2htBgjAjUwo8aIlAxuNE/XuYEOm2kKnTQ=;
        b=XpMqAQAAxJalriEaDTX546Y/3brDNZIWDjllLOtGdZ7RkhNk0iDJMFGbcoiYE6ieYZ
         OKbMRGJKkXsz52ZJsnrkB0arczm7svC2EFp1RcvgEotx1Z93Q61OJx7DZVmaPGM3YQtp
         hxiBZNxEGAbXpapu8Do2eXZS1+Qh2dnBP4tKJE8QQOKRVlKKQ93DOh9ddqv9hgjuJ+0W
         pLqZkoCvJndyvUREwF3Bg4mERq9hUyGWH1H1bds5TPn7OWeEfufc6rkFFDv9WG/hfYdf
         N1TZBXzmAUeEuOkQfjB8LhsRul6QvLIQNRc1yH8cWz64lW9+3KXRyzs7lMsC2sHI7evQ
         2ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030797; x=1687622797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTQjVZFJMl2htBgjAjUwo8aIlAxuNE/XuYEOm2kKnTQ=;
        b=WTg0otoM/EWoFzRu8TrFdeVJrs9kkRScMyA9EmJbRZWDPXChnAfF0lFBbe3FioIpuq
         XaqLQIuH+Ay7MImDfnLGeTPWuOv9osvHpBil0eqKM51cEOlNfr01B967DApoTmtWKzyw
         StE2ga0chmMb+XiLZPo8qFdPsPzNmuNxdceFUWQwciG83DNbfVxSyoFQ6iS4KWqHc9sF
         XdGEhdtPH0BiJD+49LQ3TGAdkz4V9F4dt5y/o3edxJiIgm7HRURDmmEc+c2RlVIY5Afv
         cizC3mDZppX/37TVFPAj1dcDws9xthPbbjUZ5a14oFVBe20X6J79GqSHTGekLKLnbGla
         68rw==
X-Gm-Message-State: AC+VfDx8+9GIh8WzEt8kI24X3wDDtVxIVwgzcRUR3FWc22FA9JOxfImp
	oEFm9fxq57Y0Gu/lHxMnQwoJ0PPBGILKiAvgG7I=
X-Google-Smtp-Source: ACHHUZ53VhbedOtIoTjgfxe0fR2ZQYEQ+cMOtRhvGEegt7oEKztTJNywr/nJj5wpHjemDNWOECt7zc4J8aDNTRKxLs0=
X-Received: by 2002:a67:e30b:0:b0:439:5b03:5a2 with SMTP id
 j11-20020a67e30b000000b004395b0305a2mr3248739vsf.30.1685030797019; Thu, 25
 May 2023 09:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230525125503.400797-1-leitao@debian.org> <CAF=yD-LHQNkgPb-R==53-2auVxkP9r=xqrz2A8oe61vkoDdWjg@mail.gmail.com>
 <a1074987-c3ce-56cd-3005-beb5a3c55ef9@kernel.org>
In-Reply-To: <a1074987-c3ce-56cd-3005-beb5a3c55ef9@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 25 May 2023 12:06:00 -0400
Message-ID: <CAF=yD-LXcufhJBpkEcUuphFpR1TA4=QwUXw4sKFsSiEL_mwG4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
To: David Ahern <dsahern@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Remi Denis-Courmont <courmisch@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Mat Martineau <martineau@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, leit@fb.com, axboe@kernel.dk, asml.silence@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dccp@vger.kernel.org, 
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 11:34=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 5/25/23 9:05 AM, Willem de Bruijn wrote:
> >> +/* A wrapper around sock ioctls, which copies the data from userspace
> >> + * (depending on the protocol/ioctl), and copies back the result to u=
serspace.
> >> + * The main motivation for this function is to pass kernel memory to =
the
> >> + * protocol ioctl callbacks, instead of userspace memory.
> >> + */
> >> +int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
> >> +{
> >> +       int rc =3D 1;
> >> +
> >> +       if (ipmr_is_sk(sk))
> >> +               rc =3D ipmr_sk_ioctl(sk, cmd, arg);
> >> +       else if (ip6mr_is_sk(sk))
> >> +               rc =3D ip6mr_sk_ioctl(sk, cmd, arg);
> >> +       else if (phonet_is_sk(sk))
> >> +               rc =3D phonet_sk_ioctl(sk, cmd, arg);
> >
> > I don't understand what this buys us vs testing the sk_family,
> > sk_protocol and cmd here.
>
> To keep protocol specific code out of core files is the reason I
> suggested it.

I guess you object to demultiplexing based on per-family
protocol and ioctl cmd constants directly in this file?

That only requires including the smaller uapi headers.

But now net/core/sock.h now still has to add includes
linux/mroute.h, linux/mroute6.h and net/phonet/phonet.h.

Aside on phonet_is_sk, if we're keeping this: this should be
sk_is_phonet? Analogous to sk_is_tcp and such. And, it should suffice
to  demultiplex based on the protocol family, without testing the
type or protocol. The family is defined in protocol-independent header
linux/socket.h. The differences between
PN_PROTO_PHONET and PN_PROTO_PIPE should be handled inside the family
code. So I think it is cleaner just to open-coded as `if
(sk->sk_family =3D=3D PF_PHONET)`
