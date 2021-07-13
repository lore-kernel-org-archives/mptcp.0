Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614170
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 12:44:37 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id 37so21524387pgq.0
        for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/mwAld4vFk0XvTjnVX/jTwe3w3M1Vxoc41DlZR0oN98=;
        b=i2wbbBtMzKttx6qiFRWw0q6yCejLVVaCGNDv8lvukhqaU5qpFSlxDGMoblycUal5B4
         NuUaJtljkr90eRzW6EJZOlWtYe2181uQTyjMQmwQ5NpmOD+bdmw6Yxfx6ZNQ/Dbrb/tu
         Ddy/JycYxx+Ce2MXDKQYtoVTbLCwFH8oZK0PwyWo4KhyxA3HW2WuGH4xJlDKnU3A28aU
         Qe27qWxbBKc02IuxeNxwj07Ke3jpzqDOjtKgHreDGjc3bprhNZzxU9b3TXwI1KvVG1N2
         UAgTHQKuZMH/H1lBmL5bRuZG2L3isVgZgWFz+uYLk8sgwgruQwSc6w2aRLBJqRGVKR+z
         BqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/mwAld4vFk0XvTjnVX/jTwe3w3M1Vxoc41DlZR0oN98=;
        b=okAArmkSHxa5pSb7h/BW3vFoGnN+lwagkPoayheGo8ewjw/CM+A6mflubCi0eFV5h6
         HhCiQuGM6m3TyvSD5so2ih6KuOGMRLZGwMKY78N+wyrW1tUNmwj90Ec4Sootee2JtgAN
         Vzb2OfazlbhX+aNY0k4uYIyuu2EfFSAQJm53ZIo8tZVII22Rk1zXSVM4/dSWv9s9w/0s
         0tMPbujZ2PI3TtzNS1P4f5aAIBhEVQKRvmXyB1Bc+eMcXXi+PtfriLgukEfxtekQTBK8
         UWShXT4W/FloWYCf7eHeEL5B7dUgjhhOPOZCflmsOZS5JNGmvUUWLW1uaYH5/lvI6ir2
         PiOA==
X-Gm-Message-State: AOAM532CtK43ibuT35g/gJHwBP44g3ch09v0a37E4VgUjG85mzbXGJkZ
	+5xmJQ830+vlLSevY+orrYbXItdblREJ2m2mhiQ=
X-Google-Smtp-Source: ABdhPJz2nVhtRdKA7U/f47RQ40cP3e2s8BlHCOliPwmKs6HQNHV6K5+U5AbiRssmV1Sxa2QNoMNfpKqT87INEAXnJ1o=
X-Received: by 2002:a62:3344:0:b029:25e:a0a8:1c51 with SMTP id
 z65-20020a6233440000b029025ea0a81c51mr4395109pfz.58.1626180277330; Tue, 13
 Jul 2021 05:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com>
 <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
 <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com>
 <ce51fdd8-f261-a17-ce9e-362b8712cc55@linux.intel.com>
In-Reply-To: <ce51fdd8-f261-a17-ce9e-362b8712cc55@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 13 Jul 2021 20:44:26 +0800
Message-ID: <CA+WQbwv_dpYt6aKAA4g-pV2HYDKM5Y4G_K-nY31ZLLLwkpLCHA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 3/8] mptcp: send out MP_FAIL when
 data checksum fail
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Sorry for late response on this.

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B47=
=E6=9C=888=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:20=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On Mon, 28 Jun 2021, Geliang Tang wrote:
>
> > When a bad checksum is detected, send out the MP_FAIL option.
> >
> > When multiple subflows are in use, close the affected subflow with a RS=
T
> > that includes an MP_FAIL option.
> >
> > When a single subfow is in use, send back an MP_FAIL option on the
> > subflow-level ACK. And the receiver of this MP_FAIL respond with an
> > MP_FAIL in the reverse direction.
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> > net/mptcp/pm.c       | 10 ++++++++++
> > net/mptcp/protocol.h | 14 ++++++++++++++
> > net/mptcp/subflow.c  | 18 ++++++++++++++++++
> > 3 files changed, 42 insertions(+)
> >
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index d4c19420194a..c34c9c0b2fa5 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -250,8 +250,18 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8=
 bkup)
