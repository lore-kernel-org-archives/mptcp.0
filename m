Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05911346E4A
	for <mptcp@lists.linux.dev>; Fri,  5 Dec 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947193; cv=none; b=Ij6NQDFaO5T0pO7kXwjvWPE6efVzPtgoMKDNzoaDmumqAwcSy66zFXnbfcTjTCLnciOtJ+jmocQ1cH9wj487fE2iJXwpXVLxv4fyX90sxVG/Y9mEOJ8CiVMy2ZhB7Zo66m3WGou+X6mGyN40wlNpymyVoZjZw3Uta/PzJ/K1eqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947193; c=relaxed/simple;
	bh=v8/ski6TtACx1ApM8J/7lN7PKIERGpycxrQ3eiaL8lQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tFmzXGbh8DMajCneSm4d3YqFk7zL/7JpqyT/JLdcNeZ3SgJ5JapOikU2gSM7w93HvsO9kG/ypuMelipfFLpYHmp2NKpiiNIz1C7NlgnyflTdExdTdd3POBww2VhuRKVSLUe2ceCVE8FBbajwwHD96DNMOHudIym+Z7qjzSIw35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOjaj8IR; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOjaj8IR"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-3438d4ae152so2032452a91.1
        for <mptcp@lists.linux.dev>; Fri, 05 Dec 2025 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764947190; x=1765551990; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwbXrhWgA6xvAcWQybaYCyXC/qnppSCDd5CCetecjg4=;
        b=GOjaj8IR+5nVNRdhIhJmR1M59P6is6KFMO3v0cH4yd8QEOVOsbIMP+kE0uVGVyRwEd
         RQklvwrINgmcIuJlV1t4fSGWLmPUeCV6axvng2SIRriMS91m/L+aASeUfGQN+exbtB/f
         907/rymeFk2M5IXYv6HsPS0FLjTJQyGidIdE9FZG79qTy4DDy97ybZspB6Dzv5yWr3eB
         dvVcbw5XYRLPBElMkkZCXmG3bG//6XNei4Cu8io9AlKcbkBp22hJnN/wiQUlzAE79BfJ
         ZSQvd7jtdkYBKs5N33w8Bj6ScQMKxFYEFjMNc6VX784l3oRUpi+vlX6k6rvsUM9Temx3
         Rtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764947190; x=1765551990;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwbXrhWgA6xvAcWQybaYCyXC/qnppSCDd5CCetecjg4=;
        b=oARJ7PiXpmcJ/Ye7A+kBRprH8cZymVxmkicRbR8jNCW8NZMaw7farGPB8xSmCJt+r2
         EaC3XgE/ztzZDLwiXD4cBXNhZIe2H/pZlRI9GZb5/nYPg4OBBeQegaYqF7gximM0wvnF
         u22aSh5HsJjScodA53toGRdmq3DF4fWbn5X9LDgd7TZtvkXaWl8vON+zip1Q1Py3Du0R
         77HBeFZlkpam2XDzfwpykglRekBzRZsUaIn8/jQ1JJ1bSliMHcUzE1Ea9KGHd7KvOZ6T
         UIZvl5n0O+pt0c8PxJh0Pvh2gSv0oIPEMRGtaC49hlxrvOHxMePm0OQSPgVDbChmDkru
         tZTQ==
X-Gm-Message-State: AOJu0YxeM+9wKJsE9T0v0xGr3RdUwiAN9C1my8bWpWrmFv6vRfsq4nhD
	4sNhsolgRw2hP/E5q8uxkKeNqU6dQFtuBVuUDeTIezjyjk8cUv2Yx+k=
X-Gm-Gg: ASbGnctvdicQc3ymGee2Ul+UhBNf2vLxAxBmGrsr8aLF7AI/Pz0XC7gSAincLudhpSx
	HSMFGlQTRGcTtmGJj3R6FMBOT1w5eeKLEoKaJMBNMjlNw2geJQYQvFVSTShl+raspuV8qzA5sUR
	ETWIp4n74JpImprhkYlRTEd43DuzT0lAvDuV8twNBkf7N6WugLNMHt0EO7BIwcR6QUIDVipXpVG
	O2PKsR4Tx+V2gnxPeeNEiNxfbu0gIRPWbPpZzOaqpWh9XsY3G3N1e2MwzuGGTno+zdir2Au7rOE
	WoGyN7NtTaFzAjgTImR9KBuRwJ95v4Iv7YHcofNuE+z5XT5POuvMrI+HUU+TVbExSckMrXJJigO
	8uUq+Mia8hb5kT8P7jNxoiKr5RiYqZHLvhpgoqZKskhGILKRAUDMkVdZo4K+4JRiKC9yEf1cm+m
	43DZw1TF5LWfWuebD4hpZY5JsplA==
X-Google-Smtp-Source: AGHT+IESiPham9EYCjTbVn+QMPTBIOAq3HjtLUXFbfUXcRiusbvMoiwCDOFpiTUjvPJCCXX4OlXKwg==
X-Received: by 2002:a17:90b:1810:b0:32d:dc3e:5575 with SMTP id 98e67ed59e1d1-349125c1069mr10872985a91.5.1764947189474;
        Fri, 05 Dec 2025 07:06:29 -0800 (PST)
Received: from [127.0.0.1] ([172.215.208.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34912ce3f5fsm4373030a91.3.2025.12.05.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:06:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251204054417.491439-1-ebiggers@kernel.org>
References: <20251204054417.491439-1-ebiggers@kernel.org>
Subject: Re: [PATCH net] mptcp: select CRYPTO_LIB_UTILS instead of CRYPTO
Message-ID: <f55d1ff5-95f9-cd54-ea67-4193a0f31604@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Dec 2025 15:06:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Eric,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19965132984

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b6994db22b86
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1030329


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
