Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0D168
	for <mptcp@lists.linux.dev>; Fri,  2 Jul 2021 08:06:24 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id e33so8829207pgm.3
        for <mptcp@lists.linux.dev>; Fri, 02 Jul 2021 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=86E2hF9mHaPqAD2tDadH6ceKWJEwIpy+Y27hV98UjrU=;
        b=OeFbBtV4dSH9/se7zUamuuKFDEsWuXzcn4wEGAqBuVJG0wiJ1kSSc9d9NMOWh9Md0j
         Wp01R/QKhrfvehDdGLhRkDvKhtFoo9BdDH0Kbv6Ap+/9iByucrcy+mYfS4PVz4h6DLvX
         nSGgBcx5JwKFC9pKmaJvc02bSZO0eJSMhUdkcR0Gj4LKoI1vgnncC3tPblXuyaAbwzgr
         IfmfRpE7Rp9HXv43puORh72U7iHt9CP5AYMnO0Eg6kmm0jXMGCIal2+DrVOveNFej2ZP
         4FIfvwurXElT3rTATAmmXkVnD3kI12J4J5wU4YEX/FrzzqVVncpUnheQhLtYKjBjXejD
         VW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=86E2hF9mHaPqAD2tDadH6ceKWJEwIpy+Y27hV98UjrU=;
        b=HwRaCnxGhIbp9+ea300jEnjwjFOxpGJ3FIx+m/mdne2B8ASI2Pzsmwb7PWBnfZhUlU
         DxK2vhuTQL0UGlX/RlrVXWTLEJ3eUFYZUJHY0eR7xZveeaDYm0e5dpJij1tSjgdMf+rE
         zAVM/bq8Ki5ytRsDcLjPNESRiBesNJrojaEP7ZFxDHG9X9onznAK/lrQKFRnKIZIzRfj
         IltUoMswQYpSF7r+GQkGGnGFPs37pJ2rjWCAm7NFj/ACQGTNTPj/49EWdRlorhmlc+gE
         3o6a6gxqKoI7/iidbm43nukkynLKod4JnKtdWcqt8zDP4F+5ov6lrb1NhTL5zPnbi+Ns
         hpfg==
X-Gm-Message-State: AOAM533lO8LTLgDS7rpjd9k5j2MKmkvzZzBQr4dkCtBaDAAXyEEQTEW+
	wDuzv8P3BeP7RYAsP/BMMEAVQw8CnQp7e0dx8UA=
X-Google-Smtp-Source: ABdhPJzgm0Ad1mKWp3oznOhVSPzIEU3z2A40ANllZ4g6YnAqoWHas9/spdZF8UlZeTIy/EWp39K1b1weGm6m4F9WXx8=
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr2332910pgm.289.1625213184173;
 Fri, 02 Jul 2021 01:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn>
 <1625048653-6825-5-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwsGFZsQYaigbQJ7nC31RbUdU70Ue6f1i15XzSO_wrMFDA@mail.gmail.com> <6771e9d0-102a-a261-fe97-b9104d432683@chinatelecom.cn>
In-Reply-To: <6771e9d0-102a-a261-fe97-b9104d432683@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 2 Jul 2021 16:06:13 +0800
Message-ID: <CA+WQbwvF_3FMVWjFD4=iOA87Quh6rGZpJ8htMYsexBCcGtNiAQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] mptcp: remove some double-check
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:22=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Geliang,
>
> I think these double check is unnecessary. the reason to keep them is?
> I think keep "!mptcp_pm_should_add_signal(msk)" you said in v6 is reasona=
ble,
> It can avoid to get pm.lock in process of sending packets. But the other =
double
> check is useless.

The length re-check is for the no-spin-lock optimization too.

These code is no harm for yours, why can't you keep it there. :)

-Geliang


