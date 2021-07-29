Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC523483
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 11:38:08 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id f13so6665379plj.2
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/EkmuqPypmn/bDDFQAj/nklpQQJNEznSVoNYG//HbGU=;
        b=jD0OSgN5IE8ZC0B0CNzvrpKh3N2CrhXk6K9KATzwEUQM9N8oU77rjXsdLXtr1FxpCD
         Q46lXohUyJNvYiSvWj7WbGBWg+tmlwDTKI36NxAe000Pv0pSqjRWfOZ6NiVuZeRTq+CY
         aRXaI1ZlUmyt41LWVOhs6OGAT37M7lKBLewAP2Q3xG3NaAaqWLLYJK++mvSVoWe6GFnH
         vZ+4z5qRMspSjZiYxFXmPhJC2cm4rspHB1w2ckOfTTQdxfr9ZKzhL1cdnDYs15gPtwyV
         +Zt7UkcotR8N/f0V9csHDPu/L+oyD1JuFD5eA8jD8M/ceJkwWDbVPDxe07Vtoa9ea/xa
         q1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/EkmuqPypmn/bDDFQAj/nklpQQJNEznSVoNYG//HbGU=;
        b=SxlCPMPk3US4wLixz6qM4iGk+gk3iOSMOngHLJghNZrkm+Vgu1DTOdj0VG0D/Qj/9M
         I78A2/SCayyrLSdy+1tQqdInBoixZ6KVlS3FNkvi1VQdv0MOK9u+STUTPs9E4KEhB6GK
         hZHJpz880EkXAlOcnbcN/hf1szFbKplVcoovsRDCPjiDzH5mQrLBCORHYhEH2stAqHql
         bplYgR3HDLbXbD4eEDqsSX4cxoS4CeDjWqIpqx73TBOiqtjd8jrouzsuPA52gB/3hSZp
         1GXeLiGVYMJ3GvWSZdRm7EsOhWDt91DRXfx4u3Q95OwohWN8u/bvsjY6yFwBxrAkgqxk
         jIXw==
X-Gm-Message-State: AOAM531zOTtPfrwOHPMIHJeJ1xfNve51eMIScBjxXiV8rxO7KKptxp+f
	Kc/1WeWFNjiHEXrld8UWHlsKotcfhqbEK/0usqc=
X-Google-Smtp-Source: ABdhPJw0+qgL7iCVtrnn9s/rtbvk4uuwpbWAX4HZZKOCM74KYj/xIuFwon78qz0OU4r2iN1IkT/pB6RAvD9hlKJS0vw=
X-Received: by 2002:a17:902:7c8d:b029:12b:793e:9f26 with SMTP id
 y13-20020a1709027c8db029012b793e9f26mr4210575pll.84.1627558688058; Thu, 29
 Jul 2021 04:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627543032.git.geliangtang@xiaomi.com> <1244ff06f1715f714ccc21bb164c6c082e8a26f5.1627543032.git.geliangtang@xiaomi.com>
 <f7de86246eb6e6bbae3235f5d78307cc0015f23e.camel@redhat.com>
In-Reply-To: <f7de86246eb6e6bbae3235f5d78307cc0015f23e.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 29 Jul 2021 19:37:56 +0800
Message-ID: <CA+WQbwvzpYfXr7n8WfY9+oqFhDVN90R+Cn4YHYvbbeTQKb4Mcw@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v7 mptcp-next 1/6] mptcp: drop flags and ifindex arguments
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8829=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 2021-07-29 at 15:20 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > This patch added a new helper mptcp_pm_get_flags_and_ifindex_by_id(),
> > and used it in __mptcp_subflow_connect() to get the flags and ifindex
> > values.
> >
> > Then the two arguments flags and ifindex of __mptcp_subflow_connect()
> > can be dropped.
> >
> > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > ---
> >  net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
> >  net/mptcp/protocol.h   |  5 +++--
> >  net/mptcp/subflow.c    |  7 +++++--
> >  3 files changed, 30 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index ba0e1d71504d..94c68d6093de 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -462,8 +462,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
> >                       check_work_pending(msk);
> >                       remote_address((struct sock_common *)sk, &remote)=
;
> >                       spin_unlock_bh(&msk->pm.lock);
> > -                     __mptcp_subflow_connect(sk, &local->addr, &remote=
,
> > -                                             local->flags, local->ifin=
dex);
> > +                     __mptcp_subflow_connect(sk, &local->addr, &remote=
);
> >                       spin_lock_bh(&msk->pm.lock);
> >                       return;
> >               }
> > @@ -518,7 +517,7 @@ static void mptcp_pm_nl_add_addr_received(struct mp=
tcp_sock *msk)
> >       local.family =3D remote.family;
> >
> >       spin_unlock_bh(&msk->pm.lock);
> > -     __mptcp_subflow_connect(sk, &local, &remote, 0, 0);
> > +     __mptcp_subflow_connect(sk, &local, &remote);
> >       spin_lock_bh(&msk->pm.lock);
> >
> >  add_addr_echo:
> > @@ -1103,6 +1102,26 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet,=
 unsigned int id)
> >       return NULL;
> >  }
> >
> > +int mptcp_pm_get_flags_and_ifindex_by_id(struct net *net, unsigned int=
 id,
> > +                                      u8 *flags, int *ifindex)
> > +{
> > +     struct mptcp_pm_addr_entry *entry;
> > +
> > +     rcu_read_lock();
> > +     entry =3D __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), =
id);
> > +     rcu_read_unlock();
> > +
> > +     if (entry) {
> > +             *flags =3D entry->flags;
> > +             *ifindex =3D entry->ifindex;
> > +     } else {
> > +             *flags =3D 0;
> > +             *ifindex =3D 0;
> > +     }
>
> You need to extend the RCU section after the entry reference above, or
> on preempt-enabled build, the entry could be deleted in between the rcu
>  unlock and the later access.

Thanks Paolo, I'll send a squash-to patch to fix this.

>
> I'm wondering if there are issues with the 0 id ?!?

The 0 id address isn't on the local_addr_list, we should set it's
flags and ifindex all to 0.

I'll add a non-zero check in the squash-to patch too.

Thanks,
-Geliang

>
> /P
>
