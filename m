Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DC1DC18F
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164142; cv=none; b=K+VW40toKflc0j5Ahc9PvOUoe5EJj4EUmmPwuoCbU3a5bNCsUDXfZjUS1bWD6Q8+U/uJXxurysQNfYvGSvdiEoJ4RIUe7O4jvXCybc+nDjPylXew8gZR5hG0atwiS0sGgvke4CR2jesKPZp4Bm2G0TNEb6iG3TO/9zeo45biPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164142; c=relaxed/simple;
	bh=c66ZhGWBWcNZ/jKVy4+bVnmOy4PauLFpYcHGTz+Xpuk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Pa15+FhOblY9PFBhQEHUpVH2mwQuSkA46PWmOryTCckZZb7UjagrZk3eSwcvVk46H4qkcpFal92by22IAJOObG7J0j5YtYNjEBpQPEwvbdKE84bz+ManV3TKG2k0Rx5BvrjMcUJMS94KO18yCUmMgo1iNJPB1ys2ScK4rUwCGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFigkvAd; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFigkvAd"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460a4f36e76so2547201cf.3
        for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729164140; x=1729768940; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cm+n4zIoRn1dmU0QJZceHgN+wi121UOsP5Xg9FcE8U=;
        b=GFigkvAdYrL7MBMKS55/CKgkMcG9J3cbiJPofhgjA7GKUKuyPLBjlpCRq0MAUYeg+e
         XNsUFmNlh5Y8nZ3KPEGM6JqW9FACjQxoNTXnhepKnSrf7uUu7aV1FKFmeBdN2MsjaIQF
         hwqzAJm2QQq1nn+xEWEk+k5SSbik1WIEg1A65XeByKE2YLwrlyA06WUQR4XRw65T4vak
         dG52G7c4LfzRskW0osWvvt+eulrXETXloVI7I2Yhog268S77o8BOHKL6Z1lP5LHnuQC2
         6SqTGmTT5hchP6TVQvQQo5PEdgsww7Eqbuws2Izj/Vnr60QG8hhBKXnoreTksMBVei1Y
         YFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729164140; x=1729768940;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Cm+n4zIoRn1dmU0QJZceHgN+wi121UOsP5Xg9FcE8U=;
        b=FlNYv0Ls67k4Z1xSslyhXds18ImdE326stP/czmmHrjMxPKyvXc9QaY61/gjz1P+vn
         01ZahknlckLvKDLl89dwtosdFDP8P7OWMJKxxUs/uJttz2nOMSIcJhcz+vLNsK/tR5NX
         WLogk+EPc0debaohldHtw4826U5VJ6PlVpFeyLEKxabbssDnAJVjVUf3kEm91hTDtB/q
         3eY7WW6b8JnXGCGhJqh6fCIAd074fjhWoaH8UHySp7AbjF3s5cNK2OMQAJbzkmJGLVtD
         OrZcMNmLRPwIAfNzQhxMRHVqPQmxFd1JV5Owh38+XNklBdiHBvNMBx1u0gZqCukQuFFi
         2aEA==
X-Gm-Message-State: AOJu0Yz65QsBbgbPqDaHxZ5YYpIVJ/U3uP4WxDOnLFpy0FYvfuZa1oUt
	Gx9aFOz1FpUfCLxBqCKxMYpwcopEOxeLRd0uKqY+qzWKRRb1gj5oi3Oz
X-Google-Smtp-Source: AGHT+IGFmPYEK4soDDkVdOlzDu8BJRUqUHhVhxNTOWx6FO5fM5Gi4GekXLYsK+mSR1aGP1qBJboN2g==
X-Received: by 2002:a05:622a:5a90:b0:458:2bda:e543 with SMTP id d75a77b69052e-460583fc69bmr310632431cf.18.1729164140362;
        Thu, 17 Oct 2024 04:22:20 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.21.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e1564sm26528851cf.29.2024.10.17.04.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:22:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241017-mptcp-sched-avail-lock-v1-0-028ef592c6f4@kernel.org>
References: <20241017-mptcp-sched-avail-lock-v1-0-028ef592c6f4@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: remove unneeded lock when listing
 scheds
Message-ID: <66e6b91a-3922-9ae8-d41a-47f9674ce705@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Oct 2024 11:22:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11383138502

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8866d19ec4ef
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D900176


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
