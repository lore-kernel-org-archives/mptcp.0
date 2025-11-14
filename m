Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46B1DE2C9
	for <mptcp@lists.linux.dev>; Fri, 14 Nov 2025 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084615; cv=none; b=HbDXOoWkzrv1aN+aBc9VzF7OIM80LF3k5s+CBXT++ohQJ5ATmAtRpVo/dFiKmBAMtHUzghEqCiRU77V7D72d7TQcGUObICZaeNSgGg+W1P9VT2evQFh7L4tYijYsjkPi+1qSL6rMTxOh2eVX+kCUW0NMgZIwFL0UKbXCd6GiUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084615; c=relaxed/simple;
	bh=NXCxcEnKcC1xOljXjLHvaEiXeouGvHb8dTE/p+UpMqI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YddG/CiMeRe6XpLPbxeRuQrkDidcySYHB8xD6iNn1r6FuGe4xEYtdwGX+2vT+X/qYjy3Ho6lA0NwXUbd759BPU3dwgGY36Of7oFpww52z3Cdh2kdCB6jlNYHZmSlgOYqMsa6/+/Osj7UH8BK0z8R1AQu8L3ZpOrbOs0PkWLxl+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3cdUSvM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3cdUSvM"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1212731b3a.1
        for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 17:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763084614; x=1763689414; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxnUhoGMvmRypuOiZqyr1a1uNtk9how5+rkt00YZ+yQ=;
        b=E3cdUSvM3y/Wj5mUzhTyjkbN/CrKdJRm8sY1xpNGZD/q1NSsXoNbT1Xq+k9ECEDLne
         DDwHKrBGx9jwarPMkChHY6G777wBFWQbtnfQVMGVDsMrorjKhL5fOc12cz977gwxaefo
         nQ9Wh6b6VJpFVt5uJ7WIRXcVPpZgPivWtFpXSq2nMqDNpRDrGEldI7LzXjoi+jMOtdma
         O8bWVsXI8vhBZIRiWKPioetS9vsqgwbUJXdqh4SZ871YZVo4h/FOCuWOm5e+dQa9c/OQ
         qcui4SC6ihGh7pibw8//KL3oSpsTeeCRtuRspjluTza6h7QHAkBnl6it8v57xa+iJK24
         qytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763084614; x=1763689414;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxnUhoGMvmRypuOiZqyr1a1uNtk9how5+rkt00YZ+yQ=;
        b=r33dy/bkpbhcd8vNaVQSka5Ypumx/YmJHikhu/IwDncflIIyunABOOQItxdgle970d
         W31mW+oDe2xJ3KKwraBIz6/I01ror4nRKop2/HshG9hgb0exBYQoYoxsdstIp7U8Y4I8
         jnnxw0r9uCcRJx/cO8dIC0m9P/LSm/mGI2HijCfZLQAiw4e/efYU0m+MV5hjWE79GuFD
         6OsPjbrTRBqwtaDRAO4ZZe/DDWmmab/klNSdKLCv6yWh3US6lJwodTQtdAGthFf3Eb5O
         1aSpxkW40KeimfOx8ggsXP9/6gUii4grl13+Qtxa8h1H002jX9KwnCPI+JdU/eA41OkD
         1MhA==
X-Gm-Message-State: AOJu0Yy++SIve0BNyJWPJe3LXEmS5TkFGfzTH6D7SygKQfZIaz3i54ea
	yCIqwcT7LKYRCdZLncPzXe+VE9J46zBtLrEH77kcokVj5rlVqySUi3Y=
X-Gm-Gg: ASbGncvl5XKuZoezZmJ/XwkZRlUJ9fPHqTxGKbXJ2dUnZTcjr84TA2kLTP8VCccth1D
	UIGL0Kd2SeBW0R2mg4sjbR2hHjQFopTCxmtP4tbIVIjvzJWBC3lhAukfhDF4RAtThJ2iRjzxN/q
	3y0D7Thb55koX3ZrBdslYUvi+fbswtxz89IiMgbDXd9mObVgSVpAQFRgyxsAwnZegSfFog4jr9M
	ALZsXoK0y1GG56NPZkB35Lwi18uSG7nka2b8ZmsXaQQNRuoc3uoCdNOJKNF/uL5wUIUrbdv87mj
	PzQgbQXdmYXwCBqZk3Wz0YK7wCjuLdQhFMge419YnZdwl1r4I4LhYX5uDCRiKFpKJ+GcQdEPp/n
	bK+Cq16hBlrgIx40QE85Q6+6M6CsnfQKaxKL9sJhCVOOPIXsVzjwvotuFIGl6I/jruv2+nQoh71
	0msF0C5vhP/DlgP27u/KDkM656gl9CQW4PNCPK
X-Google-Smtp-Source: AGHT+IFdMihnMdO540AoOjfKDeHn//EoZIrVUKllJvvvr16xONODfvdlzNaay9Xh5V7M0b/oXG01GQ==
X-Received: by 2002:a05:7300:ec97:b0:2a4:8aaf:d6b9 with SMTP id 5a478bee46e88-2a4aba993a1mr517342eec.13.1763084613569;
        Thu, 13 Nov 2025 17:43:33 -0800 (PST)
Received: from [127.0.0.1] ([172.184.220.153])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088604sm4285873c88.7.2025.11.13.17.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 17:43:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763075056.git.pabeni@redhat.com>
References: <cover.1763075056.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: a few random fixes
Message-ID: <4fb8c093-d8cc-0b1b-1a44-2f4a8bbeac74@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Nov 2025 01:43:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: 85 Call =
Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: normal =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join=
 =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/193490=
79984

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/88e88d30abed
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1023207


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
