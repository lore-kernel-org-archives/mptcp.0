Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A2168
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 10:38:04 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so3964854pjs.2
        for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9QJKu7RNMsR6VK7H64J812jB/LtB6HqpSU+NMccMkH4=;
        b=j5yXtmf4foPO1Kcs6ZnkmtvwuzwvULpWBR5FdN7341VVj92DBUXDLcT4LIuHG1HGg2
         LInhGpmzOM2mLBHCyp9GJoxwXLOpmvxLSoRq961MR1R+981ApRHhlrqZ/gLdHjySNXeo
         hkamAbtVF0LjOJuIzTEzQNJt7PHj5vLG2qQZYDjTu6YWf15+SCpm6q3LpB+kfXUPmMtm
         OnxPbes6Ve+LiLJaeOkUr0J9dYQvUdOJXEx3mNZuXT+vWow4u2AFEquDa/bYn3drUZBU
         mV6AF+8KloKj9yMMJ694JgAj/Pn8R3WxZ35GxZXZwP/u7NXT16vV1lCamxbqZgDTLZic
         3jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9QJKu7RNMsR6VK7H64J812jB/LtB6HqpSU+NMccMkH4=;
        b=NClWR4qGEJ6A7ueEsD9k06JEJc6mdXq4ojhtkmb6xVRm82KmAvYvYC3D7rrZcpL4sg
         +PTRuE6YsVapvKGfYQTLFrnpwWDH+o9y/9N4DCZzSRRK7QOXNANRH6NFwIL37RhWSqPt
         KjuEVdKYaXpOdUU5N0vkXvKJGrKe1LtglWth3tSJYLnFgKPWHfgFk5qrOux7skoXLQ7d
         rPlno75fI3U5Dyy+4iL5woes6SIa+icBCWAiue7lUUoGNIJFHQuDcrpzgD4lyXNUXSP1
         xD83CVIsbvH5amCnzHcpfKgr6ocnw97YZVFSJZMgKBHQhF8edGcYChJJnzISmr6VUQWJ
         X6ZQ==
X-Gm-Message-State: AOAM533U1TB+pFZpFHporQbKhL/tyv8nrczdGgS8aVhkkO/xeri3rDbB
	Ww2olgCpUdETQ2zqhn1kdXaL5cUgwip9SFLy6ck=
X-Google-Smtp-Source: ABdhPJxRF4KQJdgtgnTNFafLdyGPJxlCcl4nL+mbobN5RMAVoxPahAbrRCka977Ue1Oe+tuuqo3pNNnNQX43UdMVeeE=
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr3880582pjb.6.1625049483750;
 Wed, 30 Jun 2021 03:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1625048653-6825-1-git-send-email-liyonglong@chinatelecom.cn> <1625048653-6825-2-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1625048653-6825-2-git-send-email-liyonglong@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 30 Jun 2021 18:37:52 +0800
Message-ID: <CA+WQbwuKVK5wQ3b9ux_43sJQHcCN2xvJqVCDGi9uaUT0LREOrg@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] mptcp: fix ADD_ADDR and RM_ADDR maybe flush
 addr_signal each other
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:24=E5=86=99=E9=81=93=EF=BC=
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
> index 9d00fa6..50079e5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -253,6 +253,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
>                               struct mptcp_addr_info *saddr, bool *echo, =
bool *port)
>  {
>         int ret =3D false;
> +       u8 add_addr;
>
>         spin_lock_bh(&msk->pm.lock);
>
> @@ -267,7 +268,8 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
>                 goto out_unlock;
>
>         *saddr =3D msk->pm.local;
> -       WRITE_ONCE(msk->pm.addr_signal, 0);
> +       add_addr =3D msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) |=
 BIT(MPTCP_ADD_ADDR_ECHO));
> +       WRITE_ONCE(msk->pm.addr_signal, add_addr);
>         ret =3D true;
>
>  out_unlock:

This part is removed in patch 3, why we need to add it here?

> @@ -279,6 +281,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, =
unsigned int remaining,
>                              struct mptcp_rm_list *rm_list)
>  {
>         int ret =3D false, len;
> +       u8 rm_addr;
>
>         spin_lock_bh(&msk->pm.lock);
>
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
