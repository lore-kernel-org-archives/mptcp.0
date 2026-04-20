Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B23876C0
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672898; cv=none; b=M/IRyniSxQazISzc2Xjn09Lf3b/lplW+F5g4BLaC9D7b3AoJuYTEtcNN/iqycfuxpLvPih6LY6g3TNUmNW4HO9Vi7UqHhBWmWg/dYGlqZbRTohzOAs2wU1NL6kuk371r7mRQ4WPZ//EaGi5T4lQ9dnSgpd9BKUTwfVMEvuJBCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672898; c=relaxed/simple;
	bh=yj3bSNSAhZ8HRY44fVvKTLCPmd4ciDnfJ9bQHXtaHkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=O4Zuw9hOF2iGyldOw3n+hz1ZtfWsSoFgVhzZLAHFnjBt6ASPmpNTQRNdUQO1zlLDPszjgp4tdeaBMxDLyS/rw6ZhhzE02XijT5nYgC7ydOa2FaFDGKINL+vmKt+I8/z+Gk6xPkuESNhUSYmm5hZfKP1lZ0c747380Ht0TxA30Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/H4NtDy; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/H4NtDy"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so1663116eec.1
        for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776672896; x=1777277696; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26HF2gTe/IIOWAIanI6JD54fQPM447SChmcVkqPBGOA=;
        b=d/H4NtDyavmFHPEDsILnXbJRaGJPDI49qRSnOFEmOnSoZpvCPQEu8GJw315zLCEMHV
         MCdfYdGLdE4MIjbWl7CD4zpvoQ3QwcGx6tuWMULW5phvEcTGmGqJpZITjqoixIzMF0+H
         VZng8yW3tG2ZJpMefsQH5+vSLuDGrS4B3dv/gXNSVu7Xs2CgDGV2iwMIpUhHge/3S0r4
         kRcE/xNudNDfVdF0xlY+kpvBLQoX00bM4QJ9o2tDFgkS6P80u/64bnr7BM6z74d5FDlZ
         4GmX73lGTfNsfeFFMD+V1nKn1M4Z+bvF5KCAHp7+pn4VgwpMjKwQjm6Vw4wkFbJuRRyo
         pksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776672896; x=1777277696;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26HF2gTe/IIOWAIanI6JD54fQPM447SChmcVkqPBGOA=;
        b=qjP6ZsAppgYi52jLfemU5nZC4k5cYVcZipqHML3w389K4DjPpzk8hu745h70YVYR4f
         Xmzj6fP/PC/hEkH+5/+a2wctRa7VI+qzuT74ZDex+QptktQ1eRea33mYYEcHYhuza9ni
         oeFsz/AfsqtfMIyvkGOMxQ27tj2rQDYTknfyVu695ZkSedcTHrwBVN1oRTZxhLwqrQ+l
         cOuRGAuOCwPH7pw23npim1VO0LSWuHQZIhjH4mGMAaUglSxozMJ2CUDMHhyGTTMKNYSm
         PeCCNfMK8eYtEQ79kR41p8gMd4lJ5n1jEm5+414QYmr9WhkTPDAG9/KVIqq00EPZ5rW5
         q7JQ==
X-Gm-Message-State: AOJu0YwRnnEoKcl+8jK7Wv1nmuEOPE8Qdq3mdiW8os90udPkNgqfkbLb
	elzSDEhnKwUvMPp8oqR01A8HVK2Qg04ohGu3cQn7yAiLR/yPNPtVpPndQJMUYHo=
X-Gm-Gg: AeBDiesn1mpXFfNweypFi+KJzuyeJWrO+LPeODzFlXjFJ7dDkAgFacEdoBGk9PSi29a
	RyPz20KN3S43Ohu6vOivYsgXPVv45JjcZ1GaY2zgktsItSq1ExJD8ZlFJRQ910yPg+7YhMGLT/3
	BfZpsBBDZmqLMlvW1oKZ7Nkvf73uUREZYLaLtSk8CX5P/gG2/3nRU8i7knXEWc8/pz8TK7gz+ms
	pRPdWtzEtPn70dYxdsgIZawE971KgGQOXt2CAsyXBKM5jySdXs7bH9aKLTLfGzgCViWxF2qCwxh
	H2bHgEOasXjS8JU65iKyNH+IfBNt7eHnqWE2OJXItwK1ivgl6uCA5aR8AnpG6RST6PssxKCwMO1
	ggSfJx1rFN1tISqsjXKJYfk7ZqDf0VBW4rlI2eaY8NADGRlngaG0na3F+/YCs+Spd4ZbncVaIWA
	yYBbMzKzZuhZH0+jytCEOzP+L/DkP88OLTrSVK9MG3cCm9
X-Received: by 2002:a05:7300:dc05:b0:2dd:6937:79c8 with SMTP id 5a478bee46e88-2e46519e697mr6681367eec.5.1776672895963;
        Mon, 20 Apr 2026 01:14:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cff04sm12839163eec.23.2026.04.20.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:14:55 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f6a4cf56c8c361d3e7373d83fd3930bd28600b4c.1776668161.git.tanggeliang@kylinos.cn>
References:
 <f6a4cf56c8c361d3e7373d83fd3930bd28600b4c.1776668161.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH] selftests: harness: fix pidfd leak in __wait_for_test
Message-ID: <d52b6937-e58e-0527-1d92-576b6ac66fab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 08:14:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_mp_capable =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/246537=
26761

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/08cec27d8824
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1083166


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
