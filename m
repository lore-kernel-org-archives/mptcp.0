Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D292E3368
	for <mptcp@lists.linux.dev>; Fri, 14 Mar 2025 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741924625; cv=none; b=ZgpNWfC5jxxYa2qDevTqyBLsow2tyXLMhNn1UtJz7L/2H17HOC3xIe9vlmKruaQr22PotooM5HYvGs+a1x4/0C7AJPeurvZ2xoffxIIb8bB9HjbVq75qLqCfHpKprkD/xvBeaL0aljZm+sUadgr3w1qnTJCErzMGrQ86u+vWM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741924625; c=relaxed/simple;
	bh=T1ZAFZmQ4TyTQZg4sbuC1d4pf5lnn6mQAcIlOufuhh4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=T9FNvEO4Xc91TRkKWMoFLyKvpO0XTG9qMsXXm+i00DAnvtA+INyvJVnwmpBv2qoE+n1KXTRxPCztmmOtxvlzYw6A5XsRg/giJnWlKpET3lPJwPP4f8XIsJ1WG+vVumUbCE8rfQXjhpgcbbYh21d4XyFxxqH0iOb4IMPlhfHEe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNEAlpJK; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNEAlpJK"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f05acc13so18850176d6.2
        for <mptcp@lists.linux.dev>; Thu, 13 Mar 2025 20:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741924622; x=1742529422; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+u9sUTtBP6Mt9RS0VXy5o+HRaFxnpzBZnoNb0q4GVA=;
        b=CNEAlpJKC0t/stBe7Ae5elIlr2hO8P7JDHb3FeW1ou7X8YDF4FNVSvStnNH/wGjaSz
         Vd2SmL2V0WeXnHStkdYoda2YGJ0/APBY73p6EQKSjOH8WfHdN15b5PojoafhCxYF+WUG
         BhBDIqdo2JLTwK2f8Tm1HzCLqqylbsV9LtHKv22ZIyS5dgxZBeePRThkgSXMxZVJEw7h
         OH8QQ35yKu4H/R0yXcHk76ywwN9VqbLf78df/fw2A5awWfg6C0nlM2RNaL61LicQJRQY
         lvBckNlMR80gkShunwjpldJa2BQZL2aWQXkX1FpM0zwGuHeHvVjy8FOrvjEfLxE0UBV6
         727w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741924622; x=1742529422;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+u9sUTtBP6Mt9RS0VXy5o+HRaFxnpzBZnoNb0q4GVA=;
        b=jeD+SWcS3WVavIXqtdgCOipJorYoz6fq6tR17zsX2cZgzdQM3B7rMErBgx7CiijM1K
         2e9KtWGSCmNGiLKC+CG7dOUTJVVNmJURfmvYjZeBwD0u231JsNb1O+NCOze+xD5U1ISJ
         Ko6JXKw106otv+7+G2l08G1yOOiTjdHBWRDB310qPczld49WoPeX30m5wmya4VM5JFX4
         9qGiyOZMgKpU+jL00UwZXTVYC+afkN74Z18HZWgudGoUij/reVcv0eCEuQZC2yDKw2sM
         +CmQh4q0qm3i7uGWD8zwTQIcbcU3BuD6tDgBhKWKtZr+/0IuIljOb6dE4REMoomW8W06
         Dxgw==
X-Gm-Message-State: AOJu0YzU2uWOD/Aw8r2e1BXYq/1bCXX+o1C7KB4HRtD06N5O821OvkO5
	vLqaVD0KHTq69N/UnXb2HOWoknfCLgMEADZL2stThLEHCpBIhSInEBVXNHc=
X-Gm-Gg: ASbGncsFRUEcFVNteZa/KLVosQG6s+PrOq9p7PxUCI7+7W4KQV8PCgwuT0qm4uyZYW8
	O0VzOMpcVGUolvxzBBP4cAwwXV5i+NUKA0t6PYGdByTiMAaCztSVglVQgfRuDWK6XmV9eCQKeNc
	oiQKuumf+yrsBKZB3sWivS2uGpK17YhibCoOS5THnHTkf7+hocrHiXZE+BhRDhYY8BSAaPtNszO
	0FNHV1Y9/NwI6zAkFMQ8SNeJQPlnO5SeUP30lamvId8HrlrA+awRBuvE68vVIlo9bGhnPWsGSxf
	o8f1che1D3epAtjTWPy+ZIa0JzaaFAkOXZATbxiz9CnFGJBtPsEZbtkmDw==
X-Google-Smtp-Source: AGHT+IFWN3EhTXFq/rW4EZr4UinCzDFIGkjfEkfJoW8CmdCzy8Jry03AiCbyJ6F/lm3DdTdhN47IWA==
X-Received: by 2002:a05:6214:e46:b0:6e6:6a82:4989 with SMTP id 6a1803df08f44-6eaeaaf7679mr10147126d6.44.1741924622430;
        Thu, 13 Mar 2025 20:57:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.221.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209369sm17972426d6.2.2025.03.13.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 20:57:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741919893.git.tanggeliang@kylinos.cn>
References: <cover.1741919893.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 00/10] BPF path manager, part 6
Message-ID: <a8bf42c2-a0db-ff8b-2ea4-d90398d0c9e8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Mar 2025 03:57:00 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13848993575

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b5c3186d7405
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D943747


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
