Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024221;
	b=RbklCDPhD9BMe19MHMeOAgScsQh3Nr2GNyuLxrFDkCgmvAH9f/kLh6D2NxVeOkxyv5n+
	 z1mXnx5IIaGakcgaIFQudgOx/yttVRmasGQYYLlD7Y6JOQfa/hLMXmjAV/+md6dPg0TXT
	 Gzu8RJG8d0i0kosG0text43Lo2AqpWz3T50nlVvsuSVUiVVxDeEPb7X9aQm9IEqKNxERR
	 +SyYXwzqs8Fq4mQWJ3YiQHu3K4paGtVncVgN6C+fSFqln/mqBVif8EQi/5cRvfSAgABEt
	 /Q3jRPSErYrrrA+G79DUPADi5s0W24sJ9hCcEGRO4GVWinzSTDZulHV2SXY6ruU2MHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=yN1Vt5vWrlDXAyol28CcMWhHpYhdN3dopiVlEO5DIG0=;
	b=GQVCdk+RTeQbSYm/Dgph22Efvh9dsSimzAoP19/VuJix7OkuFRDWT5MfYndb7XgjFaLL
	 cnLuK1YVlPnmCpg5zpv2aOPCeM04ZaKAPFjrWU24FX7OlS3iyO8WwFhfidUIgthM+xt+K
	 l+MuD9Gs+ewGRdpBU6vSiWNP8EXP3hWWETBinPgUNMdbDpL40z2pwX7Fys8fhQVKmWXUo
	 Cfu+kD7ButpdNiZA6vLVTM3ZIOGhMH2jk3Go6RGOIVqmRT81vvVLSCPwvsiXcqEr5QNKF
	 Z7/ZxflUhMdHzIAG/XdAE4aiPcBVUFlrTYOdejI7Vu3bMS56ygvG2jMZb0+DygXbjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bC9Aaxbs;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6584F606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 14:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6584F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bC9Aaxbs
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6dd059478dcso2181101eaf.0
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793024220; x=1793629020; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yN1Vt5vWrlDXAyol28CcMWhHpYhdN3dopiVlEO5DIG0=;
        b=bC9AaxbsN695B+mM+XBxsVGy6SJeEUs3ursFzVhH9EMnQ111MUttlZwxIL6/xIfOnN
         NfaJ0gTV9MurwyFS4QP0pO/TGmw5skftsPYsqBfDiCywQ+19tHwcdxiE5oOtXo7GyYfh
         1dtIsHnNGG4JsubGz8V/gX8IxulQ16QCaL5T4awmI0w5aywTVXznx3UrXoDh0MKsaIz8
         SY4EKOROkIODy43Nx9mVlvvHJ/2ubhOZsCGOQRd9KQwxfmj/yHAraXZIgs7dmm2AKN7l
         X/Py2s97uEwrfj0FZhnu7iJRgmOLi9MWbvM1A+aeIOS2xjd/W917L0MB5oeA9yLtEzUz
         6xlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024220; x=1793629020;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yN1Vt5vWrlDXAyol28CcMWhHpYhdN3dopiVlEO5DIG0=;
        b=kDXp7ctjhUrgxPQak8SJyMNTRTg2XZLlu4unVvSDWcTzuNIgRoiQxNQqt4GjOoqGrZ
         kRXQQN+BdZ+lizO5fPHYiKr4ZQEn0xfcbX90ohtxAEkj3Xh/AlQrBa1wHXesPLCCsJSr
         mHHtLfgPz1UUMDWLdk+rKzgeANrPZ2tHVqGDs33G+LLjem4IPTiqEp/gWrYz7eEm0pUU
         PH2OkKolGPIxcf63jSdxj/xiwTGjt2Qv/06hn2HHQC7UPRyq8tB/BPQqhfYLHg24SkAW
         eqD8v0KQBNSCfbQ2mHZQyclHlEYtqQc4uQQY+NUx/yNFXvwJ/2MVcrmcFumf/HMnwiWh
         aSXw==
X-Gm-Message-State: AFq9FYK39v3sd6WIh0nr2p/rnY2ds+rgC0CNkPyl/OftcZx64x5e+N3I
	MW/9vPGvPfbixN7Kk2oAzn3n1T71jWkJ3mhq94pVcgMlTi1JfO6g0x8=
X-Gm-Gg: AYBFou1MMKt01LlALb+TavGsBE4SgJ6yT0+tV10zC4BQu9EDQjU8/9M2nQTCmLitkSj
	nh7gPY4FfDtRTAD4/7FcT1btEt9+5wMfPl9Cu40kXxQ+tqKmBT+B4gFJH/CzmoO1XW1n4r4qWSu
	fh0nOBM369zWKpiUYFAC52NN5fdnCHrrKBQ2pI4oTkcfqedei3OeM3HuqLj2yTLyCwmqX3yfnyC
	xoFkxxDXKcoPC4g+aqpBD24vafmDhpDb3YBdOyRILYCXOHr29KT9Gkpm61I4EADD9zUTpIGtiKg
	Chvj3AlGyR7iz8S1w7FBJag3J9Z/3ocssCxzFXvOOsMl70nWMYBkazIxQF+bc+scm5HziIYZn1/
	/nGBOGjzr3LTKcwjGVTXiGo1JY8GPRsFgexNihRpwxM6BG5NfeGKUZ3svFJ3pdwa+DKSZk8WbdS
	XTH8kDGR4b5rdDtH6wnkan5vAb6unDxciVdUTiYlBjKwq6294hSaHID2mdEZ4k9RKsLnKHSBIDB
	craHVKHnBSk4hpmYoPsBuUzfy0J6PfPb3SYLUVORjHgWWsrrjfRCJbcZIf2I/ZSWrM=
X-Received: by 2002:a05:6820:55d3:20b0:70e:d5d:871b with SMTP id 006d021491bc7-70e0d6cd430mr1009039eaf.3.1793024220261;
        Mon, 26 Oct 2026 07:17:00 -0700 (PDT)
Received: from github.com ([158.23.19.39])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9da521b6sm7503346eaf.0.2026.10.26.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:16:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
References: <20261026125345.3019372-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v11 0/6] mptcp: pm: in-kernel: retry
 subflows closed after an error
Message-ID: <5bcb9d6e-c11b-98f5-c6ba-df923874301e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 14:16:57 +0000
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

Hi Anil,

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
et-next/actions/runs/40329307127

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/11686de355=
1a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1193741


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