>
> On 2021/6/30 18:57, Geliang Tang wrote:
> > As I said in v6, I prefer to keep these double check code, no need to
> > remove them.
> >
> > Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8830=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:24=E5=86=99=E9=81=93=
=EF=BC=9A
> >>
> >> remove some double-check in mptcp_established_options_add_addr() and
> >> mptcp_established_options_rm_addr()
> >>
> >> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> >> ---
> >>  net/mptcp/options.c  | 14 ++------------
> >>  net/mptcp/pm.c       | 21 +++++++++++----------
> >>  net/mptcp/protocol.h |  4 ++--
> >>  3 files changed, 15 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >> index cceff0a..0711fc1 100644
> >> --- a/net/mptcp/options.c
> >> +++ b/net/mptcp/options.c
> >> @@ -659,7 +659,7 @@ static bool mptcp_established_options_add_addr(str=
uct sock *sk, struct sk_buff *
> >>         int len =3D 0;
> >>
> >>         if (!mptcp_pm_should_add_signal(msk) ||
> >> -           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, o=
pts, &add_addr))
> >> +           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, o=
pts, &add_addr, &len))
> >>                 return false;
> >>
> >>         if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> >> @@ -674,10 +674,6 @@ static bool mptcp_established_options_add_addr(st=
ruct sock *sk, struct sk_buff *
> >>                 drop_other_suboptions =3D true;
> >>         }
> >>
> >> -       len =3D mptcp_add_addr_len(msk, opts);
> >> -       if (remaining < len)
> >> -               return false;
> >> -
> >>         *size =3D len;
> >>         if (drop_other_suboptions)
> >>                 *size -=3D opt_size;
> >> @@ -707,13 +703,7 @@ static bool mptcp_established_options_rm_addr(str=
uct sock *sk,
> >>         int i, len;
> >>
> >>         if (!mptcp_pm_should_rm_signal(msk) ||
> >> -           !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
> >> -               return false;
> >> -
> >> -       len =3D mptcp_rm_addr_len(&rm_list);
> >> -       if (len < 0)
> >> -               return false;
> >> -       if (remaining < len)
> >> +           !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, &len))=
)
> >>                 return false;
> >>
> >>         *size =3D len;
> >> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >> index 9c5b15c..2311ea5 100644
> >> --- a/net/mptcp/pm.c
> >> +++ b/net/mptcp/pm.c
> >> @@ -255,9 +255,9 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8=
 bkup)
> >>
> >>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff =
*skb,
> >>                               unsigned int opt_size, unsigned int rema=
ining,
> >> -                             struct mptcp_out_options *opts,  u8 *add=
_addr)
> >> +                             struct mptcp_out_options *opts,  u8 *add=
_addr, int *len)
> >>  {
> >> -       int ret =3D false, len;
> >> +       int ret =3D false;
> >>
> >>         spin_lock_bh(&msk->pm.lock);
> >>
> >> @@ -276,8 +276,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *m=
sk, struct sk_buff *skb,
> >>                 remaining +=3D opt_size;
> >>         }
> >>
> >> -       len =3D mptcp_add_addr_len(msk, opts);
> >> -       if (remaining < len)
> >> +       *len =3D mptcp_add_addr_len(msk, opts);
> >> +       if (remaining < *len)
> >>                 goto out_unlock;
> >>
> >>         if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
> >> @@ -287,17 +287,18 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock =
*msk, struct sk_buff *skb,
> >>
> >>         ret =3D true;
> >>  out_unlock:
> >> +       spin_unlock_bh(&msk->pm.lock);
> >> +
> >>         if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should=
_add_signal_addr(msk)))
> >>                 mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK=
);
> >>
> >> -       spin_unlock_bh(&msk->pm.lock);
> >>         return ret;
> >>  }
> >>
> >>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> >> -                            struct mptcp_rm_list *rm_list)
> >> +                            struct mptcp_rm_list *rm_list, int *len)
> >>  {
> >> -       int ret =3D false, len;
> >> +       int ret =3D false;
> >>         u8 rm_addr;
> >>
> >>         spin_lock_bh(&msk->pm.lock);
> >> @@ -307,12 +308,12 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *=
msk, unsigned int remaining,
> >>                 goto out_unlock;
> >>
> >>         rm_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
> >> -       len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
> >> -       if (len < 0) {
> >> +       *len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
> >> +       if (*len < 0) {
> >>                 WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> >>                 goto out_unlock;
> >>         }
> >> -       if (remaining < len)
> >> +       if (remaining < *len)
> >>                 goto out_unlock;
> >>
> >>         *rm_list =3D msk->pm.rm_list_tx;
> >> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> >> index caa4a60..5d7c9d7 100644
> >> --- a/net/mptcp/protocol.h
> >> +++ b/net/mptcp/protocol.h
> >> @@ -770,9 +770,9 @@ static inline int mptcp_rm_addr_len(const struct m=
ptcp_rm_list *rm_list)
> >>
> >>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff =
*skb,
> >>                               unsigned int opt_size, unsigned int rema=
ining,
> >> -                             struct mptcp_out_options *opts,  u8 *add=
_addr);
> >> +                             struct mptcp_out_options *opts,  u8 *add=
_addr, int *len);
> >>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> >> -                            struct mptcp_rm_list *rm_list);
> >> +                            struct mptcp_rm_list *rm_list, int *len);
> >>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common =
*skc);
> >>
> >>  void __init mptcp_pm_nl_init(void);
> >> --
> >> 1.8.3.1
> >>
> >>
> >
>
> --
> Li YongLong
