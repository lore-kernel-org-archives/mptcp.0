Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1932C3261
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789299794; cv=none; b=QwPqUZ7v1AJQtpBBK3trLbR0r4Ud1VBLwf8O9QdpvTmSJRaur88th84/relRzTdaMJqXWr2jlD7+0Zflxy+/W42e8plKF4orv02xASF4VbwmeBLTEfUEKNM+MUHwd2icJKvtUHKdM0IkT81LwPcR/ECsF/hqvgjHgM8RP66FaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789299794; c=relaxed/simple;
	bh=LTku87uLYYvFf+x+S16OfjJ+EG/QLNgQ7fjJYec0Cwk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=cfKm9Z2r3X+jf7Dnj9zskx+MtyJtX8sGAUBYKBo4nmbVuzeoMpJUuqu3aNMgtpcPKL+0oGATZaLYcUit4mKiDTwfUeCOfEp1PgPQzHnfB6bQ4KaAKA5IM2fBztsNtNcIYlBkW6O0T+9y9Lxq/03/YbHVkUYsxaUH8Y3pL8hxZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyZcSd1/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyZcSd1/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so831643a91.0
        for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 04:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789299792; x=1789904592; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8mG39OyhC9DSr2OopihcKcyxjZhxiKexBcKh4QDnO68=;
        b=EyZcSd1/BUZAD3aKzC28dpvT+i/cPBZj/6URhd07HdmXJTYFa1d3HiZPesfyyD6+ax
         CbiWk7Ai2kbW2Qr09xUN+uThRZ0392uXq77MQSZp4K3mR3t0lBeY/h+Pag++PgDuGwdw
         cD2aqi/ZiDmaVjbn89UNPVFP/COyypMy+ZTPxHPS+xlWP2janBZ0Ryx2KZgDhBzWALKD
         V++FdbX1kvfUdXCMQGZPwDQ2WVG24fbuwCwNAQiJCkQlYfUS0BQB2LLmdew5MuFgtLKh
         1wXXstzf0ynQC/Ii8o3TMfLhRAL0BmWchEkERZVD009iN4lEEgq+w0Ke1pNXgiga02EB
         b3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789299792; x=1789904592;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mG39OyhC9DSr2OopihcKcyxjZhxiKexBcKh4QDnO68=;
        b=n0UXZInuY6AXCpG4AUJJxhvlghFt7lbIIWONsLkXscvuANrNsda9Mf69BR9ikV96qm
         +OclzscefbgXMtW8j1VyKWrxKS6QOpaov7wTra9ujAp9mBOzV73JL43K3a1lKq4NYTCS
         dRcvQj1lZZrfbMmidHmld6aBulO1rd4o9mRfvALDUDeLu8y0OgQs1dAsvXRGxiWjUqLL
         mkolJv3h0OlGkt8weArc3i8KtDnwJSBnJtQwRGVmIfouxHJD0EucPKV85JqVUJs8mRw/
         hCUr/a32iScgF2+HayfMtn51yZXewyqIV+m4aM8iCargFoVxEOek06mNjaCHK+vKgS0k
         h1tw==
X-Gm-Message-State: AFuF++koKA0Js/rvdHTstQ4YPEtS6t2818KHPKEPCQUddsRIW/Cvskx5
	fFRDoSlJjLrXDWenAyNciR7EH78gpvNoLX9xNwhL+rr6ci+mrxUPI5k2lNZ6
X-Gm-Gg: AYBFou1gKSQbLAhL7M3hnlbvAFTYvU/f+sOfbJtjRLS+i1v5Jm0YIPmtITKJZF3HfDD
	HphEXyLCRoKv1gD0VBWE0GFZSjf3M/UkelThXngM6gdxQVh9cq5eqkRuUrtO5FhC3FxHtIiaccw
	7ekb3EgbUPkYgELbh5wCMuJT8NepE1gUoy0/ZFQ58Yk6fqENpchPDN/HwQHLwZAxvEQ3SLXoFEJ
	RyQaNOp9hXJa0BInPWEpSwJIXAV9QqGTrhqlzbjOQ4U0rjNnfTeSLQzTTTLWIdkUEMfRpYNl90A
	A2Qe/HZyTsGELajCGgSuHfjTMs3suBWw+KtZ6Z898zCjtRx/GD04LVZrmkwXT56mk2+jR80Ue8N
	5qCJ+s1wS8afjHN8BHlkH3EDfBNWr29NwJqzvHBxAPQmTNVQUqeMOk1UZbE7uPhUYpv5FWZBYI4
	275MxEy6SDN5WcjU2XZePkiasW0o1Kr/Nu+nErD/+Z7qGq/HBq7upqFxmtWDJItdgd0Abnkjc+C
	X4z1PW1hF1eeg==
X-Received: by 2002:a17:90b:390f:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-39d9c0b7047mr21924155a91.12.1789299792340;
        Sun, 13 Sep 2026 04:43:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.154.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba7a9bb56sm20468935eec.31.2026.09.13.04.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 04:43:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 00/16] MPTCP sockmap support
Message-ID: <b5f9e8d7-b738-1df6-3b5e-1d54cbbc663c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 11:43:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 3 failed =
test(s): packetdrill_mp_join packetdrill_sockopts selftest_simult_flows =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/34752281734

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/30f4301b3392
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1163753


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
