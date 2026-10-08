Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F942124D
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466950; cv=none; b=MvxCkyw37QNg3Z8mnnoeh0lK8Y7DvgEwekPMJrMctoP3P9P04cCY2Mz3xbrnRnfBxclfB6/uB7sq/YShof1B5F1/MRYOdsFdgURF6AgdG+NmrGflQtWPzPJUFKtbFEOVfy5oWZVZIpzLzUsNnkyl8QmyVUK1+/MY38HFMq7FzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466950; c=relaxed/simple;
	bh=4lSU8QOeaDsa1dRNOD4McehBAXPjDfnla8d+H5PTPgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ZUvPI6VAp82mimNeYOE53lakwAFHEF+d0uaK2v0AWwaUzegSIDdRcQtPPaGOhS/wm2/IJG+KmxIfyqHqT1jt1+4jfVfmrVjWaA8Qy4kOIVa/hnl7j1TyKZWyRtWSnkYdcieGYLtcOpYo2ZuftkE8nvZxW68BOp78952xeFkVmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sI2FpCzk; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sI2FpCzk"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ccc7a6070b4so1559386a12.0
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791466949; x=1792071749; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BAyiOthA1hn38bI8irDXmjsMUuC+lcS/HzerhZe1xwo=;
        b=sI2FpCzkMSoLrsYVZ96X/swNG8gqSyWEHOymyJvG9341xoZG8VlcWHaw3L19WefuRr
         FdA4LgBM1YCk8OkXuf5+Wupmz+dvuIbJEv1xbgPIaQ9eWubD/lZDc9+KDzVpMC+zQg3x
         LjOAi/FrQRxkLsLYn9EFVmJsGFENPlm5rvmBY07dj7XnqkLTvQuKsHleVmeg8JyYgFEq
         v2oT2O2Hhf4DYnVtxvKUEJWUYDvxAY4ht1y4Jxxi4VRvqxsMDmoz/rX5XTj6HkXXTUcy
         N9rBD5BHuHoBXS3MwhjGdLNDOmTA4dS4S3p/4+xcEmhjj1dBMEX1ax5RKS/lrZNewU1M
         NzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466949; x=1792071749;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAyiOthA1hn38bI8irDXmjsMUuC+lcS/HzerhZe1xwo=;
        b=rzVB1CIRczdNAmCdM1b0PiO6Pq/EMB+5tDdqWN4RlIqVOsDuJMAQoB3repeXK9JMYp
         TWXt8SY8LdrNWeQFFhcxfwLlXeqQDAErSC5iR1QioC35a5zHIoA96EVEX92xnruo2PNC
         IA05M62DEigJ+7vWLnaSEJ0lOaOyIKYzHXPDjpT2gmVt3WtQ7oMpLq9jsYq73y0HP4NB
         qhqNz0MnBKvaf85cMHkyerWCmaejibGDyd5z0br63cEo+07xZSnVkbiHgOcydWgeppmW
         C/iABVE5bC3xSHONLe7x+RTtjcZrKwo4GEyLwUgnZNTbW4J+ZNin3cd8h3z6yxku7GRf
         RvMA==
X-Gm-Message-State: AFq9FYKUNHeA/Y/TiVnddJtmseA4wxF08L+LB8L/7K6nxW0p/bi3V6iU
	GqdEZHFj2SzHjsNK8sOREdI5P500T8wSh2ZmBbECF4GxrX/xlygdqi8=
X-Gm-Gg: AYBFou3T8C7FsMXpiEwzdVqXZ0LWoC/9RFcWkll0LshDu/t1x1RoqoIIt9BcXNtdWqw
	OD9CkyFv454ese69PlMNezfK4t6UZvnnKHKBD6R3PA5e9rlkvwEZmrBNJPdm8qekuW/MHN+MLgk
	ielbOOuJ99e2ljdCx27AByIEmFYsuetDxcMZG20Aei6umGk4mBn0gfq4aEjc+zA/oJ9/XsNz78X
	boXrd3dvHYLvBkxU3xjVyVDZznkut6KWUZaKToohPPgx56zX6A4XGJ2eSr3Rwl0/HEWwjO8gb/G
	wMPtsQX3L8y7aWhUi1GRR+hDhe1eTyIMH3ULeXjVTjVnMC23avml24jQGNcO7NbEzCdgXxvwJT2
	XDQVdUB8giJSxy0udIH7lD1ed8W4ObkwInZ+ZzEBUrZ6iboolIQ5wlyEfoj9w7Y8NKNTDq2nsmT
	Z/XoY3m+lMxPwWVPK/e44XBhySEtlc5BcqfXcgdJHRCuOGb3cWzDYrcyhgo+Iz9y+d9cNzP90rM
	Ex2W7/PPttL
X-Received: by 2002:a17:90a:1057:b0:3a8:bb56:f450 with SMTP id 98e67ed59e1d1-3a8bb570f55mr2316908a91.41.1791466948806;
        Thu, 08 Oct 2026 06:42:28 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.178.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff7ab034sm4326205a91.4.2026.10.08.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:42:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261008121602.206507-1-rameshkumar.t@phytecembedded.in>
References: <20261008121602.206507-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
Message-ID: <e2f81350-b9b9-d790-fb3d-33a199ad9e58@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 13:42:27 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/37777427552

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e76f38387d=
94
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1181596


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
