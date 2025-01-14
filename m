Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01828EC77
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850640; cv=none; b=Hq86ej6T4a2MiMlijCEghQV4spX7jSdxME2xc5ONeC2xZWc2jq78O8EyyYysdgtZwAjl66x4NlPhBVWY/rsjcGDwC+z6csBvpS63RIHP1zW7vfxu8BiRiECLok2/Sz2e35jejC59dL+juKv0PbiOM31MlgwcDgRNSJ7jshWsmkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850640; c=relaxed/simple;
	bh=CHUfcYP42FrN9glkZ8zyYifdUroAKcwIqgaLnwJysRM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WeXqKGiKWI5KRZaLqyybRe0BfXYq7+GnWKboi373xC3wSFiobu9p5bspGYTgRHXMegZ3DENoICSb7Sr+OHkGvCY8xpZG30rlDAhLUArIBOgv+CNCLq2SHxlmR0WBrpiP8kho2pgKRb7WUtI2i3smxJQvTjg0U+JA9dH15gAhUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgzcR/tL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgzcR/tL"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6f1be1daeso474315585a.0
        for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 02:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736850638; x=1737455438; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOwI0L0vUMt+dBi2Ge0MMFjwgFkg/Pnyw8nO6dNR6i8=;
        b=lgzcR/tL3VKqYIEi9Ia7VmCtKD4BaYzIx2FefhLgpcHa28GkmARDJz0fPMmdaV7LX1
         s251d/fDRvSTlkoAbUm21z/XzhyOgQzbaH3opllauArRkz2268idhirTBaIsgxXlpUCS
         Ac8yWuaeDSumSAKbABQxzfDadXSO8sK+FAMkF5+DCeRyG3JvH+fTU6Ss/UQflf06FMUA
         j+MbHJOi2tUdo6FlFHNk7Wd7x7M+3yCS83N2EHzNh+Tmt7AJxB1XB/2Opsv4B8RJPKEa
         xsWfEFj6ZQ4P4QeOaiQpbotIXUZHIWV7nhVRwHcKhlLntbNlsqjrCL9dfuJ6sp+1VfTY
         FjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736850638; x=1737455438;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOwI0L0vUMt+dBi2Ge0MMFjwgFkg/Pnyw8nO6dNR6i8=;
        b=U9riPtAYfRtmPMS6iaUzWyqmSpl4tb60zri6pBnKz9c7j6iDKsQbBOBDwbgUmvA+R0
         SgjXBkzdm3LuETVWYvNvet/q1og4okaZm2NPnQn1qVGInFvP1DWk1tiD9PSoRM8G1jwh
         KYOesJbKK8+BX/x2z3GTMUCccp39uaKHyfGvwYtCI7MSgrxlVPwUfcPwVWRAGdcSpR7B
         bmbOVueMayzcnpNBwRgeA2p4aZAj+rIKVvMdCkPZeSXAZe3m/6B7IyMyAol2YEXVIEB+
         QG2h4sbcTYsj24EiXz3qiXLAC4ViUrebawQV12zZ4ZUFTgCk0SMLEWYtKuSf4xHK0Lek
         I4fg==
X-Gm-Message-State: AOJu0Yw7Q7hUqvrVmdDpMZk6lTt3tkzr/YxtcY+USmLHKczq1faADWex
	sIN6RCsA5T24DXAlUeT5uqZ1O/bkJMYLAphN5FovhTKZDq7/RXDzbJboXcw=
X-Gm-Gg: ASbGncuk6IVD6BKQgEctgcYmIJvmEmGgKvnTMyM53k0ByfDOs2wzeUtUIzjouKVd06R
	fekEAAyJ747JNlsn34WIJI7lobpHGjzV8/baS9J9sFAB2vSsL547oSlSp3rGf9R1NPTaZsUhWHy
	Wgw/nr28GZ6Pz9vrp5RREInkdtvjUqIdrqoPaXhbfa2UC+wadSCo38LU7ex4pmGxOiNrkK4zco9
	AgRXgYmqUx3Kwcl1O42UxwmCDb+k7p0RLqPkI1KLAoIX6BoYgIPTK0LmO7z0qT53KU=
X-Google-Smtp-Source: AGHT+IESdiHK5NHxzljBebPsZGX+95JqnueDOuN+VkAPya7aszxmuA5P0XRxAkBlvmk7hqmruZfR8Q==
X-Received: by 2002:a05:620a:244b:b0:7b7:342:a0a5 with SMTP id af79cd13be357-7bcd97a4baamr4168899085a.55.1736850636599;
        Tue, 14 Jan 2025 02:30:36 -0800 (PST)
Received: from [127.0.0.1] ([20.42.51.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce35031acsm590167185a.88.2025.01.14.02.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:30:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736845893.git.tanggeliang@kylinos.cn>
References: <cover.1736845893.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/6] BPF path manager, part 3
Message-ID: <774dbbc4-6c47-aaee-f38b-76061952899e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jan 2025 10:30:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/12764834472

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/26e5e4f892c7
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D925192


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
