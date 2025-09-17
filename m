Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C530CB25
	for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117479; cv=none; b=mHAKs9ZHtsxz5Y7d7+oUXYYZO5PROMRwKu7o1gY/n9+ow8IyONoHQa0sBqxWCt/fP0awnYfjrkI79h674IinTTrGOtFfDfto+Bi25ldoBtnyQ33npZB8AwiYZu/uKlWIgaqoRQqYYRdf/S4eAgrtM19Btl+3uUtTsXntu9hrpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117479; c=relaxed/simple;
	bh=sji3plzl78xdEE1eYbXyo8y6+cMTKt3vRkdNeYXiuZk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dc41tvf4MpuxIhXLH536aIEdmvpbIHpcK7gT+apvkFIlH3uKFZ+ph4wASGRiUVBoEn1EYekQNRbupdLM2bkY275dP+sJoutGQG7Oc1PVh9FdwAOirraPfQNOTq1kEJ5v6xpXzQcaKyWG6NTic91sTBoe7f+DAcvhoiiVhodcQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhnHvduS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhnHvduS"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-828d8d06630so108301585a.1
        for <mptcp@lists.linux.dev>; Wed, 17 Sep 2025 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758117477; x=1758722277; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AZaRYS2FjbgpIUZnkLFYMNxmO2Kch0QIRMWn9DRyK4=;
        b=hhnHvduSho2IDXxJB2KcWjpqKp5KMCsioMLyG6ax+8oy99V6EED9UeoyU43ksJQWlJ
         Scm5kDr8TizMsRJnvld3TAYaYTn75+EwapUyMl1um7eYqn7ZaNQla3biaISGOW0kQIhG
         2T0IMeOymDsCmKEwLXQVC253jJG8/GW9dty2nXGATK0eTxDqTM14PjOB4pMYrMF+u09f
         ZB1IBh2izOs5LErt/mEabmD5+mDNdTxJXJY6FVHisJbF/y85xK2ZFf5XJitWntS+XC1j
         qRX/yPYsfz9mNIz4ow1xsoMdnD/ePq+uY3aHiW1UGGbSpij+EzVfcI+3anFILPrLig6P
         Tz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117477; x=1758722277;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3AZaRYS2FjbgpIUZnkLFYMNxmO2Kch0QIRMWn9DRyK4=;
        b=ice3e9wWdOcO/aNjuIqqVPe78KAmYo5RkvoI61UU/UPMhlIO6cZZIZ1s3eh3Q1kW0S
         ELlDP0eZcDGodArPQmysu4+qyueN0ncwhSuFwRy9pASLMMX1T6jYlJoUyZysLP9PKMnT
         lzlhqphJc1kYSc59HxsEO43s0pZAeXxnpwp4NAQ20xQmPZ7Zt2X1Hl7Xkbn4tn4c6OvT
         WeBgdcKuNeX6kQ8X6ypS5YZhTBxWLBYRRLjRNJUc43gN0goQ6qusrSskb7YCo+j3Moej
         +cC/RXg/dMWFnTKFBnfJjwBHanCtYlGh+kD/VAST5h4XhE1owg4SPhqDPvMcXs1kRrOF
         Kh7w==
X-Gm-Message-State: AOJu0YxDgCmNNaveZ/nT3cJDiJ5My/gmAAb87q0YiQm5pNCbkFxmGOqO
	+qtNbWDRGs7IAH/n1taDPGE+VvNU07U2hT398WMEKWykjkPtMEHBwu4=
X-Gm-Gg: ASbGnct8F95TSSt3Oi8J+wsnnFHmgUy7yeWbPgo2SaLNDYNy0YKTT36CuMvUQ6fmWos
	E+faRfmU7MWBrFsO6RABOFnBStu/HKwE6b4mIur1AhTqFdVzraGaV7QRet5PpyQ4m1aXgTFzGF8
	uAY229N+Q/cLaRFKQJHdKxHG14ugUUgfD78teXjzRs9vSy2DscqN4GsinNobGvvuf4OvPKn9Tem
	jYe4RJH88k8z+j3KwLIDNLfsGn1ttY2+7lwSkpvFBtlP7d+z3XohKjEJlEHx/EVuzuSMB6/hSj6
	lZ0pwCWXqGakKkD6YWrYwdolBnQNqWkwAcctUJhFgPL7p39CeSy4IPVsjQu3TA+L1qrCfGM+d52
	sBkOOI06qmiJ6RF/+CJ3Ujp8XBM9Lys8Vzw==
X-Google-Smtp-Source: AGHT+IFCgqZmHFCNmVVfQaS0MvIH2Je3ZPnTP6cvFFfwUz7kf+MOncAyrMtucOeQpzPobajlhW7hNQ==
X-Received: by 2002:a05:620a:708e:b0:80b:bb34:371c with SMTP id af79cd13be357-82b9be9cdd6mr669771985a.4.1758117476814;
        Wed, 17 Sep 2025 06:57:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b7a29cb0afsm51955411cf.36.2025.09.17.06.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:57:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1758039775.git.pabeni@redhat.com>
References: <cover.1758039775.git.pabeni@redhat.com>
Subject: Re: [MPTCP next 00/12] mptcp: receive path improvement
Message-ID: <dc90b86f-e3c9-7588-4bb2-215bc19ec3d8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Sep 2025 13:57:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 5 failed test(s): =
packetdrill_mp_capable selftest_mptcp_connect selftest_mptcp_connect_checks=
um selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile =F0=9F=94=B4
- KVM Validation: debug: Unstable: 5 failed test(s): packetdrill_mp_capable=
 selftest_mptcp_connect selftest_mptcp_connect_checksum =
selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/177955=
36153

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f83d2e5ccf99
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1002996


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
