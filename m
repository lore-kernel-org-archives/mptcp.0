Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DF72
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:56:38 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2871275pjx.1
        for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 20:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7xn2ruMiSCrIaA2iJOASqWY/7Ueso4/rKFKl2RWwMQ=;
        b=EaV73SjUbSsq0mdPSBtIl/QpIHoCmJp0cIXmBd10CD+ohS0bk2KmKJb1f6/ZKU4r6a
         dVccvysC0xDj5JhsUMJBO2jw/eImTzrmv2zaY7r9BdZPWU/gWBQQANrxHnJPWwAKp8pj
         Eg/5c1O57ZKQuHkp+nNKP7WsHOwutcm7vPTfiurf29gJcmBpY+UC1zyDIuYksLyxkp89
         m/K4Lof9OTm6LHVQhrhBGN2jYh5qrA2aylOOoxVkHXiYCxzAXn4wY6ZbhesNLORm3bQL
         C1sz1v24PMV+CcuNNPgROMcdPehdywjsQ33DV3zORadwraYecjVON5PMh3COCKLjV90v
         u6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7xn2ruMiSCrIaA2iJOASqWY/7Ueso4/rKFKl2RWwMQ=;
        b=udJ3gw8/cLyDNM8mhM1Bryem8TaNPWq3+K2CxIZBZCPozVWyGhNFPqVwrB3XitWxFB
         06unbyvv6hOcGccH1uVAwhNAWkqCo/xVDj2aurc21wwi0dAWgBrYNybaLvJTy6Nuogjl
         QA2LxFgb5ic7yHVb+OwZyc6K6G+8Vnal+mKNsOHqwsxfT/glDIu2JIjnRCE1qWNKNc1g
         /jcuSJpySeAZtnbe45CoveQQKZ+qvENUa5cZtruFLmOq4nfCY77zLZ3wEs9KG5iU5WmF
         8Mr7CbSLFQjd7LxbMX3uyzqz7KmBB5VvRXi34aj9qdYtgj9jm48wAGtV5LROqmc3/nmn
         cm+A==
X-Gm-Message-State: AOAM531+irc1tuDBhRlVqEXjBf1y4dIXEoV5smaH6kC4Z2xKB4AzG5Xo
	/VUOuy/G6VvPI0t67URjovkFZpA1xwi+cF/OVxIEU77EQsIHBw==
X-Google-Smtp-Source: ABdhPJyRqPD+7Guhg+XsQ7fi0Q5ZzuXCArnAvhxTBOi2LFJohyDG1egL7k1KQa+k0t0h8dk+fOcAB3SJ7gj0mIcsDN8=
X-Received: by 2002:a17:902:6bc7:b029:129:20c4:1c33 with SMTP id
 m7-20020a1709026bc7b029012920c41c33mr6413578plt.52.1626234998028; Tue, 13 Jul
 2021 20:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
 <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
 <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com>
 <ce51fdd8-f261-a17-ce9e-362b8712cc55@linux.intel.com> <CA+WQbwv_dpYt6aKAA4g-pV2HYDKM5Y4G_K-nY31ZLLLwkpLCHA@mail.gmail.com>
 <e53ce4a6-d4a2-1248-9541-8b3c643e939c@linux.intel.com>
