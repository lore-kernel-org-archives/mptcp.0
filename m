Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8B70
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 09:52:42 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id j1so8494996pjv.3
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gTpKSkOwCuo8ReG4hnZN0pWlpG4uLJ+m1UxnFAkCI4M=;
        b=vQ+K60yhrv9zqmlngC6RUESSvFWD839fpYPOkyn1yGuMCHZ9Z56LbmalYPxs0bialO
         rvh51lLcga4eLBRCVkbgw0OdfBEsXwxbskNoEeRblQJE7C3++67d/gjNiBVx1dqxNV6t
         UUx2KreyU+4j9QYo2aCVpjUxV4+d/b0oXUDauHW4f8tsSvKNDhWZ+AKkSCLhhVVjMriZ
         F81ww2689Xt7Wx7sOOOa4d01q11p5rg7WGIPPpkBoVurTWyocfBUnxVdUqvq9xzJYgxM
         ZV3IKePAtK9dej3U6BT1yDtgqmte0zqfkdf6h+upoCaJOSL3SW4dLMmyKqKlXmuCRw2O
         cATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gTpKSkOwCuo8ReG4hnZN0pWlpG4uLJ+m1UxnFAkCI4M=;
        b=hhYBJX1XiO97L3/S9sZaJJZsvZzIgdnTvQf7RGfRxV2KtvkEk2SGkOc9ylVPDuzOtC
         03Sf1zclV4SI/fh2khlNNc5j7SvuxtEINRTc1ILpNdjqt5LZMEOePJGblCbWJ7Ws3tfp
         MfZTn1ifkcVWRMg9uURu0lBLTlLf2lvuW+CerREazAZto9fuv0VUJHoSf8BZJrKXTZvJ
         AJlMW9NQdlGXwbEexW1/k82T8buFPAtmcmqdiythQUrd5niT4yL8RhNHZNBnHmCglsoX
         ieJNW1PZDhoQ/K5YNHVQSmNi803kFlFEqAFONj9dZ1LpCa9g+eXKao16R8ljF92ez1ar
         D32Q==
X-Gm-Message-State: AOAM533ZDqh3Sw1RnzzTgWe+nHGLk4M2ffH4e5sjDKpJNWxg/1UutsKm
	h9ahs+0piEIwOUs6qWpbs39N90h78clbUSw9utU=
X-Google-Smtp-Source: ABdhPJwTEIv4/QBLzfhSL0GefCfBYIME4nIZseoBSgmo8Z082nKejWGvbk9JrreO2GC2Xx/manIRnGCU6ZN6jq3nadk=
X-Received: by 2002:a17:90a:4fa3:: with SMTP id q32mr16034710pjh.123.1628761962071;
 Thu, 12 Aug 2021 02:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <e59a65d4bc669101b598c79e57ff425e4cf88d6e.1628752099.git.geliangtang@xiaomi.com>
 <85da0534130a3c604d2207bb9d74accedde7156c.camel@redhat.com>
