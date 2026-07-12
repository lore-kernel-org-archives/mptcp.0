Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4452AE7A
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783854040; cv=none; b=g3AsmwnYNzC1TQlO1yklzYJ9uUwx8Cv3bT4GUwLQGoTOYkFKozMr+qWcC3I8rXrqCY6olzSVbe9Kotb7I+B96FGksq2McU+iPhChZB2nqHCueKR/tvGMNSYJhMWVPWlImwHAnEUKri81DDzRLoxC2MrOYQ+19csWK6fT+JaFD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783854040; c=relaxed/simple;
	bh=8F9aeM/xrjAGto+hDzczoY8oJKJ18gAu2PhW6zTCSb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=JNUlQK9C4Boof+NvPyV+pbtU2cQ5U/xAX3g7CFnTND/tWH8sYyYO+NQbPF++cpjhNiCYKvvE2P7Lf55e4n34EmckVlgMZwDcgtHsEuhhUzHpr72CenjjMcrWU28res1D6HXpubUMaaKBDfxsm4Ql4JaKeFXG9tZddrMTQcpdqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRMP5vVr; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRMP5vVr"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90004d2f7b7so34641116d6.1
        for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783854038; x=1784458838; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xHhxO3VtPC/1lE/63PdD0sBF4G1NZPmyEq6Ll/R4Uro=;
        b=bRMP5vVrVs0EafKc0EEFDg/jhA2STBs2IPlFJjmNJXFoLQqw4yUh0qikCTlr04tFc/
         bQz5Tu8pxQ23C4zWe9buJz/QyizUOto+UUOsXHmAf+bS+iQ3RBD0X67HVUdoA4N1U1UC
         YVNUIDRNrYlnyI+s6O7LII4ealhBRgBnojrImCNIjH5y5wXC2lUTVuVk3PHjFsvv0r3D
         7A35cW1mzbHHRjtPZAu8ceTURcoP8zoOYyHhE5qtsIUDjxyoZ/GbFkF8hKQgGcCw0gG9
         j1q3qFs2ahETVdkzWWBw5voJOuyUbKkS6HcM6Whw4KBz8RPG3eoh///8e50cO7ZvI9yk
         owLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783854038; x=1784458838;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHhxO3VtPC/1lE/63PdD0sBF4G1NZPmyEq6Ll/R4Uro=;
        b=pCMR1B9GoZOIhPGxyLs1aKEfhzv/t3Gqn39sFwtXRtegqTjzngh9MDfItIEMyu7fAa
         /IzTinyYCgLbk8LLRMzg3BK9c8+p/DJkysCdXZWowQPRKPw5aPbk0Qg9T5lnmP8PwYUJ
         jzdxhwjZqs/V+mUy6kb/cY4gjMTikfw0VFbZxQM2lcWgOKa9h6hY5UL2jrW3YR2qFsoF
         tnWcjqN9VMx4LrPTtJXnfbCi+vcVoIejOynFfsOog3obe27grMv8s2Tu6i9ZWgtrMRLW
         yY/X/2+7QGvgH8rAxGYSGi46cqh80SGgpBTWcovSi2TL29oIq/Yb8W/9RTE9hLNaLAl7
         eOqw==
X-Gm-Message-State: AOJu0Yy6Cn3ZYj7l0NQm9qcLBSqQuyTcSLTzeHqFx4AaqAvU/Wji4dIZ
	YkKIbuTk6E18sPbfgsAcQpj2RVoEtEKNV7bGzljJxAvlhQFpFpkH16YRc6gA
X-Gm-Gg: AfdE7cmAqT1nq+Lb9oHehh1FBz8Pbsp8yzuy40MQHSblRRwzwByvcWYxCrKJV8TgFVh
	EyqB4F+xoCI5u9OhDeGWRKh0mBUKHk43+GjIlLmfa2BfuxW66xOLMD/0sVhv0dBzvsY10+08OhH
	U2pwyCo87QOmOoWz1vLeWfzpUjdf1LMIOSwDb61IWWig9Q05W7c5DdLSdBcdCAwn7gVyFuu/jVB
	+6x3NC6Jr48iV8SmbLH8yimwxCr8wwBdlCWR8GgVjwrgqvapPvmKRdOs7npP928k84tNap85ywQ
	o0vDuOPtcK13UC8MW6VyFQFnOa8NgI9CW6f5/kqF4+0uTT6YoG4KaeiAxAvspwYTx0c5DSC6lm0
	7Gf5sZuaL62I2DP/NvS7G78IiOn6xZus92WCCVjAudxr3wZ1fbR0b+7qEjDmc5ug5ZexGntk1t6
	HCKAoURPZnPGdGQidZYE62nxyMtw==
X-Received: by 2002:a05:6214:19ca:b0:8ee:39bc:8fb4 with SMTP id 6a1803df08f44-90401f6e6fdmr63501656d6.33.1783854037458;
        Sun, 12 Jul 2026 04:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.227.85])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fe218sm99414546d6.33.2026.07.12.04.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 04:00:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1783849522.git.tanggeliang@kylinos.cn>
References: <cover.1783849522.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 00/15] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <3c4848e0-07e4-dc83-2448-ed7bd6733b0a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 11:00:36 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/291887=
14062

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a09e965284b4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1126049


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
