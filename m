Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E6486B87
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046839; cv=none; b=A1lPkKvghTEBOiZNRo1QbjPmNItTc4PWYw6HIdudEW2ZWvUPjQDZwlGDd+fT7jq4LcZJ6nIpuOP+sx23e44pEaBnrxeZebiFQNZfnh0A2/o/Z5fgIgb9Aqmi1LwEfIjNsFx8j96cvSTaScjjqR5vTOmX6ec5RVkiQtXgmizabxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046839; c=relaxed/simple;
	bh=khBWLSPsDimxY9n7jWhxU2wNlu2p6S/B1RbP/7/4B10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=LVfPXX6ORUROf2W+NE4XIb6pQCtpaH/1x1g5yMCzJgKLQNJYY2gKGKcraku5KRZITR78CqGnph4yWQvhNtZ5ZVc1nkFjBmnq4pQeafRcs0V9NVkzFMljp2W9S7E+wEzFP61sU5xbeZZhhniN6qdPy0VZP60Gp0Ld5X4UB32m7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0yAukc0; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0yAukc0"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb7so277936685a.0
        for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789046837; x=1789651637; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GKYlchMxbunEGHYisAxYZpjUNYEvajSgnK513aaatw8=;
        b=s0yAukc0FujULEyk8xC5rvYOSPwJUNBDh4ZbP0BWo9wlmdo+0ZoTrSDGi0vC/x+JFN
         kF0XhP86ubz2RRc2mwHdH/M11os8+ckU93YR+H6JdjVxeABq+6CBHHP97m47zsC7w+sX
         tq58h/KDMpr9VUQv4aOFFJf3wnF3qHEFrm1eGckSP5n/4C4e2ZqizbpCw34utmgo+qyp
         Gy+a/Sd9E15TKtvJvSHIlA5Gmn2ABVYsoK8HhS/apZKySQi9QJO1zBeVByOB5OKN6XDg
         qBg7e+2gjv0qB7/TwJ6h+wu5Jme8WEfkXb0FE06X1SsK3MepM/1w7NGASD2y3K5aLbuA
         tYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789046837; x=1789651637;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKYlchMxbunEGHYisAxYZpjUNYEvajSgnK513aaatw8=;
        b=Uh9t74Fk6sXqxiguiURNblgF8G8aT2zWXHqlGnqJb3cORYFLGeFFsYEej4CdBP7OTk
         TI5Fp5CJdd7SXEKBCPeQSnc7LAmv7Znj3jNn2D6OeMuZ7qW/vc9ThV/sd2b/O9tNm6Fl
         COHSG4swK2/dsFyjK3j+64Kou2As01J7FpG6XV0k6X9TwQ5TiB3sLkLTGFdaNUQHE+3b
         oppj5JFca2tZJDyHpsXP2Op+jV/7oDL36/5p2Zpu84sUhG5FM1g6DDlwHEzIMUT7wgBs
         1reycXKjBxiBCgZ8DxJYtr7Jd4JuUPI1SAmnJUvGGYFSc+qs+CAhckp6MvA2/LCIG56E
         3+KA==
X-Gm-Message-State: AFuF++nj9g/wXe2dU4IZLQ1xwNmgkJcUALDsdv5e3WvoOYYVgMZAobhE
	vZcBcPPBrAHG6BLPpBntAVoZNjT0/DYP7c54eyaQHqUHOedlABl4EY0=
X-Gm-Gg: AYBFou1btIIf+SZxBexX805Lxk69vPCWGLZ8+UAf0zPnXq+/HBAiweBWj6RYWZghUVB
	DDVVLm85K3saX4wY54Qv+UjlPNUqkkkbb9XpDpwAFxMxlcWC+4qjbTrDDiBufcPOUf+cEnCu9rc
	l5JYIrnP/WZBO/CxeQCEpBuzF8TnnwMoLZi2xjz4t4pOlCXiL6KcjEv2g47JhfvWcaERDSEGZCI
	GrSg7lhzlwxDMUgQqFeLtzJBw/1Kb5HQXOMxFxjjYSpxuAk29VG1/3oX3944X3+0KSbrkruVX0F
	eSrcfwDHFZNclJsQrUpmb3PAP1/LzA/ZRlOWDonmcl+SqPLvfkEwyjg+7tRpJp9D+wGuSF8y0m7
	AmcwcAJWhuop+8Tna/xyBwcE/qT+eARLLUNIKK2N1tcLM4GwRVsDEcRr70qdYYuKy0cj7tuK9Rk
	q41HDwEh9UiKkmwAV096ACpFmuOFQog2CyOMNR0xLtiXmlR2XyLpkWsbvU0kOidlxKeh8LzyDw9
	BGQSQLXlLhA
X-Received: by 2002:a05:620a:2951:b0:930:f337:ebeb with SMTP id af79cd13be357-939c93d60f9mr1733969285a.12.1789046836953;
        Thu, 10 Sep 2026 06:27:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb566a8sm1718299585a.25.2026.09.10.06.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:27:16 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260910-mptcp-connect-undo-net-v1-0-446e4a4ae3e7@proton.me>
References: <20260910-mptcp-connect-undo-net-v1-0-446e4a4ae3e7@proton.me>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: fix leftover fallback after
 failed connect
Message-ID: <fc2fee07-1790-074d-f479-64af9463bd28@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:27:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join=
 =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Perf: Unstable =E2=9A=A0=EF=B8=8F
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/34478188118

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/103aae4aeeaf
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1162041


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
