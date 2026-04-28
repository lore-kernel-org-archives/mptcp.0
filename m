Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFFC3A9612
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405719; cv=none; b=ga6lLaUl6GPxr+3GnIgPTO3xVdbPYmUGX9FZVaLJ/aOnaeF79w3bXmQ+i6BdtI6yHX3UChgrsD5WEr3ysXqKBW9tDww5sXNTuo+vXm6cFdAlDOvWZZrQYiJnTKWNvY6P5oezeXiKgSF/7IBJ3YlraRRbUYu24EvmHX8EnVt6GSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405719; c=relaxed/simple;
	bh=aHrNEYgBKTCkXP2huczXmfU5+0RBkUZ+mpRQ/xkD/g8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=iY0EdSyx/y8tBC2rpNrXaBBV0V7rw75BtVqm9vEExthW+WraFvkrddXwiJGphl+jZu+leF4lxG7wgP38+ogVwN2W6fwJs65mA4b0YIKnSd/8M0uoBSz5x7NZrG5A2n4hNFmwPRx7KlM7X+kkZKpUqzdUoGHOoKzBVLa+L/4JYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMI1dR8h; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMI1dR8h"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2d832f2f44cso10084689eec.0
        for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777405717; x=1778010517; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUgrrA95e47wIXxnA75eqtEC66HEs/YKVLy+FvnMp4U=;
        b=LMI1dR8hGQg66xmL1N1XMGXjf6UtlmcbCSLRBMfBvRBpDCT0KUTq1sQjpnZO55AMZy
         zBLe20ejmvStY893W6Wo8Ahdo5wekqlFJZ1D8MkblKqSYGwg1o8GZYGZVW0j1s9f9yRO
         PrPoB4In9lfPrKi9Cp5ubQ6E3amyHMtFLxNnbo3OUAAAjO4rFihelhNCqMYko3HvUF6j
         AUiEvW0QAhHROEXRPV9CCF6PZZMLJ6UaLSKIT9kDT9PsK6pMvRvPJWDEZ4iC6ME/x0YP
         1y5c2HTn1pPA0qo3sSqP4B19hMrNE6C+Bda1vbZkC29cSVa06nAXtm7rrvaX3YhaNtnp
         H0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405717; x=1778010517;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUgrrA95e47wIXxnA75eqtEC66HEs/YKVLy+FvnMp4U=;
        b=HWqMOiw9JerThCwC1PAwgbIoErGbB/3Y2y0hNiMgQNzZSU7onc1lwnCVLpaZd+P0US
         N2ryMbcHBrknwbkawx5rgwwSW23mL49qGcuvDpy4ZGaoA67zxly+XfeVLXngw7blbTNZ
         zh94vY8VHaajpnxhWlQLsFLRbzmcXylCqq0TJkQj2zlfwbKZzIPVJGcDRPkYUpQrWf+k
         aITf6vD3/oUJyPb+Y69CWPqnHP8EyUPcQ2VShFNlIxff0aWo0XwevJsQyEeRkU0TJ8XN
         Niqu2lNLtTlqO3BdHUsPz3issZeMYRAHkBt/J3hSTGprb5ARA4IFDSL0pyv76dme7xAm
         iFtA==
X-Gm-Message-State: AOJu0YyEqMPoV2guf99IxCFa3GsfV/rWWDT/N2Hb0PIRYzGEbGk+azuS
	Ar91hwppiu+dGGm8AxpIuDp4rug1YSzcHTktUvceRWe9gT+JByvu9VQ=
X-Gm-Gg: AeBDiev+7TNAjuLRscRMsTajwrCJYpPiKBnAh8tPgltUiLjEQZCx7mvWDZKRpz/Rws6
	bYJQGEElUSP5wYsMqGWJ9MTD+6wP1LoR9Q9OewzODwigJMKYe01NAuhvDhiPZ/OpFak5OyLYXnY
	fu7oMc6L20X2eGN958gm2SKzDe+bb1JtGgc4NkkFptmY1i8N26WRRQCWVRrWiTHAGb1Wtyqztvj
	GxoEXVW5DRpsSNtj9BvzkIEEZjxrkKGO47/oeKgmq1qO9WTL5kEO7rhNE2aXIJ3sxl9D8RvW7Gk
	j40LIDbzPC5E0q+zF0T66HIxxe2ADaI0QahI7mZI/UU8EJyab8G9TZVbbanqLK495gmXJr+8RB9
	ltLsCLZ2quYhGxMeBpCqpTbu82BmQ2DPStihtrHxWLuQT2prxfTTDbzoxlYk6X69upr9DuUptqB
	d98ogXiiDi0oXgOUBVzD6TTT4+JkamWgiaH8p8AjfpOzbYMArVAg==
X-Received: by 2002:a05:7300:1908:b0:2e6:ff79:e344 with SMTP id 5a478bee46e88-2ed09fbb95bmr2162669eec.9.1777405717016;
        Tue, 28 Apr 2026 12:48:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.138])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a1064e2sm2840746eec.20.2026.04.28.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:48:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1777324037.git.devnexen@gmail.com>
References: <cover.1777324037.git.devnexen@gmail.com>
Subject: Re: [PATCH mptcp-next v4 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Message-ID: <0741ba0c-4968-6a9f-2a7a-09b00c153c04@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 19:48:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi David,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 2 failed test(s): =
packetdrill_fastopen packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25071789731

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7688d292b14a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1086438


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
