Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74935947
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223772; cv=none; b=fB/oiUnCeL2jnFUnFLAOWB3DVenbDWtRGCzbb6V7j/1emzbJF8oPLuRfBQQClHTi2rXQubQ7C6KdAB9KCSq52QxGqPG5OmJL0YPAeVd2phqtDHH1zzQHCbmuj2tQjNNgeI7xUzhEk1MPD902C+U/DMMKwxQWWRXCsHm5RV18lPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223772; c=relaxed/simple;
	bh=vCM98rNKnl/alIuoPpgg9dW5TMmCnTg4tkpNmdc3zvU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lxx2x3pIOVTsqUBxgztDj94Tzq30PMYTgyoMp4wzk/rrwBHX1JjoVOXzecl+GJd8ACGjfzK5meOj1841WPnVmXWb8mIhMAk434wq88MbU5QRuS/4EZTZjresn3VmZEuxjcZjqsNXKkBDKzw+7ojmKORT81gyEcQzMqZUe+UABzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvGIACaV; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvGIACaV"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42480cb4127so4356915ab.1
        for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758223770; x=1758828570; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afC3kCqsZu3z7S6srL2GfIhbeRsnA4U/Vx/e0fJlivU=;
        b=kvGIACaVuiVDdqFNbeGaQHWUbsm43qeVvZotXXDS899uxOtNwLFScBLxTTB11hGrDr
         s0OdgHaG/r9FByuurHGeDylFhAcWbfIFAUP0XaxQoGjwyi2yMKxwvm9XteeEF9zrPwkY
         MeP3OIlgphyAwOGn9HiYHW0PMI++Syc3zUHrlSYtBnxzPrwYTOmN0Q67U+equWY7KXDN
         NHu7CrQMCG45xPFqIGJ6UEwPG0ugBGKfrWCRjEslN/3+auzimzN2Vc4Gc/7B9hmgKyQh
         Dzr0LhjUDgIqqD/I5pjCm7fYKd07T4o/i2xrQoKSO/JuWHmdBGrW0eYDPeN6ze9QI1+L
         Ttxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758223770; x=1758828570;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=afC3kCqsZu3z7S6srL2GfIhbeRsnA4U/Vx/e0fJlivU=;
        b=Kf6GLhnSEgVQ8F+/ilzht+UEXV6eYQV6CKTTCdq9K2rKdcFCoBbmg7e1QtV2RKE9se
         7bM4W76+5m2rDH8u6WNjsj/JwwB+vavnSxF3bQAkUcBgwcFPWKHECUppJ5mtzBSYozQW
         7Adnu6UPI3TQmHNRAcxY68eSBuY5W/oVrAEu4wpfjFS/MkovullLayhjuzba+yKAe6UF
         O8B4PGclirgh5mv/T7KfvYdhbV9bG3aD5EwmxOkQvWDj4NA9zn4fKcSm2YXlUO/zML9f
         KSn7PQw2tq+4pPBXOhakrmYCel/snALtrlRkeMtpKp6dTJbwceDKxihTgkCXMX9iQWRl
         lrvw==
X-Gm-Message-State: AOJu0YyxP9Dnp7ks8cQQqyaJAHqfDhWM+9whJwX8nYAghBt8+6MinhCp
	Pp8dkcHnDBLuRfb2dqXVl+UmlYoGz+NHp2d7UcFey/s9+oQzskhUZPQ=
X-Gm-Gg: ASbGncttG8qzGe3A1mbYojhxvqGSalL15zWp2v35WxRPQPNojogiZX7iw1J4SwfF99V
	2PC92e5KQuaJFEVRwYQ/d/Ve4QtZRNsdgdezIz9EoOH6W5Lz8Ac9pNje812y9WdmfjNcxsTn+so
	5OttBDDSDJlqT2bF7EIlqeSjLo33NDOQ+2wGd38guQ/sKG8fwLIRf3GwYAvbyjKXmC2t6asvQNJ
	hXgF6pomzhPB6D152gvPUkR0m6gmXXPf1qmcCUopMi43LVj3Sw3r/Y3e2I7dNPN4fVkZLDWpvzs
	oDz0DrARb9XFepQ0bx1r5Us37rUm9dMwx3UGAoJIAtDaaGy4DN7/3iYZ2PXZxd9MeUBSWu+NAyB
	wtVWOLS6fRWOyz4GsgDhik5gzJoGaHfxZwMv6P+T8iUIEK3OZX5IvAEs=
X-Google-Smtp-Source: AGHT+IG/I7hhjY8aMMNZGbGYGk7W4aZJWsbB3Gnw96ruyWc/dhzbbY8wAtNt4CXb9KtlGM5BZsJ2MA==
X-Received: by 2002:a05:6e02:1c24:b0:424:80f2:2a3 with SMTP id e9e14a558f8ab-4248190b6c4mr14762585ab.6.1758223769949;
        Thu, 18 Sep 2025 12:29:29 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.215])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a682a59sm13044715ab.16.2025.09.18.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 12:29:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
Subject: Re: [PATCH mptcp-next 00/10] mptcp: pm: a few cleanups
Message-ID: <1a5e9b78-a543-a353-68d6-d7ea1f46690d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Sep 2025 19:29:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17837220771

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/481fd3636aa0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1003950


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