In-Reply-To: <85da0534130a3c604d2207bb9d74accedde7156c.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 12 Aug 2021 17:52:30 +0800
Message-ID: <CA+WQbwtraWL-b1s8Wg==p22Qkzp7xkEt7XdzsS5krYpD09wkvw@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: use unlikely for non-DSS suboptions
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8812=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Thu, 2021-08-12 at 15:09 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > Usually we get a single MPTCP subopt per packet: a DSS. So we could
> > optimize the other suboptions code path with something alike:
> >
> >         if (unlikely(any subopt other than dss is present))
> >                 // go checking all of them individually
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > ---
> >  net/mptcp/options.c | 75 +++++++++++++++++++++++----------------------
> >  1 file changed, 39 insertions(+), 36 deletions(-)
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index eaee69df6635..7e8019ad8542 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -1123,49 +1123,52 @@ bool mptcp_incoming_options(struct sock *sk, st=
ruct sk_buff *skb)
> >       if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
> >               return sk->sk_state !=3D TCP_CLOSE;
> >
> > -     if (mp_opt.fastclose &&
> > -         msk->local_key =3D=3D mp_opt.rcvr_key) {
> > -             WRITE_ONCE(msk->rcv_fastclose, true);
> > -             mptcp_schedule_work((struct sock *)msk);
> > -     }
> > -
> > -     if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
> > -             if (!mp_opt.echo) {
> > -                     mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> > -                     MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> > -             } else {
> > -                     mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
> > -                     mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
> > -                     MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> > +     if (unlikely(mp_opt.fastclose || mp_opt.add_addr || mp_opt.rm_add=
r ||
> > +                  mp_opt.mp_prio || mp_opt.mp_fail || mp_opt.reset)) {
> > +             if (mp_opt.fastclose &&
> > +                 msk->local_key =3D=3D mp_opt.rcvr_key) {
> > +                     WRITE_ONCE(msk->rcv_fastclose, true);
> > +                     mptcp_schedule_work((struct sock *)msk);
> >               }
> >
> > -             if (mp_opt.addr.port)
> > -                     MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
> > +             if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt))=
 {
> > +                     if (!mp_opt.echo) {
> > +                             mptcp_pm_add_addr_received(msk, &mp_opt.a=
ddr);
> > +                             MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_A=
DDADDR);
> > +                     } else {
> > +                             mptcp_pm_add_addr_echoed(msk, &mp_opt.add=
r);
> > +                             mptcp_pm_del_add_timer(msk, &mp_opt.addr,=
 true);
> > +                             MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_E=
CHOADD);
> > +                     }
> >
> > -             mp_opt.add_addr =3D 0;
> > -     }
> > +                     if (mp_opt.addr.port)
> > +                             MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_P=
ORTADD);
> >
> > -     if (mp_opt.rm_addr) {
> > -             mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
> > -             mp_opt.rm_addr =3D 0;
> > -     }
> > +                     mp_opt.add_addr =3D 0;
> > +             }
> >
> > -     if (mp_opt.mp_prio) {
> > -             mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> > -             MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
> > -             mp_opt.mp_prio =3D 0;
> > -     }
> > +             if (mp_opt.rm_addr) {
> > +                     mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
> > +                     mp_opt.rm_addr =3D 0;
> > +             }
> >
> > -     if (mp_opt.mp_fail) {
> > -             mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> > -             MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
> > -             mp_opt.mp_fail =3D 0;
> > -     }
> > +             if (mp_opt.mp_prio) {
> > +                     mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> > +                     MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX)=
;
> > +                     mp_opt.mp_prio =3D 0;
> > +             }
> >
> > -     if (mp_opt.reset) {
> > -             subflow->reset_seen =3D 1;
> > -             subflow->reset_reason =3D mp_opt.reset_reason;
> > -             subflow->reset_transient =3D mp_opt.reset_transient;
> > +             if (mp_opt.mp_fail) {
> > +                     mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> > +                     MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX)=
;
> > +                     mp_opt.mp_fail =3D 0;
> > +             }
> > +
> > +             if (mp_opt.reset) {
> > +                     subflow->reset_seen =3D 1;
> > +                     subflow->reset_reason =3D mp_opt.reset_reason;
> > +                     subflow->reset_transient =3D mp_opt.reset_transie=
nt;
> > +             }
> >       }
> >
> >       if (!mp_opt.dss)
>
> I think with a slighly larger change, we can trim completely a lot of
> conditionals, specifically:
> - replace all the 'opt.reset', 'opt.mp_fail', 'opt.dss' etc. fields
> with a bitmask 'suboptions'
>
> - in mptcp_incoming_options()
>         if (unlikely(opt.suboptions !=3D BIT(OPT_DSS_WHATEVER_WILL_BE_CAL=
LED))) {
>                 // check the individual bits
>
>                 if (!(opt.suboptions & BIT(OPT_DSS_WHATEVER_WILL_BE_CALLE=
D)))
>                         return;
>         }
>
>         // here DSS will be always set.
>
> With the above, for the most common scenario, we will have a single
> 'if' statement in the fastpath (and that will use branch prediction
> hint, too)
>
> I've the patch half-cooked, if I find some time to finish them...

Thanks Paolo, let's wait for your patch.

If you need any help from me to finish or test your patch, I will be happy
to do it.

Thanks,
-Geliang

>
> Cheers,
>
> Paolo
>
