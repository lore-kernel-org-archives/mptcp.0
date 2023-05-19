Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4A5670
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 15:10:07 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-437e4f09268so1018804137.2
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684509006; x=1687101006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KWqkBPQEmPWU7T8irSEQ19rUE/es/slaObd5Ru40e8=;
        b=CaUz2f/yOW4aGWCZ5lY4n2DpH54eaZTOZG9wlDax0OmYXS+KX2mLgQXbkPKMKLGd6e
         3+JEd7bGAYBwgnLoEZxvunxavDtenzl3e3OgVz5bxVU47F6SuRsHaTcxhklvttgQKO5R
         QZe4de0xshahU9asNHZGSAJuzxm3oDtMMEFJQBbvtl4MO3YA3BqXpfD/5Urzp+QpiAeQ
         xtZ6YfnxHZssG/wN/aCf0oAzXBbDYMDBcu+mx82p9CITW+s/WZv3I0LSjJOHp6XMs0tI
         vJWs+N6Qvs7zJPbIrOmJGNgenUSY0pFTu1ElZFakYBeHbv8DsZF+2mcwmugVZCL2UeUm
         1vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509006; x=1687101006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KWqkBPQEmPWU7T8irSEQ19rUE/es/slaObd5Ru40e8=;
        b=T2th+Ce9zUE4naL1fPCMvbcFd+p2Qd016fIo0lNDyCMOgmG/HrgghLxu2+Uf2NFuLJ
         wM6NzaP480aYVDwRBMoJ6b6nWoUxYAVy6wv2FWCReS4cdsOx0EENJ30RmSJF9ePCb19J
         zFNazijsd1vVxU8WNF8vmvMOvLqmDi/mO5HiKlowU2ATywrPafNkP5RNEiyjcp6iXOdu
         4VlRISeg/QQLe/D7Snq0GlJnM6jIp6no4s1c7kb0EGIog3KKgtPKOxTETURqw6t0HH3p
         Fthjacqce93c7Pr9v6PmKkrl0ApjACiQZBobfco9SG+M+TtH31fGl5h3TZ0cas52Y6Ua
         0QmA==
X-Gm-Message-State: AC+VfDyKWNm3TxU/Qdk39bBqU+ptg6pu+PUHF/qJYzaTlObAmHSFRfOc
	LJvwGkXYwvqEYOI7bC2lxbT5fj8Gkgn/r6mWe4E=
X-Google-Smtp-Source: ACHHUZ4YDSoSYd6hMiZzPteknsI88n2Z6dDHecK3Hv6wsxi7bbkE3UGQ3yqSJRf0pq9VVmVStocD/LYkHtRrC0xxkqU=
X-Received: by 2002:a67:e895:0:b0:437:db1d:7edb with SMTP id
 x21-20020a67e895000000b00437db1d7edbmr1229546vsn.6.1684509006032; Fri, 19 May
 2023 08:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230519135821.922326-1-leitao@debian.org> <20230519135821.922326-2-leitao@debian.org>
In-Reply-To: <20230519135821.922326-2-leitao@debian.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 19 May 2023 11:09:29 -0400
Message-ID: <CAF=yD-Jj6dvyOskL+F52_aaaCovVTcpoYSCeMY7xH=FK7r3Jiw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: ioctl: Use kernel memory on protocol ioctl callbacks
To: Breno Leitao <leitao@debian.org>
Cc: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, courmisch@gmail.com, nhorman@tuxdriver.com, 
	asml.silence@gmail.com, alex.aring@gmail.com, dccp@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	matthieu.baerts@tessares.net, marcelo.leitner@gmail.com, 
	linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, leit@fb.com, 
	David.Laight@aculab.com, dsahern@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 9:59=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Most of the ioctls to net protocols operates directly on userspace
