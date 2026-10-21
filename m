Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586122;
	b=4Sw4CAgMHMHC2o6RSeXeJ70ry5OCFc3DLL4QCDIxrgfuAyqwfIjiGInV+6EFqukv6ogi
	 dYZjM9gPgycGbazdLohpy2uugwC3YpBXVj97j/h0NW8jE/XswbFmlT9uL7qN9sk32Jd2m
	 mSZNuYNXxz/rkDgvAJzCZXD65cygD/5v1NlHckM1MtJTpYwfFgxqISG1bePNxB/lqkJ5+
	 WYYT8+DaSAUR3Sk95IKUXY+aeIa8EiTw4G1ye24ES5Ud6YgIgi5AkGZPW9uBN6fI8+MdI
	 0iyCXQl/sHoLKKYxeTHs/q45eG1JrHU11V3/TNrWpbm7JSWw4TYoZ+ujy6Xj3xiQIWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=blE86et7clK2aS40mkSV+3WARMewsTYfjamB6DWKhNM=;
	b=VAHf2nQe6akV66eqVI8pMiSwtxi1zPvn0UrYprm9+dudsmKfmsi55ZUcuiR/iyOVK+LY
	 l7k2LiU36qVMf/n0TV4/U6s+uD01B1LeAw2RZs8TDwqI1Z5iCGrM6bz/psb8YUxyNRItz
	 GZtdknFxjaiWBu/3g0DfirUWkjMObvwzrzHYTn5HcP6nRl9kSh6EMlnk07b0RzG2oXvqx
	 m3yy5jK4RF1srHBNg6ntNznYuKO6eyD1iWDexoJhBQcnAulNqz6Fs/8//7EjcvWQIideU
	 lUoqRxSH2fG6fPjnhIwiWAmM+OK6VPQ+9S/p8S2Y6l/mfApPuE+Y/GUZoE8zmi9tD8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gLC5o7wS;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED67606A32D
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 12:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED67606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gLC5o7wS
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e63ee7b4cso79392485a.2
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792586121; x=1793190921; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=blE86et7clK2aS40mkSV+3WARMewsTYfjamB6DWKhNM=;
        b=gLC5o7wSU3anaihEupSf6VdopvUA2UdepwZnx8JoEIzDMmECuPglIlDhZGlOyDRz2O
         ksmE4WUR3YXtThrQqP9DlyqOwi+Cd+O3pABRasCHQPVtYLXXykC2fYJ9HejPD5HjwVXG
         DFhQcUW6A6P0Sp141ydIiMFseFLqLzm1kCUocGZnN2tJFt18f1+McG+gVY4PQbUCr+qk
         EM31iMkiG2ULqrcg0TZThUxHuWqATUHuWuYBjs2ZRaYbgD1l15WILQjL9dNhU5XxbmAJ
         GYGQGYZ/1eUOdAat7CfTWAssnAse+PoNpbG16sMut99OXZ2W3O6CIfnr89JjrwTVHVRC
         fRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586121; x=1793190921;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blE86et7clK2aS40mkSV+3WARMewsTYfjamB6DWKhNM=;
        b=XYAUV4YnczuEfP0wdRiDn7Zw2iIlXdgaxUNw0AKYjemFuvhLBz0u5otAdrnF2LkAGf
         cYb01VfKOt6w3w0Ck63nB88nXutHVpg1MPgqjCbCLcDD7c7qSv6aFnj0MtLdORVNDu3N
         0DBuYFZ7fNh68fn5Gy2bhhF/+oHiSBWS7e4p4cCCj7s+GhI/gdk5AaGHUfmpXeTowrSe
         TWxDCsc7Nlz2nGPgOuE91WOZG9hSkTFQ6zES+11tDb5htApFRAud8gh9SlIueNefIAVe
         6TW/fMHCsFU7nlnk7XIDIeE7G323nwCZ+XY4W9lJ25ctvIsmDoiFmZDxB1JtQsnFUSTl
         k5Ng==
X-Gm-Message-State: AFq9FYIEBdwfXyfDrdXLTyYbN84F5/H/21PmzF5FetHBc0PJhcW4wIV5
	qzP81Z9xr6J8bdPop3Otv8F/nvvHWz2lOcGtsPRQW1vGz2DGdEONaNw=
X-Gm-Gg: AYBFou3S11frV5kwmtsrKdy9xB0Or4hyYxB8xQ1hXKD/jS5jIbUZkQ3z1SGQJh4bkgT
	PtlJYb3DKo1qqVEyFa5jfIUH23kWR/SZ99qOVFprdSIX8GVpFb0AodFwjgwYcqqBqgLYWnn4wtJ
	oG5+OwnNy09rVYNmNrDmAwD1MG2dB8h7iW2xxXu/AMxdDyesFTJe2vRGVkUx3Y2YdN3l8mkt7CH
	G6SagL9Bx0bLKO7xYegg561v6aiXbh55ZKPf5XlQx7k22EbtGoNSipCXi4IwDdHZw32/6tJuLbU
	PkxPwwNFt/PGU7QibCH6OygOV+47UWmxNl4Xn504mTVckfwcADUYhG5BB4LUu0mfQwL62yXeLj7
	QYXricQo6bLGUDlGHmfBZj2UqeY7bat13wr2NrX5BHDNebDIeKMPJUyoHx8jqxvVfLEoBfbSXuq
	RIs9tdZOfcZsJD3UZeO7OxuaFBuO04l9p29T7QMaIla481A4zcn6ZwlSIRo7FHBZa2dKNvjMNA5
	SZ0Lu0OrqlQGFoHeIlZ4sw9+JJcJ3aKFsFCjQV7rbc8EjXIwT0ClPF9WM9btjHINJK8a3s=
X-Received: by 2002:a05:620a:3707:b0:93b:d7a0:d9e6 with SMTP id af79cd13be357-93f5800b976mr413051785a.64.1792586120798;
        Wed, 21 Oct 2026 05:35:20 -0700 (PDT)
Received: from github.com ([172.190.119.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56de57e8sm246297985a.25.2026.10.21.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:35:20 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
References: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: echo until EOF on
 partial reads
Message-ID: <39ead063-2a52-4ca6-a951-49f071ed504a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:35:19 +0000
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

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39578925751

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c9f4681b9f59
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1187922


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
