Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0123F267
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930402; cv=none; b=V8UrVqZi81MW5hHJu6cBOm7i6hkXNensl5tV3WmXRtjF1lTItOy40uR5gDV/7WMwIRHLtcVwaOuefFChOzD5/qDTXGBsqOAlxgPgUMVDh/QAeeYzXuiIfyXs2vY3/AnSk6v1iqqJnvdrE/8pgwnJvcgPF6ZSMcabCF0DhVXAdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930402; c=relaxed/simple;
	bh=W3Nv60idgE2jfs+93IIagkWEge8mmC2F0fiPQSRgsig=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=E0imuo9HDtUJJPNiHMWOdu/3wJSqzIvHXYD0M0SmNVwYogBrK7tryG8zi3NqUlwjMREpgugReSnGhmjYYoBgj0VESFspRehFOmlh1K9o02jMgYxG7J7QBKg0zGHIIC2KOkfFwjTvrJUs4nHcX9ZczXEw18BxJYe5m/39QOxg8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8qEvKHJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8qEvKHJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2161eb95317so114967975ad.1
        for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 00:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736930400; x=1737535200; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsNo8ro1pTO5wn8HnWbYubmMVsI0b6LS4Q7MW9zGALY=;
        b=h8qEvKHJZelkPEnfJU7dBp/dNBtePa+eL3repKoa/75Xyd/3oXirYgrRwsEsW+oc/2
         fkbTXFmWl+alQnTd/vjoRdyaaDMfGf0v23MYJtmlywPacKP1uy1FB7p+kmdph7xsuUS4
         lzP5zp4l/KYy0GT7Y3tb4mtojA2fPPdNzqLhW2/ORpLjE8/926lqtR4bs2lLYbiICPq5
         8E6cRu5WTfPd75ANRTz7aOmXtvaIHLBJfnKf2axk4GU5jNwO9NUtRoxf2g9HPN1e3YLd
         FmEvdEseSYpXxXJnJ0j4Xo+I8HFJtUpBsUYSueZq3MA+zkdTuNQeW1WkjihHp9fINC8q
         /BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736930400; x=1737535200;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dsNo8ro1pTO5wn8HnWbYubmMVsI0b6LS4Q7MW9zGALY=;
        b=cjtqGKDlh8/mqdgxl5mAfNxEEjeRpL344X1kt2iMW/59FgOHcpVJEhn8zYnV60eS7+
         DzLTPhztR1EFnSNY7tJIrkaz9bdry5AMWiDjWi+HiVPR/8/ckunMxaa1KtbmVjwRxjgy
         6eO3IOpfHs9BU0D+rJ5g8K/fWKXYVenOftkOdA2u/YEj4txtTGyAD8rE2Z7gPqwn6+88
         BVceMnR7lkR5G2fbuGmpmR+rBK4ktoy9iqMIe4FZ5XjR5x3SHY/1YdBZC3EFPMfoqEJ3
         C2nlyTUpdnE2L++dQnQbRrarTlWvc6tZ+Q+Vfdbsc3qUhIIyupauozFuPGXalc4m3iYn
         0KpA==
X-Gm-Message-State: AOJu0YwSZC4+OzqVvKXFd1+EwHsx9ym06tejFl5qrs136QPWR3/3Ha0f
	fnLaMo57fssMACJN5UsNutNiUcFfwN9AilbkKckQpSXfTlIuUhFAJrXX
X-Gm-Gg: ASbGnctLy5WM4Y5ddkbSevXK0K4tlHzIMd/R14aq6ObThrfyIfzZz/jqqUTVtE8uYnA
	rp7O4Ck7ENykdmUCadsxMVf8Et5B9YwO98PD1JnNEoye+r3oUjQBaSXpUC8fa+FIGOEIccVxhFa
	hjti2InVRwTZH3ixHMg0CG8Vv4wLwWCJl+OqfWmm2rjMXsUxLFUeaDTxHbgpsCH+uBr0UKEnMIX
	De/UuSmnk+crEwxWTDvXVGlzcC7PWxuD+2mZFwpKIPhMnoGQ0zPcCDMrxyixV7yz2bR+g==
X-Google-Smtp-Source: AGHT+IHyu8kUv7juqGfMhhgBqqJt8b4myfuU76OTzVLDrSQotoxR0CWMQamSjjBZCNCshhYawXVWvQ==
X-Received: by 2002:a17:903:41c3:b0:216:18f9:528b with SMTP id d9443c01a7336-21a83f6299emr409392425ad.26.1736930399864;
        Wed, 15 Jan 2025 00:39:59 -0800 (PST)
Received: from [127.0.0.1] ([52.234.46.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a3184b68b3csm9312103a12.25.2025.01.15.00.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 00:39:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <38e34a835050f35b7f14f7938b20f86a97ac0836.1736926065.git.tanggeliang@kylinos.cn>
References:
 <38e34a835050f35b7f14f7938b20f86a97ac0836.1736926065.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests/bpf: Drop cgroup_fd of
 run_mptcpify
Message-ID: <e67cd834-ce68-9e1d-baff-07818f2c7b4c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jan 2025 08:39:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/12783748540

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c6705ddd1ca5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D925578


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
