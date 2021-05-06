Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA071
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 11:23:12 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id s20so3209440plr.13
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e5cOvPB52WtdOpuxaedkvFG9HD4T7cbg8EO1e2Aqcv0=;
        b=UiMCDWEYYGCSlWzSCRR+2O9dGiPO3N8STuH0L0gNndPOH96I1Yn/WMceoIs56RqJt6
         Yv6PTtPUBvqONNwhGzffRtUwvJKkR+O7WaF8cBYXz3c86/thwZk8YvUdBes1WcZwhmVl
         MKobAGqpHVmkNq3amKD70KyxMQ818KQ5olPdYx/YzL7ucoZ4Kci8ZR99V7j3/wc1CVcg
         edxv3KqjnWIvlVyzWudVoa0GLPWTd4jwNQrKlVasV3fGsuIHXBC+TP9bnEIrh81AZ/f9
         VRZbKFKgu2/Lwtzm16m0krKKSFmnbIAxy+g/zflao0E/lwTz70ewmcNCnWtY5VEHREoY
         F2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e5cOvPB52WtdOpuxaedkvFG9HD4T7cbg8EO1e2Aqcv0=;
        b=IBtSZPLd+NHblx5H8luN+oMfEhvPOys7DSYdfbyXr0VgcLwAfMj/dM5JL+Q8BDRVx9
         +kBIy2dGKMQs/Gq4Wwx1lO9iyrzUBYFbwjyn+QNl8j0umXPVqzAFZlD4vjaTWMrc+Pd9
         jy+ZT+TC0OlIZ826LMm0l1qqYIdNO2LlaFApC7f3vKM33w4v4gPI5rFm5ysvpztoKfC+
         RTO6RrhD4F4etltWQucDnsSNZapnhOotOcpnacBgQrJ2DIhG+2/OQ7cojAJ/4t29xJNp
         Nx3hVV7vk9+/l9O+xbYxsUk1s39Ii2NFbCaF54FGPrFjJPDuv1kkm7WawG20zWGRFlTr
         AW+A==
X-Gm-Message-State: AOAM531JG5PJvwgfPWtnw6WdxzndFQOy+cZJu5y+Yu3ke1S7th5lOCwk
	AmYCmr4vF8fXuNL2lPEcx4QPcMtKyYz0X+Y6PnqkyDYMDoE=
X-Google-Smtp-Source: ABdhPJw05rrAZB/Q8pEgmKva3XpUFFJEZQ7J//D1HL7DCXh/Or9AouqdrP7k1pp2SGcFRm8hmO+7unEVz2aQH64KX8E=
X-Received: by 2002:a17:90a:ea11:: with SMTP id w17mr17174744pjy.6.1620300192253;
 Thu, 06 May 2021 04:23:12 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210506103734.3845725-1-matthieu.baerts@tessares.net>
In-Reply-To: <20210506103734.3845725-1-matthieu.baerts@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 6 May 2021 19:23:00 +0800
Message-ID: <CA+WQbwu+cr0DW=REfMpUKao2sCtHnGCC5u_Kzufh0jdTXRuUrQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add a new sysctl checksum_enabled"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B45=E6=
=9C=886=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:38=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Fix a compilation error without CONFIG_SYSCTL:
>
>   ld: net/mptcp/protocol.o: in function `__mptcp_init_sock':
>   protocol.c:(.text+0x43e): undefined reference to `mptcp_is_checksum_ena=
bled'
>   ld: net/mptcp/subflow.o: in function `subflow_v6_route_req':
>   subflow.c:(.text+0xa0a): undefined reference to `mptcp_is_checksum_enab=
led'
>   ld: net/mptcp/subflow.o: in function `subflow_v4_route_req':
>   subflow.c:(.text+0xabd): undefined reference to `mptcp_is_checksum_enab=
led'
>   ld: net/mptcp/subflow.o: in function `mptcp_subflow_init_cookie_req':
>   subflow.c:(.text+0xb74): undefined reference to `mptcp_is_checksum_enab=
led'
>   ld: net/mptcp/options.o: in function `mptcp_syn_options':
>   options.c:(.text+0x68a): undefined reference to `mptcp_is_checksum_enab=
led'
>
> Simply moved this function outside CONFIG_SYSCTL with the other ones.

Thanks for this fix.

Acked-by: Geliang Tang <geliangtang@gmail.com>

-Geliang

>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>     to be squashed in "mptcp: add a new sysctl checksum_enabled"
>
>  net/mptcp/ctrl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 014752c481d0..603e0c851d2d 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -41,6 +41,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *ne=
t)
>         return mptcp_get_pernet(net)->add_addr_timeout;
>  }
>
> +int mptcp_is_checksum_enabled(struct net *net)
> +{
> +       return mptcp_get_pernet(net)->checksum_enabled;
> +}
> +
>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>  {
>         pernet->mptcp_enabled =3D 1;
> @@ -49,11 +54,6 @@ static void mptcp_pernet_set_defaults(struct mptcp_per=
net *pernet)
>  }
>
>  #ifdef CONFIG_SYSCTL
> -int mptcp_is_checksum_enabled(struct net *net)
> -{
> -       return mptcp_get_pernet(net)->checksum_enabled;
> -}
> -
>  static struct ctl_table mptcp_sysctl_table[] =3D {
>         {
>                 .procname =3D "enabled",
> --
> 2.30.2
>
>
