Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025935A938
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803377; cv=none; b=KNXGc3y2Np1DQGPxuJgrswcTeGfQ6q/0xU6q7hZ5d5qob9M209CaJ2MZCGT7UrzNCTUXvcFtzHoAWUgUubKDnHhkRUurQ5vreAnbxlnI4jnC0Fbkx5gjXDuyDX6vWVPVXdU6nFCCwVOEI2aNDcT4or/N/UKnQyd2rvi9W5kX8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803377; c=relaxed/simple;
	bh=BMlodYOCMqvBKGNHaj4Fxa7+BjGpkZa2Ki6ap80HXlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=tVU7TRA59Bjuf9B7rK4QH/KfzBPgY/rUr7723NqDYQ+nuJbQ8iwAVbhHk44pUI3ADnbZL+V8HOkyREbzyfDqy5Hv9gCf7WPLKzJAJ08rEFucOKSEpHo8sZEovY9cIv/I124bWWOHIs77ycA5rpTNxCEsPLrLnsaSXRi7z5wUK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvHNh3CX; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvHNh3CX"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso30818356d6.1
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776803375; x=1777408175; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50cCH17ujn3SJA0bTwqM4RP4lCzGVdTcQCv9RHpp9vw=;
        b=mvHNh3CX/9LS6l5Qby8n3sPR3OUKsrbYx/kGR3VFwKwvyHNVA0QgXj6L3kmU6mAxwc
         Q82q02qJGlgCULSiAgIdkPi460G3PdhxAMxNvyxt4CLTGtSi2ybq13tI4mA76OGGznsi
         6MDwFYfS77WDTuBpk+3Oyc6V5JWKI++/iqWU8A0ufxhMPfNqqtP+5FpnPihxz3HEMJlZ
         aCFeCy46kjZcde26JTG/bgBD8S+/0yhkuy+ZLnI2gUCobjrAWwoY8jM2xl8X5jR8hFu6
         FFKo+2TqueIDpbdBi1+F3rpVMsNTfUtQwWRyO5bUKcYHctnutzGNDyBtYhN8eBjFAzfm
         QCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803375; x=1777408175;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50cCH17ujn3SJA0bTwqM4RP4lCzGVdTcQCv9RHpp9vw=;
        b=stl2XZ8f9AJGjveqf6Gll3MzxAPYs/yru4odE/5VgZaFUfVOMZvabwmxrZJ6bqcz2y
         7luWnRF2yD+uTPLnzmN1lQWA6ETGTCejfMeZk7rSvp9pOSoGTEukhcneGxXEtWlLb6qg
         0soIN7ZH924JDrpdDkSeqPJDckQmMPkp285vlAQUe0y3aYiuqLrhiRaE0G1mJwa4Lkt7
         5tVAgo1cLqoinwpPKM1ZOvEoHH5K7GU0esbax32uY1WC+W+1zfCU/x+v7cSXY31DygmM
         kEpaX0UNNnLIsZ9oLy70decjEz1SKZ3dmSLFMBFTgYW0ZeJOaxyEWKh9hjQSqkvIjxPD
         cWPA==
X-Gm-Message-State: AOJu0YxdtAQpEJrXUHndCYNFxMONhy2EvaCoweVaHym1613WxvXVB91y
	8RhqcE75kJEMJyeWOx4PySBMLsRnSzzXhYJqcwwbf1IuvNnzWeoPn1jvWKsO
X-Gm-Gg: AeBDieu7vxShl0VdclcX6BmzBJUHwrzuoiYkbwgp3DZLfc5BSaJ1wzRMJWmFv/fZONc
	64aH1IY5R4LwVJ5JtiOpS7IUDgCaGDraQng0fEluU77qQbc9LAcpI0DFkytF+WcGDsK1sXG+bL1
	93ALkhRY1GVvD/CnPWu2tlrhDL5zOUKksxFGMOCX/apnxfJg+W18u/jMm58rNaS1/2ePbW38nyh
	52XEqk/AQUOEu1stlfLA1XFlKr6PDs5hEV5JykY1B51zHQ655nO+2S39TSHnp5LLDZbZ4wRMjRE
	qAcZ1VLJUhsckwOnLHUZlalIGXW6/TvfxMNA/ydJha2rqDD3Qkcayh7l/5Z98wxBm4Z4ZAQBx/J
	Imjd7xAv7iuWXjuXLY1Ff7KB78mcVYJVIinO4K9mdqIcIEqnCBDY2aZT4k9oyguwkQWn7ZXkPjD
	Nw4g9+z+ILl1ZFdo/jhteF5JKsSaiIQvzE58COBM784Dk5/Z6qhQ==
X-Received: by 2002:a05:6214:202d:b0:8ac:7d2f:c7e0 with SMTP id 6a1803df08f44-8b0280ecd23mr354496286d6.23.1776803375310;
        Tue, 21 Apr 2026 13:29:35 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.184.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm112207696d6.49.2026.04.21.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:29:34 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260421191337.58341-1-devnexen@gmail.com>
References: <20260421191337.58341-1-devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <281551a9-b3e3-825e-2725-622ed34bbb0d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 20:29:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_sockopt =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 1 failed test(s): =
selftest_mptcp_sockopt =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/24742390998

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/150b821b1924
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1083991


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
