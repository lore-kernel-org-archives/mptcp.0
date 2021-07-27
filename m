Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE172
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 04:27:53 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so2401437pjb.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 21:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0tnYe+DTeUxOX2cx+y3BUbMg//3rqzRpawJRF8mu1nY=;
        b=cSHKmLmbGodezPBADLa1wu1MhmFoUcC25ieXDieVnr3gsVxH+reKIJ9srfUu5SwTLR
         0Jgpl1pUfut6ev1E4lUvULVJjKWr5Arl2+OTa0ZLY3VhTAynNrk8UGTsbMMIw1JtrnDx
         A5haAFo55qHsVS67WOS/oEb7UtE5bQUxyE0JHtcEneaMnGb5i85SC9xHs5k1VS9r50x/
         2F/72zqzO49mLkp5Sl+0VfXxlx2tgG2kRbjMvZlwlOnF8NaQF5Bna/BEJU0ZMV002W7w
         JwLpjpiFeMyVOpH8PTlNiTr0yg8ZN7kAkMGeTAk8kAcX6o7D/vGVfsiw75l3zJ9t6dh9
         ttZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0tnYe+DTeUxOX2cx+y3BUbMg//3rqzRpawJRF8mu1nY=;
        b=laZ9q8/0rkm+K+13UzsyHgpJ+F5NW6MVLm3czOP4nQVL/JWnzFwO/ptFGLFMOy0zSw
         rPBYY2swU3naii4M+1lMWyqPRgrk4eqyrKp0H/ms1PGIbTAM2g4GhSPj9jJDNNj/pboh
         7eUOU15lU/hOVuubsSenGaKe/wpof2erBp6XDzwEmgyg76T40MayCGX8JPvgPj5w3LxE
         /ipn1HIdaV84A3Vw8Z0DyMnxsCXZxSTyTBZuVJMX6W+mVqpymX18nDfE2GnCO20dcksC
         e2ndHZ7VGS/xdbCABmF2FwAsmsEy4oYPKqrMRmckdpqWkOSXLQqAUoSXlaNxrW2jX6hR
         D9gQ==
X-Gm-Message-State: AOAM531f5j2F32L9KgPRUFZC0prAuOSJm88k9fVqlI7Z7gH7CIt3GNY7
	8e0fWLlXb8IEhkUXJdT8+OxwzUGJKTfdkbb83ro=
X-Google-Smtp-Source: ABdhPJwQ6s/VdD/ZZem0Sa2gvhsXV/iR61vD7s+QpXIzn4jYlGMG6ytfTaDqU+uDlbWFUzP0X7oYjuYTHZq1SisaSDI=
X-Received: by 2002:a17:902:8201:b029:12b:a6a1:57ee with SMTP id
 x1-20020a1709028201b029012ba6a157eemr17074751pln.0.1627360072729; Mon, 26 Jul
 2021 21:27:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627296764.git.pabeni@redhat.com> <d945af43d09672ea8bd98d06439db11985a3504a.1627296764.git.pabeni@redhat.com>
In-Reply-To: <d945af43d09672ea8bd98d06439db11985a3504a.1627296764.git.pabeni@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 27 Jul 2021 12:27:41 +0800
Message-ID: <CA+WQbwsdwum4B+FpSyfeR_nan5rPD1VRZm0WOoqAHHseQOz4AQ@mail.gmail.com>
Subject: Re: [PATCH v3 mptcp-next 1/3] Squash-to: "mptcp: move
 drop_other_suboptions check under pm lock"
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for this patch, it looks good to me.

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:55=E5=86=99=E9=81=93=EF=BC=9A
>
> Commit message to be updated appending:
>
> """
> Additionally, always drop the other suboption for TCP pure ack:
> that makes both the code simpler and the MPTCP behaviour more
> consistent.
> """
>
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4d1828fd2482..cd2323e5ccdc 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -266,10 +266,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, struct sk_buff *skb,
>         if (!mptcp_pm_should_add_signal(msk))
>                 goto out_unlock;
>
> -       if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> -            ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> -             (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.local.port=
))) &&
> -           skb && skb_is_tcp_pure_ack(skb)) {
> +       /* always drop every other options for pure ack ADD_ADDR; this is=
 a
> +        * plain dup-ack from TCP perspective. The other MPTCP-relevant i=
nfo,
> +        * if any, will be carried by the 'original' TCP ack
> +        */
> +       if (skb && skb_is_tcp_pure_ack(skb)) {
>                 remaining +=3D opt_size;
>                 *drop_other_suboptions =3D true;
>         }

If this patch is to be squashed to "mptcp: move drop_other_suboptions check
under pm lock", should it be like this:

@@ -264,10 +264,11 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock
*msk, struct sk_buff *skb,
     if (!mptcp_pm_should_add_signal(msk))
         goto out_unlock;

-    if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-         mptcp_pm_should_add_signal_port(msk) ||
-         mptcp_pm_should_add_signal_echo(msk)) &&
-        skb && skb_is_tcp_pure_ack(skb)) {
+    /* always drop every other options for pure ack ADD_ADDR; this is a
+     * plain dup-ack from TCP perspective. The other MPTCP-relevant info,
+     * if any, will be carried by the 'original' TCP ack
+     */
+    if (skb && skb_is_tcp_pure_ack(skb)) {
         remaining +=3D opt_size;
         *drop_other_suboptions =3D true;
     }

Thanks,
-Geliang

> --
> 2.26.3
>
