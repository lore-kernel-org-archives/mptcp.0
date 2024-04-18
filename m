Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E2127B57
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437093; cv=none; b=I6zAoaYWFX2lNqGwow/aijkt6Rd58mavkeZdORXVCCWYX84jYAKw1fMYwWVICEbgElVPU7dj68vfP0EwxBaAT8Pr+zrwZ8wK6aGOkJcbCT1j2i4cnxRb/+W4QgRaQzWAVIq88iefKvPMZh1QgOszI+acWR1Z5qSAbwdWb0cAw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437093; c=relaxed/simple;
	bh=akPMqwAR5FH0hCVSEIwJLMzO2hPjcIo64wGwZ6188Mw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=L22zJRTePKQzJLmagHQzHQARaG2WK249aC5PhMMq3yCPKMyp/1I8EqCeR2pGu3USPHFOo6XexAHhudoprJrVHIPvOaODzxH+jcSplbPyMfzX+BrlV1H2ZNePnU5JYVYdvHpqzNAtionMQqKzpcI2e17C0R07WrfyHrf+foQE6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtwH+GbM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtwH+GbM"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78efd0fcec4so42161685a.1
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713437091; x=1714041891; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE0Y9IlvPvAip77aPfi9fXaerL8/eA0I4ZmbMXiT9L4=;
        b=HtwH+GbMAUGxMxu55zXMt4iWWrdfhLCJDhpaa5kw+dBcXeJjcf7EbtLQDn7QM5wsMH
         gcS/qsroZvnxeXdytDm8TYNBFyMl/80kLCZTOonOsTDR6DHDkf4gnBIwLXgQU9T617BU
         7JUHkerrVJS+mOKIpGrNeJuNPltEeuV7PSlE0nzXbfYdZfosgxv8/cllIcqEFFja9fS9
         /eGdqCbjZATiJM3zzbRxC9QphkPtogKWSuHJ2KPKHzIszo+GYXMfTKP+OJWxGX7dVFsS
         qmL5KhMZF2owudB4glm1PYpMNa/32ootF9effUlBSPZJKC1XZfnq1n+/+Ys8BaB5lXVQ
         M0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713437091; x=1714041891;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sE0Y9IlvPvAip77aPfi9fXaerL8/eA0I4ZmbMXiT9L4=;
        b=j4kqGIwrnHxIBuzhnPsr3BZTx5ZizkxYhrW2fmXu7iIly0WKf0KnaV7X9uzfHLfRzD
         NH+NfoNE2LBW7DvabjfD8HNH8IJACW2TWtcDnjq3wnF4cwOVziIj/ZzLBY/DeXTlBe/a
         f6xMEQrW8Buiaa+9Rq6l9mgB/E87IQDrHURY3HOF+yoj4Z5TenMetgaWxQFg/Of3rON+
         9hmKqPLTNJ+3nIU5R+iyf6fZGi9/aqLDG3fSnuM4+WOvwUXINx4fIZmCAu3vPcvdu/wT
         UCEAz410R3TReJjJLOXiylvaS5o8STIlUEqHH68K1+7ViYWPWRmwU+2t6Y+3pfM3J7Er
         WzTw==
X-Gm-Message-State: AOJu0YzS56lXmV2/fq7kq1TGF64OiitVTDu99C/YM0yp/ZJ0RdKb0d1I
	3yG8wa+gD+Rt7dZaiRT6kAqEXV78LIY6mGu1kSJvZyE8iRbbWpe04ARd
X-Google-Smtp-Source: AGHT+IHJKzX9whU+rwcdUWA/Ej750Xm/jl8vC9X+tBNGwOVGe6ZOocacWdJU8kMB6e2tNDLcpVCZOA==
X-Received: by 2002:a0c:e78d:0:b0:699:2274:b229 with SMTP id x13-20020a0ce78d000000b006992274b229mr2369847qvn.14.1713437091148;
        Thu, 18 Apr 2024 03:44:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.91.168])
        by smtp.gmail.com with ESMTPSA id y14-20020a0c8ece000000b00698fd83ac04sm522785qvb.135.2024.04.18.03.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 03:44:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net>
References:
 <20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net>
Subject: Re: [PATCH v2] sysctl: treewide: constify
 ctl_table_header::ctl_table_arg
Message-ID: <abb23824-1f47-f9f8-3427-4bd7f1e2515c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2024 10:44:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Thomas,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8735953278

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/33b9e702a248
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D845722


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
