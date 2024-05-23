Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9125FBB3
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454699; cv=none; b=G/lwyqlYorP+k1Ptkc8zXh1zWQRcjgcwcMiLvR9zhmtSXRO8T1NjWrGyigdZQ+hmIHRk9JetppjvUPXeXISSLMr3IUzXZicfn3UfpBzLiHaCYKT9cLZO7BDAiHyma1XbHd4SEdLQCxBFlY87Qf8kDFp1BbF6ym/klRzQYk0ij7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454699; c=relaxed/simple;
	bh=LU9db6ve3IRnVOAaeoErVh11bwSo0jsg+4sn9U0DzUo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=abLD4UMRcrPl6c6LEkqqOuI2u16JdRp0ZhoIQrNo3b5ldT9AzugccKTv5Z8o0W0zNWhmMfdbHu8aGHmgoGs242NL4ujrEpEOBSjj8tP9LJmiInlXGF/mtP4Pbfi4dRCx54IjmyZObtya7yVOYqGY+aoumaMl309uFT2oy0AMoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXfkS3nb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXfkS3nb"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f693306b7cso2610776b3a.1
        for <mptcp@lists.linux.dev>; Thu, 23 May 2024 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716454697; x=1717059497; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdPjoGhTZClrBTIc4l/RJYdeYiI9b7iGA83OdH9gP1A=;
        b=nXfkS3nbxOYMW7PCQVDSzo0SMbA7CilsfVs6kGSRkfe5+qHcqLH68HMYkipWteYBGX
         jt8+S/b9SQGhZAlHNjlTQ63YvQgf01rDyadmcqzl8gKz5OEj1fvJyypf8K1KZX5wXaRc
         doHZY4Qjd0OtoRq9Iq7wsD/Aw4wOztEHhKfFBskQSBdMnQJlBKPpVQNydOgTmmw6+d1t
         3Z52cJrY6xpwCtaHAO201UQgliU3aToy5z73UILGAbGIMxJRYTFaRheivUWdGPvytcct
         vDN5fTpfxAaJ5xWUxxyXvmwrGwOA7KftLbXUIcCn0pvBXY0m2GDhGIkZwC9cvTLOgFnD
         RbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716454697; x=1717059497;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EdPjoGhTZClrBTIc4l/RJYdeYiI9b7iGA83OdH9gP1A=;
        b=F5JbHp6KqTl2+yyGyd25ZEssEkJgWBccQkBYOT10W+lPiIOkBQTNcz8aP2jkmWGlkm
         U1oc6HXT41LaGeoChwAqa6rQ3XIA5hl9fVkunN2pu6TbYOz4SbiFEaBz6N4rUx9l1jT0
         DAuENXa7CwDjYbQidDOQdD2DHtAhYk2WUCk1kjxdHVahoXJLOl3AjgjCugDT0AueT1Kn
         jmrv2T57lBsD/K0v3yyyHuz2HLl/5+IHvU7Ek/R5hD3F4vx6jLPWS5P+JxhQRxLklUh/
         U+pKQiXhGsvvwwcJAxbhvPq0rIG1E8Sc6SEsqJbxz6jrwmvM4Cqb94/bsE5eeF1MaJh4
         u9pA==
X-Gm-Message-State: AOJu0YyI9enVU9PLKKphls1sXHFcNqvyWUq61/L1mw2AfBvPKvLIw4ns
	5za0ix997T9S2e5KPwww+64ohoEOqvZlOXPmjkCDf8ns6Vd2YpF4p4xJ
X-Google-Smtp-Source: AGHT+IFyeCe+L4CFP3YyzfISU8QLCHmQDP9zVckeFvtaud7zToxY8tEdf44GdwLtseBJeHMgNHcEnQ==
X-Received: by 2002:a05:6300:808c:b0:1b0:34ed:c931 with SMTP id adf61e73a8af0-1b1f88a6f48mr4471304637.37.1716454697520;
        Thu, 23 May 2024 01:58:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.28.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f34349aa86sm6447695ad.226.2024.05.23.01.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:58:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1716451525.git.tanggeliang@kylinos.cn>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/4] use helpers in lib.sh and
 net_helpers.sh
Message-ID: <18247242-56b5-a309-9749-1d19d44f5b58@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 May 2024 08:58:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9204660898

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4dfead4c10f4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D855244


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
