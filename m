Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260DC3D1CB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782461958; cv=none; b=oRSIEuJRUAivKHA3xf/VVVq26/KanDjrFmFIO9S+nm3CR9c8goCUbr0AUKQ0ObyEtgSzkdlZbhbSt7xG21jP16jE0rYRZn/KEcV6Bl/TjT8bJfkxHLyIF/2gT0WGZcdBI3ouS7EF0BEhYUHtdzTArExH2KLEjvX7nnV0gyLbOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782461958; c=relaxed/simple;
	bh=w9j+Plk5TtNTFVp+eEW4QbPuEiO0s2BD04v5E4jqtDU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=dVyoHtdrrXx0rFUFyN12mpkn6cxTEG7UGxSHXPofS3dGrZv/HPUdKZCS11ILRFvPwl82aNmU2AuQN/l76rikU14+kJ+0lMJaoUbjkLLAl6U6djxv7+Q7bBPukLfT7ABIcMNmUHirH8HTQSS/UABNyTJIZhZw4LFY6Qao7ulpixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8uHSxzW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8uHSxzW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51a019e9ea9so7959821cf.2
        for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782461956; x=1783066756; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ18kotcoWlVXhC1a/TwdTAflM5CHSzBBcO0JDoHxAY=;
        b=c8uHSxzW43+dnj+NFGwgYCqsxrMi4Z7VJjladPhxdc3mppCFFq4SQNzbTS3/0q/KJa
         mJzwoywzc9ev5ep9jcvWfcpsnIHBvQNd4ZdA7iGAzMf5AzmneGvH37J8xTYJfSHhJ1b1
         ZhG6e+CgoERjPsBC8Mb2i9qgDst5hC16omsGnn/YGYKBfHFkMo7CypA1LNudnLCvGXL4
         /8g4s496I+5smwrg77Yvy8Ezgy7VQwIQPwf00Hwq7si2gIwsgGrnJbPIsf7OBNfGjwpD
         rwExw1lNI1AHQJTxvBFCeUhwoToTcDD6tyAxUfNnvEC8FvvMUKjkQ7BIGILqQriPwBko
         PUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782461956; x=1783066756;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ18kotcoWlVXhC1a/TwdTAflM5CHSzBBcO0JDoHxAY=;
        b=W63m7WpdJ+rV81E6LZ+wHOXikHWqyA0L2G6Aguw8YcmPhXf8yTUOKnUGn5snoG8DZA
         Vv8HOXAkgd8OlJDGU6TbSPcYTBifi1YqAq9rkPMdE1UmG8khqZiw9tAIIEHLEs+Fk2Io
         XjZmzyEUifdOXvoXaQNitLqHQC5fUQIi2MzEGZ355gDotO/nXxzS8It3bOBKJO6wJN0I
         ZdhIKd9YILmP43d9LI6nJjb8tXcxCiwlFxx/ezQuwMjtqhoq8noACcmt5DhyyOdBvroS
         t7HvkvAa4ay9M1UZ4vgX+l6+RKrbnhJSuai7uokUgWeJUabJ5XvxZcDo35s3VjrdMGPJ
         YFqg==
X-Gm-Message-State: AOJu0YyFbaFMOBP/Hmu4JpYHRTALKgIQUmSoDfxcQkjq37xVyt7/mI2J
	ZND4m/tAljvATVD5+Mu73VreMBnfLsatWHtRt5fF0sd22MG1XT1MfE8/IkRz
X-Gm-Gg: AfdE7clmxogzxOwiwf2M/vwUNuqh++eyHZU/LlsUdI6dfPzNexM/DfevkLONh2kXpbW
	baQGweJFPu0SrjRSAvcdSxyNIucEgR4cX11/Fw+tGT8O6fHgiM02goR6UJZnGlC2FhBSS5GNpes
	klQohT8I/AwOn2m2jq6SiCIR8hQhEkTky5cQLfaijm8hjsO4bxMoS/t0HUg43rcB4FK5VTvgYsl
	m8Bh4SdmBsGpDUDEzcQqaveCsPUXOjy7PKR//Kh9GGEgJ1u3hdHJ0W+wSzqIAjIssk/5rGghtzI
	Boost4HkGsBJIpmq3X9EN1dfDjpqJ2/6X3vdC1Rr+D6ZbUzbjWji4GFMknazmv2aC5c2U+12bFl
	ikBx0JVhogGYmci8NudztWaAFgNXkI9HAE3VnhaEHQSo9VBb7zJ5ZJkED4BUyF4rHCZSZF8HSjY
	pz4b9KeGNvtjnbyP2ZK2cmj76WSg==
X-Received: by 2002:a05:620a:1b8b:b0:915:40ff:4e10 with SMTP id af79cd13be357-9293b47517bmr912958785a.4.1782461955716;
        Fri, 26 Jun 2026 01:19:15 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a1892sm1084838285a.38.2026.06.26.01.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:19:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1782457962.git.tanggeliang@kylinos.cn>
References: <cover.1782457962.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/3] only remove entry from
 local_addr_list when sending a REMOVE_ADDR
Message-ID: <76a0c6dc-ef0f-4452-37b4-b7aa5e69691b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:19:14 +0000
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
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/28223950581

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2e04a2de29b7
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1116901


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
