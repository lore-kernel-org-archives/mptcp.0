Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E01344040
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491811; cv=none; b=dpZZKyG3lF+P6lAc3w2AwGiHduuuemV7x/370gANpVJG9i9sTnQdpSCvOITwmKeGhUq0tGJL8viD0rpEVIJkvPG/Ls6uaClhHkax3PaIyos8RK9uDbe3fY99zRe43i/oD/iRFJi1miDyfFxkQA4EnuPqTHediT7viCTFfB8MVp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491811; c=relaxed/simple;
	bh=HJaLbGgl1PBe9NRYINeC3nBhf5pdUgmvN/EzHCMf0Fc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qZ3bJaJsMVzhYE3bQue/urw775GgINix7TLq+jTrRqJqg7A/jLsL0Sandre6mKbD16yhD5BwcDCdZPMvjoAqf2TTpUU8INrFMe4B9Rsd8PjAuTLw1kl3sbj4wRj7O0yq3QnbxTlnGB+R5OzKwF1PhtsJPAHbB+Lj7B4/r5A8bus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvzt20T5; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvzt20T5"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b051b557f6so278156eaf.2
        for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786491808; x=1787096608; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qOdJAzjiN6H+DGfxm4TDTDECXH0/LF6jSfRgcLmjGRI=;
        b=lvzt20T5/8fmv6ciHHMRlSHhbsMjk7BQoBG6LQe3mUi3WgqrU/zhwHb5TSravAnuTx
         cRF9hWz/d2z5acwGkxGMyrzISnoS3Eqwv9PMB+SDX6at2bw4UUzJnPFj9h+Rho/K/UKX
         Qk4exUoWq6/ShdK+EDeGI48w4Oi8MVrupJzI+LfGR1x84wY80adsOpjlVbFhK37AE5zU
         5OWpJZlmnWs4e8Km2hdywj9bsK0AiHNF+uk+4OJunb0IesKfqCC4YPZjneHzFgNrwi8i
         sAQu/+lXt53eZTvwMFXkWTbsUVKesfZJYOQn/stI8DahOeuXWobo+koaITPE3gGawKGy
         KvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786491808; x=1787096608;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOdJAzjiN6H+DGfxm4TDTDECXH0/LF6jSfRgcLmjGRI=;
        b=AD6gumz2JbNOqBA5ORWgFS30VMebYHbI8W9fgqwhIPesaPM13DvGfMb5twM8ftEOdR
         QLYwYCqQEhc/h1ucWpitxhCB/whlUmo+2/YZav6gNKCMksU7SFVn0auUv0QAu+Iq/ztS
         iZAoARfOGHpt7TxXmGlH+HZT451r6AoIYS9+8oihfmzL9xpFN1quWBfRuCYHmpozJjBV
         0ZM6tzW3GuAL2j0HCZJFHwNSs3hDU1dX0gqprIRX2pscLGpYFw2ZOH1V0cQi4g7Ic67i
         mX5IBNONwLoRY0G5aN2+rt44rqOQ/23qGJT78XQPY5hYffmo5SKs59eSp0ccpsmnBPYs
         2VJA==
X-Gm-Message-State: AOJu0Yz8CuS0d5W9D5GPndmXwN8zyVdPK6HBIboJ2Q8eXIkprajMBWI+
	hX+3Pe53PM56aBCLiBhtuzYXGOzIE/JeVVjoEx9JQBn18oEoMP8CrNY=
X-Gm-Gg: AR+sD11sSMDD32CPrJPbZPRIMLBkczZV3FazFHfEoJ4TPAkax7cV5bAjgz57Dq2xR1J
	okNbRPGJn7X3DyZ4sTMwngKbeDoQgFNi+hY/SUGh+uVR6Lxo8hDf6aJ2M2TNEi2voqRSliS3rPc
	cdxbY5cRIV6o+tl9n4EigEOcqAn5I3BHh6m4BEZqqd13l0clRL3+hHrOIKVKfgNEuXSsqRSPRCM
	2YJ9Hp/+DiTDyKfznP5XZ+PbUXIqFlpT9vZXIeINsoroAX60+fnKjgNVIlCnZ/P5jASl6++xVAk
	eXlLRO8M9El1AJ/oO8mSEgtF37NWS+7e+SA1dEnhRBHz0iBw1do5v7hFK8UpsjiI3wlpj/waYL2
	e9ns1x6F9WQfxmH9TOq/bSiU8jpyb0S9SUkUs7dL1vlnDny5OTbQWmwbaGhK+jJj1UKFa755zDz
	En7n1aGmt6DwmYEciSI27Hb7E9nIVahEBbiyFIkYgLQfIK+tYtM72+gXPbqQD2N+M2MO+d+c9Ux
	Q==
X-Received: by 2002:a05:6820:4ded:b0:6aa:e70f:301d with SMTP id 006d021491bc7-6b0b291d8e8mr599115eaf.13.1786491808473;
        Tue, 11 Aug 2026 16:43:28 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.215.52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e3510ec1asm713516fac.2.2026.08.11.16.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:43:27 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Harshit Varu <harshitvaru666@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260811222325.90426-1-harshitvaru666@gmail.com>
References: <20260811222325.90426-1-harshitvaru666@gmail.com>
Subject: Re: [PATCH mptcp v2] mptcp: restore full join state in syncookie
 MP_JOIN reconstruction
Message-ID: <8ecd376e-3f2f-e138-a31c-bacd130d7462@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 23:43:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Harshit,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/315445=
79623

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c6dbff20aae1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1144353


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
