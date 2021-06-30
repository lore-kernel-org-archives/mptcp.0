Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55900168
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 10:58:07 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id y4so2057171pfi.9
        for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TveOiGN2D5feECKhWqdDYfZyni2hZ6IGX81YOQEe1o0=;
        b=QWfAeOH+yuOrJFOIPqlh3v5GPawn3+DNkzyprkFwhq5FUv5/kDVnPzFmKbE/fvHj8k
         VoGvRNCR5lRmVZSI0UdEagSMty7706Ucskd9dTIDvp7XcqypYtaq1368zdpvnGkpf/RZ
         SDCHbiv3TPmytavzJp773A42yVFcAcIDkzk8//wkMgxZD9MCxJhNA+MDvaemxu6+z3vV
         B+eqbBEFswVdHvSXlSz+iojWS5ZGvghOJgPbxEILB3kVwypRF8GfamlZXBoZG+9lgOtM
         hoC7rm/9RxbAMgJyrWWTnh4v/7vIrMsl/0X22+mChYjtsIYcOlo2UpxkXFOVLqDAAwK+
         VIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TveOiGN2D5feECKhWqdDYfZyni2hZ6IGX81YOQEe1o0=;
        b=SBx1PltVf3PyzrsZ+b5/Ai/+Q3l0U057q7hY4tVRHTeVAX+Z5sYlQ8SX1FKGDe9aqy
         5VBnM78xhYhz15pkp01kyS77RGWKkQ2IKB6ITZZdzU+1Rb9Tvunj35dE9LO7v6zc5t/L
         tcgKZhjSJ/504lg+orYn5YO7umtenOaGpOSMrb2umehkx+oIgAlZGA6ytGMqvoW9UR3Z
         BBi0fNWBML0ESfg5OrAAcrLWbdHyAVSfcyCOfJ4YK4c4qmr7ZEnr/uyJ+QwQaHf2ejuc
         Im45kqcxauXZMUhAsDZjKvdVGRyxw64MHxdXZfG16B1cCjqU79/b0GyXMI3xKAwAu3sH
         uymg==
X-Gm-Message-State: AOAM532dFYTZi9C0ZxGEmXvIFt2yJALiHQRmLpz9/TSYJf0SE2L3F6tT
	HvXbpms4JzEzOLuohNRzpcxk6Aur4QAIs5xv5sQ=
X-Google-Smtp-Source: ABdhPJzLjcd99asMto8iSKyClqRRbHfLyoQyE2a+VGabyWWOE8Aa/kwYFY2W0YTULO4kr1JJqoynD7QP09rVZe7IFoQ=
X-Received: by 2002:aa7:8d01:0:b029:2f0:88da:1821 with SMTP id
 j1-20020aa78d010000b02902f088da1821mr34768452pfe.67.1625050686906; Wed, 30
 Jun 2021 03:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn> <1625048653-6825-5-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1625048653-6825-5-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 30 Jun 2021 18:57:55 +0800
Message-ID: <CA+WQbwsGFZsQYaigbQJ7nC31RbUdU70Ue6f1i15XzSO_wrMFDA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] mptcp: remove some double-check
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As I said in v6, I prefer to keep these double check code, no need to
remove them.

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:24=E5=86=99=E9=81=93=EF=BC=
=9A
>
> remove some double-check in mptcp_established_options_add_addr() and
> mptcp_established_options_rm_addr()
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/options.c  | 14 ++------------
>  net/mptcp/pm.c       | 21 +++++++++++----------
>  net/mptcp/protocol.h |  4 ++--
>  3 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cceff0a..0711fc1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -659,7 +659,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
>         int len =3D 0;
>
>         if (!mptcp_pm_should_add_signal(msk) ||
> -           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts=
, &add_addr))
> +           !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts=
, &add_addr, &len))
>                 return false;
>
>         if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> @@ -674,10 +674,6 @@ static bool mptcp_established_options_add_addr(struc=
t sock *sk, struct sk_buff *
>                 drop_other_suboptions =3D true;
>         }
>
> -       len =3D mptcp_add_addr_len(msk, opts);
> -       if (remaining < len)
> -               return false;
> -
>         *size =3D len;
>         if (drop_other_suboptions)
>                 *size -=3D opt_size;
> @@ -707,13 +703,7 @@ static bool mptcp_established_options_rm_addr(struct=
 sock *sk,
>         int i, len;
>
>         if (!mptcp_pm_should_rm_signal(msk) ||
> -           !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list)))
> -               return false;
> -
> -       len =3D mptcp_rm_addr_len(&rm_list);
> -       if (len < 0)
> -               return false;
> -       if (remaining < len)
> +           !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_list, &len)))
>                 return false;
>
>         *size =3D len;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9c5b15c..2311ea5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -255,9 +255,9 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bk=
up)
>
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *sk=
b,
>                               unsigned int opt_size, unsigned int remaini=
ng,
> -                             struct mptcp_out_options *opts,  u8 *add_ad=
dr)
> +                             struct mptcp_out_options *opts,  u8 *add_ad=
dr, int *len)
>  {
> -       int ret =3D false, len;
> +       int ret =3D false;
>
>         spin_lock_bh(&msk->pm.lock);
>
> @@ -276,8 +276,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 struct sk_buff *skb,
>                 remaining +=3D opt_size;
>         }
>
> -       len =3D mptcp_add_addr_len(msk, opts);
> -       if (remaining < len)
> +       *len =3D mptcp_add_addr_len(msk, opts);
> +       if (remaining < *len)
>                 goto out_unlock;
>
>         if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
> @@ -287,17 +287,18 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, struct sk_buff *skb,
>
>         ret =3D true;
>  out_unlock:
> +       spin_unlock_bh(&msk->pm.lock);
> +
>         if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_ad=
d_signal_addr(msk)))
>                 mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
>
> -       spin_unlock_bh(&msk->pm.lock);
>         return ret;
>  }
>
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
> -                            struct mptcp_rm_list *rm_list)
> +                            struct mptcp_rm_list *rm_list, int *len)
>  {
> -       int ret =3D false, len;
> +       int ret =3D false;
>         u8 rm_addr;
>
>         spin_lock_bh(&msk->pm.lock);
> @@ -307,12 +308,12 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk=
, unsigned int remaining,
>                 goto out_unlock;
>
>         rm_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
> -       len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
> -       if (len < 0) {
> +       *len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
> +       if (*len < 0) {
>                 WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>                 goto out_unlock;
>         }
> -       if (remaining < len)
> +       if (remaining < *len)
>                 goto out_unlock;
>
>         *rm_list =3D msk->pm.rm_list_tx;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index caa4a60..5d7c9d7 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -770,9 +770,9 @@ static inline int mptcp_rm_addr_len(const struct mptc=
p_rm_list *rm_list)
>
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *sk=
b,
>                               unsigned int opt_size, unsigned int remaini=
ng,
> -                             struct mptcp_out_options *opts,  u8 *add_ad=
dr);
> +                             struct mptcp_out_options *opts,  u8 *add_ad=
dr, int *len);
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
> -                            struct mptcp_rm_list *rm_list);
> +                            struct mptcp_rm_list *rm_list, int *len);
>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *sk=
c);
>
>  void __init mptcp_pm_nl_init(void);
> --
> 1.8.3.1
>
>