> argument (arg). Usually doing get_user()/put_user() directly in the
> ioctl callback.  This is not flexible, because it is hard to reuse these
> functions without passing userspace buffers.
>
> Change the "struct proto" ioctls to avoid touching userspace memory and
> operate on kernel buffers, i.e., all protocol's ioctl callbacks is
> adapted to operate on a kernel memory other than on userspace (so, no
> more {put,get}_user() and friends being called in the ioctl callback).
>
> This changes the "struct proto" ioctl format in the following way:
>
>     int                     (*ioctl)(struct sock *sk, int cmd,
> -                                        unsigned long arg);
> +                                        int *karg);
>
> So, the "karg" argument, which is passed to the ioctl callback, is a
> pointer allocated to kernel space memory (inside a function wrapper -
> sock_skprot_ioctl()). This buffer (karg) may contain input argument
> (copied from userspace in a prep function) and it might return a
> value/buffer, which is copied back to userspace if necessary. There is
> not one-size-fits-all format (that is I am using 'may' above), but
> basically, there are three type of ioctls:
>
> 1) Do not read from userspace, returns a result to userspace
> 2) Read an input parameter from userspace, and does not return anything
>   to userspace
> 3) Read an input from userspace, and return a buffer to userspace.
>
> The default case (1) (where no input parameter is given, and an "int" is
> returned to userspace) encompasses more than 90% of the cases, but there
> are two other exceptions. Here is a list of exceptions:
>
> * Protocol RAW:
>    * cmd =3D SIOCGETVIFCNT:
>      * input and output =3D struct sioc_vif_req
>    * cmd =3D SIOCGETSGCNT
>      * input and output =3D struct sioc_sg_req
>    * Explanation: for the SIOCGETVIFCNT case, userspace passes the input
>      argument, which is struct sioc_vif_req. Then the callback populates
>      the struct, which is copied back to userspace.
>
> * Protocol RAW6:
>    * cmd =3D SIOCGETMIFCNT_IN6
>      * input and output =3D struct sioc_mif_req6
>    * cmd =3D SIOCGETSGCNT_IN6
>      * input and output =3D struct sioc_sg_req6
>
> * Protocol PHONET:
>   * cmd =3D=3D SIOCPNADDRESOURCE | SIOCPNDELRESOURCE
>      * input int (4 bytes)
>   * Nothing is copied back to userspace.
>
> For the exception cases, functions sock_skproto_ioctl_in{out}() will
> copy the userspace input, and copy it back to kernel space.
>
> The wrapper that prepares the buffer and puts the buffer back to user is
> sock_skprot_ioctl(), so, instead of calling sk->sk_prot->ioctl(), the
> callee now calls sock_skprot_ioctl().
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Overall this looks great to me.

Thanks for the detailed commit message that lists all exceptions, Bruno.

Since that is a limited well understood list, I'm not in favor of the
suggestion to add an explicit length argument that then needs to be
checked in each callee.

> +/* Copy 'size' bytes from userspace and return `size` back to userspace =
*/
> +int sock_skproto_ioctl_inout(struct sock *sk, unsigned int cmd,
> +                            void __user *arg, size_t size)
> +{
> +       void *ptr;
> +       int ret;
> +
> +       ptr =3D kmalloc(size, GFP_KERNEL);
> +       if (!ptr)
> +               return -ENOMEM;

> +/* A wrapper around sock ioctls, which copies the data from userspace
> + * (depending on the protocol/ioctl), and copies back the result to user=
space.
> + * The main motivation for this function is to pass kernel memory to the
> + * protocol ioctl callsback, instead of userspace memory.
> + */
> +int sock_skprot_ioctl(struct sock *sk, unsigned int cmd,
> +                     void __user *arg)
> +{
> +#ifdef CONFIG_IP_MROUTE
> +       if (!strcmp(sk->sk_prot->name, "RAW")) {

This must check both sk_family and sk_protocol. That is preferable
over string match.

For these exception cases, instead of having sock_skproto_ioctl_inout
dynamically allocate the struct, how about stack allocating them here
and passing to the function?

Nit: the function name is quite a mouthful. Just sock_ioctl_inout?

> +               switch (cmd) {
> +               /* These userspace buffers will be consumed by ipmr_ioctl=
() */
> +               case SIOCGETVIFCNT:
> +                       return sock_skproto_ioctl_inout(sk, cmd,
> +                               arg, sizeof(struct sioc_vif_req));
> +               case SIOCGETSGCNT:
> +                       return sock_skproto_ioctl_inout(sk, cmd,
> +                               arg, sizeof(struct sioc_sg_req));
> +               }
> +       }
> +#endif
> +#ifdef CONFIG_IPV6_MROUTE
> +       if (!strcmp(sk->sk_prot->name, "RAW6")) {
> +               switch (cmd) {
> +               /* These userspace buffers will be consumed by ip6mr_ioct=
l() */
> +               case SIOCGETMIFCNT_IN6:
> +                       return sock_skproto_ioctl_inout(sk, cmd,
> +                               arg, sizeof(struct sioc_mif_req6));
> +               case SIOCGETSGCNT_IN6:
> +                       return sock_skproto_ioctl_inout(sk, cmd,
> +                               arg, sizeof(struct sioc_sg_req6));
> +               }
> +       }
> +#endif
> +#ifdef CONFIG_PHONET
> +       if (!strcmp(sk->sk_prot->name, "PHONET")) {
> +               /* This userspace buffers will be consumed by pn_ioctl() =
*/
> +               switch (cmd) {
> +               case SIOCPNADDRESOURCE:
> +               case SIOCPNDELRESOURCE:
> +                       return sock_skproto_ioctl_in(sk, cmd, arg);
> +               }
> +       }
> +#endif
> +
> +       return sock_skproto_ioctl_out(sk, cmd, arg);
> +}
