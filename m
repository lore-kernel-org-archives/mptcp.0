Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F121771E
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350808; cv=none; b=rSs+QL6eiaHP3ZC6apuD64PiVrR/99MKW/R6xvz3nwXkMdPTUNYYRLBN7dwiuXf8hvrlFkLlx1S8aKwxIbrCVE6/Ap1JTuIgFkGv9055x7C3OSM5nisV5SYwZco5taMklENICp4/CGZoUN55XxOaSCvJCLsdcedLN5DjCr8mYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350808; c=relaxed/simple;
	bh=pA2WGU5wcRPkmEydoaO7nP0DfBbBKozWrA1m/UP+SwQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ch4sddVzEuNCqRZA19a+LBpdAU5Xo9rISmc/kU5Vx2my81D6UmbAWHuBkVmVPNVWUaKBa8fIJ98chhFJu4m9IugImcsdqAhYNfn9ovpUVMSd1eqX4dQbsfui2btJgGNK7kXrxokWLvC9lMihdUzax1zBut1tCzR53a4WzBOmJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUo5oUli; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUo5oUli"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235189adaeso29373615ad.0
        for <mptcp@lists.linux.dev>; Fri, 07 Mar 2025 04:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741350807; x=1741955607; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/AaBZDRSVQtmw6ecw8YChVYthJ3zGcPXw4GRinJylg=;
        b=gUo5oUliU4bXl0dLprt0dIUTYCXFW+9LSq3GHzVI27V1Y2CfMGkT6xnqNbsOfR9Kq0
         eOPGvUw1Z04nIRlRuFflUBFRJtdERG9DK75+FC8dnAIz4cj0mSdnNx018QVltnKgLgql
         RvD9sWP35QWI6ynuXJyKbpxUTTZJo9ocC+ku+9eDrr3cuzDnc1PzHFfabW+oSMAFS2h/
         DrPlZzND/UXP64iJSrxuBm1BCv9pYPkFx0l++zIL9gK3iXSOnafCoevF2Umfvj8OQzJ1
         VrtmC+0q1g5cSxU7wkw1dtV3Xv09hTbC30QJcEP2uAR9ka7LfgJE9aoWa/lkVyRXS1TP
         uKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741350807; x=1741955607;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/AaBZDRSVQtmw6ecw8YChVYthJ3zGcPXw4GRinJylg=;
        b=Ba5qewOkhRHeePPIpo5XmKpmPRoRc4sOTSqiYe5U4vPIhjRXXlTB8d8v3ySn/Wfs0y
         VqntcxC7KowSTJ0t6xqNUcYosYK/Q0hi3tFv47XipQ6PJ55PV573ZF6kONBp4shnUcNp
         Tub9n5inHnVr44ZvZ4s/3Ws/H762kWYgKZKJquJcs/eqB1ATCZkfoYPaQKKW18tZ0gJA
         1ewVLYiPgxkSt0FR1A97UkgJ5yAyoOFO3ox3DHpbuSzB6VjHp4oVmSthtea3ha+67UHW
         kWtc1Q+qGH2Umk7uKuAUklIPCY5IVcNk3zJXbU9eqTG5lQSVo0YErO0LYvF2INeit2sF
         evJw==
X-Gm-Message-State: AOJu0YyQ01QnsTSJbiuOoMFld7KCrY0MQKj56y48w05Vp+h1hIjQTfeJ
	xsNk4zH+iIYLfMZc6x/3swrDeGEnIwmGflzzTpTbNP8sScXBoq59mbUq
X-Gm-Gg: ASbGnctino5q9enyHV2mSAHX/5y8Kwm1o4GRHAEINEUj9dZ+MLxP/CFwCTrgP2DRcWq
	6WcaE3GJqmkSCX8K2x56iPSGq7DU14jQxSZQuvoN6A/EGU22N7cE+NwyJtx47Yi6gqnUCpafoGU
	Mz2i+RGU9Myl4DIEzYGZ4gLuQaXRIsHwFv6Dqv5NmWOTCweY65U9NQqX9CN0k0oDUKIc8JKw7BJ
	3XydlPmz9+nEDSYU3NrY0BHoaGFdbJiJt8Uoq9A3/fgzAYeq6J/iqcH2YZLPIUXb8z0Kdh2SZ68
	VfZiCBnOL2pe8vHO93IgVzEN2Lq2k+O1brPQzL87qhkQzdU98x+sEN/k
X-Google-Smtp-Source: AGHT+IFo/dF8jlI0gerv2W+Zfxs+K0dIhfIoV1Vfjqck3s5p8QM0djh8N8RW1DywJwRqCVRYvqWYSQ==
X-Received: by 2002:a17:902:e5c9:b0:223:607c:1d99 with SMTP id d9443c01a7336-22426f30bb4mr56417315ad.0.1741350806495;
        Fri, 07 Mar 2025 04:33:26 -0800 (PST)
Received: from [127.0.0.1] ([52.225.37.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8eesm28709385ad.112.2025.03.07.04.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:33:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 00/11] add bpf_iter_task
Message-ID: <21f9c38a-70ba-ec9a-78ba-958447e22a8e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Mar 2025 12:33:25 +0000
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
uns/13719922203

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/76b642669ea6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D941486


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
