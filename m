Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D521D555
	for <mptcp@lists.linux.dev>; Sun,  2 Nov 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762086835; cv=none; b=qnAcTkupFiRp74bFg1kxC1kG/7+KXLshGmtXL+lWbC6u5lAebxrr+aNd94ByXLndMdTn8dekR/BdHLQWPo1RRPqVS26u68kfqbWpszPEFQzIuquyx7H9jOahihVkfiua9GoL1gH6hDptx9ffobO3PQzm4BM1OnkGh84DaqY0Uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762086835; c=relaxed/simple;
	bh=I9wHkWL8MB8xoAAemQ45nIHh4o137VuEtv+S5ZrVIMw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=R3j1PvFCX00o6E92fxZVGl/1KLQp0R4yMYf1Y74RmX87xEY5kjYSKSlg6BljdTpo5T+qOFfrRrqH4VCdkYYd6M1+BKHdOquWlp5CDLypfG9vmdLaB1IE4ej8D27CpoQxh6kiVOFHDWVOGBhszWxpMe+Cfj1Beveq77UF1m0dbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaOH43es; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaOH43es"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4332d5be8adso1911515ab.0
        for <mptcp@lists.linux.dev>; Sun, 02 Nov 2025 04:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762086833; x=1762691633; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YEMGSsjOZQPDC8rjvZmBzWNIpXwqam62H5LQndrHTI=;
        b=eaOH43esU5pe4Y8u39ZGMl0TQIKZX0cjAmcWiIc1gyYy68tv9yVAWqe6YoMQblVmza
         8Yp4L3PsY67garwQaWJfI1W1onJoHtQRH1Sot6DVC5dEgtFl1XeXDT0cG3wd2+icoY4I
         5aYTA4B8xF1l6H4cP2q/SBealjCIRuc6ImX5Opj16AqfuuHYDggeEniTQQLkhTTdyCK1
         pulvRFXEBX0eN+pCPadeZmQGNuBF504cClG1NDFX4XYeb4MciqKZ07wbYamyMgr3LHlL
         scm709kt4EGjS852soUXmJvhpKgqieSBnsCsKhkk5oaJnvvAZegXMnYvvdbNJgxw39ew
         NxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762086833; x=1762691633;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4YEMGSsjOZQPDC8rjvZmBzWNIpXwqam62H5LQndrHTI=;
        b=Znpz+wr4W3k6ZFstTfOrFX2ej+CacIwVl9iuTrkhXsNP/TU02DT2ElI/U4uSPnLREs
         tl2UoFAnWZHAvxWHLM8PQugMnHSZXO5QNWZVak9ESPFjGyZ8XyfqiDmO9X4zxO3Wcand
         JcAi8KbQqOXawCiYeXSeLznUOGMTEasISIfZ+Vy4gBa7I9E8Xy9/Tep8BQeEra2AKTyI
         UPGQpNdW0GADfcicvRK3DU9P86ibL3guGJ5nijlukS4wDBG6ChTleDaIyRiQvLKdYF6/
         RpuwpCWwfb9Z1lLc+FEE58nrCf6TDOH20FcyoAZulaEczblBsey4kJYFXPG9J4O2pAG8
         G9LA==
X-Gm-Message-State: AOJu0Yyd2ZbLtT2hJ2okW2k49LPgRjbMoh61RdnpbyEKINun0wioxRRI
	TRgLRwS+3T/t6Mya+hctL7GhTi77NB4jr7cyboiKo+BRfW48LqtIpZkwJKjW
X-Gm-Gg: ASbGncsxC6OEq36GY7icDG+8yt3nA+lHOYjdHJgs9dBc3GXQd3qLuKGNYPLmzUXcaOh
	eBLwpRnM0ZeD4B2XKtm4e3DflsXKeVIFiIpcesZxmQKsF/J9/hd7UQ0r6lI0PD+E0w8UeVNOTbZ
	wQu3id+FSedeKoW5XMUAien99HTxJZ/NDv06DJ8d413Y/+9wX1URDC9886zUqtKmWV3QKhgp2YG
	Xd4ic1LAS2OcRTjlAszXQWaL8GAAW8v6nJovzi2JY7/da+6wck19YI34wQxaNaqfxHvrHLtgTlJ
	uc0yzNRydG6qwLtPpk1xq+CGUzNhGMYLL3DM6sL4B8Q/BhtBcMNbsfSiADwH5nnCSWX7kvVEkqM
	GtUgnHq4JghZs1TbEqcP+Zh5SFVXGVFPOJ//DwqDC/qQysqQbijtLyIeaNdOJdUut6gUxeJ1f8+
	FxFOslYDRqFzPe
X-Google-Smtp-Source: AGHT+IHf/0ZlCFK1S2Nwe+bDLiT/k8f2CcauuDnVEPjiHU+LMWyBiQvXoiJ9Ft7r4+/6zC6m0ME44Q==
X-Received: by 2002:a05:6e02:4511:b0:433:1d3e:e540 with SMTP id e9e14a558f8ab-4331d3eeb0dmr58055845ab.24.1762086832889;
        Sun, 02 Nov 2025 04:33:52 -0800 (PST)
Received: from [127.0.0.1] ([52.154.131.96])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4331028acf9sm26893995ab.12.2025.11.02.04.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 04:33:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/6] selftests: mptcp: join: fix flaky
 tests
Message-ID: <d09d787f-de8f-95ec-aeb8-2d2148b70d2f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Nov 2025 12:33:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/190116=
45207

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ee5cae87148e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1018612


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
