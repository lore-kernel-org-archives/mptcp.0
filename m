Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E8209F49
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500362; cv=none; b=LimqMwPNxbgl1vyOn655xs9CvZBfUa/e+Y7uQuozUxgTICCeZUdyMtp7kAYGr88Hru9nmY99/LmBLCN7mHTWvAcvCvHdoAHc6y46z9J5VhY13AsCKV5whN0zZbpBKKxrrbrku6uI7uTwmG1PHVMA38H0r7NiFxTuX+bIgVpafQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500362; c=relaxed/simple;
	bh=e639+owzXgcWptP9Aycbb2Dv+080obC8Ez7GYw2oQeE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oLdXnxb8w2Ik55QRcRaZz7ewfdUHZ1+W/0gxMcTQdaNXJrOW3jaLGlztnkiI2jumAy5RGdKDSD6GXeH88lsdQp8/T3CHsniutj27vv7a/jHTrtCONUXeFhqmrVHmesslLR8C6WQUagsvIy9PUgGFiwMV06dEvcZyyEgbnAcSoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im65ID5q; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im65ID5q"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so3231122a91.0
        for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 01:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736500360; x=1737105160; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp20UxeF4QdShTyvCmk3U6iph+oympYu7edRFdmUfoY=;
        b=Im65ID5qBYKLdVLVDicmsBDatrKCGHzYKR9ptVpIrNdvRuxxQrYXmhY7cfLgNPN/Ak
         JlU5yUnsEU6NTAcDS4zWw6dFSt84Q0fFhbXUbfnJtqT/lEyGj8zubxF6HJ5wIjKcUL8O
         xZzGb187v5oJEAdJEm5195SqThZaNK1bHDf4aaYnaoKQIbbsiwjCCou6wCjvsMHXOgTE
         g5un/pQCrT0M8cfKzcrTu81nvWorBdc0dx2qKjbQGECdSkzLS+AK6ozM50SX8ZhL0d8w
         9y+N3/Ky3TADA0fWI9GMzV7M7tYaIerWidx+l8FE1+Ka3C91xnNLkp0h13Qn63fM+aUX
         jkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500360; x=1737105160;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qp20UxeF4QdShTyvCmk3U6iph+oympYu7edRFdmUfoY=;
        b=dKXAvksufvUWrY6JGBtzXLZa/VVMTBF+Vr4gI15oWw0cX5gxVfP2BRyYWjQ/HxaFSK
         z3hRdk/h3650YcwCyNg1iJvBCERRGtfOxmN9WJZDlfCQ8ZHZW1jXIt/xqUU15sMT9RO5
         0r8/fac0wyGvAYV67fp62a6ELlbe8OYFYSaa5R0cjIgBBb1B+PnTsLhkr7npWdOiVGuJ
         Fp913p9HpqgYUYn4gr6AYibTnNxnPcR6qZDZ1oWXjARKpbNUqlqeJi3A8Nbl6xaI/Kj0
         CL3yYPvnid4YCcP4Sz8p+Vb55DpYkLAItOhQVNUXh4qdFpLu5AUtIBZ3MspVTMbV7GOC
         ZwLA==
X-Gm-Message-State: AOJu0YxeT+o/PCW4UAK96+LxwxUlGaTLSb5M56PPrU8Sk/mYNiJRYbOa
	ZpOVUXuZ46Yz7SH0O6nMkbLAw/VsG+ZuHB5hsi0vW9vr6LBQG63XBNcw
X-Gm-Gg: ASbGncvBUxmX2HW+cwXhmV8iekxg9E6QOcJmDymjh+uv9ONHxoqGvCeWIgCs8gLB5pe
	jPGuVvJh0tgx1mZO7HzCWbyTHZkUvv87wghPofpw8Mf+1Ltaj60TSeTRsiqaoSnpE8M2BuJHYUd
	ZynCANvXoW3oTAeTQxTqqKi2GU4/3iMwglmbuafojOJxkPIMHp0UmK8RHdxxEzlPIa+TzVAVhP7
	1FMoxqVaFJAp9aUonkwEDhGcCjAsbYhwVYJHxe/8t/DZRHsiHhU6jPW4JKHVoQPSWDUDA==
X-Google-Smtp-Source: AGHT+IE3E9Tbe3vnOaIOx3gzgXu9L+CHtOzc7C3RR5D0KptOT7pZjvOp5C031NhA7Ie7tYvlINzrcg==
X-Received: by 2002:a17:90b:53c7:b0:2ee:9e06:7db0 with SMTP id 98e67ed59e1d1-2f548f3400fmr15009062a91.11.1736500359953;
        Fri, 10 Jan 2025 01:12:39 -0800 (PST)
Received: from [127.0.0.1] ([52.234.33.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593fecd1sm2830161a91.15.2025.01.10.01.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:12:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736494320.git.tanggeliang@kylinos.cn>
References: <cover.1736494320.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/7] BPF path manager, part 2
Message-ID: <c4b1fdc4-d75f-e0ac-99dd-4d196870f0c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 09:12:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/12705356024

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/10b9fefc341f
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D924040


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
