Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3A1103
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 05:29:33 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id v11so15939857pff.6
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2r2YJ9z8/DlhBwQrlo+ggv+RrmXk5WJX+ZtmBwlTjKY=;
        b=RNoBKzsGttlzdKQnPiEJnG221x14PCjwsW3kj6CyvCAyVnlJy//Q/L5IiS6i3I/4Or
         6kVpWRUjXT8ZLhTQlb73/K9rc6Wsd71AvMwt3KmCdc8ZQHKrdiJvnSRa7k4h7RYMPixC
         GbQCwL61QiDJ5e0Jgy8vxk+TBeKWzBu++gYkHKoe+LQxtkwm136+wFKtUtrmN0x9mduD
         3NDu4dfExBqDNNVl8L6d+WQn3lEjgnxd14ZLKZhIMMDvKjVsBYwGAvOM2CAJlda9be9m
         fxDuex7zrjhiz0ozCU+LWmu3xZ6ErKg9ZDk9unkYhw/J3YFphzllF/0hdOjuvGeM4Bpn
         Y8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2r2YJ9z8/DlhBwQrlo+ggv+RrmXk5WJX+ZtmBwlTjKY=;
        b=sGjKA20FuCQKOOJPE8D+qCc+YvJjEChveZx1iOh9wPRvhoHGMVu5TyA+QN/PzQBDnQ
         Yz2kat/+XjRetcxvJjf744DnHU3YKf6MFWBltOH/0ShfEDttCGhKCxQxVvL2++VgjTYl
         DTU2z00XcMR9YSXX/CRSbJffLCylO9xUjwz9Iki/y/9TzImGRyzuh/oxWt1GR09pfY27
         KOgfgFZFj3DKGFKNngHt4sj+zwvBxXlWwZQuRJI1B93qFkcOWG0YSEHjVwTkQo49FYSY
         AhXq5TmyJifjOXkhQJZhy53PVoQk/qrIUONuWbLWfdJtPqu+caL0RlCBe7m1dbpikWrf
         Op9g==
X-Gm-Message-State: AOAM530s2L4T+SJlX+s5HqWMXTW5pCbB1jS28iB8rlNX774WSss1SR5y
	qdVz2X6Oxssq79ZE71zYxZ4tPJuJx/aI8UQNbpQ=
X-Google-Smtp-Source: ABdhPJyuzkoGE0IPDE8V1GtC5Nvtgct3xyNNq9kPHWgNhHMepyfq8l+meuY3A7PoqdT0NztEm1jSmu0ONXVb4Mu+oY8=
X-Received: by 2002:a05:6a00:1a47:b0:510:a41b:362d with SMTP id
 h7-20020a056a001a4700b00510a41b362dmr21017741pfv.30.1652765373434; Mon, 16
 May 2022 22:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513224827.662254-1-mathew.j.martineau@linux.intel.com>
 <20220513224827.662254-5-mathew.j.martineau@linux.intel.com> <20220517012055.loesbaunau2bxbt5@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220517012055.loesbaunau2bxbt5@kafai-mbp.dhcp.thefacebook.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 17 May 2022 13:29:35 +0800
Message-ID: <CA+WQbwtWUqK_dR5Chpfg3S9nbTNEi20YqSJkh10MVcaVSQeeJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/7] selftests/bpf: test bpf_skc_to_mptcp_sock
To: Martin KaFai Lau <kafai@fb.com>
Cc: Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, Networking <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau <kafai@fb.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=8C 09:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, May 13, 2022 at 03:48:24PM -0700, Mat Martineau wrote:
> [ ... ]
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/tes=
ting/selftests/bpf/progs/mptcp_sock.c
> > index bc09dba0b078..3feb7ff578e2 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> > @@ -7,6 +7,7 @@
> >  #include "bpf_tcp_helpers.h"
> >
> >  char _license[] SEC("license") =3D "GPL";
> > +extern bool CONFIG_MPTCP __kconfig;
> >
> >  struct mptcp_storage {
> >       __u32 invoked;
> > @@ -24,6 +25,7 @@ SEC("sockops")
> >  int _sockops(struct bpf_sock_ops *ctx)
> >  {
> >       struct mptcp_storage *storage;
> > +     struct mptcp_sock *msk;
> >       int op =3D (int)ctx->op;
> >       struct tcp_sock *tsk;
> >       struct bpf_sock *sk;
> > @@ -41,11 +43,24 @@ int _sockops(struct bpf_sock_ops *ctx)
> >               return 1;
> >
> >       is_mptcp =3D bpf_core_field_exists(tsk->is_mptcp) ? tsk->is_mptcp=
 : 0;
> > -     storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
> > -                                  BPF_SK_STORAGE_GET_F_CREATE);
> > -     if (!storage)
> > -             return 1;
> > +     if (!is_mptcp) {
> > +             storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0=
,
> > +                                          BPF_SK_STORAGE_GET_F_CREATE)=
;
> > +             if (!storage)
> > +                     return 1;
> > +     } else {
> > +             if (!CONFIG_MPTCP)
> hmm... how is it possible ?  The above just tested "!is_mptcp".

Will drop this in v5, thanks.

>
> > +                     return 1;
> > +
> > +             msk =3D bpf_skc_to_mptcp_sock(sk);
> > +             if (!msk)
> > +                     return 1;
> >
> > +             storage =3D bpf_sk_storage_get(&socket_storage_map, msk, =
0,
> > +                                          BPF_SK_STORAGE_GET_F_CREATE)=
;
> > +             if (!storage)
> > +                     return 1;
> > +     }
> >       storage->invoked++;
> >       storage->is_mptcp =3D is_mptcp;
> >
> > --
> > 2.36.1
> >
>