> > void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
> > {
> >       struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> > +     struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >
> >       pr_debug("map_seq=3D%llu fail_seq=3D%llu", subflow->map_seq, fail=
_seq);
> > +
> > +     if (!msk->pm.subflows) {
>
> The pm.lock isn't held so it's not safe to access pm.subflows
>
> I don't think it's sufficient to read pm.subflows with the lock or add
> READ_ONCE/WRITE_ONCE, since that would still allow race conditions with
> the msk. To handle fallback when receiving MP_FAIL I think the
> sock_owned_by_user() checks and delegated callback (similar to
> mptcp_subflow_process_delegated()) may be needed.
>

I think it's better to use the below mptcp_has_another_subflow() function
here instead of using msk->pm.subflows to check the single subflow case.

> > +             if (!subflow->mp_fail_need_echo) {
> > +                     subflow->send_mp_fail =3D 1;
> > +                     subflow->fail_seq =3D fail_seq;
>
> Echoing the fail_seq back doesn't seem correct, from the RFC it seems lik=
e
> this side should send a sequence number for the opposite data direction?
> Do you agree?

So we should use 'subflow->fail_seq =3D subflow->map_seq;' here?

>
> > +             } else {
> > +                     subflow->mp_fail_need_echo =3D 0;
> > +             }
> > +     }
> > }
> >
> > /* path manager helpers */
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 8e050575a2d9..7a49454c77a6 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -422,6 +422,7 @@ struct mptcp_subflow_context {
> >               backup : 1,
> >               send_mp_prio : 1,
> >               send_mp_fail : 1,
> > +             mp_fail_need_echo : 1,
>
> I think mp_fail_expect_echo would be a more accurate name.

Updated in v4.

>
> >               rx_eof : 1,
> >               can_ack : 1,        /* only after processing the remote a=
 key */
> >               disposable : 1;     /* ctx can be free at ulp release tim=
e */
> > @@ -594,6 +595,19 @@ static inline void mptcp_subflow_tcp_fallback(stru=
ct sock *sk,
> >       inet_csk(sk)->icsk_af_ops =3D ctx->icsk_af_ops;
> > }
> >
> > +static inline bool mptcp_has_another_subflow_established(struct sock *=
ssk)
> > +{
> > +     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk),=
 *tmp;
> > +     struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> > +
> > +     mptcp_for_each_subflow(msk, tmp) {
> > +             if (tmp->fully_established && tmp !=3D subflow)
>
> Why check tmp->fully_established here?

I'll drop tmp->fully_established, and rename this function
mptcp_has_another_subflow to check whether there's a single subflow.


In my test, this MP_FAIL patchset only works in the multiple subflows case.
The receiver detected the bad checksum, sent RST + MP_FAIL to close this
subflow and discard the data with the bad checksum. Then the sender will
retransmit a new data with good checksum from other subflow. And the
receiver can resemble the whole data successfully.

But the single subflow case dosen't work. I don't know how the new data
can be retransmitted from the sender side when it fallback to regular TCP.
So I'm not sure how to implement the single subflow case.

Could you please give me some suggestions?

Thanks,
-Geliang


>
>
> - Mat
>
>
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > void __init mptcp_proto_init(void);
> > #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > int __init mptcp_proto_v6_init(void);
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 0b5d4a3eadcd..46302208c474 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -913,6 +913,8 @@ static enum mapping_status validate_data_csum(struc=
t sock *ssk, struct sk_buff *
> >       csum =3D csum_partial(&header, sizeof(header), subflow->map_data_=
csum);
> >       if (unlikely(csum_fold(csum))) {
> >               MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> > +             subflow->send_mp_fail =3D 1;
> > +             subflow->fail_seq =3D subflow->map_seq;
> >               return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY=
;
> >       }
> >
> > @@ -1160,6 +1162,22 @@ static bool subflow_check_data_avail(struct sock=
 *ssk)
> >
> > fallback:
> >       /* RFC 8684 section 3.7. */
> > +     if (subflow->send_mp_fail) {
> > +             if (mptcp_has_another_subflow_established(ssk)) {
> > +                     mptcp_subflow_reset(ssk);
> > +                     while ((skb =3D skb_peek(&ssk->sk_receive_queue))=
)
> > +                             sk_eat_skb(ssk, skb);
> > +                     WRITE_ONCE(subflow->data_avail, 0);
> > +                     return true;
> > +             }
> > +
> > +             if (!msk->pm.subflows) {
> > +                     subflow->mp_fail_need_echo =3D 1;
> > +                     WRITE_ONCE(subflow->data_avail, 0);
> > +                     return true;
> > +             }
> > +     }
> > +
> >       if (subflow->mp_join || subflow->fully_established) {
> >               /* fatal protocol error, close the socket.
> >                * subflow_error_report() will introduce the appropriate =
barriers
> > --
> > 2.31.1
> >
> >
> >
>
> --
> Mat Martineau
> Intel
