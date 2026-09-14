Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973933ADAC
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412297; cv=none; b=B/zHO1ftDUDTl+3LcOtKSWqdQ/OYQnM4V86znH4yp0I7suJ61hRYsjnW5+1dwGjLujnYNP/Xrrahn7rmkD/Pc/SoYw4ppcJdtBC9q7lUTg8QI6y5fv/hX9BlBQn1ETYpW/FCvAR/z6uJwSM9WnVaz7SD5KOLcNW2T3hOuDnHSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412297; c=relaxed/simple;
	bh=Z2KcbHbwPS7MXuT4DUH4+GG4deIkGANiDtrkoTbgmaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ceaxTEFFdhpQ0aADazqiGR7tcaXd5PGVCgMSWsI84XYD0SuoH1Ph5tv+To9riXCS8z/07TP6WyonWsDADyOXMkjUhVllnLz4xel+dQuJqlYGoz2mUjgGn4rCAuODI/Ndbb/njqMmwiC/qhTpGCssi/hUyP4QP+eMWOrF9TrsTNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj7hz0sl; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj7hz0sl"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52ff0eea420so1415011cf.0
        for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789412295; x=1790017095; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CpTsha2rFhQmmzERkg1WqUibAGoFpPK9+/5qZLrRbTY=;
        b=mj7hz0sl7gMwvUV2EZUIULI7E8N/2fiqt7pYpwI801CoJCXr8NBTaf3HacYcZAoDQu
         oBniFQDGHm4TQCv/3AY+A8l/o0oG7M8Y4Z0aWurh4Ms03kcBVQKEmG5uo2h1hHTWMsGE
         0gVcTm19U8d4gAKTQS8JehiEe27IPvdC9sJ+sXYgekIm94xOG32bIr8qLMhUB2F7vkb/
         jsL5VCib5GZIClletqCFsemxanPEnzKOQ1AyWfSOKsG8hIwNp7baF0GGmKRQKVwlJpCw
         0Ib/ItlVFPhb6BfCTQw0XOlH+5x83rRh5Z4BDpUDw/j3nqYvCPZxyEREjfCAws6JY3No
         OgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789412295; x=1790017095;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CpTsha2rFhQmmzERkg1WqUibAGoFpPK9+/5qZLrRbTY=;
        b=L1vU06Qp0KI8ajiHEU5edcAa6xcVBH+ixxNumA++tJQXmwb3oT6S1NnwgIEO59IYKB
         eIZ2p+VRSUESvv7GL5jcjQM0Y5bzEv1xhTwaCJZtb6eVtZq9koBgCnt+cxo/wvIorWCG
         AvNEMxGpvtLFaB+F0uqVtjEYIoyt/dN7fN8txhzbL5G0vNZQghwrJiCRP3t8Xwyte1uZ
         M4c5rp0whBiCAb7t/9DmAQWduV8rilO33qyXODpUMFBsegK6aonsnv2KkV3kBk26PjRe
         aOX1fWIiVSexFUdutzgs8gYCROE8/P6MDH2gifkT9LT+TX0Ucij+AGRmjrNRbd0voGj2
         A0RQ==
X-Gm-Message-State: AFuF++kYkV/PjEXeb4gHeR82dR/ZPQs9jiMSvNcVS3gtXqrc9ESO/jjz
	B85/okpnv6qbUJj6ej8r5Dlnlw+ksrTvzoPZvUjnJXRHeUXvUbkcftM=
X-Gm-Gg: AYBFou2SgCz/0YKC5Wdb4EF8QM+5IXGDZ1FXBHYEasbcOQ8nQ5FGrFE1xPdi0Eaj5nf
	BUIbiNOXeN8DlubdzcOhL9S1Mw9/rxo7iPGdXCII6HpOAV8A7H+LEeBclTP6xZH0nLfJQNswmNy
	VsLtSNRBFmrONBXpc5zRrzd5KePvETW2Rkr7Nuqd0Tw9wmlpfHod3euz3rFfzx7E7uOHx0Ru9t0
	7/S0Ulxe/SHCDJuvoOdes9J8pdkNHaaVme77xWfrHlDUGJHo5p0G4Fd5+kjgD7xZCrMC1ywHDRQ
	uH8ULBvH4DJvldDbNnVuyWy/0OnEeczVufynpTK8H+V9xHt+L24QNGFTAfOItyb637o80AqT8BZ
	LbVVRmUGFzCbw3yIvZ0Wo3r/cl740WlS+EYDVBGMST1iK0xNYfvAlmnVG1C6B9hGjDlY0lhTX2h
	AN5JpLtEcAlv0OZjU/SxsS2lfQld9dvEZy6Sfh9Ym9VI9Brvyu7RyccJPw9yf3/DUIULEhOkGxW
	k/u570GNTA=
X-Received: by 2002:a05:622a:351:b0:530:a30e:eb96 with SMTP id d75a77b69052e-53119f2527cmr10293481cf.35.1789412294585;
        Mon, 14 Sep 2026 11:58:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.183.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530dfa7e000sm93432131cf.21.2026.09.14.11.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:58:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260914-mptcp-sft-join-typo-ns-stat-v1-1-30d5a5802b57@kernel.org>
References:
 <20260914-mptcp-sft-join-typo-ns-stat-v1-1-30d5a5802b57@kernel.org>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: dump stats with
 right title
Message-ID: <7fc3cc6f-a248-1bff-d891-23cc5a507096@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:58:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

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
et-next/actions/runs/34878576649

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/88a039d1d1=
33
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1164806


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
