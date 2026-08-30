Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962539F191
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103992; cv=none; b=JNpewhr9qlEdTyyl7Kdvcs23Jm6oYAd4CvfhXtaf2lD6yTx/r0uzGAS1RQpap2lrIIb6KOF+KFrrcu+7CN3nkfKLh0IJ8ke7+3FciXsPCiKMGBw3va/yBPSstytX7pG5Vj89IhedHqrMHd5Yq0+322EKv0kGRzf2ZgCwtMFfDLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103992; c=relaxed/simple;
	bh=XuRDW8AL+Of5QaWOEyEoAzrSTeFtIqvX9pY5dfPiP1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ilutpXHWwba0bQ2nXT4g4ZyK8Mp5rchG+xbZMBk8HDtKTGl9Td4NgjlkHfSUcDDd5Qq4S2F8niSZAsQJy0P4IyBCaFdCm95DxFXzIDuiBv/ICu4VgtnUGGt+x/yV9KnAiIYbjGh+2+HSI+P24SjqMjlnyhcGopo/NrGlLIaj30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4cMagnD; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4cMagnD"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-855d2bfae95so2760204b3a.1
        for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788103989; x=1788708789; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SK5veCFOMhdpBz7qJvDvHont1lIv5JbjYDyZvSl4klc=;
        b=W4cMagnD5YJlTqMYtmLKuySvyxBr86tfPSRrwsZ+bhD8Cehj5Yd+4aDQOK9p7wSMM4
         5dUmGRyHElfzt3WNNjWGHFb2OCMoIhpqxUDphgX009dpcjEf4FW1vL0vTyNafe3mxg39
         pgI/wiotsE+HdcCf43gs1AkuV9u15EmdHfN9stimv57WapA4R1scXA275Vh1Dxpby0cZ
         i0nO9UfXb9Uxk0JnoxqX7hTrek8vwHzINhNN7+IlzS+O8jawo6gN5EBWtPztta+F9PgT
         ImpzmMPw4oBP4AxPMCrbl2kJU/gDU2FkYgRho58WZeQUXWapHCN424BPztrNcAkiMWd9
         9CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788103989; x=1788708789;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SK5veCFOMhdpBz7qJvDvHont1lIv5JbjYDyZvSl4klc=;
        b=pAx/kLR4xFWN2U4WqkeIukFtmCi04HkMOb6DY16/Sd5ddsVPROFQkBqHZM1AZmL5dZ
         wFmYb1w1YWpzD1XYHSn2JgHAnnEvqnOqAR52EX/EcoVn+OP8C/fEhloX0AhdkzTjMysk
         TrUDJmXU2qlFo5zfFcq9pazuvSLKxSfHnUnv/g6D9Q3QGJ7fT5aCALC4YAbEfcCqZGpX
         PhWZsmWE3auhcPtRGQuazmseG0Q//ulQgqJRu2CYajijCszSBhnfuJjz23u+hTH13Dgb
         uZHP9+wy7zHpQQvppFStOsgKeDc+UKlvvnePKhvSnHhF5Who3kRGmz8WU053hXmT4BVZ
         KLOw==
X-Gm-Message-State: AFuF++k2AqnfgbzOsmwLmp6vsaRzBGpqTdO83mcQ07asjGdqm1weENx3
	wQgRFcLkU3L6apnZ0laGdod5OGdtzcOyy79c6+8GbaVjIgzeRKyl2TZ+R6sG
X-Gm-Gg: AR+sD10ci7GMlAYJTwP5XdighQ42+AmPFnQo5IvUZxgBxNak8XuGl+4qdWNgpVX1aQs
	Rs2dH8cRUZU9d4s6i6lJmfY2Yy4jCeGqCbdKqwwoBLzS8zTkweIqERvx6IkCzuYss/PPp8w1/Hx
	zygRMGBePCYlofgdz690ANGNTNdKOXRCGxzaDu7y2XaqbL9aiPRgXVADZySKnc035NRMJo7aRo+
	ecyN+Lt5+z78Yi8UNBwNRfNnXU/JYRHLlv2/zHxF+hsZzVbK2Sd/OK6+Rd3+Mj8q12TJMHtO404
	7em4SqsduRcF2edpAMEopWYFNDx2E3Q+q63j/68qugD5ZVS4/uewXufvbMLDmpM3YnvGki6UDwY
	MDYdXSwmDOjQkvOK03MrcNJITLuVDnXKdZ3u2hxdXNukGPz5S3P8/+GjDXLfIRZ72eL2kXWlzzM
	j6SIAr6W3sVBivVJMSTVBUdb+gSYvR6l1BBWjoxOE1CbW2y3yfWeAFyCi9C0bCffdnVnV9an5tz
	Q==
X-Received: by 2002:a05:6a21:6454:b0:3d3:aed2:6f29 with SMTP id adf61e73a8af0-3d5da1ae4camr1734500637.29.1788103988749;
        Sun, 30 Aug 2026 08:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.117.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d18eaasm24121075c88.1.2026.08.30.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 08:33:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1788099847.git.tanggeliang@kylinos.cn>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v11 00/10] Reduce the differences between
 TCP and MPTCP for TLS usage
Message-ID: <fa191475-a2bf-db16-2281-9b7ceed624a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:33:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(except selftest_mptcp_join): Notice: Call Traces at boot time, rebooted =
and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Notice: Call Traces at boot time, rebooted and =
continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Notice: Call Traces at boot time, rebooted and continued - =
Notice: Call Traces at shutdown time, ignored and continued =
=E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/33317921888

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/3e4dc4f936=
bd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1153916


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
