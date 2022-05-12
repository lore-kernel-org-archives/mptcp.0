Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7318F
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 02:35:57 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so6544562pjb.5
        for <mptcp@lists.linux.dev>; Wed, 11 May 2022 19:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1NHbeJwSxy/KE7ziMbFRBwVPTapn0SsRrilUgGMvWCc=;
        b=dlZLQWNA9SaSxVWqUvTWiQHZ6alzG31JeKEl1OGhMKaQvo7Z23YnmSvwc7oqzIx8bl
         cK/UKKKz+y0rGsNp73pv8/pKs/GhsUGzcGQcQn8GXKaPyC4FqietO0WB+XypsXO0R934
         zDKj352neNHP+LH0ps3Dpk/rF8HycxmfQhnsgiBcOuiNYulNI8dx3iHwfEzN6dsEkucS
         k5a6e2IP15H6f0yTxEEVkVuvMZa31z7ufjbNX5vQ+huuyPNPGBpys+zjyOm8ZLnEJP4g
         rJ3ioyuqAk27SA7hpkyei1iIgW+GBIctlrc7MHfSbIWv/aDb2CMXGSuYfWqjQIpResvM
         mEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1NHbeJwSxy/KE7ziMbFRBwVPTapn0SsRrilUgGMvWCc=;
        b=Gs4H1xw5XFkvbxu8F03r+eVtVZyGG2oJiUJYtOlHfeDz8P3k+VQVLM3hIFiYawtnJs
         rxeyODSP8jZbSXoIXKm4Aufmd85SdKICkVtbiX8celVYPFToLHvCYoJmewju38MQyuWB
         X+3yP9aAo3gn4TREQg6VGcjvnNbPIzfUCS3nPhB4Eg3TIKWu+KvA0sY1MC6HsKZgVPf9
         2w0a2QjMPnRSb7RKpqCSKJX1cNRmYE9MTpq14P5I2pNmubUS9gQaRv7kR5Vj9uR0nIap
         KzviYnyz9Mj356ot6v95yYJEF2yefn4/IY/Tbu7+poqGHqR3jgPYms50c1kzyl8vQ9Yp
         JeiA==
X-Gm-Message-State: AOAM531+hkbgaX0HePyqNoJx7AW2SaSawSFlWKNT2GmJ1ftiqhXKSzRF
	BImUr+FqiMFQststeHU0WuhK2bl+XRtLA5fr1ug=
X-Google-Smtp-Source: ABdhPJwDHVbp6Kp87ppbub8wv9MLQ+JLBfAnNPgVPrg4KOsqQKAgYMNrspkEo2xsobCs0s/ro+cf2i4svjOY8CO96eA=
X-Received: by 2002:a17:902:8203:b0:15f:4423:6e9c with SMTP id
 x3-20020a170902820300b0015f44236e9cmr807044pln.25.1652322956854; Wed, 11 May
 2022 19:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <5e05ab9275671ea3018eaa02028197817715de65.1652275377.git.pabeni@redhat.com>
 <19d1ced2-b6f7-9e69-b152-6d52c21e0ac@linux.intel.com>
In-Reply-To: <19d1ced2-b6f7-9e69-b152-6d52c21e0ac@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 12 May 2022 10:35:54 +0800
Message-ID: <CA+WQbwsMB5Eoy6BPoPM6bBq2+ukARRq+1Sxc8L+bq394EQYjFA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] mptcp: stop using the mptcp_has_another_subflow()
 helper
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=B45=
=E6=9C=8812=E6=97=A5=E5=91=A8=E5=9B=9B 08:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 11 May 2022, Paolo Abeni wrote:
>
> > The mentioned helper requires the msk socket lock, and the
> > current callers don't own it nor can't acquire it, so the
> > access is racy.
> >
> > All the current callers are really checking for infinite mapping
> > fallback, and the latter condition is explicitly tracked by
> > the relevant msk variable: we can safely remove the caller usage
> > - and the caller itself.
> >
> > The issue is present since MP_FAIL implementation, but the
> > fix only applies since the infinite fallback support, ence the
> > somewhat unexpected fixes tag.
> >
> > Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> Looks good to me. I wasn't able to reproduce the CI failure.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>

CI reported this failure:

[13:54:03.080] # itx[ ok ] - infirx[fail] got 0 infinite map[s] RX expected=
 1

But it doesn't occur in my test.

Thanks,
-Geliang

>
>
>
> > ---
> > net/mptcp/pm.c       |  2 +-
> > net/mptcp/protocol.h | 13 -------------
> > net/mptcp/subflow.c  |  3 +--
> > 3 files changed, 2 insertions(+), 16 deletions(-)
> >
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 59fdab2d0c27..8ba51120f35b 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -303,7 +303,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64=
 fail_seq)
> >
> >       pr_debug("fail_seq=3D%llu", fail_seq);
> >
> > -     if (mptcp_has_another_subflow(sk) || !READ_ONCE(msk->allow_infini=
te_fallback))
> > +     if (!READ_ONCE(msk->allow_infinite_fallback))
> >               return;
> >
> >       if (!READ_ONCE(subflow->mp_fail_response_expect)) {
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index f98c27300e60..dbb914def5cc 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -661,19 +661,6 @@ static inline void mptcp_subflow_tcp_fallback(stru=
ct sock *sk,
> >       inet_csk(sk)->icsk_af_ops =3D ctx->icsk_af_ops;
> > }
> >
> > -static inline bool mptcp_has_another_subflow(struct sock *ssk)
> > -{
> > -     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk),=
 *tmp;
> > -     struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> > -
> > -     mptcp_for_each_subflow(msk, tmp) {
> > -             if (tmp !=3D subflow)
> > -                     return true;
> > -     }
> > -
> > -     return false;
> > -}
> > -
> > void __init mptcp_proto_init(void);
> > #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > int __init mptcp_proto_v6_init(void);
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index b38a02db924b..550c8fbec54d 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1218,8 +1218,7 @@ static bool subflow_check_data_avail(struct sock =
*ssk)
> >       if (!__mptcp_check_fallback(msk)) {
> >               /* RFC 8684 section 3.7. */
> >               if (subflow->send_mp_fail) {
> > -                     if (mptcp_has_another_subflow(ssk) ||
> > -                         !READ_ONCE(msk->allow_infinite_fallback)) {
> > +                     if (!READ_ONCE(msk->allow_infinite_fallback)) {
> >                               ssk->sk_err =3D EBADMSG;
> >                               tcp_set_state(ssk, TCP_CLOSE);
> >                               subflow->reset_transient =3D 0;
> > --
> > 2.35.3
> >
> >
> >
>
> --
> Mat Martineau
> Intel
>
