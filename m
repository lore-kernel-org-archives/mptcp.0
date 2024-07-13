Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145E2581
	for <mptcp@lists.linux.dev>; Sat, 13 Jul 2024 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831262; cv=none; b=kB9pXGZkMRl/xxdlTcxzVVLEJ1DUtIdtqs2VbC+WZZhlNq3Jw9JquWjnJU1t8KMOMqfUe5xgoAHhEIo1MeKS3zPajTpn4H6Wg+zl+xV/b2Zxj6UPJlG7fgTOGhUJ0vVJpCpBhoICE29PbS4V0rR/zM7QxqFROBgDP8Y9XNA8ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831262; c=relaxed/simple;
	bh=3isqoTKgOqyXbBm1aiDOXkOZvRTVuv6DopCO4gd0VRk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gwIKSgOdNI5ICoi3uFBwFH0PSrh7ooiSlJlXPWbYD3oRH9cG1uMRv6uADmlKAL3ahMliDzK3Hbr3lw7WGnMBwiESMgaBB26n6Gu7CaLAuLqZC27izdzpZdhXrWyw3LxdEXiCubB5jHV4QCNYLUc/LGQw6k8khUCX8DhSHhn1EZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEMUgUvB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEMUgUvB"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79f1be45ca8so153372785a.3
        for <mptcp@lists.linux.dev>; Fri, 12 Jul 2024 17:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720831259; x=1721436059; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wNKZbNxxmu8JRIomf/wPsonx8uRX++XxRCA2KXh+ww=;
        b=gEMUgUvBfXGJaGggeZ9oUm6Ax0ImEmI/uICVfTVqIviGK6wnFk5Tdj2dGL7NYpxJrC
         GZjhOlQJONaYDmzW3kjXX9r6Z3R2JVdsBnLtl3X0Tmi+1vjdMn4Bz2E4shSvAD6kUjXl
         sFb/WNYlwCXwnqscrAwTEYtAxyqw3dW5Y/QqT3X3HMDS78ttextT1s6QMii0o0tbOsbJ
         RBkelQng3fOn3JLEhLs6KWjDQ4S56APRpc6amX2d/Er4sAM31V2vMCDDpZD/AZYZ6Lve
         AXhHj4OQxV1AalwlqYH5jXRZXetqwUTgHO9CpXQc3s8B1MFj1klAUc2XfEs1bofBoeXL
         aWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720831259; x=1721436059;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wNKZbNxxmu8JRIomf/wPsonx8uRX++XxRCA2KXh+ww=;
        b=W/fV0DuY67lR8pMJ4dJ8H2+yPwLFzWXjNgqrH5HsFdWwL+mX968iqIIDGkS4CygSu7
         mXHybFTVj4z6n9Fl7+mbtunqxPo4AudQf6MUpYwytJ2ZTDKKGl4ODQ1lijuzjc1SaBLR
         YCf/zmu/b99e9RMig+iuH8JlCBdUIKHrnkQiMbUV/lgnqUerK8xozDAv6urUuL5DiGfm
         GeHABSuCMtOd8VCcNmlfW9AGKddRox9HJv4umQnzVLw9OBCmrvki+OPnTlgIgEiPRmLP
         EB43E/CrlURT6kSU5ZgI2xQ/2wIyKgopqY5vLooDwqqMiHdWGLIdAR60sIyz3khQvwoj
         3swg==
X-Gm-Message-State: AOJu0YzSuMor1bfCMwrSD+HaC7OwZe/dkMRif2+Lud78a4jljo3TuclQ
	p8nh6zRaGPk9nHHF1Ur1l6CQs9dkQpfpSepdaKlpS1P7fBKJBuw=
X-Google-Smtp-Source: AGHT+IHq+do9IouPxUC3eSWVt/BZw7beI4sIVhCkECUz1PbhBWgHqo70upDLGvsjOxwAxHTKN5sbtg==
X-Received: by 2002:a05:620a:2990:b0:79f:9ab:4267 with SMTP id af79cd13be357-79f19bdffc1mr1804186585a.55.1720831259575;
        Fri, 12 Jul 2024 17:40:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.189.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbedfdsm5672785a.44.2024.07.12.17.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 17:40:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240712235150.99175-1-jhubbard@nvidia.com>
References: <20240712235150.99175-1-jhubbard@nvidia.com>
Subject: Re: [PATCH] selftests/net: fix gro.c compilation failure due to
 non-existent opt_ipproto_off
Message-ID: <1f4bd7bd-fa37-67be-b9f9-747e6a8a95e1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jul 2024 00:40:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi John,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9915563597

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2e3231d9f88c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D870973


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
