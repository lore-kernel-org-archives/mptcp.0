Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12FB44F569
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126359; cv=none; b=Th+3oO+EGSZrm4q7AsLa50qsQwo8P8T6SWeXJvmocHBmU9yp/gqxHiZWslY3zBQy/HoeirXrsngoOmxO5fqFiAV/2Q4kRHngjdRBeSnX0sWVQBrI4mPoHQdl7U3fJJ0S4jh6kNs7HIA5nl0iZOUfp3kuxqMPJPuxQm5K8jl19HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126359; c=relaxed/simple;
	bh=xgFApmqvCS9lXC86xjcDndPlbtK3s29iepDSZFxUg9A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qryPn7WvO0f2rat0ZorYJYQ5RNQqFeys9e5ELgyFQxTyIbjneX/i/MqoKpFDYxPnWY+pwwVGKeZsaw/B8Esmf3x5wsZ4OczvAEsaiLbx7YGfa/DM7Q4ebXlMj/qDBUIv0+pzVkbEc2+beCVSRdLTR9wzdSNxWUOVlxG4k7zjPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7J6rn9n; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7J6rn9n"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb750so727597a91.1
        for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789126338; x=1789731138; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=55W2sE/eFUlIF0qDutz1/DNV9HLJB7sw8vBB1o89Oaw=;
        b=r7J6rn9nt9ujmqC8SiXbsfZoTMBArRxTYD+VJtsweJs/2+guRwTcw1ek9KZAKo7akz
         3MS+X6twQaxH2VWo+2SoqIEkc3GwnGeDP1lT7/aKXODbQvvlII8cP/kMnP8ZSgIQbH5e
         JXe7NEsEcALsto4tZMaM7xwIGuq2prRbQaKkk5deTz+XYAF2Ls391cQ1EMiOIzuq7WSA
         0NbGgmukNqVLkOqrMmJv9e/R0+2JFvQnc+IJwwXmk/KPPifpQUS6p3UAfoVM6Bs6T3CP
         T6xY2NOErzcnR2F9n7Ih5iDLBUcQGvlWeEUkRaWWOo9hWFyOiGR7Sh1Jsk2dzfAQ67X6
         JMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789126338; x=1789731138;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=55W2sE/eFUlIF0qDutz1/DNV9HLJB7sw8vBB1o89Oaw=;
        b=hazDJNZDJzXTwkE3wgw5rn+jwJeaz0D0dDiUfS8EtM24Lr1xQcDwL3XaNDhnr/egYk
         A0etqcQq9JOaxUWON8YSK2embwP9KNVeSro9n9xRbwWd3UXdunKqECQ7zfvYfch7WC1j
         wt5cl82xHvhvluR2eDOvx2vUEvzHgvMakuqbI+gjL4GV13xl9+T5qF99bGEwY2mVhffa
         P8SFYmGlGIol/PAZI6ITMSsaNw8M2Q+b1sMhS3GLLQWkYpJGmG8goolsMfNfytQvFmw5
         Y+3BPb790vXpb8Uj631jOJdqGtdpeQoVpm+cNK8OjKc5VjpYUU6Tv/tE2af9FLYLe43T
         jFRQ==
X-Gm-Message-State: AFuF++njagSuvdGE6KAg6bfIVSvSJFAr5VFQyet2+KhiWomWhsMLGDFc
	k4Uxmseza8RiO8g4YWrEWUOYr0aoNaKskxUuupLePcJJ/WT/Xw0yrZk=
X-Gm-Gg: AYBFou14MihrXbB2sOSTS31TDh10uHtvlQgk9J0+2yr++Yki7Q4BnasTN9TANKsEA70
	yxBP+ou18NopUH1O53vBN+Q6rpWU0wc+rjAf+TR/x32pYDxyAiKktSunbGwDQcMAlAFKk1VgdN4
	y8VmHpqO4wu1Rfoj5w3pvrsp0pLLCzHSnHLHUWNM8UBafGUfblLZm43P4q0JVlJKn4PJynQTT5l
	IVMCUXPM2Ese+xLhAMyJvelL8VbeRi+xkgOZxZFaT11mcbjUCjIm7DKPYWZrNWSlCcoqFMJF3+g
	up1WR8FFVKLoY+GwDIhGeY1W+TgdoEZhVPShrqDE+YA/ISqsbTuz5TsrBvQ5a/JvE6Iksul+Tn/
	/uEtWoJ6RZ+lG9X6YsKI5mOrLUx5hFqK8CsYQ4dV7Ik201nlewIXmC1MLpORBm18QIOwsf5CbLu
	GcuGlRh3hQmGNGpl3F71SSwF0E9kUrApttRlhWw2ZLNb+XzzfRmOvBjgOq/a4jdzDpNpyrCssD0
	ui8M9bPWgII
X-Received: by 2002:a17:90b:2547:b0:398:9be8:ea64 with SMTP id 98e67ed59e1d1-39d9c225ceemr7425104a91.17.1789126337608;
        Fri, 11 Sep 2026 04:32:17 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.129.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4fa50efsm6641048eec.28.2026.09.11.04.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:32:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
References:
 <20260911-mptcp_penalise_send_v2-v4-0-820f2be4a8fe@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v4 0/4] mptcp: sched: penalise a slow
 subflow
Message-ID: <8efff591-b05b-5511-fa84-ebbf9907adf0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:32:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/34588145416

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b027657feb=
6a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1162787


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
