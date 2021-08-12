Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B41672
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 07:09:50 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so9244005pjl.4
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 00:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rWAzgDa2iH8zJZsDE5cRIwIUMZD8oN1dxTDR3EgsqTQ=;
        b=GWO7fxEf62dN9CMUrX2x0OPGaqs3nWp7GOElROm5RiXm+RDmKZm0mu2XGtQz57/pVs
         WfhxLKhLDf/TSlVEFXLYAb8MhiJ8GEtFbQM8UcmxOcXBEPC8Z1NGNQ863cY4s1qKrqBH
         GadkZj0uOe2QmMq+WQIUGBcF1H7yZ3vD5oalKv85rxHRYTDfFWjMSN+DTUUVX+2aHV2p
         1rdNYgvnFMfcrM8fNgWF3u0iJgudkHnFOe1FHL1t1tR5CHqmWxyKtSt5DTQbTTxq+nnH
         ZHPb6prqYJNSM8aYcIsShQo8VxSCWEZ2fd59He1/DaWUpmoL97zE3PbXyZZFOqB7wy2v
         Ifyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rWAzgDa2iH8zJZsDE5cRIwIUMZD8oN1dxTDR3EgsqTQ=;
        b=AyeLRAy7B/3gcZzSmrgs13+Q0qHzMnd0XKnQMrmu5DsZXwZwu5Xvv/Rm1L6aB8WONZ
         fkDH7CX/q2il3plGvcg9zMzyx8J/rOKJAaCnrYcR4F+UZjsIs5nBOPGMPaSQ8mhvVKzl
         Zx44/p/JIXvaY9LI+8hs8gzZgJMFH4dl3hT95m79TbT0x6JwHhgD64J01RK0BP090BzC
         EgYYFXghkcIoe3fRYh69LxkUSBZrBLwjlvd8BbjxYarX0S1xsjhwm+Lh8sXiIW3wtRWp
         N+VfhCl6WfC//WNOH45KupbTwO12TdeYkeew5zOxkU2jydXA/axmJc5Y9C1o0Qs6SmDV
         FmJQ==
X-Gm-Message-State: AOAM5322ctsz+9q/cyxDoD4RDqp6Coj0sjVYDTZFvBYm4QKQjz/WZXx1
	mHnZomzCJ7GmiGDZ/JucIE6PnccwXZ7nl6ZOD/c=
X-Google-Smtp-Source: ABdhPJzO45vyqD9CBgpowDKtDU1qIiRnNUQ74Nk/kbbcpyAXsVeCCMyaOQjl4oTP7EhPFtEvam7Tsz3g5YIBdpO+sI0=
X-Received: by 2002:a63:d458:: with SMTP id i24mr2632173pgj.289.1628752189892;
 Thu, 12 Aug 2021 00:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627464017.git.geliangtang@xiaomi.com> <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com>
 <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com>
 <eb3602e3f2a3550e9c1c27e2b5e3428562ac1010.camel@redhat.com>
In-Reply-To: <eb3602e3f2a3550e9c1c27e2b5e3428562ac1010.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 12 Aug 2021 15:09:38 +0800
Message-ID: <CA+WQbwt1FA-HyKLkwJ3vTSxT6ZNBdCQKyRGnZoR-KtenHK7M=w@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 2/5] mptcp: MP_FAIL suboption receiving
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8828=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:36=E5=86=99=E9=81=93=EF=BC=9A

>
> On Wed, 2021-07-28 at 17:35 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > This patch added handling for receiving MP_FAIL suboption.
> >
> > Add a new members mp_fail and fail_seq in struct mptcp_options_received=
.
> > When MP_FAIL suboption is received, set mp_fail to 1 and save the seque=
nce
> > number to fail_seq.
> >
> > Then invoke mptcp_pm_mp_fail_received to deal with the MP_FAIL suboptio=
n.
> >
> > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > ---
> >  net/mptcp/options.c  | 16 ++++++++++++++++
> >  net/mptcp/pm.c       |  5 +++++
> >  net/mptcp/protocol.h |  3 +++
> >  3 files changed, 24 insertions(+)
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 2b15063c8009..cd9ec4acf127 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -336,6 +336,16 @@ static void mptcp_parse_option(const struct sk_buf=
f *skb,
> >               mp_opt->reset_reason =3D *ptr;
> >               break;
> >
> > +     case MPTCPOPT_MP_FAIL:
> > +             if (opsize !=3D TCPOLEN_MPTCP_FAIL)
> > +                     break;
> > +
> > +             ptr +=3D 2;
> > +             mp_opt->mp_fail =3D 1;
> > +             mp_opt->fail_seq =3D get_unaligned_be64(ptr);
> > +             pr_debug("MP_FAIL: data_seq=3D%llu", mp_opt->fail_seq);
> > +             break;
> > +
> >       default:
> >               break;
> >       }
> > @@ -364,6 +374,7 @@ void mptcp_get_options(const struct sock *sk,
> >       mp_opt->reset =3D 0;
> >       mp_opt->csum_reqd =3D READ_ONCE(msk->csum_enabled);
> >       mp_opt->deny_join_id0 =3D 0;
> > +     mp_opt->mp_fail =3D 0;
> >
> >       length =3D (th->doff * 4) - sizeof(struct tcphdr);
> >       ptr =3D (const unsigned char *)(th + 1);
> > @@ -1147,6 +1158,11 @@ bool mptcp_incoming_options(struct sock *sk, str=
uct sk_buff *skb)
> >               mp_opt.mp_prio =3D 0;
> >       }
> >
> > +     if (mp_opt.mp_fail) {
> > +             mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> > +             mp_opt.mp_fail =3D 0;
> > +     }
> > +
>
> Side note not specifically related to this patch: usually we get a
> single MPTCP subopt per packet: a DSS. So we could optimize this code
> path with something alike:
>
>         if (unlikely(any subopt other than dss is present))
>                 // go checking all of them individually

How about simply doing it like this:

       if (unlikely(mp_opt.fastclose || mp_opt.add_addr || mp_opt.rm_addr |=
|
                    mp_opt.mp_prio || mp_opt.mp_fail || mp_opt.reset)) {
                  // go checking all of them individually
       }

I just sent out a patch for this named "mptcp: use unlikely for non-DSS
suboptions" to ML. Please review it.

Thanks,
-Geliang


>
> To do the above we likely need to wrap all the 'mp_capable',
> 'fastclose', 'rm_addr' flags in a single bitmask. e.v. using a union.
>
> /P
>
