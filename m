Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D123DA7ED
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551396; cv=none; b=a2EJlx0vuwpZZRIqmlsMYMQM3I2Urc+50Mcl3wLcK5gUjND9+i/KF8WOzaFFjyYf5SPcEkenUyP8UASmaGxnRRAaAyjrqPlWHmGR3nKwCDvxp4QaeXB4CHsklNtBJpumLYvDSgiAcDprwA9uCDQtb2hp4zyOCE5DdNLxmtKPuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551396; c=relaxed/simple;
	bh=1slHtn1N+6LGVAHWvu53WQAw/VPPyISYVewR0Uu2/xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=EltSTNXbiWKikGmXPJgjT1ezTJko/JO7Eg6Ki6rC0UTVEU43vzEfq/CUROQj/u2OxTTN5U/RJtX2dohKTVKrgy09sculmwbEXgGY11Bfzwc81+WsgBqJbq32WyUc0ZgGsQJLSmeM+ZAjMLEqlMfkwrcaoCOh5W2aHKB7JRXlMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIWTb5Fa; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIWTb5Fa"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2dec803f9f0so1173326eec.0
        for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777551394; x=1778156194; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w9+FkzzBs6fdpljm5QwkynuLOur3Z+J5P2Q3bXKrH4=;
        b=EIWTb5FaKoyJHSML/vbqM1mAX0nGUpOGgnUs6LDR7PfS1NpmgeBp02F+tyfbKYyThn
         Qd5Kd7wxjm0HU8osFT//FLyosRKCBuPSLfoInCtD7C+V9yRSXxjiMCLfyuGWz42uIY+o
         5otm7WxpNJ9agu1S8m6NDa3HV7PsGZT8uyzXUXHWgmK0dnHZCDUHL8FAsbK5i7GzNXQ/
         WiEzL3hosqqq/hyToSO9zfAcizwvobBlo5GP/Y3Yemn60zqC5vLHZOdkkt77U1Xt2Nbq
         1f6XfYwzVCnGxlyEJMq/Bq4YrNjJJpj5FIgcyR68NY96j+9/auBCnO+5Xt9Hxt0R8dHe
         RZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777551394; x=1778156194;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6w9+FkzzBs6fdpljm5QwkynuLOur3Z+J5P2Q3bXKrH4=;
        b=FVE3UKJTIpPF6RIAxMTE2TDsCuRyxWAxeA5u3oaQWE7q0ne47DGzw0haejmo/HRm6e
         9nCsAbfLiiA2fhSdatF9rh/yyOEP2aiyJkMAV27yPNLPlOqauqCuP7ykxuqiEO/tPYRZ
         39VGPwdzYdd9geOqNu+JCzXbMKtPtm+bR6pg2fb9TllgzUSKMCgIw0CdiPYTdXyM2fMN
         Rc6atr/Pp/plGA6EhKmMEZvc0yEiR2vIHAwq4DIkG/w42lbSAQO81ecHOsYJIYeRLseT
         izbnBJrz4RfuatXyECT6YKjM/SsmEM5mgTgwhr7euV1zRpNgMIL2oMOAYpJ4GAQZYXdf
         rjLQ==
X-Gm-Message-State: AOJu0YxbgQpmfGAnU9TP5RBFkVqetchFtxfIqnwCqW4bDqTUtwp78Ejm
	hHJzMawJRxh93r+rhXQAkDRh/NM3Fj2qqUKmzAoeMCf5FUhTd+tLjNg=
X-Gm-Gg: AeBDieuRr+VaAa2duBPrHrugn38aH/THHHZeoAyb2tVJ96SLlKj68h+O5WwrJy0d2n1
	wcQgjA7Qzn2sX9JzCyQFULg0Euc+CbvFo1osmHCQkP300MsgPc1COc1RzSxU5YQRg4E7f2i2V+V
	zEUABI1h5V0wya8O/rbdc+ULgASMhiQERW2BZPZYUDAht20631SvDq2AGxDP/HqtimrVXCwX7Rq
	R5TLV/55c3AXe2Erp9pWfc7pm2RqCH982dggMwXCU1MXpeEkmQrzP9Zy5Ao4DxZqWzB5V/2KzWq
	pulW7/jmFxjifJpCcM4trB7eUdzlQ64/LYqvwD8kTs9dw//8jVoWUY5URzMG+w/hr1fvkdarXhL
	k01XS4kM6Y2/1ceavbh+R3UFv5tdpWSTvKrMJ4nrEnoQz1sGICI5dP2wP7OscdOWHzS/lcC+QV8
	fJoKPcabVJvKb4WQurR7On8Vvcrj7Z9lpHNUf0sNztWPOi0pq/vA==
X-Received: by 2002:a05:7300:d0e:b0:2c6:67b6:3acc with SMTP id 5a478bee46e88-2ed4f6d8718mr915382eec.15.1777551394114;
        Thu, 30 Apr 2026 05:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.193.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf8e268sm6373723eec.12.2026.04.30.05.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:16:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260430112026.343691-1-lixiasong1@huawei.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: pm: fix ADD_ADDR timer
 infinite retry on option space shortage
Message-ID: <18707a46-51e4-edd2-103b-7e02b773db69@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 12:16:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Li,

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
com/multipath-tcp/mptcp_net-next/actions/runs/25162701341

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7d24b4ab078e
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1088056


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
