Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD071116
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 08:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689151021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xaE05s0AGZwUiXWqw8mTnX+Gt5aHWdD02zqOBFVGBg=;
	b=XI1FF62Mq2MzCTvJZS5OwzzkgfLiN4EECzQMcbFnBlC69HSSk+i5+E1099BoV/6exVVskJ
	gcJiKs3XkBXeA2XVwF371QPluO47EJXAazdZwN6GmDMYRUzMjowY4ZPnPFgNNFP8h9IZ96
	KOPu6vbJLuUEWjr3fRQ6VHlyV3Q6h3g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-FWkVAGHMPSqjCTQs2yY14A-1; Wed, 12 Jul 2023 04:36:59 -0400
X-MC-Unique: FWkVAGHMPSqjCTQs2yY14A-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403838e9f4dso20295621cf.1
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 01:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689151019; x=1689755819;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYekZJfI/UnJsSnIpY1o1JV2aLNosAm8sZskntRhoV8=;
        b=ByNoi4IVVRVTOfE3On6/WkqYTS2P6JO2Hc2ckaurdBaq1e6FJkDp89h1a0TQtgVNjW
         SGG4HBAAj9SImFhkujXYEyJMC11mH315+C3dSY2Mel8pTm3xzxyeKug8UFS2w+/Hio86
         LQyisp5PsgM1zqG0SRGjYiWK0U3zcvXYEkydZ3N4R6nCIIX5s7yxVLuTTepQl3DWXlxH
         9ZfdHsK0D6gT7PlCwvJrHmPZoVas8FOwK0z38jmYywVj+pT1EoGCoEzgbE8T9tZ08YJy
         gWhDN33TomUUBNxWk5XX7p0kA7bWwtuAj1OoxYmlGCU7OakBx+ZZspNXcgZ28wBQzdn5
         FtBw==
X-Gm-Message-State: ABy/qLbkBxhKofUShru9Iv+bOMgJRl6nQBGnC5R5UWkFGHXIVhI2j6cG
	GH0UUMVKzocncOepxwln4OVxO9QPPoumd0QGw+vvibQRBPat3VAHIe1ZGRjO0qKO46njAdfLcHx
	WWafeRjMRQVStKmE=
X-Received: by 2002:a05:622a:1a1d:b0:403:b115:fbe with SMTP id f29-20020a05622a1a1d00b00403b1150fbemr10438689qtb.1.1689151019344;
        Wed, 12 Jul 2023 01:36:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVL31J+yjuteUZJx1tX2TVxj71SksHIXC29FPXUrjeFD4VgPvStPFGNUXPwRp6ITGTFqnm9Q==
X-Received: by 2002:a05:622a:1a1d:b0:403:b115:fbe with SMTP id f29-20020a05622a1a1d00b00403b1150fbemr10438679qtb.1.1689151019097;
        Wed, 12 Jul 2023 01:36:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id he21-20020a05622a601500b00402ed9adfa1sm2080546qtb.87.2023.07.12.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 01:36:58 -0700 (PDT)
Message-ID: <a875e3a7c34c5fccb4499cae6b9a3d338fb16dd9.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: join: colored results
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 12 Jul 2023 10:36:56 +0200
In-Reply-To: <20230628144927.828117-3-matthieu.baerts@tessares.net>
References: <20230628144927.828117-1-matthieu.baerts@tessares.net>
	 <20230628144927.828117-3-matthieu.baerts@tessares.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-06-28 at 16:49 +0200, Matthieu Baerts wrote:
> Thanks to the parent commit, it is easy to change the output and add
> some colours to easily spot issues.
>=20
> The colours are not used if stdout is redirected or if NO_COLOR env var
> is set to 1 as specified in https://no-color.org.
>=20
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh |  8 ++--
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 38 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 3a0e2fa7754b..e9a3e85970fb 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -209,22 +209,22 @@ print_check()
> =20
>  print_info()
>  {
> -=09printf "%-${nr_blank}sInfo: %s\n" " " "${*}"
> +=09mptcp_lib_print_info "      Info: ${*}"
>  }
> =20
>  print_ok()
>  {
> -=09echo "[ ok ]${1:+ ${*}}"
> +=09mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
>  }
> =20
>  print_fail()
>  {
> -=09echo "[fail]${1:+ ${*}}"
> +=09mptcp_lib_print_err "[fail]${1:+ ${*}}"
>  }
> =20
>  print_skip()
>  {
> -=09echo "[skip]${1:+ ${*}}"
> +=09mptcp_lib_print_warn "[skip]${1:+ ${*}}"
>  }
> =20
>  # [ $1: fail msg ]
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testi=
ng/selftests/net/mptcp/mptcp_lib.sh
> index b1a0fdd0408b..1080d5d2430b 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -4,10 +4,48 @@
>  readonly KSFT_PASS=3D0
>  readonly KSFT_FAIL=3D1
>  readonly KSFT_SKIP=3D4
> +
> +# shellcheck disable=3DSC2155 # declare and assign separately
>  readonly KSFT_TEST=3D$(basename "${0}" | sed 's/\.sh$//g')
> =20
>  MPTCP_LIB_SUBTESTS=3D()
> =20
> +# only if supported and not disabled, see no-color.org
> +if [ -t 1 ] && [ "${NO_COLOR:-}" !=3D "1" ]; then
> +=09readonly MPTCP_LIB_COLOR_RED=3D"\E[1;31m"
> +=09readonly MPTCP_LIB_COLOR_GREEN=3D"\E[1;32m"
> +=09readonly MPTCP_LIB_COLOR_YELLOW=3D"\E[1;33m"
> +=09readonly MPTCP_LIB_COLOR_BLUE=3D"\E[1;34m"
> +=09readonly MPTCP_LIB_COLOR_RESET=3D"\E[0m"
> +else
> +=09readonly MPTCP_LIB_COLOR_RED=3D
> +=09readonly MPTCP_LIB_COLOR_GREEN=3D
> +=09readonly MPTCP_LIB_COLOR_YELLOW=3D
> +=09readonly MPTCP_LIB_COLOR_BLUE=3D
> +=09readonly MPTCP_LIB_COLOR_RESET=3D
> +fi
> +
> +# $1: color, $2: text
> +mptcp_lib_print_color() {
> +=09echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
> +}
> +
> +mptcp_lib_print_ok() {
> +=09mptcp_lib_print_color "${MPTCP_LIB_COLOR_GREEN}${*}"
> +}
> +
> +mptcp_lib_print_warn() {
> +=09mptcp_lib_print_color "${MPTCP_LIB_COLOR_YELLOW}${*}"
> +}
> +
> +mptcp_lib_print_info() {
> +=09mptcp_lib_print_color "${MPTCP_LIB_COLOR_BLUE}${*}"
> +}
> +
> +mptcp_lib_print_err() {
> +=09mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
> +}
> +
>  # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when valida=
ting all
>  # features using the last version of the kernel and the selftests to mak=
e sure
>  # a test is not being skipped by mistake.

Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks!

/P

