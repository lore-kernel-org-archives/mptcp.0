Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250216414
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684777555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OoibBRfzugCbQFVyyO8gC4EZ71rjUgvS4tTLI8B4as=;
	b=FSfbHM48fFjVJsV2rQ5YLxxHRV3s9pdBe7114t0yobF1PjF7yK6VkIkfF5Vy9NKLDeuSe+
	fneSoeYHfSQiXPmjUIy7s/pFQB/Nj2rP/xh2zrqVrPtjvuSeoIxUWAEu/nNKAxE2nf+z27
	DEP9Pt/goo4pjzUptHVBcaL3X6F1Ldw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-gTP37HqoNpKzTuUpmp1ENg-1; Mon, 22 May 2023 13:45:54 -0400
X-MC-Unique: gTP37HqoNpKzTuUpmp1ENg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-623a2273194so7751436d6.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 10:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684777553; x=1687369553;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ob6asCVrBqF2spwYOwO4uaSqiVtPJfgDLIuAh5bK/z4=;
        b=NbF62yFcC76/3JXuby2NbXgy+XLZU6Ctpp0yug7DAZPAF9Cv9eckRL0055O7/K3TJM
         qvTAJoiKgpWSoeTRQ9rcktrTykehjKOqUiVJuDsdmo1fB/oBMftZM83r7Iibbh/G/xUx
         14EKBT4AbQ1hqr9DI2YFdY7BNfiywOeJrf9DdtgLvK2TugJq8RzTHsvJdcNBASnp0Da1
         AbM4gPl+KRn+KG+bgIKONVnGcysCEvlD9Fm40GIyQ8oJ7NfpOGn601aaKVf4PNaKjwLa
         YKCbA94BG5sZtDV7V19btl1zgWGNyym4s5dUe7QOVy7iXxSVLFaZeBbNnhYhldewYXie
         gVUw==
X-Gm-Message-State: AC+VfDztKLvLZFEcwOBQtYC/Qv7MdTvM/YFW2zPiMM3F1kGaXRmQY1y2
	He35n0EXpg5Q8Uip6KFZJcBArrUT1mD0SKnksjTkNHVcCtfLrVp60/Iid7RaSQDPhdr/VlbthpJ
	zYg9R/6iBVIjToWnM0VJE1B8=
X-Received: by 2002:a05:6214:5099:b0:623:5678:1285 with SMTP id kk25-20020a056214509900b0062356781285mr19477635qvb.2.1684777553425;
        Mon, 22 May 2023 10:45:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TagdRtJtWvG+nlajZgAuwPpCGSIctAKbuhAkfm9iRdKVj2lmM/IurOAoEUIZ4T6SIBx+jCQ==
X-Received: by 2002:a05:6214:5099:b0:623:5678:1285 with SMTP id kk25-20020a056214509900b0062356781285mr19477615qvb.2.1684777553156;
        Mon, 22 May 2023 10:45:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-106.dyn.eolo.it. [146.241.241.106])
        by smtp.gmail.com with ESMTPSA id mn21-20020a0562145ed500b006212a3d8cc1sm2125003qvb.32.2023.05.22.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:45:52 -0700 (PDT)
Message-ID: <e163a9ecc2d40f123f396aa1bd67e2a3f6b60b1e.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2 28/37] selftests: mptcp: join: skip
 Fastclose tests if not supported
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 22 May 2023 19:45:50 +0200
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-28-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
	 <20230406-mptcp-issue-368-selftests-old-kernels-v2-28-50313e4f83ab@tessares.net>
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

On Mon, 2023-05-22 at 18:38 +0200, Matthieu Baerts wrote:
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
>=20
> One of them is the support of MP_FASTCLOSE introduced in commit
> f284c0c77321 ("mptcp: implement fastclose xmit path").
>=20
> If the MIB counter is not available, the test cannot be verified and the
> behaviour will not be the expected one. So we can skip the test if the
> counter is missing.
>=20
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 1f24495308f9..ccf52aba8a1c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -263,6 +263,19 @@ reset()
>  =09return 0
>  }
> =20
> +# $1: test name ; $2: counter to check
> +reset_check_counter()
> +{
> +=09reset "${1}" || return 1
> +
> +=09local counter=3D"${2}"
> +
> +=09if ! nstat -asz "${counter}" | grep -wq "${counter}"; then
> +=09=09mark_as_skipped "counter '${counter}' is not available"
> +=09=09return 1
> +=09fi
> +}
> +
>  # $1: test name
>  reset_with_cookies()
>  {
> @@ -3179,14 +3192,14 @@ fullmesh_tests()
> =20
>  fastclose_tests()
>  {
> -=09if reset "fastclose test"; then
> +=09if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
>  =09=09run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
>  =09=09chk_join_nr 0 0 0
>  =09=09chk_fclose_nr 1 1
>  =09=09chk_rst_nr 1 1 invert
>  =09fi
> =20
> -=09if reset "fastclose server test"; then
> +=09if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx=
"; then
>  =09=09run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
>  =09=09chk_join_nr 0 0 0
>  =09=09chk_fclose_nr 1 1 invert
>=20

Here and in a few later patches, I would do the 'feature check' only
once at the beginning of the functional block ('fastclose_test' in this
case), in the most conservative way possible. The goal would be
minimize the conflicts caused by present/absence of such patch.

/P

