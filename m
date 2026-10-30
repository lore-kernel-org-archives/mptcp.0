Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793344099;
	b=ucgLBJxE5zndGOnk2KMzxoz7TGvFYjAuCm/qFMtTRTCL6PvlHTI6pxgQ9XQES53MBPeU
	 Cm7Sm+JY+gD9Tjpld3E5ZoncRJw1Ool7B5detj9Q9iSakfWZymtQEUOFalYWVkF5UK3ma
	 JST32AxGLbAPKb6n7Itgg8zL+p+A85j/TL4ENphRgBqDx1GpWOSVpAM4o3+EXyPCRT8ZL
	 +WRL4chMpPAO0nd7roTGBukWAh9m2A9f32QJB2aEuHu5WA2Ms8q8khhsMLBlTIUTl5vG9
	 ipa8NMeIiLM9UyYlf61PNL9j6NzGppUE6gFGU/YrjhfoU2oXUjOKIc5927ggB+pshag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793344099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=5I6CIwasmCAh0nbrBAm6ioPtfl0vRJUiIi4qujgomng=;
	b=bGQnYJocPl591FdF1OkgH4oNPGyZ5pFg4DgSiAae/1kgOxtFNybPB7pFMcXMWrqymUO5
	 QX9J/VFMMScwm/PE2B4Xx407INvqgG567bJTRPQa5Tmx6uHvyjK21AvYFXMFKB7ztWY0i
	 Z05bZRnafrrw/Vl9dVsaW7VMJYscTCssvoc6zBzUkQdKgZwbXK2ozot+zOlH60AeNP/AC
	 CHKT6kGFpXClPeiCR4P+o8b8QXQsHyAZL9QLsrS5A2R5TfoGQNeDrWjC6IMIQ/VmKbgc3
	 layoeT9J3O2icjwHi+MuWF0sRkcj4Obf9o522caR99L4VtFIVknAhJE312qtzS0VepA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLqo68FH;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E579606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 07:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E579606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLqo68FH
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-55e02e89f78so109196b6e.0
        for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793344097; x=1793948897; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5I6CIwasmCAh0nbrBAm6ioPtfl0vRJUiIi4qujgomng=;
        b=GLqo68FHowJFS86T3QTazq1q4aPf5W0lmIRC4cqfxoS5aKdhNOJ2gT1Ix9OLRBWn6l
         YXB27LM1++tvxZmFJBVRW2OhreVFWIzIhOoYaDGgf1Qvf7LxomgqlrEHPvy5PiQnMJfP
         0EWy8Q0dh/E/UBaITdXdO6p/7+nZueo//mcmL3m0o6cnnvvi4/XAvutz2D7WnDpM1FET
         yCkWN1NMoNAGyIOuzJpnvKbC3NzxeQMU3O8zyCe08nNVeP3Ku3QVWmxEFsbu8k2k/Uq4
         +oIaFaPFowNCmMvu4Pysx7GPLJAN+Lm1MNi0bnC/Kgxf23jmj0xxoCDbIcDwz8jT8ybo
         Purg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793344097; x=1793948897;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5I6CIwasmCAh0nbrBAm6ioPtfl0vRJUiIi4qujgomng=;
        b=jboebbMPsuobB/JcREsH6A/irZbIuGHCf9orft/hzOLLA7l3MwJOKSPFDZPn/gsIuN
         W5DcjRsBy8Tr5oYVD1lqweyoKMYFd6mhzhktno6+s5/AYHEHUIiRdrAKYcdnfxqIMsVm
         qIeJ9yfToLK47jnVDXDYHMwFF/rDwwcvluT5XPK/EVJtH9GGNMtmXvh5tnTxb9X/Omua
         OIwZaja4xakQmBH2wcOVvPYtomIMjOqt3g/VmvphhwrrTzU17lUlg2x5UkTxx8ikSRwI
         zGThdLjaKVHKB4VuPbSKlK6vYNMgSbk7F2OdmpBfwX0NwWGYzzObX4IBfwKZnVatKH+O
         dUBw==
X-Gm-Message-State: AFq9FYIi2dtlbqMZzRm/cSMK0uiqYmo3p1KjflGifCwBwEWcS7QjyaWf
	yJVujJlXv/hputoXgJmsgBWByRb0IngI7GmyOMoG5YU50ndw5AZUZPE=
X-Gm-Gg: AYBFou20C7Lqht/6WdRdzSlP3uXEhhy2ETP4WYVJ3GFPNyl4znmqETk/8qQw7PVPv+9
	x1sbPjXmUXPLIpGs91AId8L9Gi4yes8TEiwmObEk9TdnVYAAatDnbotSaUkYOUxSoaROKATdUEB
	JjyAbIHc8aLahKbxeiQ9x+Zz6vcwVBAjpaVcBLEyJ12HBDqDPWlAcBG1ESHE2ujdpxN95JqxX3b
	UXqkH3GHKPjSB+X0dPO/tP3OJx3DnWzbhvPMVA5LS7jWMOLHGk1qqOmEFArNe31aI0FbWoOBaGB
	YsYO2QSjJ/+0CC73aavVWwJH1kQ6cUWRk7kH/8BE2EciGpaFMRhWxcbQL7U6ywgSXQEjdltRg8q
	L+xplPjxAEj73+RG9uc9+09jrHgIPb9PnalNQ8SxL7C7BrzRl4jb08N226u3ZEsm+airEHVpg94
	RsxPR8U+U765SqJwb0khEKYiM39tYOy/6yi/6vuRgEcjdL8ZmAVFmMAfWdFwQt8yK85d+TLC7hf
	za0oV2FPELAaKldbvLYSZlFToB8Lk6tl/ie5kapSezG+usiXs2GICaQx+9gqvEudo52CWn37K+8
	EIkVvDuoHXSkTdREMdblAM/slGQBwzUSQLI7t8ixog==
X-Received: by 2002:a05:6808:6503:b0:4d6:9232:b3bc with SMTP id 5614622812f47-5640ddc12d7mr1107929b6e.51.1793344097500;
        Fri, 30 Oct 2026 00:08:17 -0700 (PDT)
Received: from github.com ([135.119.23.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fdd2fb7sm975906b6e.10.2026.10.30.00.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:08:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
References: <20261030050727.3534304-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v13 0/6] mptcp: pm: in-kernel: retry
 subflows closed after an error
Message-ID: <b5be4967-8aca-4f11-1c0a-bf2fec33c3b9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 07:08:14 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): error:sched-mem-pressure =
=E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/41008476946

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/bb3a06a4b9=
76
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196840


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
