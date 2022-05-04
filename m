Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A23420E8
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 03:39:03 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id iq10so132417pjb.0
        for <mptcp@lists.linux.dev>; Tue, 03 May 2022 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ojJei5xsr8zN3UiiD4FreQU7UJTpsG0BjNzzSw27eoE=;
        b=OpyoUEwtCwMVVsT+AMMGPPjAFeYe62jjnDBjEhpr9PUmFOciinjHEzmwe/FAHOClGS
         88C515WqqMNQI3c/HtCoB25PGpvpz0QxCcK1hd3IGefVo6d/23GFQkPP+FmR+u01zkJH
         QuUQIxYiDH6Pth+4vZXjLmkBDtG2EFV/MdblZMMPjlTGQU/esNdTdftTrmZEnLjucOq/
         l0bOYN+n6hnx77PQegXJkSovLY6QFL1Ka8By5xscsE1AyOsPnNC8OJgI55m0aDnxzbSd
         PS1aDZDFAhpWTs/s1G8d90vkhX+fLmMYH3ma0IFW73v+iK07hsw+Kwf9eytMb8l77UVQ
         ngNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ojJei5xsr8zN3UiiD4FreQU7UJTpsG0BjNzzSw27eoE=;
        b=CzZ8VJSQD8d564ifXjhLSt307H7a49TM5Uv2crkjGe3yBVpOVbr4Co8Yz5vqEUnvxl
         RQU2lOOyQ13RvKaGir+vGveNmfG49aco5FhQXQzmODOa/hF1UDdwxJL7vwe7TvRZL0E+
         0FZ9KrstWZ+tA6IfWCL8AM8cV5lbh/h7oUzq4Wc8og/uwQRKvMNUzUFYP6cKK58r0tfF
         giKq6/hbQcEkMs3Gf54S8lngI9jFRL9yIIIwV5MNKkx9wFAEt6Ko5Ctl2mISO06xGSRb
         80cCPskHiaapOpCuXxPCYGDsIvExwmPNn1gMvr1P0WN1AZ+SxndHKmYmhvsFVMKByq79
         Vb+A==
X-Gm-Message-State: AOAM531lc+LJZ+Z7d1HWV9M/vkq8i+LpCszJK8oDgyJAgngGkdL+vmXb
	ziLCIDGrw24dNug70FGVJnCdg5xij5AlfocevZnxxzodf7rGzg==
X-Google-Smtp-Source: ABdhPJy9TJyZJJ4JnZRBFuy1976YuOgWhtV9qQwyoj38DARzNIyguI7qGiTAuSJ9oatltvsX2ChBa8oaTiOJSoUgNUk=
X-Received: by 2002:a17:902:8c8f:b0:15e:ab1c:591b with SMTP id
 t15-20020a1709028c8f00b0015eab1c591bmr11027448plo.171.1651635542868; Tue, 03
 May 2022 20:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f64ef5eff420a2bb55103bbbb52c9dd527411da4.1651247530.git.pabeni@redhat.com>
In-Reply-To: <f64ef5eff420a2bb55103bbbb52c9dd527411da4.1651247530.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 4 May 2022 11:38:54 +0800
Message-ID: <CA+WQbwv7xbbQ7rb9BY+pknzU6nOg2u248jazG9_KkJ-MqoiMLA@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] net/sched: act_pedit: really ensure the skb is writable
To: Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2022=E5=B9=B44=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=BA=94 23:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Currently pedit tries to ensure that the accessed skb offset
> is writeble via skb_unclone(). The action potentially allows
> touching any skb bytes, so it may end-up modifying shared data.
>
> The above causes some sporadic MPTCP self-test failures.
>
> Address the issue keeping track of the (estimated) highest skb
> offset accessed by the action and ensure such offset is really
> writable.
>
> Note that this may cause performance regressions in some scenario,
> but hopefully pedit is not critical path.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Is it better to use this Fixes tag:

Fixes: 9dacaf17a6010 ("net sched: make pedit check for clones instead")

skb_cloned() is introduced by this commit.

But I'm not sure.

Thanks,
-Geliang

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> this almost solves issues/265 here. I'm still getting some rare
> failure with MPTcpExtMPFailTx=3D=3D0: sometimes the transfer completes
> before we are able to use the 2nd/failing link. The relevant fix
> is a purely seft-test one
> ---
>  include/net/tc_act/tc_pedit.h |  1 +
>  net/sched/act_pedit.c         | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.=
h
> index 748cf87a4d7e..3e02709a1df6 100644
> --- a/include/net/tc_act/tc_pedit.h
> +++ b/include/net/tc_act/tc_pedit.h
> @@ -14,6 +14,7 @@ struct tcf_pedit {
>         struct tc_action        common;
>         unsigned char           tcfp_nkeys;
>         unsigned char           tcfp_flags;
> +       u32                     tcfp_off_max_hint;
>         struct tc_pedit_key     *tcfp_keys;
>         struct tcf_pedit_key_ex *tcfp_keys_ex;
>  };
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index e01ef7f109f4..5ff37da2f9c3 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -149,7 +149,7 @@ static int tcf_pedit_init(struct net *net, struct nla=
ttr *nla,
>         struct nlattr *pattr;
>         struct tcf_pedit *p;
>         int ret =3D 0, err;
> -       int ksize;
> +       int i, ksize;
>         u32 index;
>
>         if (!nla) {
> @@ -228,6 +228,16 @@ static int tcf_pedit_init(struct net *net, struct nl=
attr *nla,
>                 p->tcfp_nkeys =3D parm->nkeys;
>         }
>         memcpy(p->tcfp_keys, parm->keys, ksize);
> +       p->tcfp_off_max_hint =3D 0;
> +       for (i =3D 0; i < p->tcfp_nkeys; ++i) {
> +               u32 cur;
> +
> +               /* AT reads a single byte, we can bound the offset with U=
CHAR_MAX,
> +                * each key will touch 4 bytes
> +                */
> +               cur =3D p->tcfp_keys[i].off + p->tcfp_keys[i].offmask ? U=
CHAR_MAX >> p->tcfp_keys[i].shift: 0;
> +               p->tcfp_off_max_hint =3D max(p->tcfp_off_max_hint, cur + =
4);
> +       }
>
>         p->tcfp_flags =3D parm->flags;
>         goto_ch =3D tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> @@ -310,7 +320,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const s=
truct tc_action *a,
>         struct tcf_pedit *p =3D to_pedit(a);
>         int i;
>
> -       if (skb_unclone(skb, GFP_ATOMIC))
> +       if (skb_ensure_writable(skb, min(skb->len, p->tcfp_off_max_hint))=
)
>                 return p->tcf_action;
>
>         spin_lock(&p->tcf_lock);
> --
> 2.35.1
>
>
