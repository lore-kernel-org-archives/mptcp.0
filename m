Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE61E1E1D
	for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930451; cv=none; b=e/6i82t2AmehyKYSpGICk9HxQjZFx4sWz5CkcXA/dIGjbgiz38wLT6s8G9oRoj+ZQyzeMaAlyRDc+yyLdHh+9UHcU+7/M7y8ECAFqwWhqgF3WQkoPuapaTaYjCpBsm4Xx8pHYeK/rxs39uIepBteCF++I6F3zWjcyHUe1NW5Yxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930451; c=relaxed/simple;
	bh=TK1tLYoGro6YgbuwOidZpKupU7naMGNNTEUBD/hYSRc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jNxM61fasG3THX3RC1SxO8uMG5YLxDHNbFvn3Xzx83R/4IlyWOuTu9UlH8DBDm0fV7UjMIFT5KUIciszVWqnLDedLG8uksgNyavVrmuaa6+YAaFG86XAgdYsRaDlLT/k8oyxXVUp2G7BWc1vu095pMV0B3wM7JopI41w5GZEtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHveFmJs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHveFmJs"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c58974ed57so601825185a.2
        for <mptcp@lists.linux.dev>; Tue, 25 Mar 2025 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742930449; x=1743535249; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOC/6nAtmVuh634T+uyiQBxtYoIJZ8aam+zbOIowarU=;
        b=MHveFmJsGh3m9ocGE2p/TZfl0846aBGqJxTVudWlfGFvL1WwjxEOIatmKHvDb/Dmbc
         RQrqAkODL2FBl7xgaEF0VC4gu3i0yb6DBRMCcmM5hlaSxwVlKRy1hyzYF3F+Hxj/9dF9
         i2iA5zvFNOGcrafgaHxMjIjFM9kckQbIJrnsMzL2R3TjdNHuIgyJ7dqQzK3flxIkciLA
         13ELPj1f+K0GqJL66LsRapFbmxSvL0Z0pD+jZmODnE05j62HDbTn4YtuLGyK/Zy7VUwj
         loCe4z4GARFZuNm3WT74oDRaHBWCKhk7vcHgho9PswNdqGMAHcGKnUWiZmOorUzOOp62
         i5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742930449; x=1743535249;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOC/6nAtmVuh634T+uyiQBxtYoIJZ8aam+zbOIowarU=;
        b=mmaadOx7FcZM0giPJCvjArOk1/BiGUtuMsvnZqiJlIFkvKngsMGT+3L8EEW6uAOyh5
         DoDYBdhqSVvhXy4zEN5hSIPhzJ1kSr5LQW5bsuW5AbzCbrz0F+1slSpAV3IREQFUOusE
         s/H0GsR8ZwEMNxZ6YBcmQVWVNUcsxJW7Izl1SQfE/WtzUTa69vJx4QGpPTrHlLjCWkGW
         HOhJh0hHJwccmeC4szcjtS5PUAstSk/oucTTXrpJa1+ILebx6UD4wdY7wY03IVOIxLQE
         jC1sOvP8igbnXpkSoO2xWoT+Gaa0VobFmHBVYHlZR+flI2uLNR3h/YbbODTe90IqCZWJ
         qqOQ==
X-Gm-Message-State: AOJu0YzNskBNzQbVmorMvKNw8WyUqjPPPOOfV2WIP/PDrwC+OymglLcV
	BTK8rJisOEp1aIDk2g1rWCd7xaXfEwEqWq9ztyq3b+Z1xW+ehCC6arRC
X-Gm-Gg: ASbGnct/sBlgd42eglgK44UhxSkYL16tTXyrit0BNFhbN6BNy6meKkHadV+o7He3kcL
	bT3PC49KIsRLgsQEgiZ26gkEfdWFEwKcJywHM5mIjjitl17zmYg2gfEaLPndatEOeoWfAB/d6tf
	+uKYJIKOBbLmsWXzB/J3acR6nIvrtcTSpIWAIEAr85Lab/cyB6Q7m9jc1xF7l0EqFdyxw+r+IkV
	dGaKSSgZK8z1tcWcY5lGOFUC8VGXkrMp6XGIdQXx2fA7hJhoBIgjvHcuA+zFtY0QU20VskZxIR1
	z1TxGcJaaLVpQz9raEN59xPHlKt3El7j4lgJJ/0SyZVwMiGdQtonsf6Scw==
X-Google-Smtp-Source: AGHT+IHSJDHr2N8JwAWKuZrxRqr4y3VmIKPKIGQ+qO8bL+z/8MIe0oaSRWX3NzJf1+W9FIdiGYKvQQ==
X-Received: by 2002:a05:620a:4451:b0:7c5:3ca5:58f5 with SMTP id af79cd13be357-7c5ba133713mr2768324985a.3.1742930448807;
        Tue, 25 Mar 2025 12:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.44.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d0137sm671344785a.31.2025.03.25.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:20:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250325163251.135510-2-thorsten.blum@linux.dev>
References: <20250325163251.135510-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH v2] mptcp: pm: Return local variable instead of freed
 pointer
Message-ID: <7e04b7ab-03e3-798f-e87c-9346b74c9058@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Mar 2025 19:20:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Thorsten,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/140672=
88712

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0852b4c9fbd3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D947230


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
