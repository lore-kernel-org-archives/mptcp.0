Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D421A449
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980769; cv=none; b=Gm/Bb7RTK2cRRvkhZzztHB7ugpV2rFFZMmKVsGn92N0TS38e/pOev9dQzSi2yyR+5VoRcceUAc/dTdsm+/0CmB/GfseGUpXa9Vu/YbeZ/x6tg0Cu2y8PDFzqTeMZxyC6e+crtiYxdObhKH8iVMMrykNWdj6MS/y2oZOdlm/idG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980769; c=relaxed/simple;
	bh=G5ezOSZFTACy8mi9iJAFCx6ae8+JeB8jrI+GDYK63WU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oPs+zYofAj2go4evcnKZbBMJdHQrPBsDg12HlasJVEAioFllGw6VHf3WA03eeC3z2X/ahPDXzb0VoIEDoosphfaHC5ZeYapUMJpZUEMJIrVhi1fg70+kngS40GFrgMYZX+JA1CSuA6C5F3z/KmImuGep1nC1izhOB4xKYUKGdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSsB9UrX; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSsB9UrX"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-43377ee4825so19099815ab.2
        for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 02:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763980767; x=1764585567; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvaKMQ5hI+n3VXUZHWodEWPdzoY2FAQb+mSPzHP9SCg=;
        b=CSsB9UrXs2nozO9Ptqlwg9scj2cduE3P17OvJOg0OBBpIqlYwcDO4rTA34SM3Houjq
         KEpPBYwsczTzq7OJSsEeKQaWY16O4TNYYIrHA9NLHpYzYuxOjJ9u2UCvkIF3j2uf4Vwc
         XC03dxpMWySprE5cbj4IUWViVAkR0QVjfmxeAYKur9y1LWm3TiFuemTFdZjht0N+0Ndv
         eGTA48DWnXefPQUEKoRPpzJjedCUyeqXGmfqwobkct5NnfUHN3v9TpnIC2w3og4HHJOY
         kTrGKo3gFoWtmbYtndzAI/3m7fGgFOCHsI4NXGxMKaOWIuMkecHWfV+XS9EJ8glCrsJR
         voVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980767; x=1764585567;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvaKMQ5hI+n3VXUZHWodEWPdzoY2FAQb+mSPzHP9SCg=;
        b=VAsv2vumfgfDCzLjkwhoKZkG4FG6bVyTEgbDg0clNuAV0L5vxqnmNoQ9cdoVb8vNYE
         ac+ObuMXw7NrZG6DrOWbG2Q3wIgxL2U+Mz8FRBZI+Xx9cNw11YxX9FBV+zmYyRjzg3zM
         r8AXMRLnlB3vpwyIYm2JPmrhqu7DOWoqvCwxm8aX/4x2ob0m4z8zdvXNtDVmFOjNS/fn
         90cPUshwfdcfezbYQDuq31co2tCCD5bDeG85G7wsLm3Pv67ump0zScFLy8ezUuRewttv
         iQevcS+aeNrhJGAyuuHBgB3Szl+LK/Y2VIIok6kujJhcnbzdHttnUyKOrIVVtFy6OH6q
         kbFw==
X-Gm-Message-State: AOJu0Yxzga174n0Vj3+vQYvVjFOKF57oBhvURtiOmTcGJ/EUQjzphsEK
	T3mvHdCVgWZB5g2/nYGY7KRVsCdk58Xc1LvlId+OlpbNrdyv4X7w8o50lh8Q
X-Gm-Gg: ASbGncuTiVU1KW1diZ9F2HryD96/sGyJ8Hsq+NMBRmLKRFoztuLRqYbuwzZ7REo+F5w
	tZpZ4t8Js/ZH5RUI8bjlYF5Fsb6gTKuIMsKXGktyqyYWSu7WZXkTyzB0Qlh31LTr04DEjvLRFN4
	oVucP7bKUBrfY+g3IjOWz+/l/XpkuXgFmDQZo98aFiZNakh6ujEM4rRR0Xu2qhB5dFPDk+rO7Lb
	znwCNv9fYKbXxaELv6uzstFUog8ZLLy7GaTapexNUfGE+RMxoPaZzDhX2HIkwRIuEBd9fCdolUV
	O90Xh3gdrbDQm02PzUxJvDoXqhLvh2OZeMHgq/KHZc87aMxm4+6tLPKGCDjAme6Onq870HpkGwz
	9vNO9Gks3Fz7+PUhqH19+0rlhO4fk7TG1Ey5NiyWUkeeK361bLMoG/nMR5NC+f9hBP+fY5HLHBY
	CJKi3vUc3YjZRF6/CmEsqeezkT
X-Google-Smtp-Source: AGHT+IER0/+Dmta0yV8umnkVsdAiYvUkaU6294c+DTUPLwlIU4DOrl7kBPh01Wj9hdfdpDwQDiTDPg==
X-Received: by 2002:a05:6e02:1fc6:b0:433:2091:8a86 with SMTP id e9e14a558f8ab-435b8c25befmr93966705ab.6.1763980766622;
        Mon, 24 Nov 2025 02:39:26 -0800 (PST)
Received: from [127.0.0.1] ([172.212.164.19])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90e707dsm58323115ab.30.2025.11.24.02.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:39:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763974740.git.tanggeliang@kylinos.cn>
References: <cover.1763974740.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v14 0/8] implement mptcp read_sock
Message-ID: <c12c0c0e-c4df-5d27-4a6f-e6f84f472ebd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Nov 2025 10:39:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/196295=
93335

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/600285bd8e5c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1026854


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
