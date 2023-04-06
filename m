Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF18AD29
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 18:17:05 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-32656582b40so394395ab.1
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680805024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h70PraPH5+GMWozAhM7JaPVH30CeiE+sjPLouQsdB7g=;
        b=sV0bNyy9DUoGVmnnZYp++9XpnHtdFFdBIfUu98tiebaRLFSkMDjqsbZX5u2udu69+Y
         NWdL2QKNoj40V0Xpai63YRAE2NFq4G0ApvL0Seq8uOnnpjOIY98m5/FJ+jA7YQUsLw2T
         bzb6HqEUDO1i0XQgWyH2SFNkZT6MQ2EpnWsommuVxAol7APb1dh3X74x5lR/fgRFt4ME
         79KCT3E0JCzB+cinRi4Qww3f1lTq1vV9bb4Z30q6vx0LkuvbZ0QHlv+I7rGhWyShLhya
         OsM+H88PXCY3o5lUcgSuRGNaDR3mIesOqI117sq4d0NwSFNMRoApUNatSKDXEi4dqi11
         OyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h70PraPH5+GMWozAhM7JaPVH30CeiE+sjPLouQsdB7g=;
        b=1HRxaxNIPLS9uBeLh2iJjdNFXaaypuRhVjRZirf1gUlDCoO4+64fYtdJPasI8OztU8
         PH30Bm8I5NhVgU7wZMroSHTsxTMRf6taFsN0ttAlYl4K/l7Ho/hmRdLI/1dUgVboTuOK
         zmBBQv9vZJftd+RnctvHr1TuwyVj3bN21DOzEiPcbVF+IusfrG8GJsYwy0gPUPr4Dsin
         6H8NIy2+8iZe/YugwpXrLsr/FpuztHXfc/UqhovWXHj+zD3ec51NQDoGVmnQInunDw0C
         HBIYbpynSKnUL34zNxW5qHX2GxHBtBB1t4UzU8Yfq5blj5DLwfgPy8hEQEDdQlSqpbLe
         01iw==
X-Gm-Message-State: AAQBX9cDXd0PEs9HqON18eHYJ0/h/1K7qZYJAVP/bd0CTstwxgRp0DkK
	8mMoZ4ys/UEJhfSqHH3hkwrrLiSgSkueE6s9Ffj0Hg==
X-Google-Smtp-Source: AKy350b6bIn2q5v2MiKCNJhNqfrzRDXgyf/sd6L4aQ3P3U8+mlRZqYYT3NQuDmpc3IFVPLht2efOKqjcmlhBOYYVtCY=
X-Received: by 2002:a05:6e02:1e0a:b0:326:55d0:efad with SMTP id
 g10-20020a056e021e0a00b0032655d0efadmr20905ila.12.1680805024290; Thu, 06 Apr
 2023 11:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230406144330.1932798-1-leitao@debian.org> <CA+FuTSeKpOJVqcneCoh_4x4OuK1iE0Tr6f3rSNrQiR-OUgjWow@mail.gmail.com>
 <ZC7seVq7St6UnKjl@gmail.com>
In-Reply-To: <ZC7seVq7St6UnKjl@gmail.com>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 6 Apr 2023 14:16:24 -0400
Message-ID: <CA+FuTSf9LEhzjBey_Nm_-vN0ZjvtBSQkcDWS+5uBnLmr8Qh5uA@mail.gmail.com>
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com, edumazet@google.com, 
	pabeni@redhat.com, davem@davemloft.net, dccp@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, matthieu.baerts@tessares.net, 
	marcelo.leitner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 6, 2023 at 11:59=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Thu, Apr 06, 2023 at 11:34:28AM -0400, Willem de Bruijn wrote:
> > On Thu, Apr 6, 2023 at 10:45=E2=80=AFAM Breno Leitao <leitao@debian.org=
> wrote:
> > >
> > > From: Breno Leitao <leit@fb.com>
> > >
> > > This patchset creates the initial plumbing for a io_uring command for
> > > sockets.
> > >
> > > For now, create two uring commands for sockets, SOCKET_URING_OP_SIOCO=
UTQ
> > > and SOCKET_URING_OP_SIOCINQ. They are similar to ioctl operations
> > > SIOCOUTQ and SIOCINQ. In fact, the code on the protocol side itself i=
s
> > > heavily based on the ioctl operations.
> >
> > This duplicates all the existing ioctl logic of each protocol.
> >
> > Can this just call the existing proto_ops.ioctl internally and translat=
e from/to
> > io_uring format as needed?
>
> This is doable, and we have two options in this case:
>
> 1) Create a ioctl core function that does not call `put_user()`, and
> call it from both the `udp_ioctl` and `udp_uring_cmd`, doing the proper
> translations. Something as:
>
>         int udp_ioctl_core(struct sock *sk, int cmd, unsigned long arg)
>         {
>                 int amount;
>                 switch (cmd) {
>                 case SIOCOUTQ: {
>                         amount =3D sk_wmem_alloc_get(sk);
>                         break;
>                 }
>                 case SIOCINQ: {
>                         amount =3D max_t(int, 0, first_packet_length(sk))=
;
>                         break;
>                 }
>                 default:
>                         return -ENOIOCTLCMD;
>                 }
>                 return amount;
>         }
>
>         int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
>         {
>                 int amount =3D udp_ioctl_core(sk, cmd, arg);
>
>                 return put_user(amount, (int __user *)arg);
>         }
>         EXPORT_SYMBOL(udp_ioctl);
>
>
> 2) Create a function for each "case entry". This seems a bit silly for
> UDP, but it makes more sense for other protocols. The code will look
> something like:
>
>          int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
>          {
>                 switch (cmd) {
>                 case SIOCOUTQ:
>                 {
>                         int amount =3D udp_ioctl_siocoutq();
>                         return put_user(amount, (int __user *)arg);
>                 }
>                 ...
>           }
>
> What is the best approach?

A, the issue is that sock->ops->ioctl directly call put_user.

I was thinking just having sock_uring_cmd call sock->ops->ioctl, like
sock_do_ioctl.

But that would require those callbacks to return a negative error or
positive integer, rather than calling put_user. And then move the
put_user to sock_do_ioctl. Such a change is at least as much code
change as your series. Though without the ending up with code
duplication. It also works only if all ioctls only put_user of integer
size. That's true for TCP, UDP and RAW, but not sure if true more
broadly.

Another approach may be to pass another argument to the ioctl
callbacks, whether to call put_user or return the integer and let the
caller take care of the output to user. This could possibly be
embedded in the a high-order bit of the cmd, so that it fails on ioctl
callbacks that do not support this mode.

Of the two approaches you suggest, I find the first preferable.
