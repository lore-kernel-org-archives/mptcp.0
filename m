Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6029D266
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777875102; cv=none; b=iI89baMFMJE9Kkoqbz/Y/UEOKTd7zPsJ9vTyxt6Mhq6XDmTkKSk72QnK9FiEXhzIsKmyRS/Smy0DlQCnYYHDlxIbtxQa+ZGCYWCKZLhT3AYtYEo4jl8ej678mX6d9lKsNT3sPkZtCiyNDKHyzdrNuOes4p633d9fhTTTTgei4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777875102; c=relaxed/simple;
	bh=xp3TcvDnPa1YGoOGqhGWNSX6ZB6mF0/3b26NjEoeHGQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Q+OuX3PhEXcKlikARKhp+IwS+I6IftDPWOmOhHodsMi/kgcv8dgIF8CN7l1qFmB3WN4mdLMKLbzLv59n28pty8WwVa9HCHom/3O2qYjsIRQNmoIDrFZ0SxN/8hA6q8WPyeZD8IeNWvfhFegrViHJ2Gul0XLlo807UgF+XV8vNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX2O5d0t; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX2O5d0t"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d55b97f358so2865796a34.3
        for <mptcp@lists.linux.dev>; Sun, 03 May 2026 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777875097; x=1778479897; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EoDBHUCd/HajYsEslj9XvXGEnlztFWweTH1frEU/Qg=;
        b=SX2O5d0tDT2z0Fsnip6UKmp2BHZ/CQINF5i3/JtgJ7N+XJQUXrjXYAJr0dkWb9YGTZ
         wNV95zKLZVukMK3t0mkfYSeX7rxO5Pcy6zgkwS/IJndQt316F9Yy/hYjoFgJqACfiqR3
         jPu4/lhmddinIg11S5OvYSZ4J63TB8ZZ7Qwioa7XDBTfOQgu6oq4pcnvN+vhRGO6gJVj
         Av+R+o/MrAfqk6W7C2ySafUl81JnQv7Icx2YcBjXbdhKrTvC5AJrGmxGpXzJJrUmVHhx
         e7vMa6nyEAtjaW2N9v1HXtZUUad6erQpxn8YiJNWXc/pHEm0cvbxJ/TohZq9giAQM1tW
         MjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777875097; x=1778479897;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EoDBHUCd/HajYsEslj9XvXGEnlztFWweTH1frEU/Qg=;
        b=i9SKUC5kmMPtvKPgGoFW1Vy9YXu9H8fB82IRmUphl4kA5AXe0jbCPL+2BwiuN1B61W
         PF5+pzX+5kkMwwio1CwZCqhVtdScS4BgQos8BLhmztUBuWN+zSbEMT6f6CPbg5CdmFW9
         NIzsfNGLBGW14lTrVdyuh/70hvmCdt4SPMzW29MFI0Pb0D9V7bf4Qbf/UNURDB3hj/LC
         sMJ2/WcC3XeL50Bv+X4BNNrOHH+z7jOgjOll86j5H/2ThJs8FLG6oY6cmnfhc8ipvmJ4
         Y5RKDo5EFUVJpugppczcLhlQS7/tQclQ+dfthfF5f01J6iYzJeY/0MEUOfbWDO5HKCvy
         Zk5g==
X-Gm-Message-State: AOJu0YyQ7X3u9774IAGoxkMkRm69h3eA7rrJ9LwrbgM2/Prk/WMaFw52
	CSlgTwqGiMRh7WitzL49uSKnKzMiuDhWXuNytrFx5m543DK5hrb4IBQ=
X-Gm-Gg: AeBDieshLc93SDKoTg3q/6Ys4Lsddg1L6EL9y2vdLvzPhrl2E4zqXbWsnJsVEejgq3p
	q5SjFunPLz0fsZhm8IGkJnNv9iFtudgpLjF0aX4TkwlkZ0F014MWhwRD1s2l9nrXpbI00nlndpz
	x2oq4ZrWC34/prW3WB/ZK3HdQVnQMrhXuj3pportbtxAciKb3RHYQQRDxPipUGOx4T4otDc21mj
	zU3FPSOThmG/Nz4+OMNaCpOMNOeHPyPrvWQlE1bV5dlhRnV1G11ckWWvPkHguyF5o4kHxOmRqrk
	TNXAVkWJXsARxsKpMrUom2H1715Ft5m4AiRZ2C9pA3cz0QFvFCK+8kALK7/jP7NLBsbejk4W1DV
	XSaTsRY3WdrzPq7wp5IQNVe77IoDKELlWqya2VFONfxigu4GT+xsQvHyXixgYKr6X7pie4wPbJ7
	BTObIKqPorKfksEqb7ns/QISB9gP6DdVflRCUGLh+HW8OudLyv
X-Received: by 2002:a05:6830:630d:b0:7d7:b841:c6dd with SMTP id 46e09a7af769-7dee126fb68mr5143216a34.11.1777875097594;
        Sun, 03 May 2026 23:11:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.84])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7decac8ef53sm7633067a34.21.2026.05.03.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 23:11:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260504044051.3725846-1-kuniyu@google.com>
References: <20260504044051.3725846-1-kuniyu@google.com>
Subject: Re: [PATCH v2 mptcp] mptcp: Clear mptcp_out_options in
 mptcp_{syn,synack,established}_options().
Message-ID: <7f5d01fe-7a5c-9e7e-a1c8-e9d0b98f2a53@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 06:11:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25302049625

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ffef28928fd2
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1089081


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
