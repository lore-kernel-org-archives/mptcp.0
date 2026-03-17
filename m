Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA13783CF
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746265; cv=none; b=VlpbpT3gAHlgdtUpts7wDy02U1V3ln4+K9iTCWfxyOewLtoe1fkTLf5uUdBgAKPIb/YG4K6vSjDc/HMk4Oq8Namzq+SPgjQCfkZWmxx27H0xfZgubi0StHxe0tn41BBUPdBMojluWg6HbBFTUjeF3Vl+Kl259COP2kqegN/zUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746265; c=relaxed/simple;
	bh=e7pomv4fkBDIPaB62P3LhzVjF0V2XJJI8JbClfKqcms=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DaQpmgXF2G1O95p9ElfbC+4x/RYe5ZUEUEhmnoJndzJ2DFnwx92JcO8k3ju5Yq28Xi8rlA2ohq4lN66eWPaZP8RmllQwjpDTcrIxNwfZdzgDzJnUs9HZ5Zm4DoSFzUPO6aPLZcDcUaWbxO6ytGRP5pRoPXItyeadnX/TuK2CmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbPHzJCM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbPHzJCM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-509101189f4so50177941cf.1
        for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 04:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746263; x=1774351063; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVdvoY0Sbi8zEqKRqxRChZRCeOn5Rc7B1qvQAn6JPBk=;
        b=mbPHzJCMSOPHiEVJZzZprgGn2Tqvg/sBtOVJG7MKggiT0yeNe/SAciRXwoa1xQgV+9
         1cgZppEzZWBQmalzloH5glhCBmYmakomi8vzqgLkI2VTmngRhyH2YUarX/18ADhNSegU
         xjmAiVrZmDQyh36w1dQE+Qkejw7iSueEIDBUY83wcXCeU8muF82vw3PxpEBVFeKzoUA4
         sDha0VbnJV2YQcGzbsGftjWTrI5Zzlwen6Te4ttc7D66gYMNbPNY1mtEN3bdfDW1nB5T
         7adup1UQMB8Khd9YLEROhQS47fQ0q0e1LEmv0P4mgc4ylVxKz/0FeFMM+yHYvjetUG8P
         678A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746263; x=1774351063;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVdvoY0Sbi8zEqKRqxRChZRCeOn5Rc7B1qvQAn6JPBk=;
        b=gbOqXVPBxl7kfGq91IIkDfXR+Sm2Bo+mO84uMt/lI5hyjmyy0Lj7H+cnaxu8V4jsR9
         GLmL8WHbvOOzht8CXT8+RskwsH7S13jWmnIs2tl2J/bHbGjRXu18ndq0e008/9bHqUWE
         S1GNbOArGpAtUNKmq57D3CEiDeFtoBz93PfMyFmuQeMlZsFaIyzNh0hjkj0YhQShIzl7
         WaF/an794SuBDNFgW4mbfX7XV8f57EW32PphxcVYzH0wmZRyprkyzyjkWG4sDv3J5aho
         33seobQfV8ZIxu15cDY4R4/wFsZp5QQ5hmImfcZ62L0JsfGRFoXpOJRc1Jgs4tz2aS5p
         +a4A==
X-Gm-Message-State: AOJu0YyeVip66A6l+CsJvgnkvYZoyXbVAOoQl6tPjlpL1IAti7PpdSq/
	9E+iIoSyHMoMwMQ+7BKgzVHnfdZz2txb0t2ahmSovbI6zKiz5dMpYPhI/HM0
X-Gm-Gg: ATEYQzwp97e46MsahBCXIUgyAdzFi1Z0DKIH8lGXDOJhKMfHLu6GQK2+uQDNtmB52lK
	tjjtcYz/SKbidh8tPcwdPxJBAw1XRRjrd+iPLxa8mbFPqV5Ia5m7qkEP8wlNt3y/X1X5tbyPHbH
	dY3PeBEIOZjMrB4sMe8jVonrV7ssRs9H/XDkwdyi4JZFHisBiaLfJ4RJHb9c4OsPCe8X8cUiAuB
	DcI0z5cNnrYws2/XXtRRVYlCZTYFTM9MH2+lbpkftvwiMPIFfYu0+J83hthkcmuaLt69ht1oxli
	rsqK62yy+7WuHWV2t8eiHr9lbcXQPv9yIZjMZFAVFyjqRN2tWjplqPexHhTA7zGNFZDRC1DP1wB
	HonT0+VPP60UgZ4bBLPxugAGAMxiv54UU9SN2Vhq/FuyzRg54vK8Jug5fIIFYLbBzEWfLOWu6Eb
	BDFboa8B+KOYKco2gwCNnUb9wAWDjcTXRb4yU=
X-Received: by 2002:ac8:5d08:0:b0:4ee:49b8:fb81 with SMTP id d75a77b69052e-50957e72df2mr214411991cf.61.1773746263203;
        Tue, 17 Mar 2026 04:17:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.70.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939e8d4bbsm140970771cf.4.2026.03.17.04.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773740361.git.tanggeliang@kylinos.cn>
References: <cover.1773740361.git.tanggeliang@kylinos.cn>
Subject: Re: [RESEND PATCH mptcp-next v2 0/3] implement .splice_eof
Message-ID: <d0f388f6-2070-7874-8551-1962e335d45f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 11:17:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23189071186

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e9dd5ccdcdfc
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1067870


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
