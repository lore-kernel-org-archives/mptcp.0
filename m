Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405550;
	b=T8aL6buNrZt5TYrWk6rsvzZFqtV6Ke1ELfY2/Z+CL2VTbLCGMv0lU77y/Og309wfMvi7
	 IugMhAxxL+Qefv4RtlPdI8lZ5GoDESE0TkpkDKgIfgY61Zzw165656B4U130u/H0Uc+aM
	 MdJvcMS+m97OFHL4vCDAM8c+OUvuIkZM/JKjwewntGsf5X5ihlFx6bK3n5HxWsqeKiorv
	 AQiCMeeE7+E7k7GNysBa7HsSQnbBP8SWU8V/8XxVR45oyxwX9rTjBvbKTaB/tHWbbWN0v
	 fKSyYXdDGs6zYkymcPK8w7cWb1HtUBHyupQTDfEjB+HsYd4W5OjwM1wspckBMjGkg0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=3klrgDoBr07PG5w7bGp75eJUfzAwnjRr4s6jE5tG2mw=;
	b=RM4oNHPreoWlDilZ7iD2/mXcBRi3QXw7MlLL8fBtt4HgnwJEUkRSra/WayP3UOFwtrpH
	 9spz58PcFpEHQPRfluQKiEJkyg0pjkfdr6GykHHdvjMBggHRnNUrgRssyWIQ8BwGnL70P
	 GrXU3z4SroZJiTlUaSNhnFFyx/bQl/fduj8FR1E0FZu7ag69qaNP/+CwHTCpKafH46Hy4
	 0DoIwdj0M0g2HhzbLKcwUCUViBh+CgmQgWjZC1Ymfvl0nAxyqajeSX4Cx1xlAbjMq4OAz
	 OxSEW9VVhWiGg1K7sVV271G1dMwugFV2gsQyK2QZ2MSEGK//l4IXIDE68pAU7d43M0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DnXwNCXU;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F10606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 00:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F10606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DnXwNCXU
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df7f544919so863330eaf.1
        for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 17:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793405549; x=1794010349; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3klrgDoBr07PG5w7bGp75eJUfzAwnjRr4s6jE5tG2mw=;
        b=DnXwNCXU/FbVszW3+QztvX0NhEDtT/qM+oMfduf45ikeDyK3OYEFhR49yPKD8Huuhx
         SA2L8wCKBHP+EakH0l0qzUztUHIjPlwc86lz74WnND2eKUPbNM4Gat6o5hgpRJB0I7uz
         lE1h3cP8jDSyq+VC4HeeZ2Y6OUbyJhMWlgwWJBFPwPerfYno843PRaP2+Je720CueLOO
         C+OK7uOa6wWavCh6VU/p052AyUYRQZvYCp+pedAMU+YnSFq+R6HHa0gexJC4BQUu5PvR
         IGJwBLjLICcGhrdjsnYEPmjaN5byysE45/bv10hyy22MMYXbyTsNJkZt2reMukyFfIrj
         vNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793405549; x=1794010349;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3klrgDoBr07PG5w7bGp75eJUfzAwnjRr4s6jE5tG2mw=;
        b=gx4pZvWB+z/5+lIUOtgFGmiZ3fG4p1dzdRtaC/0zdk3Ai0cpynNLb7icnu3q1rJHkO
         izDoykhnEmDuSj/nzhS4iNK16vtc0mRKGktyADew9xJkd14CLcNmkE3PuaUpf1TQO3rM
         ZXFG2UYbmP1KNo7C6tJsdAxWUwI/mKEr+Jbnwq8icZkmCxjgEUmOgHw/RvSvLzxWVzSZ
         wEVDyb2xwOfwL4D/X0azXBfKRAs7KC7enM+z/Urgqp3GHX3Iyh0SdnOUEFYSJ8XeGdB2
         2aRd3VqGHRaZHT7yS9L7geZwDvw6Pdj2uIJrvUQZzjWa/9ktxypvpIMvaiwP1xLozLk3
         tlQw==
X-Gm-Message-State: AFq9FYJ8+d81mpNsDz4XMoJOkOH8OIcTiuQ+rpSVADPq7bmbaaJ5t9F5
	et8m8+EZZsqi6t4IIBO5wwbF9uNzGB7nz/rqPpnJOyr5dpn01x5lEpM=
X-Gm-Gg: AYBFou1DHK5PeYizBjuJSo7221TrPikAsDa6FjIlGnR9lWNbRhB6SKlxeN527L6kkRd
	cEo1erbYmmWN+pCraKz4JL99GWURZiFJ7npdYaYVD7HuFGEdY7aVFMUFumkc/rpzzi73SshbLY8
	P5Ny7eOzEBGjlwPskZSRd2OyHWRo7TuIsD5vZj19MlSf+EkD0s7vxZIejC/bp1qbvwvryUOgMt2
	bJTEWhyY2FQPKnQf8w+Vgd2Ewr0sN/XbaULLOQEviLPbGszMBuWqUgObSbpMS5WFq0MAan1DTCy
	/72QKRO9C/HEgrfGqkKTovmi2NyFNeG7/6cju1UtiUSqEfHvbCAe5Ht/mufDvudcraQlDoLTJtJ
	4kC7A8pCnQx0sDx9UE4IqBbzd7SjExEYlRe9rQTtmClf7Jh9XOxKjJL/AgU8C910GEY6M2G8Xmi
	DFHlDwTpusBFhERuQ6zujuywksfWJAUoP8yuzmJDIISBVyt/8czhV87ro6zkAMFzeo4axcmL8mK
	FQ26TiRYIQhC32OvqOyDMYT+y+YrdiHRVUenL76gVSX6DfnI+Bq7pALu57ZvWtlFW3MsZB6JjaD
	QmI0PLqkWEMwjG3hAej51MGKrbxjeGWqWTewY3AsXA==
X-Received: by 2002:a05:6820:1c93:b0:713:286a:3d36 with SMTP id 006d021491bc7-714f29c8b72mr2622081eaf.62.1793405549317;
        Fri, 30 Oct 2026 17:12:29 -0700 (PDT)
Received: from github.com ([4.151.214.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354efebesm3213850a34.19.2026.10.30.17.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 17:12:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261030-mptcp-tfo-mpj-v4-1-e6eff2027342@kernel.org>
References: <20261030-mptcp-tfo-mpj-v4-1-e6eff2027342@kernel.org>
Subject: Re: [PATCH net v4] mptcp: do not use Fast Open on MP_JOIN subflows
Message-ID: <d3078226-19b2-e1ba-a0f4-2391dea497dd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:12:27 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Yilin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed =
test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug =
(only bpftest_all): Unstable: 3 failed test(s): bpftest_test_progs-cpuv4_mp=
tcp bpftest_test_progs-no_alu32_mptcp bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- Perf: Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/41138587801

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a00b9355ed10
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1197522


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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
