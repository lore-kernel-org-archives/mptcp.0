Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4A1FECAB
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058780; cv=none; b=ROn4/qkjqQ2e0PhQLdyS25N4cmyoY5WL43cPiFBufFxvJMtoSOWE/GWM/BAB4k1D9Zrw9XPUHxfDgapX2yV2VVme2ie3iN/HIcBKpxnrUN4w0ncb6khTnYBpfyWmIfahh5mqwkiyb5oRwAc0p23Lw0Qwvm4ZZNm6LF1C/+3QSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058780; c=relaxed/simple;
	bh=Ehrh5uJ/ADb+VO6siD6YyUuOLz2abUInZJU7qnKkSWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=UFfwPH7d0gpcH3ECPhbgCE5PtlWl82JFDi7ua/xbfpWjHDwtPr3awoyuAUQJsd5/rusfUXcTu+8tPJakqjRO8gZDMK2g32VKDb6VUg5+qEo1w3kJf/9L7K59f59HLTVa5Eyg5Yce73t3PexmIu7Bl8uX/rzfeSltNMnOKqJ4G2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo6HVl7V; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo6HVl7V"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1370417c01cso6511349c88.1
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780058779; x=1780663579; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nT4Lpx0yZ5CRHImi6desmhOIb53PKwm3pTHTSNx5FhM=;
        b=Oo6HVl7Vm5pr6N8eARWIOpB5Ufy1k1j3g3hXYTpllT6HF9GnJtHIg25rLtA3Wpc9Cb
         1xslGck/2inl/u/nCOpioeYu9AVWwsQ6+9kFEzbtN1DFR6HMmba3do4fzdtfuopPj5q5
         vWKfR4wLEfupQ+aKWJKFboFeOyXdsW7xZ51QKTKtLPwhwEikK6ryaj/OsU5T0buvKZ4K
         JYuyJnisWCmFu+anNwjxOGshXIwoZgXyKpbL8LcYbJq7arQwkzet5AGwOJTwfzpMttDX
         ZZ/XQvwMTnCtZ6p2srK0MpAM5smKG0Qu8keeKgCQB1g8ckKaULnQLGM7QmkmvkY1SMM0
         yJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058779; x=1780663579;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT4Lpx0yZ5CRHImi6desmhOIb53PKwm3pTHTSNx5FhM=;
        b=G2KHWjodLuO4kfus7I4BOSz6DsBh0aGaZfdF5VDCqMMTBwKtC8/+mw/ClmhFMZtDCA
         +5ac6w5t576Pq1gvCS7NLPpsNNUIal67AR5CuaV7OCa5mBj2zblry7pa3IC9sDjB09h0
         bMBZDKDn9BrKSHg/wqWk89EIEeuarB+HtllW/taWv3XRjFGrEhngmAAqYxp2gR7EjmaY
         RWTv+ODAijSuE3ynB45AvALQTiLMhNlPU8U9TfEQMfUbH1/TW6I3OIF1+0aUG8XzBPHs
         4MYJmQeRNCRehXQf73sjAbDM3+yi3G7WlijXSFh5upIVd1WqOxZ14jDwLh0b5toGAM4v
         4qHg==
X-Gm-Message-State: AOJu0YyxMiRe4XhJ564NGH49O3S/gLjVRHaV7RSUdlrcw9LcdXmk09eg
	oEPLivZrxsOO4lFrb5fXW6sOdRsiVyosS5pX8leBoQr1aFvjNMBEqEM7Vm3Q
X-Gm-Gg: Acq92OHmBUdTVOVeiJJ/fvQOBBYFbs6fbR0xxgwnTzMUPMW2UP0gWXK1tm0/97nHGvG
	hJ1BgIFzUT/TLty/nlSp52LWOnk6gak49HdRXRBbYgPrTcczpL0aoOrYchBKEUYbjZrJMDiO+mQ
	nYC0wo7mVPwp2kw6CT+IUpSqsWnXc0+LK15mGfq/VRUfW5ZWAfU0hMEjNYWdfSrxTDqSo5hMr+m
	vIMvXFd9E2niZNJPQtgN3j1msr8iRbFCJalQfIlJ3sCTqmie4OCMnTimRYajXZkQSdVewc3o8g/
	dX8jWEWCaaq4cACQmWX2fMYWu70XfJy+LuksD+Zgf0HIfnnBENgrkTDSh/W7752kVn6qXGrcwUX
	KhdaV9Wd29wn9n/Vvy/qfo7KQLK9NEMNkx1q9ouXuGDXJmtp+MV0VT46jhg/sXEbzigakXz6RcV
	vkBPpMXC8sPlnDTnu1zi2dL1XN/dt1lc7ZSa2IHLAHJ0Jve1oH
X-Received: by 2002:a05:7022:238e:b0:135:d7ab:7ebb with SMTP id a92af1059eb24-137af00c6fdmr1068473c88.29.1780058778587;
        Fri, 29 May 2026 05:46:18 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c7e4ebsm1153886c88.12.2026.05.29.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:46:18 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v22 00/20] MPTCP KTLS support
Message-ID: <eb31b639-67cc-04ad-7ca8-e34d18087c07@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 12:46:17 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266347=
97129

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1a53bf73533f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1102837


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
