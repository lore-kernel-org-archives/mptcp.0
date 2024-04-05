Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8582E401
	for <mptcp@lists.linux.dev>; Fri,  5 Apr 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325511; cv=none; b=HbvbVJd+7MzKVtSZUhRdVgWcEKFTJXE9Lg/FCzIJhhQ8qji2FnznYXP8zQMiVXJGElMkftewCnFjZGQ6OKE0ehfwlTuvIPUnEkxmYp81ERE3Bk7Dux5AI9tWcLC6gxCnOTTZdcKnGxN2EIUGpKTgtCq7VqPUq41LS4VFojYH7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325511; c=relaxed/simple;
	bh=5G5cpUPYvuNFPJ32KhXO5wzm9H0tiKMr9UD9b5RIrsA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gt4j8DU/+g2cgFmVqh4FAjjTkAknNavNu5yLBZhNLGTTY7cx3FoQpi8sOpWMz5pDAwGFZqbLWtvFu7UGh3MSlfuccyhwqczceacT82v0K8B8OeHfq+T7ot+g98zgHSlQI4gss1+aIHrUeBIAH+Lxkw2rcLzjz+H2MBKsFAY1haM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN/svJ1t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN/svJ1t"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0b889901bso19329345ad.1
        for <mptcp@lists.linux.dev>; Fri, 05 Apr 2024 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712325509; x=1712930309; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjfNHzQLXraxR9eOFBAYyBBIHgIgfI9htO96QwQEchA=;
        b=WN/svJ1tkHKBdiHGujYK+bpJ50QOvPQfI7zaNOKvvo4OX8fMC1N7715cWo3z1KdCSO
         PGb6aAqYZDjoVfrIV+6FEa0p2HBXtV38BWcVbnRq61LkbWELjaML5igM2roDCNOsYGrY
         jXNnlze90HpwAr7vMZD5OMJb0cY0oDllIDUiv41Ru4tC2T6FRYh1tWkztrpbVyPWhIRR
         FyVUYOh+PY8lYC25jeZ3zzHFaJw7j57fqmDk66PNRJOO8+eJytYAb/xzjjb3+Gc7dNxo
         KUopXlJSM+sfCrfxJFZWcI2GKKNneIMponOuk6+q0b2YNTith0Q+2sjzGvON0xnCC3Af
         07JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712325509; x=1712930309;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qjfNHzQLXraxR9eOFBAYyBBIHgIgfI9htO96QwQEchA=;
        b=wwHidSOyK8BiAWrhCw2ASI8db1CR44ut1WWKWOwzwO7viVex4cECFFqQisqhWL1xzC
         Aez/DDK7kBtH0K/SsMYylUM6GznDBDgVLkZcGmYVDpp5HV4syhiYon5/2A6uFd2Yasug
         jZfdeXNBWY7RTfrZzud6olAoR5s+C/lh7YXjPjRFleLx0SqGFeiuYLWYRBZsUm42NyY4
         PUjGOABzAOwhjrUWUQ7x1gHYd7c7DoWLCufxKx2nlNiQKxtT8ocR4bC6IHQp0eImPjOm
         wHQ5AkunbBexnrAFSu1UEdvW5gjBFpDa01nesg3VBMwBhe1ZhW6Mvw4UppFyU0P2Kh9s
         feog==
X-Gm-Message-State: AOJu0YwHZbWBXWmw0pYP3hNW8Ihzt5Sp+zs3PUwHuJlvPhYd1t94dzEU
	ermaI5PolnknbeEspMmjmlFlWhpcvjhtEklbQaxV42n5QT3KCD4=
X-Google-Smtp-Source: AGHT+IGJFdDSvocuC7SnSQy5zU04uW21KXedwhXruS1GvvUSe8cpWahSHpFNlT7GbB6rvunmv+VY2Q==
X-Received: by 2002:a17:90a:6883:b0:2a2:2654:9e95 with SMTP id a3-20020a17090a688300b002a226549e95mr1513967pjd.36.1712325509298;
        Fri, 05 Apr 2024 06:58:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.68.208])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090a740b00b0029fbfb620cdsm1517930pjg.28.2024.04.05.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 06:58:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <>
References: <>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default
Message-ID: <20f480b0-456b-dee1-1435-1410ebe71517@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Apr 2024 13:58:27 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8570540406

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a9717d138165
Patchwork:=20


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
