Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587979;
	b=2kcGrIBvVutKddFOav+1pjuYWFAfkDJYmo+TFgjhd811ZJ7Q4JYnD96+A+qjxcgjsqpe
	 9h8SzntWtcJm0wd9M86z13WCXE1RF8KrZChvy+rk9YID+4YR4HcfCoref7UA2Ns46BoDl
	 cKlRV1F5cR3r44AboszIYaonCeCfKg5HnjQ94hIG63Y/hNYtXy0JdPr296KAAiY0xU0Z8
	 kok+99oTS7CJ3ZuB5wIc8Tv8PVjLfpi+VPdAwhVuy5wILVOauE8qwkvoOQHHq81k6fPXQ
	 PA9kcJz9crAKeIxXHqu3mVkhHzUg1DkL/EjVN6dGVs4U82Le0mkR6ElkC8l02EJHbTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=1EC19yqo54R17XQUal5j6WmddIvbfKH5q7Pld0xsfO8=;
	b=MoEw9NhmaFtuzxaT7W++w01f6IUVYBZNIDEu70usgW837L9Vf2LNvKDsDyFBv2kMMkaH
	 sWbmGcpgke5HADT45sDkBVKeYSphZ1lmfQvOCLvJs7cAlpZ75MgzYmN6a0QUhAx+KNFYH
	 ALOGfiwW6MNh2w+MYdNA68TyqYI0pXk5RDZa60eaNAhyT9sN9eyhN/73xaaWTsZBIMYCb
	 eiBAuOWW8ks2IDnHNfhEImXFNNgj4HopRn9H5CsXhXmCl+8aT735U5jk0XSTftMurHo8K
	 PBD01HYpfzzwZ4qBDClXiAUGiuD1GdZhh5jbMG5/HdC0PNwBWQdzOGpMPJ4+m7c2SZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="ml//g9oC";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A84606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 13:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A84606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ml//g9oC
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1846bc43c28so46401c88.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587978; x=1793192778; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1EC19yqo54R17XQUal5j6WmddIvbfKH5q7Pld0xsfO8=;
        b=ml//g9oC5K6f8NW4jCuQB3q0lezhAZTdNEMB9sP2z3FjAoqj+UU1kBniK6XsT/wS3N
         kSLs7EwOJ7uAlxTYjqKfxXh6LVgchA71nHFSUbGzn3LprbsZX2LmYVrlN8FGdAS5swdN
         6mds7dJzJufnXjndr9p9NmYQ/nvfaawXxz4yM2nAv2yYyxr/PGiR+L9q73ho9WVBJ750
         ndrt52H3In+kCLTdwmc08+VanaraQyBjEFNCoZkV9JRccnCEGSVlvDATal6iyUk//9Jh
         4Vl7Q1EPPlJUeES92jzNVZpkdQba0xkbuGSGSx9laO4W0kKqknafF9GIC5jsBTQL5vtm
         lwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587978; x=1793192778;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1EC19yqo54R17XQUal5j6WmddIvbfKH5q7Pld0xsfO8=;
        b=N+PIWtu0HmDOaWSwzjnkB6IMY9ozqzFF/K8IJ1zGy0lE+s+Z7LyVNYicY4IqcoZW22
         wwlK1Ga0RiK8viuY9YZzxshxdD+cfhviZxm3+ch8cNYa5fnClJpEX9RtQsdo/8E23fq3
         8aEaopdlUWE58SLCJP8mAhxk0pBWikcRPU1T77nphkIJw5YhcCgikhUpL3TwW4l4b6Xl
         AVBqo7V5GrR1TK77raxD0gTMYpVh/nzGXdk5WlPJs0meq60HwJh8hl9TwIHnlyUhr1Yx
         IB4tTviJwwMzAfa3b8/ZJmlVWeuDBZyRIs36xQqi6G4dl48Er/YGa6m6YdEdEG8rkwXN
         MSMA==
X-Gm-Message-State: AFq9FYIE27Av6zTKBZ46JSFGJ+SKFJuw7GDtGOX99Gbh8pGrzI331ET4
	wQ3T5+OIm5xavKXHLIuZQqCp5ZWa1xDGCz1SWlftxjQNMyRrMoL7P4OIlAs+
X-Gm-Gg: AYBFou2R4e1VrBeEpCGykKKRRpO4q+cBz2T7PgzdyvM69sVGDQaHCulzpXvfHowlv4j
	4zNkn4v8NBXLzkh6GNonQMHbmbf1EC6X7nkuC/oM5d6nmEuF+UOtea45zlgeluPoqpSkfC0vZgd
	WZj0LBpRQTkXqsqZ5x8gGn3TGzKBny1RRnKHjGj5srBpJKcFB/cCS3QU6Nv8W1rRbBbTuJMxRK1
	/Gbvt6t1ZEX9jgMWw29FP8KKH0+PT0r9mLkcY55SAcdjYrc3EAG5w9Q8/CIyGN2kwK5gWQZEtkk
	QPx0ZXETZtgKIjf9e58JXdKoVH2jRT6/2t140xhSmzzvqWONnfzCeq32OhdFZ93dPcxmroLRoYh
	pgvFwQm19WL4LQIZ4nP3zFABXjFbQ/94bwSBfMD+BGMKeF4OSe4xBVjY0pG4/wls1Gmz/LSqY6y
	DySgoTXf2Lqk1oOLS2oR1+KRNo3vi0x1U+nXJC02ZO8yb7tvwmHIyS50uQOdjMNDzpEhhxARz7W
	iIHGXD4kgetGmUBo1CqBZVDfhIX9Cu4Q/aKtcIXEn3m8GJnhGDVyxqeTKNWlolMWh9/oXN0B9Ch
	3HjZhf8bZ63VcA==
X-Received: by 2002:a05:701b:4586:10b0:14f:b5ac:ace4 with SMTP id a92af1059eb24-190a756b94emr2445305c88.44.1792587977258;
        Wed, 21 Oct 2026 06:06:17 -0700 (PDT)
Received: from github.com ([20.168.119.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm5764519c88.13.2026.10.21.06.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:06:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261019190558.465270-1-w453y.me@gmail.com>
References: <20261019190558.465270-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <6cc6e72b-703e-4830-8486-635c45e89b6c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:06:16 +0000
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

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39580202297

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8b3489f78ed5
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1189193


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
