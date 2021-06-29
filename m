Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C07168
	for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 05:44:07 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso1673802pjp.2
        for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 22:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JmRotNSSx6QXuKsNLs08yNGV8fu/AZoXdGO43OxguLA=;
        b=TzsYdF7mIg2/1wKuZ+pZal2JjL5YC1DGjhqzykUsmPOrmdyyumLqRdE3QB67yYLlDH
         LLpMlPd8/Jqjr2VowheFlqi+3KK8R/mXOwl9RFZyvjaDdhvQBZRTPKAeaH15pr1VVpYx
         kdb7L/kWpf9AsIpksEw0iaVZtkF7Z3XZagt3JMn9nwAnBDoVOAfSUnLUT1IT+9TXdsDz
         E/0f+oGljozDfoFrn2Lj8BrkXBY5OfYGhBoJzXabIICCecWk961blvo429bb0KFnjeoS
         pcEWFkT7Ek611OLHkJtA0s8rVhTCUlSROjsdBClquAIi321yPpTE3qwMY3CWK+mRqPdn
         7zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JmRotNSSx6QXuKsNLs08yNGV8fu/AZoXdGO43OxguLA=;
        b=nV6DDMw9TxLdPByx38iwdgmHFeG5mwdWC/aXTSo1nIYRoy71+a855BWBke6t4+kg6k
         33uovxiklMYuZOaBLyISVT+a5exLQXD4wTNl5bpTNyXco4dqFO2ASxcFUjXjcfC+ki6w
         pRDRaiAgv1r0FF+1ogORmF5MzJbUwgp8pqVLMfwbpHZ72uJud0v1AbZCrGkoto0Z/h8K
         7JWhAwJrzpUt5zIFnCdm02kBWbrci5G3rYt7fZqjDYcKcOxiDuTYubpTJakR1JDvpabh
         7p8HcCol1lr+hyenSlzE7Ch9suxiIN3KEPlkBWvD/cUQ+t34kkotvFjREhKEoArl7ru8
         D5uQ==
X-Gm-Message-State: AOAM532Lqe8eS8jctayIQ4cJtFb5AqH7mf5XTGP8Ot8rb0wZyaUDwERX
	cNYuladGgZ9kEhh2Zs3891ohDvWDIlH72RCeTJc=
X-Google-Smtp-Source: ABdhPJxx3lbXrwwq3esSwmEmxToaAESMuoni/9ZDEhifHCqKPgxSZukrPYdbZjugl2smq8t6Pw+6Jmzh+0+5OlBwzcQ=
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr42167078pjb.6.1624945447376;
 Mon, 28 Jun 2021 22:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn> <1624930899-99623-2-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1624930899-99623-2-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 29 Jun 2021 13:43:55 +0800
Message-ID: <CA+WQbwtxcHsHvthHp65NX=Y0uHuHpMXv1d9W0S=fEY=rUQEW_A@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
 addr_signal each other
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Thank you for this new patch set!

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:42=E5=86=99=E9=81=93=EF=BC=
=9A
>
> ADD_ADDR share pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
> done we should not clean ADD_ADDR/RM_ADDR's addr_signal.
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/mptcp/pm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6..6c427c8 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -252,6 +252,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bk=
up)
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
>                               struct mptcp_addr_info *saddr, bool *echo, =
bool *port)
>  {
> +       u8 add_addr;
>         int ret =3D false;

Here we should use the reverse xmas tree order for variables definition:
        int ret =3D false;
        u8 add_addr;

>
>         spin_lock_bh(&msk->pm.lock);
> @@ -267,7 +268,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
>                 goto out_unlock;
>
>         *saddr =3D msk->pm.local;
> -       WRITE_ONCE(msk->pm.addr_signal, 0);
> +       add_addr =3D msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) |=
 BIT(MPTCP_ADD_ADDR_ECHO));

I think we could use mptcp_pm_should_add_signal_echo to choose ECHO or
SIGNAL to set here:
      if (mptcp_pm_should_add_signal_echo(msk))
              add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO);
      else
              add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_SIGNAL=
);

> +       WRITE_ONCE(msk->pm.addr_signal, add_addr);
>         ret =3D true;
>
>  out_unlock:
> @@ -278,6 +280,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
>                              struct mptcp_rm_list *rm_list)
>  {
> +       u8 rm_addr;
>         int ret =3D false, len;
>
>         spin_lock_bh(&msk->pm.lock);
> @@ -286,16 +289,17 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk=
, unsigned int remaining,
>         if (!mptcp_pm_should_rm_signal(msk))
>                 goto out_unlock;
>
> +       rm_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_RM_ADDR_SIGNAL);
>         len =3D mptcp_rm_addr_len(&msk->pm.rm_list_tx);
>         if (len < 0) {
> -               WRITE_ONCE(msk->pm.addr_signal, 0);
> +               WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>                 goto out_unlock;
>         }
>         if (remaining < len)
>                 goto out_unlock;
>
>         *rm_list =3D msk->pm.rm_list_tx;
> -       WRITE_ONCE(msk->pm.addr_signal, 0);
> +       WRITE_ONCE(msk->pm.addr_signal, rm_addr);
>         ret =3D true;
>
>  out_unlock:
> --
> 1.8.3.1
>
