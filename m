Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204783D7C
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 15:06:19 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-3f6c81cc112so11511611cf.2
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685027178; x=1687619178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeTVaGcp8mf3R6o1m6w+QLJatVKY9fsQyGy4GYdH3/U=;
        b=fAtd5/htRUFMBa6f2nihULsyk2krg4KuX1xoWANa66q5xQnrzl33EhjI7zDw/HAwyP
         I+8jc6OlE/v38ijMp7n0KEs7MgDBx4is5tOGMyFslK7i0G9KI24TpDdkiJSwRGIEeBQw
         ggqMtD24W8lTsA7GshRDvyDkhP2OGnjSpqzEz0OOMJrWuBIt4u3sSx0gMejYsnKbhx9v
         7mjg1PZKVnmUJw41QmGV92z17mH6Prf/cBXyn5Cvi8HnhZzZaRgp0g8QmkOmj0J8j/hu
         K+GjM6ifOJuG8aP0rLPjJxH82SDp4MV8J8hXDZ8v11Eiw2ZzbTfZmuvBKBB3W5t7PPIa
         KfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685027178; x=1687619178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeTVaGcp8mf3R6o1m6w+QLJatVKY9fsQyGy4GYdH3/U=;
        b=RwcPyy57fVxKHrPr8Pbg/8u7R+GzHM3y22LVjdWfGyoLgwJuWuYZ+4dUxRmcPZ/4Pt
         wmg88mmRc7nhcQmwQXEqDGY1wcUFphuvfSssCDoMKOKh3hFx+mFVIjvVrKNgcKo1qLIr
         L1Ndx92ZZ+4PYqP5+PpL5Q8YXSv0M0YslONCaei/DmoGkeBKgOsSa/1Z8Mxta5kG7bak
         5ltNqHGRo2vMm05ICdY3wn3PYZbWj6DiFi5738d8DwqE+Py3z+6aUhAFPvy1WPnlTlJb
         p95f4Xr+ChqMR9lep49Qxq8QPnCRoHwFFf8X9folE90Uwjyn4K67Eb09cHE92AdO0ALw
         hIMA==
X-Gm-Message-State: AC+VfDwBRIKtmOT5C74c2luLQiMxM/jGKOvh4rm8JAQhnuYak+h3aA//
	pMRbO8ywGLRuFdc5ZQRN8J7OG2Pvm+dXk1FVEY0=
X-Google-Smtp-Source: ACHHUZ7UCznfEjmcmpbGGznthDIVRdV0Ywo844eEoZVqoIgAM1pxMcr4sL+6PvSj6oRGzSLaHoa3ww2gR4P5ptHqPYQ=
X-Received: by 2002:ac8:5e53:0:b0:3eb:1512:91c5 with SMTP id
 i19-20020ac85e53000000b003eb151291c5mr31239024qtx.12.1685027177888; Thu, 25
 May 2023 08:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230525125503.400797-1-leitao@debian.org>
In-Reply-To: <20230525125503.400797-1-leitao@debian.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 25 May 2023 11:05:40 -0400
Message-ID: <CAF=yD-LHQNkgPb-R==53-2auVxkP9r=xqrz2A8oe61vkoDdWjg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
To: Breno Leitao <leitao@debian.org>
Cc: dsahern@kernel.org, Remi Denis-Courmont <courmisch@gmail.com>, 
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

On Thu, May 25, 2023 at 8:55=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
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
> pointer allocated to kernel space memory (inside a function wrapper).
> This buffer (karg) may contain input argument (copied from userspace in
> a prep function) and it might return a value/buffer, which is copied
> back to userspace if necessary. There is not one-size-fits-all format
> (that is I am using 'may' above), but basically, there are three type of
> ioctls:
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
> For the exception cases, functions sock_sk_ioctl_inout() will
> copy the userspace input, and copy it back to kernel space.
>
> The wrapper that prepare the buffer and put the buffer back to user is
> sk_ioctl(), so, instead of calling sk->sk_prot->ioctl(), the callee now
> calls sk_ioctl(), which will handle all cases.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

> +/* A wrapper around sock ioctls, which copies the data from userspace
> + * (depending on the protocol/ioctl), and copies back the result to user=
space.
> + * The main motivation for this function is to pass kernel memory to the
> + * protocol ioctl callbacks, instead of userspace memory.
> + */
> +int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
> +{
> +       int rc =3D 1;
> +
> +       if (ipmr_is_sk(sk))
> +               rc =3D ipmr_sk_ioctl(sk, cmd, arg);
> +       else if (ip6mr_is_sk(sk))
> +               rc =3D ip6mr_sk_ioctl(sk, cmd, arg);
> +       else if (phonet_is_sk(sk))
> +               rc =3D phonet_sk_ioctl(sk, cmd, arg);

I don't understand what this buys us vs testing the sk_family,
sk_protocol and cmd here.

It introduces even deeper dependencies on the protocol specific
header files. And the CONFIG issues that result from that. And it
adds a bunch of wrappers that are only used once.

> @@ -1547,6 +1547,28 @@ int ip_mroute_setsockopt(struct sock *sk, int optn=
ame, sockptr_t optval,
>         return ret;
>  }
>
> +/* Execute if this ioctl is a special mroute ioctl */
> +int ipmr_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
> +{
> +       switch (cmd) {
> +       /* These userspace buffers will be consumed by ipmr_ioctl() */
> +       case SIOCGETVIFCNT: {
> +               struct sioc_vif_req buffer;
> +
> +               return sock_ioctl_inout(sk, cmd, arg, &buffer,
> +                                     sizeof(buffer));
> +               }

More importantly, if we go down the path of demultiplexing in protocol
independent code to call protocol specific handlers, then there there
is no need to have them call protocol independent helpers like
sock_ioct_inout again. Just call the protocol-specific ioctl handlers
directly?



> +       case SIOCGETSGCNT: {
> +               struct sioc_sg_req buffer;
> +
> +               return sock_ioctl_inout(sk, cmd, arg, &buffer,
> +                                     sizeof(buffer));
> +               }
> +       }
> +       /* return code > 0 means that the ioctl was not executed */
> +       return 1;
> +}
