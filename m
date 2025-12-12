Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15733126C0
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531062; cv=none; b=IqcrIFPWsQ8xq0hKPWLbyeW8ecyqNdlySFQI561os49sdzbhSp8HA2BmVborHjmSu0qpd0IHP5Xdh6RI58u8UVO7AxpEn9D8N76bzjmZ0w5wAkMicsouumxM0EpgQbVOE5PiwH/xytmXzWgcFSMAnuKRnFi+j44DPlvpS5r7zm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531062; c=relaxed/simple;
	bh=ib9hKmn7mK0bUe7d6g6KPKZYXGgdSt6WWIJIWKNH7Q4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RKrZAsw53CIGtk9eNcPnmpG7NyoYhiSX3FogduVGEq2iv8KjIBWO8W7cCAQ3LMqt37t2yIcUqez593jiTx55cvWWUch6rklfiEZpP9yhggTqmY61SJfoS3Avmyo/cisbc3E6GK/Y9P6mHrU1u/jbS5YlLP4mQY7PB3GGMHFCv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuxNfMPi; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuxNfMPi"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8824ce98111so14990146d6.0
        for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765531058; x=1766135858; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0e05y0V2lAYh/stfmXbvaWFXDYynL/fxet4QoO7FX0=;
        b=WuxNfMPilTqFFH+8WsTSWw6hVVYgMCBfCOdSzBnotP8kxHmYC8qH9zA3Y+EdBYDwQI
         4oulfiDpXUdzgrm12+SziSh8O2C4rAUZJcnumF4cPPve4t8GoBgPYaautl8LMjWelAgd
         mBzA85XRrqWos/YXJ7mujJqaCqXkTBGlqnOPK4benYsk+roiMj+/gCbkTnPwL0PV4L5O
         uNVOS5dEfKyksEWxHEPTKqMWZRoYIYxJXgaZxK605zboB9ew8slZRpQasxZh6fV1Pipu
         2ynHbkcnBceIL8DoHTF3TUg96mptMoaq+0Y2GyKEeG5ZGbznnc+ABbxcG93OlqEaiF20
         Bpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765531058; x=1766135858;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0e05y0V2lAYh/stfmXbvaWFXDYynL/fxet4QoO7FX0=;
        b=EVIdMkDbBsrrFL6dHcHGiXtw3ldim2LGtPsyhShjPx2O7zbiJ/CEc0pSi+jYGSOqd6
         nbYJUl1ZbKeP8yPNEQ0z0qtLPF+leENf4jwUdA6wVW++JFUNSfgPpulc4nl9rQ8B2apO
         mX/6+j6gi80ftp1KzS2Uko5cjO87cFYr4kX5AHVYlEG+LrW9209ETS9ipAv5UybKlTlA
         hP34oRIWJ9h4MmvWPiRBJU9gLrHtoGXlfFAXNpi+gAWfcokG2WeZENEhDqBOxAkBDYuY
         I6XQELZy9B9GHelLO+xSHuZEG62Dn2QaRMuXCSpnjl4ztebyAcj3EwgwkoLPrzJiCsFS
         rzwA==
X-Gm-Message-State: AOJu0Yxk5NTJWxfkNzwMK1FrwFu5D4I04ZwRfLH6/wd0nBM/VivXd7Gc
	K0bQnjpzXz0mlUifC3gCOuLs4jonVJianFMSurhKx3vBo2KW8WRO4ltkUWl8s07rlw==
X-Gm-Gg: AY/fxX7SidscBBWS3Dn0+vGRT37XPlz5FBC39gSX9LtV6+SGy8rXxQE1/GToHfsVGTX
	qXMj0IJd14EKRsjDj9MkPhz4nruLD7tG0PAGJcJkAgc6UGVx1i3w5XPL2br0KefVoorQ3EmFHjk
	qrFU2Hh8VkuUMs564C4feD3lDl7B12s1HZFLn+1GX3ZeCFH9kbDJtWvUXFmWgSC1PpyezJqIPpY
	sbq1dMrZ78QlUMlJOUGAbJ4AoNFcRpZWmTfGRPV6b6SLqTQbXgCtNGx06+IFRLFJPqP/JhLU1bQ
	B9puqJTCQZmwnHaH3w2sKbkR5S2H+oyw9kkMUfBooGOxh5HcC3J+BynVowHXCcBF9malNDmkcAA
	i+v5D9b406txwfPzj9lmyUFxd7cSZ4s4CcQSSjGWBfo2fsryC0lUk1FjGoOSBCF3/MQ37Vwkomt
	HPZY+AWxrovdWKUzH+ukPaqKU=
X-Google-Smtp-Source: AGHT+IG2mdsb+/+j/wa9jPQFi1ioSp/ZIEtTXuz03NZnZE3bm1WVE0kyRd6By6Mcn+7Xc3wGsaUxAw==
X-Received: by 2002:a05:6214:5287:b0:888:201e:57c7 with SMTP id 6a1803df08f44-8887dfeddaamr19823876d6.5.1765531058573;
        Fri, 12 Dec 2025 01:17:38 -0800 (PST)
Received: from [127.0.0.1] ([64.236.177.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88881a0b913sm6883186d6.46.2025.12.12.01.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 01:17:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1765505775.git.tanggeliang@kylinos.cn>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v4 00/10] MPTCP KTLS support
Message-ID: <ef2e469a-bd21-4909-8114-3ba0c472e6c1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Dec 2025 09:17:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/20154532531

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/397a7ac03cb4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1032489


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