In-Reply-To: <e53ce4a6-d4a2-1248-9541-8b3c643e939c@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 14 Jul 2021 11:56:26 +0800
Message-ID: <CA+WQbwvjdvHiRXefXu-4Y+9QvXcY85LwsTh=PVeyRQEX2X6CzA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 3/8] mptcp: send out MP_FAIL when
 data checksum fail
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B47=
=E6=9C=8814=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:35=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Tue, 13 Jul 2021, Geliang Tang wrote:
>
> > Hi Mat,
> >
> > Sorry for late response on this.
> >
> > Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=
=B47=E6=9C=888=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:20=E5=86=99=
=E9=81=93=EF=BC=9A
> >>
> >> On Mon, 28 Jun 2021, Geliang Tang wrote:
> >>
> >>> When a bad checksum is detected, send out the MP_FAIL option.
> >>>
> >>> When multiple subflows are in use, close the affected subflow with a =
RST
> >>> that includes an MP_FAIL option.
> >>>
> >>> When a single subfow is in use, send back an MP_FAIL option on the
> >>> subflow-level ACK. And the receiver of this MP_FAIL respond with an
> >>> MP_FAIL in the reverse direction.
> >>>
> >>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> >>> ---
> >>> net/mptcp/pm.c       | 10 ++++++++++
> >>> net/mptcp/protocol.h | 14 ++++++++++++++
> >>> net/mptcp/subflow.c  | 18 ++++++++++++++++++
> >>> 3 files changed, 42 insertions(+)
> >>>
> >>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >>> index d4c19420194a..c34c9c0b2fa5 100644
> >>> --- a/net/mptcp/pm.c
> >>> +++ b/net/mptcp/pm.c
> >>> @@ -250,8 +250,18 @@ void mptcp_pm_mp_prio_received(struct sock *sk, =
u8 bkup)
> >>> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> >>> {
> >>>       struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk)=
;
> >>> +     struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >>>
> >>>       pr_debug("map_seq=3D%llu fail_seq=3D%llu", subflow->map_seq, fa=
il_seq);
> >>> +
> >>> +     if (!msk->pm.subflows) {
> >>
> >> The pm.lock isn't held so it's not safe to access pm.subflows
> >>
> >> I don't think it's sufficient to read pm.subflows with the lock or add
> >> READ_ONCE/WRITE_ONCE, since that would still allow race conditions wit=
h
> >> the msk. To handle fallback when receiving MP_FAIL I think the
> >> sock_owned_by_user() checks and delegated callback (similar to
> >> mptcp_subflow_process_delegated()) may be needed.
> >>
> >
> > I think it's better to use the below mptcp_has_another_subflow() functi=
on
> > here instead of using msk->pm.subflows to check the single subflow case=
.
> >
>
> Yes, that sounds good.
>
> >>> +             if (!subflow->mp_fail_need_echo) {
> >>> +                     subflow->send_mp_fail =3D 1;
> >>> +                     subflow->fail_seq =3D fail_seq;
> >>
> >> Echoing the fail_seq back doesn't seem correct, from the RFC it seems =
like
> >> this side should send a sequence number for the opposite data directio=
n?
> >> Do you agree?
> >
> > So we should use 'subflow->fail_seq =3D subflow->map_seq;' here?
>
> I think so - but I'm concerned about the possibility of out-of-order data
> and checking for single- or multiple-subflow cases. I need to look at the
> RFC some more to tell for sure.
>
> >
> >>
> >>> +             } else {
> >>> +                     subflow->mp_fail_need_echo =3D 0;
> >>> +             }
> >>> +     }
> >>> }
> >>>
> >>> /* path manager helpers */
> >>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> >>> index 8e050575a2d9..7a49454c77a6 100644
> >>> --- a/net/mptcp/protocol.h
> >>> +++ b/net/mptcp/protocol.h
> >>> @@ -422,6 +422,7 @@ struct mptcp_subflow_context {
> >>>               backup : 1,
> >>>               send_mp_prio : 1,
> >>>               send_mp_fail : 1,
> >>> +             mp_fail_need_echo : 1,
> >>
> >> I think mp_fail_expect_echo would be a more accurate name.
> >
> > Updated in v4.
> >
>
> Ok.
>
> >>
> >>>               rx_eof : 1,
> >>>               can_ack : 1,        /* only after processing the remote=
 a key */
> >>>               disposable : 1;     /* ctx can be free at ulp release t=
ime */
> >>> @@ -594,6 +595,19 @@ static inline void mptcp_subflow_tcp_fallback(st=
ruct sock *sk,
> >>>       inet_csk(sk)->icsk_af_ops =3D ctx->icsk_af_ops;
> >>> }
> >>>
> >>> +static inline bool mptcp_has_another_subflow_established(struct sock=
 *ssk)
> >>> +{
> >>> +     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk=
), *tmp;
> >>> +     struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >>> +
> >>> +     mptcp_for_each_subflow(msk, tmp) {
> >>> +             if (tmp->fully_established && tmp !=3D subflow)
> >>
> >> Why check tmp->fully_established here?
> >
> > I'll drop tmp->fully_established, and rename this function
> > mptcp_has_another_subflow to check whether there's a single subflow.
>
> Sounds good.
>
> >
> >
> > In my test, this MP_FAIL patchset only works in the multiple subflows c=
ase.
> > The receiver detected the bad checksum, sent RST + MP_FAIL to close thi=
s
> > subflow and discard the data with the bad checksum. Then the sender wil=
l
> > retransmit a new data with good checksum from other subflow. And the
> > receiver can resemble the whole data successfully.
> >
> > But the single subflow case dosen't work. I don't know how the new data
> > can be retransmitted from the sender side when it fallback to regular T=
CP.
> > So I'm not sure how to implement the single subflow case.
> >
> > Could you please give me some suggestions?
>
> Yes, the multiple subflow case is the simpler one this time. We can throw
> away the affected subflow and recover using the others.
>
> Since the non-contiguous, single subflow case has to close the subflow,
> that's more like the "easier" case.
>
> So, it's the infinite mapping case that's tricky. Have you looked at the
> multipath-tcp.org code? The important part seems to be using the
> information in the infinite mapping to determine what data to keep or
> throw away before beginning "fallback" behavior. I can look at the
> infinite mapping information in the RFC and see how that fits with our
> implementation tomorrow.
>

Thanks for your help.

I want to split this patchset into two part, "MP_FAIL support" and "the
infinite mapping support".

In the MP_FAIL part, just deal with the multiple subflows case, the easier
case. Include the MP_FAIL sending and MP_FAIL receiving code in the part.
This part had been implemented and tested. I'll send a v4 for it.

And put the single subflow case into the new "infinite mapping" part. I'll
add a new ticket on github to trace it, and send a RFC version for it later=
.
It seems that there's still a lot of work to do in this part.

Do you agree?

-Geliang

> - Mat
>
>
> >>
> >>> +                     return true;
> >>> +     }
> >>> +
> >>> +     return false;
> >>> +}
> >>> +
> >>> void __init mptcp_proto_init(void);
> >>> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >>> int __init mptcp_proto_v6_init(void);
> >>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> >>> index 0b5d4a3eadcd..46302208c474 100644
> >>> --- a/net/mptcp/subflow.c
> >>> +++ b/net/mptcp/subflow.c
> >>> @@ -913,6 +913,8 @@ static enum mapping_status validate_data_csum(str=
uct sock *ssk, struct sk_buff *
> >>>       csum =3D csum_partial(&header, sizeof(header), subflow->map_dat=
a_csum);
> >>>       if (unlikely(csum_fold(csum))) {
> >>>               MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> >>> +             subflow->send_mp_fail =3D 1;
> >>> +             subflow->fail_seq =3D subflow->map_seq;
> >>>               return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUM=
MY;
> >>>       }
> >>>
> >>> @@ -1160,6 +1162,22 @@ static bool subflow_check_data_avail(struct so=
ck *ssk)
> >>>
> >>> fallback:
> >>>       /* RFC 8684 section 3.7. */
> >>> +     if (subflow->send_mp_fail) {
> >>> +             if (mptcp_has_another_subflow_established(ssk)) {
> >>> +                     mptcp_subflow_reset(ssk);
> >>> +                     while ((skb =3D skb_peek(&ssk->sk_receive_queue=
)))
> >>> +                             sk_eat_skb(ssk, skb);
> >>> +                     WRITE_ONCE(subflow->data_avail, 0);
> >>> +                     return true;
> >>> +             }
> >>> +
> >>> +             if (!msk->pm.subflows) {
> >>> +                     subflow->mp_fail_need_echo =3D 1;
> >>> +                     WRITE_ONCE(subflow->data_avail, 0);
> >>> +                     return true;
> >>> +             }
> >>> +     }
> >>> +
> >>>       if (subflow->mp_join || subflow->fully_established) {
> >>>               /* fatal protocol error, close the socket.
> >>>                * subflow_error_report() will introduce the appropriat=
e barriers
> >>> --
> >>> 2.31.1
>
> --
> Mat Martineau
> Intel
