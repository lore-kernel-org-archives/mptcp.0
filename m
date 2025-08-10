Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05181FDA
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754846488; cv=none; b=ZvIiRrIqgwJ7vBZHIaT/ivWw+Slqw5KCK4788XOrAwLdHUsO/jbNllDB2AZQWA5bDuo+bwUJ3juFtgi5SgKiTrgaGVwoQIJtsYoW4Ytcq22AUlFE33LIRKvHEeOJuSR7zOqeKCb1nZWTdkUMZ+aFNsflHcdo/lrwEaiiKH40YVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754846488; c=relaxed/simple;
	bh=tXycJm91o+y/2FTkOk+0JQDP4DAPopfq1TLzZjcyE24=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GS/lInp7RqGnwetTZepKgmQxmkXmb1Mh2l4Qaa/3WZDzvhzsaGd5QugoSvnqaa48U/WrQThVEqABdC4kk+rUuAHqyzsQQh0NMzrc0j4f+EC8C2o7GGprID/mU54o7QOhg1Tg+v7+P7D8D8vPkZMn2IQJFPMtBg19i7+AZRf/i9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHc5X9xB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHc5X9xB"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24014cd385bso39584455ad.0
        for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754846486; x=1755451286; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3kPEuyMJKdfZEruUK4WcSjT4z58iPjJoB5WybG7IVE=;
        b=QHc5X9xBJZGVj284kka/uqWA0+3Oxr5pEaw/PrTgmhGj5f+Hl+tYMQRJllijherma/
         1Fx0EQsEpXUYPbboKFhgL/R8rzV1MUbbcV0qNgL0jZgCyStYnCa/FVHBS+sIYkfpJsFs
         o5Seji4Lkp3/ln4BDHTaMVuYE57kO0UlfOWU+4kjF2vGzBXX1TkUHDYbMGd02fN+nGMY
         C5V5aGW2dw6Aoa8/mFrMYcwhmwJuGaqAxZTvxVLx9qCVHe55c/e4PBCQfv2PWcrMle6d
         3SipTNglXvCnQicpAVM39e4rL7nDH6T4poOrOmxXdacqdnP82mLY3aVEXOU1Zhikia97
         74Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754846486; x=1755451286;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3kPEuyMJKdfZEruUK4WcSjT4z58iPjJoB5WybG7IVE=;
        b=isXFenEKCj9nZdluNGnsd6OYNuStv4AcnBrIwLeBidXTpUlZq9Ckwj1og905oUk589
         LfTpiEXmdnVfOMM38Sc8wyEWscY+ZsChNa3HCNWndeKu8qHA2Ixrn8GDzvZjB19k7YTC
         HYuxwvOLeHb4BPliCRc13rsoNzBssL+CQNwNEEsJSymsxLhA2kKZDJs461xzxTw/64CS
         yWYaI6xrsV0Xt1GEgAk5xawAVylSbWFTOlw8/slrkxMG//rAkxEfUUgF7VSec027ujHG
         Kksxdo5AKSKlpa9cXV+91Nx0RbbWQmDU4Uap1YVIDC303/+N+jOB1X9DxV2/rNSACXO9
         iCpw==
X-Gm-Message-State: AOJu0Yw73LITmvprLMXiAaxGFp5iaT3ZQ8Ez5rS2ndkLBj2Uapt8NtU5
	C5ET5v7I9mMfFYz6WcC50XtKUs1ERUxRbEzmQDAAjNWbFMmjA7SY0SymJpSp
X-Gm-Gg: ASbGncu1vYF5QAmVFhQPi7M+sWntLGKV6NiuYO1fxUKgEHH70zeQN8f1CtUzMIEmC/y
	1T409RCx+MHxErTNebVAe9X0KxpRGHlFt4FTj3zLxE+coYooJvpaa/8EYqDixrmtuqwaRDlIssC
	HFBXRW4sVgvNwEteb66GqrK3Ks5zL6heH8i4rOEF/u9bWHWhwI6PphwWbYjSIh27VoGcEKRt8dG
	1a3TBuk0aPSuxT+ZVQfYxv2ZIW6rCTCNgbxfdHdQGxnKQWnTynmNBSRX1/+0gy5rJbgBthYHiw0
	j6RDBD5UZN3lgNvDyIVXiMolFOVcpyGwcH5ef6QPAYS8zNu8by4+dFMIdJL+j6Fx8D0DPI/xrcN
	Y7yimKfcSB3hdYWNfbNmDe47VE0gEV+rQCSSD
X-Google-Smtp-Source: AGHT+IEBrqgwE8pQerec9EpnySPAqrbm63OhKfmZOBSYquu36wup+ygLI6F1+JOH+nNSp8ab4IrRsQ==
X-Received: by 2002:a17:902:dacd:b0:240:5549:7094 with SMTP id d9443c01a7336-242c200e82emr147407965ad.18.1754846485896;
        Sun, 10 Aug 2025 10:21:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3a6fsm253387665ad.147.2025.08.10.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 10:21:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93d3186f303d1242a0bde737aeda97959c1eb5cc.1754840319.git.tanggeliang@kylinos.cn>
References:
 <93d3186f303d1242a0bde737aeda97959c1eb5cc.1754840319.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] tcp: md5: remove redundant l3flag variable
Message-ID: <679dabca-dd59-7aa9-2992-57dab2f600b7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Aug 2025 17:21:24 +0000
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
Unstable: 1 failed test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/168635=
66400

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e7e90a01cbe5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D989719


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
