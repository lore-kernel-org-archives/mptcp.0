Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2DD4A3F00
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438528; cv=none; b=DIytwKrWf+g6vgvnE8JVGpg6PdYQ0iBw8S1+xoCBg0egClZ8T004O8j6nc8rK6SMDz/enIR/WBkKKKuVCQhpL5FNEHADwml3jFBvJjMQkgGgno/Z29ZH600lAzU7tiFIEd49oZ/6DmcKaLM4ImWmZ9Nx0qm3SE7c8jJ3GYGwCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438528; c=relaxed/simple;
	bh=KWuLbeGWbqZiNu0R1vZkFwdkUbcbgRXHTEn9dmAecRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ir2TPWs25aoJhzCe9rcAeHAtkHkP8LtLsefQDif62L/pKAxubLUUiSwHGQ9b9/z10i39Flj63DWAdaSj3JUYG1gKuE1MQvLGVURQT3MjOJA2n5yX0uwdToIrFceHZ5zB59dwbRRKCKKtZoyuiwzPUCJWYN+7kpEEyTehlPqZYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaT+Ge/b; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaT+Ge/b"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-382ef647e20so2706924a91.1
        for <mptcp@lists.linux.dev>; Thu, 03 Sep 2026 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788438525; x=1789043325; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M7VnLtB6t/2taDZwrvT6PqUmUxqd6ICRe8MLiE8xpIs=;
        b=HaT+Ge/b+KhYua+u7ae+4I0gC8XXOsLUg0DlWvT9XPgT+G3HLWwpxZ47YE0xmrsWKO
         mDZsiqTLIZPYlpb9j+aRkr1voMTO5mtPmguUGTmf5XbpyoTU2gy/R4v7n585eNpC474M
         eySO28QB5VwgLAfOyv9z9gpjC5CXkGjko15UsOKIL4PjfXDyTvnYuejsO7yMYA2vzKIc
         2iaLkbCos18wUFzYxu6cS0uON9ir6v5K7LhFzGOpKWGP0d01fLUx0Bk4h+2K/1s16eUx
         h0zpPF51f28n1wRs0YRITdHiEQdBHg2phvp8NsB9P+fKAnLghHFp1Jivz0tB8xrV4z2A
         5yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438525; x=1789043325;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7VnLtB6t/2taDZwrvT6PqUmUxqd6ICRe8MLiE8xpIs=;
        b=DT9/wNhwBPM8ED3t4jzEy/Oj3CFrseXjzaKBkB6NfV3W/9154EY0CsJtjk5ZhjQJTr
         lJRbajNuPEJ4HvbOvzVwUolzFocE7FWPFBqTR7pNVPosEv8LrEmvpq1m690c7rEbNrKW
         2HTQ0fdNVFhQBC2D+MBh1fhXy0pkD7Iq2R81+a/GXHip1UsVmKBU1V0UFmnYgLUjGjMY
         jK40z2kie2Xh9n1qubzZ+C2rY2H4K8K0qf6e8d6PyG2C+iHrISOGpTdnrnQxBvC/Mfn+
         mz46czpsJEy7G1wQSgU2c5BSyXMsYgImsjqelCdajJbnhTf2sp99SPiN3HidylrT5TBQ
         IMeg==
X-Gm-Message-State: AFuF++lQ8LqE6GvtZebbDqQVBxhK22zRv6+XLBBEBQ5tQCbryLbKeD//
	r0T53osHoB0Bbh3WuxKNgd05vp/ZOyr2/4F/zuymQiIYtrRd59kNyvM=
X-Gm-Gg: AYBFou2HV5N3zLTe4PS6e/+zcMfCpYNr50rGGPMgRFqvGPm61Ah4nVbPIB4AbvYXnKo
	Lzb1I/Ayu94Pc5pPI1xU5RoOpmELe6Nx1iSaCpH1DXrZfQ/547LBv+fsSVET30Io0fTIZYLOrDj
	JcrKcRnT65PqsobaweYPEymeYzfohw8muyEbcqd6iB2IgGuNnXgOFnrkBKv84GHFg5Mr9t1rk8G
	/KR5i+oS68tIXL3aIKx/QpVsYjiB0Hnt9J9O9kz4NBpy0Cb3YqAl4eLMScqa9Gbw5YAbSXJfQfX
	5QFnH04merbQ9pDbWTdkuLksZr52nAHOjqS+zrw8WSShiV24hkL+UUPxwrpbtdxDXKHKf5dBdvf
	olSEb/sHVl/EeXg2ZdCeBkMduq7eWy7VVu4mggT/P+pdk5ETUgrClUiBIhpkP8igcWG3FN382Wd
	YmcijoPzSDDT/aS5981+EbRMfMfYmaZ60UQrnNQ4q0v/FTypVRai1uCuIVSGDTpyK2gPnpHVJCi
	A==
X-Received: by 2002:a17:90b:548c:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39aede9368amr19355280a91.1.1788438520569;
        Thu, 03 Sep 2026 05:28:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325592d9c5sm6785565eec.11.2026.09.03.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:28:39 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
References: <20260903-mptcp-mib-inval-opt-v1-0-84a553c552b6@kernel.org>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: options: MIB for invalid & drop
 suboptions
Message-ID: <15299bdd-918c-bc26-3b6c-0d5fcc7bd421@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 12:28:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33751121801

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4bac67106a0b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1157018


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
