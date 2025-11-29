Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CB1A0BF3
	for <mptcp@lists.linux.dev>; Sat, 29 Nov 2025 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764396475; cv=none; b=krhxOszN1ibngJgC2K+aoSBXBeh/ECtVMo+bucsws3yHUjw5+AcoDCQAoAynpB3xDfiO2Dp9TH5lGVezBPUGdbVbAITAJrY9TkJ2/Bn6PH2BOs9JUV5vjMNUiAdCft7AqcLaGc8L713hio962ovCeaGeB9eTw7Oe7cHMli/wzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764396475; c=relaxed/simple;
	bh=KlDZhhAcZChVh3rO4A6moqbcY2RbMN8SKXZ/YWMgo/A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Fzupu2y+HSBBpMo/OOnnhKI1FC1UEV1g6YueSHHq7xW0MSCmbHTIjn81ZWNjjxMSp1cvSoDE0sH6br9VnzkT78kKGlKghCM1bnIvGTgOTMYb1+Lwi7FdbPacPyAFUsS2iWg6cvLxQbQ6CS+Orpya6IcqR8c+c+GNasVRL17Ii8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj4TReOd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj4TReOd"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29555415c5fso30697645ad.1
        for <mptcp@lists.linux.dev>; Fri, 28 Nov 2025 22:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764396473; x=1765001273; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ2OK/8kOORhk4epypuExMB7IdBtRNqbdtcVoIaOUXU=;
        b=mj4TReOd8QG2w/OMw81z/X0iVDjCs6HuGCnZl0B9B8Zdj2ndST3nPtRrZzqAOq69NM
         GiBH+N+4Vln0QOapa5czR+88YGfZpeyRGmbGk1llQYNjj2HspB9vEXxleVdJP4mK+Dsu
         bd0e4Aw0VY8JgUjkLAmcEnA1L7OMLBo/4ulLTjlNpTm4TACK5JMdFGvUOvX6Rd5NP+1c
         27Hn9geijCx7Byp/GCmClq+SKjNGwpb8kZzzHD4DJHN9l3KWdwfl92c/QcCQ8x9rY28k
         ZtI20IxlEpcFFovB7FDHTPDQRY75ErGY5LyqW+vFGUMevxdGUDzJCSTrMczE5CuKu4be
         FvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764396473; x=1765001273;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ2OK/8kOORhk4epypuExMB7IdBtRNqbdtcVoIaOUXU=;
        b=sppU7zjr+eB5/uwTWoO4elxaS+DJeDNh1yw50/K9OXvLvym/8LYVe3A0nzih4+VfEi
         8DZWDzQk5V9zF1R6kuvQGbAlQPOXifDkrGdqoLmvn3yyehqoR1fP7V2Vg3P4WgbrWZeM
         afEMiVzLLPkS5uhmyVyGVcR4u0oMrL2a5Z6JR/6Mg+ZRQTHzpJkOSDdpJmUt+AN/J4ZL
         jd/j9mPG32QiddOf+BYeO9v82+oA/qTqFjreJ8zKA5CFCdNGvv8+sNyRW2HQKPAIHJCA
         1leejEY76rufkGOiWqRfpM1vAy3K+KqEv1erSb8PW3TtRtARcjhsuBx2UNxMSSwrXETv
         W/iA==
X-Gm-Message-State: AOJu0Yz5gKDsRUMLJN1jbQYSfCbDzbsa7mh1KEFu2xuAVhGVg6yVp6DY
	lsY+5uJovuHvrp6Kr95dvy3ySPFv/WZYzNPKQn+OaT7j/AGfYOjxoks=
X-Gm-Gg: ASbGnctQEGg+nrr4OPeOBNB02ki+wX95j2uZdL4UbwMGUji2aH3Tt94LxKWQUlLXGTh
	0Wr9YukDCdysJj1bWXGOhhRoVIOavOWZWoOhjY0HpM8YQyyUBIJcOHWvBHwxSLTFDqEsTO2FNHu
	xk7x7h2l93AIdUnq+iFDWOIJ5vEPoSgpXMxAlrIiUHXnghdDshlXNiFx4flhBDC/+5xMZ0Tp+Lx
	zwHZdag69TilyG0I2OouXzN60AtN09gy3jZYdl8L29V1hVuEBYK43DEyBOHpevk0PGu9u8CrorZ
	HSu6/BlQHySpT/yLkUxrSFjD2BSDoYCDRa9XCtQY3JvElZRss6VStJQgoBuhtQH03JsLVWJn6wI
	jihCbOJQEYMjSh6tD9PD4+9gNRK7SiH/islMLlrB/owCK46Q+5GK49Wu0DX1yyofGyU3zU83zgC
	msqrelVCALOaC3bjLhOCues7z3
X-Google-Smtp-Source: AGHT+IFrBPK6/UJIi9Gb39STtFMPH3/a16ysCweELqdPFlShCAVj8WfSsSP0S/wfP/XC5871ngbzmg==
X-Received: by 2002:a05:7022:412:b0:11a:4ffb:9849 with SMTP id a92af1059eb24-11c9d811985mr23294196c88.21.1764396472733;
        Fri, 28 Nov 2025 22:07:52 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb049cdesm27584401c88.8.2025.11.28.22.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 22:07:52 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
References: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
Subject: Re: [PATCH net-next v2] selftests: mptcp: Mark xerror __noreturn
Message-ID: <c13ff623-0765-f919-8039-2c2cba7f5133@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Nov 2025 06:07:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Ankit,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 3 failed =
test(s): packetdrill_dss selftest_diag selftest_mptcp_connect_sendfile =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/19779229739

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/871522e929e3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1028829


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
