Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586596;
	b=nODqfVqRtwdf16PmMer89FYpobzP2cmV573wmMOLrgilOhSnA3JPU0YWRDt1Xgu13Hhg
	 nc8pgZkRKPQhZ1TP7jmiWDl5SPkkpi612X+MyKYMvGXuwAwpiQ9HRLELkIOwzFDMqgJri
	 6fmnnVR1OU9fj7f4gzhEzVGE8NH+fSxvFCRTCraBvhdt0RqfauTPTsHOe18COBvnQzqw7
	 yqexbQjOkycz822l7wR9Cauoht1C0Svet+7BR4Vlwo72OUaoDEM8SbpdlO4+Vgbki5Hvy
	 UkzYhnF29DTncaEQGIKRfc6E2wbUSlMSFzBEQtCpFE8bsCL3XPGs82FxckMBOwt6fhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=x9NlB4N0c+IiC4bKi7e1DROzjocvHxMqDhfq2XVwRGI=;
	b=hsc/JaZjF13prvRyZYSZMNOrrzw2GuBInQ0EvofU3p0NiGvID3T+5VYHZXvznbmd438+
	 x2y8RSiCEcxKHC4+dShtMAZQr4QDjZhhVArglLF/RW7IMOQoZyuluf6Q+luMvWm+p87rV
	 5wowboTnjV59YdpSCWME4szFsJY1XEwtGF2RnwX2UjKm9dIFraelWNbQoGiEHQ6GpB5FB
	 29BolpY8wyxZTXyw/lMXZuo8NuGiRI4VsjKmQaCFN5MnLRQOPGbnOGQKxK/SGWf8v6gzt
	 8zujjt1T/vVx2G0t3lYtHj4lD8uqpCnFVdpRHdxZuMe7jgVGLzpYoAPVG+U19b9QZGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UY60angd;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E252606A321
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 12:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E252606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UY60angd
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso4211755ad.1
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792586595; x=1793191395; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x9NlB4N0c+IiC4bKi7e1DROzjocvHxMqDhfq2XVwRGI=;
        b=UY60angdUc77cdLoVB/KHtrK2UhM73uAtYFuNp9oyWzHhPQa4qZWIXeA5Y/qMkynOn
         rb2M1X9pn4omBHt0aCTPecP8aq7RvotCvuuioaFOLv2PPyGN/w49IlTkkEkYzp0USFIf
         3iVY9ZMm8ix794F9LckMFMLWCck4OmUHPvPhrRUcrswUwIhCcQrBFE3DtE3YFxC1g2SG
         XMoW1bZFrw43W7RyXC7Z/H+qU55+8qdgYZkCqb2fRgu3y1/floFEPLpVSqfr9L4EmB6j
         6yvXcX+ldFTJrr6e6Q2ghwHlaZGaIZd+Uk8qmPSa1tg7R8iH00rn78vau4iWQqSfzRRR
         jbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586595; x=1793191395;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9NlB4N0c+IiC4bKi7e1DROzjocvHxMqDhfq2XVwRGI=;
        b=de5kBZ4Fgl7OWnQE/j9tjbAPw53FE4ReJLPlttyYEU3bhTOiIdUzU2J9Mg8tTgivLI
         MPm5w5H7MYBRsL0JpojORnfHWiWim0v/JmYuPTCR4D2PwMSVVkYr2OOModazPRaYiGhV
         vKh7EaaAZ8bnu1X4QzrgxWIR6FiugLxUGMo65a39EgnNqLU8xl7tFmsyGlZrmfxqJDkZ
         KM0+xzIGB0+mXzS7cUYbEHVXy9OzmF7ewlZIYUgE6Ju36emXVTUIN/99MxHclSLYyzbr
         KUmJOKV55pjDdeMDDLGhuXyedrL8YvA5mhY/ObzD+i4IRTXnjqjXElDwgzp5PIvGSUrk
         0MaQ==
X-Gm-Message-State: AFq9FYJLkDVPEocZu53y3ATo+Oh3lB/W6x7MUoACRTO1fHc4ztuvhzr+
	of+7VucFoakqobHzhlS3APFMHjrg8ST+Ztk44mHBhrAG0sq/vbJ+0+g=
X-Gm-Gg: AYBFou14B/ScAohpu9SvPMNfinoPXxrYsgB47tqVolBytiIXBrzBN23pQ206pFcw0uC
	WrSVSlAwOHeV+48onR680pmyUQ8gI8QlQpQcu6Iku0OdZUzSl86rBTjm8wsGfr4QCd7tkqnxN74
	HXl0GYyzp2/KHXlHwQSJNaBBuEFj7oX1DucGB3EkKhQxf7VB2ZbT8rZEPydPM4WpEMSskRKrG5b
	TizUk1ddLq+mA4Vy3+BNXduHoXCLGjTRv0WJyLvb+7fRZq5WHD3hBv4Na9TTXpFc8ezGkp6WhFs
	r8EY4ygSpWMm0C7Se7FRo+wSSxng3Rt3abebMzDLluTCahCU7r9IGa3+eZocMTx7DasJFmVCDID
	Xp0uE6z5ZUBDUvs3L66ddb+5DsghyIFQYr3G7b/bkfoZZGS45EM9O7LhLZ9RjXt8zNyqKTKq5BC
	z01A+Azzv13oJxHcS6UGlHONRxmNX94pmv21VbYIJ4Xf1tj4oGiOSBUlE0/YTxjpfYsWK6b38+3
	7P+2M71ex/LJxtJKaS9FLO9CGHpZsUHqnonc3O2UXndaqiSBrP9Hfas8uxBaaZwTFo=
X-Received: by 2002:a17:903:26c4:b0:2e8:2d05:9780 with SMTP id d9443c01a7336-2ea437a6be4mr16082235ad.8.1792586595422;
        Wed, 21 Oct 2026 05:43:15 -0700 (PDT)
Received: from github.com ([48.200.98.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b48699fsm10571915ad.58.2026.10.21.05.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:43:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261017-fix-mptcp-issue-637-v1-1-cda9bf1c79de@proton.me>
References: <20261017-fix-mptcp-issue-637-v1-1-cda9bf1c79de@proton.me>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: drop unreachable
 FIN accounting
Message-ID: <8d8c4410-bb6d-093d-10f0-039c8fe28827@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:43:14 +0000
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

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39578788494

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c0bc9ebb4dd0
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1187878


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
