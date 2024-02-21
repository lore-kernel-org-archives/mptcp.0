Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764B8173C
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532525; cv=none; b=On4i/nj8Ns+NjfGO5eJle/rmxP0tshCmUQuz8dtXZCRds+uwuNuwi3HgTqDEUuX+ME4Ch3VT4K9CjtEMQzeR2Tm6T0V/nNomKOaYIS2wIZVdTOSBiyyJboLLAl72+OpqkX7GDZUTwZYetxmrs0HMGUKBcVzV0CQPzKBQ5wMYYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532525; c=relaxed/simple;
	bh=4UrICG0PmIUE7416BkiCQO/2nv2YU5K/Bl26+k5hTcA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HdyJfxl+tqnOcBXao8uKii2hTDQQS98A7G0DHNtxb8iA+Uxp8bfaT5ZpfkgZW39wbPCd/7NotIsTfPaKxp/aYLnmjiIdl3GnyT7yIEbaUFZwTqdNGc+3bR7/a9eAryCq2m2Cl3HMfMIz0uBNRkob6skLGQKY8fxIyf4kfn+d0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAxWkBCf; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAxWkBCf"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607d8506099so67517747b3.0
        for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 08:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708532523; x=1709137323; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ft/Hp6ZIs1zsLn7D30ODjAZDAqcCT1umwgxsQ+9+tc=;
        b=MAxWkBCfgQnUoKcSeL9pYaujZ3BGydRjUdjBXypGaIaI46aYQW40+OPBqVduO+RLgN
         HJ8QwvMqIvAD8gcEb94Ahn5LXo1BxxD3MkLXPt7rTBoSfbuWnZn+y6nXPjFTVkTfk5PJ
         X2+Af0LfbOfkYF28EgcYtnHJSvzX88RSacfM64Tgun+i1wUPJO9iW2XMZV3ggt4vNxXr
         62oIQ9Qs5wqoyRbzo0e0pe2eOTJbvfRwW4XFbmO9vawl3Qr5RibS/ch9GisvLrPevusN
         gsNGQ8PL3Aio04j3zEtluMjsyG5K/AImqO0uwiFoijJYjyA8MyYRfb33kgIiAqWtOrqF
         eJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708532523; x=1709137323;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Ft/Hp6ZIs1zsLn7D30ODjAZDAqcCT1umwgxsQ+9+tc=;
        b=TWalhGB9G8U1tb/xiIju5ST1wJvB6jQlrXjSEGj7NZbcQJhXNuyQldIbdWRyqUtdsC
         7IiPZLV3+vUj1tMknc2BIrCw/z5d/ECe/6E04WUjMl9IHu+uP4rFufQfYFssmVggM/1a
         c7NtP1T+5EVQu32Ay3g9kHUZop3xOt9Umj596cWabtFPu+P+hkvPgMulIOJsO4U4Pxby
         hszXProay2auvjusX/fIfhrLLNAp8bM3OQ9eEWr4+bDAdP23GY6VT5naNzZMiKzumN3Z
         dyiWM6WQfNI0su4QY8eTANSuxkQQSYkwPu/b8KUPX33Q9fDp4s1naXK8smDQGi1tIhlw
         7QvA==
X-Gm-Message-State: AOJu0YzK4W8ByuYMJ36ts1PbDeKPw63K9gQOLTkm0Pq7RS+QCAvNPk+8
	0asfipw/z5O/Tpd89EGxNyWwKRB3ZCkCrmR51C1Kq2MX3IC1V10=
X-Google-Smtp-Source: AGHT+IFRoU9/jaEJAqPHdHB+vEPBe2C5bR37CtXuiNw3IRG+0T3JlMMLp7Ge4LpRyzQRSCkMkdOmWw==
X-Received: by 2002:a25:ec0f:0:b0:dc2:2f4f:757 with SMTP id j15-20020a25ec0f000000b00dc22f4f0757mr15312576ybh.7.1708532521656;
        Wed, 21 Feb 2024 08:22:01 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.100])
        by smtp.gmail.com with ESMTPSA id q8-20020ae9e408000000b007872541c53bsm4448411qkc.24.2024.02.21.08.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 08:22:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6bf1e9da6cb4ec0c6de1acd37995137b74dcc8bf.1708529444.git.pabeni@redhat.com>
References:
 <6bf1e9da6cb4ec0c6de1acd37995137b74dcc8bf.1708529444.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: explicitly trigger the listener diag
 code-path: Tests Results
Message-ID: <07b083b4-c8ac-412f-b8dc-a4991960f77d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Feb 2024 16:22:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/act=
ions/runs/7991747720

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8b0da36b3364


If there are some issues, you can reproduce them using the same environment=
 as
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
