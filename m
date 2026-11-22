Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795357609;
	b=EHSH2yCWN4+lnFz7CbDftvELRux/icNEg+hMwZhGX4PGtE1EyWnKaYPufFLKnvJtuDkl
	 W0iPk0fz8MopkYzSijbQDYr3ExdFQN76iRRFIGCVy49ACcdRIrGC/oaKyeeXUehIF+8Ek
	 fCStSBA5/XZB4knTpxSZ9Vh1nvBZyt+lQYS9NgNhE6bc7qEie0ahhkwnUTnBprl3STF6k
	 qqRtWN4sWt/LgNA/YF4XMUW4tnjdI0y0VH5RkGWRTjquyQfx4QsvHjUN7/Am7VGj3UIMc
	 rqDRFdYrzghRXMYVv3FglMVdBNHt89yZsD0LEELIFb9siB4ZGP7tygFF5+HpXRoWEqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795357609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=P8rFXFU6J9pKjCiMLw7UVMoh88KzGOshd22E3vRgYnI=;
	b=gBIucvl9tp3lYk45YdicgMlL+OwFmQIo7oY9rfYWkjh0P9pb9u3r5EqkG3m1VpsjUq6c
	 bvPQLmNCYEEAFr4aBIk7DdhdFgs6LN54j6JsrEvv3peMLtAcwSA7YGPQRj79W642BJ7pG
	 eJavUWkSnAkREgHeRwoJmE429QCxqPLXU2+CD48lbYrrJd0T3634+NJUJnbjnXQqVvZAz
	 Gaj6WGXhleythc9oqZD/oq3vycmR8RhjVp1Uxv5/uXTighUkTZlaLcWdnldNnKzZpCkQh
	 IfXY786mc30Se7Q4nh9n2qJyYoMzixBgkcPSkwIHfj7Ps8jj9m2vzaugQEKnk3mg4kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UndENKTo;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184B606A32A
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 14:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7184B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UndENKTo
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-921318b2eb8so35165076d6.1
        for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 06:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795357608; x=1795962408; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P8rFXFU6J9pKjCiMLw7UVMoh88KzGOshd22E3vRgYnI=;
        b=UndENKToTz0qsTpvhIXzq3G3mopq1KUqiQ8JLjsPMbuwwppAGEKbiRilC7YpA6TjUi
         W0CyOp1eqLvJwJN0Y7QGmkrCTjZ7hUtj0si9v8IMPHR+BwJn0n19rkHyNu4XqhyaRRiG
         4Hx/EyGTBzAw9sChnQ64I5psk/2LQln/cT/20I6U4Foy6sEddyHzNDl3ylRE6YWw05++
         hx/4Y7vuW+ol8TbdT2ouZ56X8Fjye+3jeo/xi/nh3Y+hBsFvOs9BI68iYDVN1+DDARb4
         +FEwwTVTra/a7g2vT3XXo0xYpfFWsIh5nx6yYvlekynj68GjFufZGH4ZCi8HOHWR9rYu
         9opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795357608; x=1795962408;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P8rFXFU6J9pKjCiMLw7UVMoh88KzGOshd22E3vRgYnI=;
        b=XAafyIHCxyWiPdOJULBmx9E8uk7Z/Jj6uLjlMbdRKrMC0kda0AT6GjsuCq1mMHiOyX
         Y0k86WvaOtM2CMwCDlArencD1hC+pwGLlldLX939j0pzmUz8tekI37f7KZ5373/jHIa1
         WgaXTI2aY8z7v2KIBglFOXTWALb8YYCTX8/WxBrakyRy+lHSjaABDTGiN1nBNwYcD1WR
         cmKej5MXqE2y8MV+k0e/GayFZ0pxU9W4Apms1IGMGQNBqAhWkdOb1JZc+/lkLVzVLx+0
         Kc6baNZqedHiJZjntQhsxM7l9vwlvOdcO1cM3yCJsYyJF6OBG0cufljDR/p27VL5FZDB
         Xh6Q==
X-Gm-Message-State: APuU4Z+QiyUhu6yOKfgF8C3No4EfV1/RESDpmSD7iX0ZvlVderLfvI8b
	0OOsWllOmjIIpKQcEnR4M5GPKEAIDo1BYEfr6ruzZSQnCU3ZtssWo5+FPu8I
X-Gm-Gg: AZFdTZfe4UENepyqf3ZBk97mFSSM4QbTW/IVvSNqN5JbKnt5ZQkuOrQOZwyoj3ObOZM
	Au4gjOnZiu24rHuhuzpGXkFolbEW/NOQ622j/II3hGaElzLWEh+wAUxvvn4W5T6Ohgk5Z/i3bEi
	Ls5/+M4Sdu96805Mflh20SNutt5FtTrZWUWXMJh2nlg2cK3pm9hZtLte0BBP6K4o2JZn+xzmI3m
	KBS+VpoJGbJPHFCyYcSdvj92uit0GFMbbqS+TM4nHW7ZesVGtRHt6jQjTjfc+0nzpZGyRMN8H65
	GKdsqnZNJhikjHEruQ2i/iE53Hy2f1rMVePpM8HYouO0bKxNTWmw7TJjhT4c8jmXoMNhFFCTtDY
	ws43x2bebg9fa7Sxic+7Kj4S03uVlfydiFqvdqp5CtFq7a/2fgKxUQItvVZWHN0x08aS7ZeE9EF
	QNNnDXeB++Ak6tQQ9pqs/4fPVmZedTDv7uweB/gkS819c2CQ5cATkRgDFNfrKK9SXQ4yA7OqZql
	rx26u0mS4S0YE/GljKGMRPB9zSt40BYz/+PX/wRZ4qJrp7v6QFOqtFA+bnoRl9tX6rjBsxvxHVh
	LmWavAGM3B7sCbFd0+uT+a7b3xZRrxOWDHK8See2
X-Received: by 2002:a05:620a:6603:b0:949:8d0d:6f66 with SMTP id af79cd13be357-949baa15529mr1262938185a.68.1795357608194;
        Sun, 22 Nov 2026 06:26:48 -0800 (PST)
Received: from github.com ([4.236.158.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb031601sm614755385a.6.2026.11.22.06.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 06:26:47 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1795348666.git.tanggeliang@kylinos.cn>
References: <cover.1795348666.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v2 0/4] mptcp: fixes for SIOCINQ
Message-ID: <b837d82d-73b8-0a4f-bae1-4babf33b9351@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 14:26:47 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): regression:sched-mem-pressure =
=E2=9A=A0=EF=B8=8F  (1 improvements, 105 new outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/450226=
23344

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/04f1867918c0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1218606


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
