Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73E6D0E
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 10:33:53 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id t9so7242276pgn.4
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+0e2TzY9S7WXa2dkKNtpGepLG/F1QgLFF2R8nOY80W4=;
        b=BMKLBcneIq95a9l3uMF3kqZ6SOMjDjLKEHX7a1Rli/Z0P6radMcAoa8rGb6ULhw8u6
         rcGxSUFAldvA4J85NPnjWM43BQ6OEAgLxqs7PYTbwVErFSWyo5bDdZzsOUWjtaV8tRB0
         mfQElzxbURSYSdZHhycnkQ3HyjbK3sKErrNrvqOHrsd6dKCg9mylLOuZ+fbPzxCKTY7O
         1vAkDIS6ljy7DV7Joyoz/rTkpk5TXL7ksZih+IM7ffv1JuaBEzVUSp45bs5vVoXUPzAN
         VE+GnpEmEVnhGM8pa+pOiWLsHZAMAqDsIphZp+boEwUGzfDcx5XUa+bZvCbffkhjpFue
         cppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+0e2TzY9S7WXa2dkKNtpGepLG/F1QgLFF2R8nOY80W4=;
        b=gES9cptY1fgrcsDp5bGuSbwdZmmbO6alOG0RHEUadHjxEtlm3Kq+N1t5G8zHXDBfQg
         uiUM4dpX3D6DRUVGTv8Tqch75Ch7LbbweqUsLfRZWuCcr17elnedSZyPZnyDxh9e93F7
         QP1Sft51e3Y3Pu+HKWnkXrJTrzdleDOHIcAbrYmgtSNccOTzVvw15ydeMnLFYrLZOOSh
         JMiax9RjX9XEPKSpvTQm8SFMpIy7wabOlVCcfqA2DCrZUe8bzvviY0kFz6igLkIwybYv
         VmstIUuntBcAN7RYyf578uYNQJRDWTZFjpJChwM3FnMoW1yPDQTC5D+RTO2tzH9vq//h
         DJWA==
X-Gm-Message-State: AOAM531sfzpJ4EgjWTAJAQbEX4CKMnoFa8thUsZP6e5lKHTGCtTcUH6G
	9LAyPqsRpM/ai85DrUcIdOg4ePOruXaxvwDxg1k=
X-Google-Smtp-Source: ABdhPJzvblp1AJmkeyCsfxLPgijnqRh2fvYdPDOk0JI8Ti4xwzf9aFFrpBNKWObK2KXgRwbF+pJZj2v4uodPtNRHFBY=
X-Received: by 2002:aa7:8d01:0:b029:2f0:88da:1821 with SMTP id
 j1-20020aa78d010000b02902f088da1821mr9716392pfe.67.1624617233192; Fri, 25 Jun
 2021 03:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn> <1624337135-149084-3-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1624337135-149084-3-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 25 Jun 2021 18:33:42 +0800
Message-ID: <CA+WQbws7CrpFct1pBVQ3EBVvMO--6QVxEvc+nJ8tL8BWDiiTfA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mptcp: make MPTCP_ADD_ADDR_SIGNAL and
 MPTCP_ADD_ADDR_ECHO separate
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:45=E5=86=99=E9=81=93=EF=BC=
=9A
>
> MPTCP_ADD_ADDR_SIGNAL only for action of sending ADD_ADDR
> MPTCP_ADD_ADDR_ECHO only for action of sending echo ADD_ADDR
> add a mptcp_addr_info in struct mptcp_out_options for echo ADD_ADDR
>
> to prepare for the next patch.
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  include/net/mptcp.h    |  1 +
>  net/mptcp/pm.c         | 13 ++++++++-----
>  net/mptcp/pm_netlink.c |  4 ++--
>  net/mptcp/protocol.h   |  6 ++++++
>  4 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index d61bbbf..637e90b 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -62,6 +62,7 @@ struct mptcp_out_options {
>         u64 rcvr_key;
>         u64 ahmac;
>         struct mptcp_addr_info addr;
> +       struct mptcp_addr_info remote;
>         struct mptcp_rm_list rm_list;
>         u8 join_id;
>         u8 backup;

This new struct member 'remote' isn't used in this patch, I think it's bett=
er
to add it in the next patch. So move this trunk into patch 3/4 "mptcp: buil=
d
ADD_ADDR/echo-ADD_ADDR option according pm.add_signal".


> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6c427c8..107a5a2 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -18,7 +18,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>  {
>         u8 add_addr =3D READ_ONCE(msk->pm.addr_signal);
>
> -       pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
> +       pr_debug("msk=3D%p, local_id=3D%d, echo:%d", msk, addr->id, echo)=
;
>
>         lockdep_assert_held(&msk->pm.lock);
>
> @@ -27,10 +27,13 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>                 return -EINVAL;
>         }
>
> -       msk->pm.local =3D *addr;
> -       add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
> -       if (echo)
> +       if (echo) {
> +               msk->pm.remote =3D *addr;
>                 add_addr |=3D BIT(MPTCP_ADD_ADDR_ECHO);
> +       } else {
> +               msk->pm.local =3D *addr;
> +               add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
> +       }
>         if (addr->family =3D=3D AF_INET6)
>                 add_addr |=3D BIT(MPTCP_ADD_ADDR_IPV6);
>         if (addr->port)
> @@ -214,7 +217,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
>
>  void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
>  {
> -       if (!mptcp_pm_should_add_signal(msk))
> +       if (!mptcp_pm_should_add_signal_echo(msk))
>                 return;
>
>         mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d4732a4..0f302d2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -317,14 +317,14 @@ static void mptcp_pm_add_timer(struct timer_list *t=
imer)
>         if (!entry->addr.id)
>                 return;
>
> -       if (mptcp_pm_should_add_signal(msk)) {
> +       if (mptcp_pm_should_add_signal_addr(msk)) {
>                 sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
>                 goto out;
>         }
>
>         spin_lock_bh(&msk->pm.lock);
>
> -       if (!mptcp_pm_should_add_signal(msk)) {
> +       if (!mptcp_pm_should_add_signal_addr(msk)) {
>                 pr_debug("retransmit ADD_ADDR id=3D%d", entry->addr.id);
>                 mptcp_pm_announce_addr(msk, &entry->addr, false);
>                 mptcp_pm_add_addr_send_ack(msk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 160c2ab..a0b0ec0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -708,6 +708,12 @@ void mptcp_event(enum mptcp_event_type type, const s=
truct mptcp_sock *msk,
>
>  static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
>  {
> +       return READ_ONCE(msk->pm.addr_signal) &
> +               (BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
> +}
> +
> +static inline bool mptcp_pm_should_add_signal_addr(struct mptcp_sock *ms=
k)
> +{
>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL=
);
>  }
>
> --
> 1.8.3.1
>
