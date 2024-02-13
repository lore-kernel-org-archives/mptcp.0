Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655A3FE27
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831360; cv=none; b=eyX0X+YQqGLpGsFKMCh4Y92S208y70XQ9PxZDmSRKE5w5+GAdkLCxvo6G6/rJuaRr/FjGc9l4wactzWwhxEM/sBG9VeGLGk35hlb9SuI2REgaU5JGej1qevC8/DJZklf0jcltXtSXGbKlL8QdZ8SOU9pXR7B9GCOSm16TIOYULs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831360; c=relaxed/simple;
	bh=cjlFhzvR26zaQxp6JptHY0SXczbkmrtanjgwZx1pCZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSgyIBl8pz9uo9rt/vIfxuWlSLv2IvYe0mfCOUPggkYWwYicAh0+0ew/Fe85KNHOMv8gIwB+zT9L2XTvA5LIajHh1pdXATJ2SFd7QtML17sRgUoJe+IK+RYCnR4UIceyElOp3EQSyDa3wWa09nsUkeKQ0oKyLgmVOHzc76aMUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz5nuEiy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz5nuEiy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5600d950442so4908844a12.1
        for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 05:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831357; x=1708436157; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSf2myVCODmdbJdRY4ZPy7mKcy2znYcBKlzk8TpJHrg=;
        b=Lz5nuEiyKSpvtcXN6uMxwzff4+5nfrYnc0rO0/tVt6U44qbUxum5ppR0XYRtN6UoT7
         EKJ3HVicFxijnG0Of9ItfqKwrqls9YPkaa69bEoA6b+CpnWCwnwqef0Ep5+xzP9DR82b
         6F0Sg8H/GOAQ5ANym5PcR5Xt9Vyj8jtWQev1h7yoFGVANwKSDmk+F+EXJVvrV58D8pZt
         1flQrV/mON2/ruxEnGMdsDlSWNfNrQjwDJiRAb99bHcevXDP2hwOuCoeRXiokPV1u66d
         RNl8gbImR2QDHIMopghQJWxR/ALiShP9K9YOIg3OIp/6CpHIPSrxDUygOVIccYip7RWn
         KtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831357; x=1708436157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSf2myVCODmdbJdRY4ZPy7mKcy2znYcBKlzk8TpJHrg=;
        b=qpqaUDOJQ/Ulr68Z+TylIgKyaI9iqIkMb369RhPM2hfsn3TypXjM5y9i0TebnV3o3R
         8+YfiuwAm5eDgjbvR71Fn2ALwuuWKXC/auz+0CZjXiXpnKwEl5Ec61SF7gKifFSlpnqM
         NF5rwME1A+8NfRDUzfT14i7I0Lr3iv3L/nuQlMA77BptUf/bgCDsXZJr4u6Ar/m9xGh+
         nc95ZUGNLj+yCf77ENRFmHq6Ch98FF0OU/DY9H+qpJ7YKmVKM1Y6t+WUSV7NDlCQjy9h
         sKwHRFFX4a7m+ILC2ZX5ZXNzpa07xosx2CkN4uSdrDtAfIDsjF5/PpfUWlOr7ViGBT8A
         mtuA==
X-Gm-Message-State: AOJu0YyVB3TFQua12ffujt4Lq8Kwq4mIOGo58OgKr/lNeKLk6X3A/Map
	33fCWKLj2dmVe2ci9Z080n0ZoiuHV/2XRojoQ2OXF+BZ5oB43X+D2hH02oZn9xrPGl9WqNMc79P
	OpYhqHUXA8AT8E3aQurpeql+Xu1DWMCHPw1I=
X-Google-Smtp-Source: AGHT+IGVZy6h/3bsH05MSXcj6UkueChbqG0FrRsUv0X4HjrQefb1FHry6NauF6PBImjy4Z7MvynLbTDXnmmZEUpNgqs=
X-Received: by 2002:a17:906:234b:b0:a37:478c:6021 with SMTP id
 m11-20020a170906234b00b00a37478c6021mr7738673eja.76.1707831357080; Tue, 13
 Feb 2024 05:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org> <20240207-selftests-mptcp-fix-5-15-v1-1-005b0cdb135a@kernel.org>
In-Reply-To: <20240207-selftests-mptcp-fix-5-15-v1-1-005b0cdb135a@kernel.org>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 13 Feb 2024 21:35:45 +0800
Message-ID: <CA+WQbwtXWKNpKDQ1sMF-7E-ewx1Mh09sHijO76OgVR_xotLkew@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 1/3] selftests: mptcp: pm nl: also list skipped tests
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts (NGI0) <matttbe@kernel.org> =E4=BA=8E2024=E5=B9=B42=E6=9C=
=888=E6=97=A5=E5=91=A8=E5=9B=9B 02:18=E5=86=99=E9=81=93=EF=BC=9A
>
> If the feature is not supported by older kernels, and instead of just
> ignoring some tests, we should mark them as skipped, so we can still
> track them.
>
> Fixes: d85555ac11f9 ("selftests: mptcp: pm_netlink: format subtests resul=
ts in TAP")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/test=
ing/selftests/net/mptcp/pm_netlink.sh
> index 8f4ff123a7eb..79e83a2c95de 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -194,6 +194,12 @@ subflow 10.0.1.1" "          (nofullmesh)"
>         ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
>         check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
>  subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
> +else
> +       for st in fullmesh nofullmesh backup,fullmesh; do
> +               st=3D"          (${st})"
> +               printf "%-50s%s\n" "${st}" "[SKIP]"

I prefer to use "[ SKIP ]" here. Otherwise, this series looks good!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> +               mptcp_lib_result_skip "${st}"
> +       done
>  fi
>
>  mptcp_lib_result_print_all_tap
>
> --
> 2.43.0
>
>
