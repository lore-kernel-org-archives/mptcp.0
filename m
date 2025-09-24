Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B68314A73
	for <mptcp@lists.linux.dev>; Wed, 24 Sep 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734117; cv=none; b=n4rzEycSokuKh8c9sMxoFMz7G/I+YwEB+XR+gI1/4dXRmj7HPnp9n8Bq3pmjZdIoIgzlZ+uC1dn0i4GcCF71h89CG1YsUPJmpHeq7Tf3U6oB55poOeFkqqBm4/K1jxls47pMrVw+F8ZXKjHPXbY8TUbOBZHxZXh3aZ+UzAvavcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734117; c=relaxed/simple;
	bh=BNUstnFaLNfDXSJXt9EdPRWQAaJUMk7r2uCRi+I8DiA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aJaDqrVd7+J5J0Xg5gwHJceTBONAcXQ3tZkZ1kFWx9aiALRGJO8r5w12S0V6Uy5/FYDqmdcMgwD0Wjwbi3+OyVGlxJqIyP0wjqSeDwkLud5cKcEZP6T2sjp7T3G1GpznysHu4dWmn+kKTg71NEqRfjk7XAGDDjLFfnDoSp+nh4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT6Fjo6e; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT6Fjo6e"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so704341cf.2
        for <mptcp@lists.linux.dev>; Wed, 24 Sep 2025 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758734112; x=1759338912; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cev3z5hoO0j+2RgphiXS1Z/RedyacRPuyeZtdAZyNNY=;
        b=AT6Fjo6eTPyS30CMp9SeUV0oF86dhmMutJ3eWVkeCu4V9mnCxN2jzbAyW6SgnDsrcz
         K9WlhZvvKoRA2N3CTb7nfdLvD4NfXK44tJ8e+OpIDPqx+auVGShutyqBPoBin5x9gge/
         ++EmEu8nwVa7HKf8T4/1ADmeo1zdQoUkBrDJiq9ept8np6B89fvOPYbIYtXzdCeHy9ZK
         DKuAFb85TddAz+boOPerT8nYdKOxQ0drsxIJAIwk35YBldvT+vbnXAbOXCLU2dfI7VUJ
         cmKmoXDtf2icvyv/PPZh1Pd8rPa6mUthjWrtkKmCYx1b5MG+QMKD95urltr+H5IPIDuk
         NJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758734112; x=1759338912;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cev3z5hoO0j+2RgphiXS1Z/RedyacRPuyeZtdAZyNNY=;
        b=MLKRb8AdZGLShAMJ93zlhHYTm5T2GPOEksSww08QOjgk6V5ZS38E2TNS4ChQjnY8J7
         L4zDwu2hqXvCIhafTmRtKBJFPbESzUZqmA1g3KYpB8VfrBrwczAnFTEJ1JPzpgMkV5ci
         tkW2i4n4D/xtGsBj/V9sbCrK79Hd82BPk8qktJ6E+WfZKoySZyPbDm8wQ6vttF6q2hF/
         jARGOvxmR0oF76e7tKsH8tRDhqti+efXYcNnCnSm2jSDDeLTYURxnWt85UUfsan7WftB
         N1qzUf+o1B26wbpoVK8Z+5D1k2Ao4RK6AB2HA5Yh3XRb+XrKN+jsr+wk9xGfhjrlEqi0
         LH9g==
X-Gm-Message-State: AOJu0YztXL6+LEauY3pb4++crXYpUvH5F+JVhaBfVFKh4yMWNgPYZNZO
	TOos6UtTHZbtlh7AlF7VEUpf1smK7ZrXmN6RlxcxV5NiBwIl+Fp9MYA=
X-Gm-Gg: ASbGncvgZlF2xIJWOZ3xaEkP5+n09gi2ONAQ0FNmwveVFhqq8knHfAakRaK3mlWzxHq
	qtPM0hU72xribNtez1MJp2d8PfAmM44MXTtPaZh7/G1O/TnPzKrymF5/oDy9Onx+i/aniTixM5L
	vk8nJwvGEqwnEs+4Kme8brpJfRESeJ9WmKcgVcNiMFx6twAJSZiHL30z90F5VfE0gl7v9tPwJmY
	fx3WIxKRPYw+Q3PNDTq0e4RdMoGzeNE1edLxDqY9CHIXmpllD7ov75vNHqQ2bi//4ISUar6ecU/
	hbfvuGWHNFgiNc0OwSYcCR4vmcKzHwfF3Ycdoq10QCnDfybfUUCjgyewoRnK0j2/Wb4Tk7CVGdo
	ni78dfRQBWrsTAU6XBmQWu1se9eddVChmEee/RkWpfX3/8A==
X-Google-Smtp-Source: AGHT+IFJc1VA7zFKPjPcNZP26eGeLK82zRd1YWKc/99NaZyCz2YScm4tUQOt9qX+wEqKUo+GizRfAw==
X-Received: by 2002:ac8:5fd3:0:b0:4b5:dada:9132 with SMTP id d75a77b69052e-4da4dcc5b55mr7754601cf.75.1758734112116;
        Wed, 24 Sep 2025 10:15:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.157.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793443cf48asm108777236d6.15.2025.09.24.10.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:15:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
Message-ID: <cae7e4a3-f8db-71e7-1d03-7df6e32dd95d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Sep 2025 17:15:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mehdi,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/179819=
69305

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/33c9160cb8cf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1005745


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
