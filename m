Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0D4C79
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 13:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680874208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3CijOdfNB+SVILw39XbRbDeFgN7jaEPXl8YtTWnZYbA=;
	b=M5Tz95iTK7wmozqkjrX0nl+ZLU45x53s+uWFi64D/SXgaYdWTEYMEe0lzYs9MCrL33/Y6a
	Nu8jYsjA0eUvzl8WxI5VLWBOSJ0aC3mMWVI+CPeJBeaY5yHxGNN2bqeFV7hOuRe9SpaYOh
	u9cS0a7dznvdU4/kTUtuwKg+rjJCQ0k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-cdqlkBMbPUy9ubR6EMpE1w-1; Fri, 07 Apr 2023 09:30:07 -0400
X-MC-Unique: cdqlkBMbPUy9ubR6EMpE1w-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e40b122e3cso5129411cf.0
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 06:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gxYpFPYA5ImaoZhZdF1DBlQg5B2I1dpsl2R72yh18AI=;
        b=5LhBCKEZiuw1xfC0sLpXOoPKZFYEiaVa3HfDF+hAIyJCdzD78Lkm0zN4mK14bDneut
         WC0fVFSR+phyXV6hufGsdaJ/X8HUQp3hkbo2/Lr6O+Vzf6i7h1TRcva+aGjvAP9vMlZD
         lobEOA/SSGYHFLVJwx7jlHCDhR5NOMN8huTeeZGFLWxI+RtFbivedX4YooIpOquB9GQz
         fbmmJfdfwZy/kImYyUCV+TJdgex4YdDT6ST4POxBsHJs/bdLPcFpclqKqhityxnudIqJ
         IzpHHXKlDeifprrjTkr1HVzywqZEs0g/IEYtYcExGNwjpnw9X3VoVuzNX7hHRfzVhfnW
         f0yA==
X-Gm-Message-State: AAQBX9dT6qj2uBDVXqyT70esMWqPTbNjp1kEU+KYq2S4f1+LMsnQhW6n
	fVmSOJvz08hraALAMN4R04DmGYjOGIpuoii4qu9GoJMI9qZsTaxCJmbV3vqQ5bWt9DFzsl+UeaW
	5xhYb2v0xW35LszVwhUQopUo=
X-Received: by 2002:a05:6214:5285:b0:532:141d:3750 with SMTP id kj5-20020a056214528500b00532141d3750mr4215065qvb.2.1680874206473;
        Fri, 07 Apr 2023 06:30:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y1uXm59rrGofqAjmkdizfPVZckQ7bfVZY4Hftmg2sbGYxoTHEzl956mLzL3wrL4jndzyaRrw==
X-Received: by 2002:a05:6214:5285:b0:532:141d:3750 with SMTP id kj5-20020a056214528500b00532141d3750mr4215022qvb.2.1680874206121;
        Fri, 07 Apr 2023 06:30:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id f9-20020ad442c9000000b005e26dcaa159sm1349028qvr.25.2023.04.07.06.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:30:05 -0700 (PDT)
Message-ID: <fd34566a70fdfaed72644e6b13c635058b833bce.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 1/2] selftests: mptcp: join: avoid using
 'cmp --bytes'
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 07 Apr 2023 15:30:03 +0200
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-1-9113fa4d2ce2@tessares.net>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net>
	 <20230404-mptcp-selftests-join-busybox-shellcheck-v2-1-9113fa4d2ce2@tessares.net>
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

On Tue, 2023-04-04 at 18:21 +0200, Matthieu Baerts wrote:
> BusyBox's 'cmp' command doesn't support the '--bytes' parameter.
>=20
> Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
> failing [1] because their 'cmp' command doesn't support this '--bytes'
> option:
>=20
>     cmp: unrecognized option '--bytes=3D1024'
>     BusyBox v1.35.0 () multi-call binary.
>=20
>     Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]
>=20
> Instead, 'head --bytes' can be used as this option is supported by
> BusyBox.
>=20
> Because it is apparently quite common to use BusyBox, it is certainly
> better to backport this fix to impacted kernels.
>=20
> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-=
cases")
> Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3=
-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mp=
tcp_userspace_pm_sh/log [1]
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> v2:
>  - limit the input file, not the output of cmp...
>    (strange that on my side, I didn't reproduce the issue but the CI did)
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index fafd19ec7e1f..bb26c406f09c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -378,9 +378,14 @@ check_transfer()
>  =09=09=09fail_test
>  =09=09=09return 1
>  =09=09fi
> -=09=09bytes=3D"--bytes=3D${bytes}"
> +
> +=09=09# note: BusyBox's "cmp" command doesn't support --bytes
> +=09=09head --bytes=3D"$bytes" "$in" > "$in.cut"
> +=09=09head --bytes=3D"$bytes" "$out" > "$out.cut"
> +=09=09in=3D"$in.cut"
> +=09=09out=3D"$out.cut"
>  =09fi
> -=09cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
> +=09cmp -l "$in" "$out" | while read -r i a b; do
>  =09=09local sum=3D$((0${a} + 0${b}))
>  =09=09if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
>  =09=09=09echo "[ FAIL ] $what does not match (in, out):"
> @@ -394,6 +399,10 @@ check_transfer()
>  =09=09fi
>  =09done
> =20
> +=09if [ -n "$bytes" ]; then
> +=09=09rm -f "$in" "$out"
> +=09fi

I think it would be better additionally remove the above files in
cleanup(), too.

Thanks!

Paolo

