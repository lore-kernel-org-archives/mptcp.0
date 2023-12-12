Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10247E794
	for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju7DR0YI"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-77f3c84e0f6so372113585a.1
        for <mptcp@lists.linux.dev>; Tue, 12 Dec 2023 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702405767; x=1703010567; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYjl+ZXV8U2C9F364LgYEDvscHTgWY1ZPCaY4tbSOTc=;
        b=Ju7DR0YIY2RTKRLw4vSBxxV09JEixRHCZs3PgJuLb0ah5Htgr4ItCynlf/GnBDKHib
         fSdFAQeVuW1nBj+bQ/GyPRLksuxP97O9zQuyaKZD373hGN2sp6pcGHKHiYk0flKOGVxD
         eE4uDxElnSBF4UEVw6yyQQgma8ysUTwcWRaIMnwexaMVXJy9tvW3f9smMZKTg1j5EJF5
         EdT/cDFfJapqm0M+WmbYCB56fBFrpx+4JnT3XnpNqLU0mLO4/xOAbdP3cLGB90L3eEOo
         t+9egti8t4snq+FkdTkn4+8JpRk8GX7cY+vu/d0ZuKR8U7VneORZmLq+7dFZdgqHKsGo
         PVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405767; x=1703010567;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYjl+ZXV8U2C9F364LgYEDvscHTgWY1ZPCaY4tbSOTc=;
        b=mhPtdRTi0jisfEp/wWCpRDzcx4LB7AcFoBGQJL+6qDF/ql0Mm6+tTjg908lbjhpFZR
         ZCiXc2Cymcs7ZxA9ocVnP6QuqJWaBN5nQFzyXq4yh/CtntaCAwUcfMG8/qcvl8JEeFjZ
         ejyYPjt+N8PEJ8I7//MRJalyqJE5ug6l4cnG2L2xhb5JHgdTQMBaXslhyvkWfCzH+brt
         Y/QdgkRIZRTSjvj1HTTjp5ojwfcueC53lkWIgSA4JOz0FN7aEzbpxuda80JnI3H2vkGN
         dW9Ufr7gV1mPExa7oNVZGk2fEjCL2fHkZogYs6xe2t6wTtvFrQSTiWQ7hwCXdsaUhi8T
         MSEg==
X-Gm-Message-State: AOJu0YwneJdPFoF8lw5Gw1y+v9F/2y3iyACk0Xk2rT5IIroeBv1Q3zyu
	YTWnAwM3gyqhtzrpCnGd6w==
X-Google-Smtp-Source: AGHT+IFpYYgYIlx2l6BEeVUvOC6zBooVbU5Fkh014DfmoDhmItbVOK6g0hN2GSS7Jxr9WJJ7mmV43w==
X-Received: by 2002:a05:620a:675:b0:77d:7178:e1bd with SMTP id a21-20020a05620a067500b0077d7178e1bdmr6742068qkh.78.1702405766811;
        Tue, 12 Dec 2023 10:29:26 -0800 (PST)
Received: from [127.0.0.1] ([20.55.126.70])
        by smtp.gmail.com with ESMTPSA id re19-20020a05620a8e1300b0077f13650cb7sm3927245qkn.2.2023.12.12.10.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:29:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <784668db3e21351c91f4f312720059c6fa5cc15d.1702290281.git.dcaratti@redhat.com>
References:
 <784668db3e21351c91f4f312720059c6fa5cc15d.1702290281.git.dcaratti@redhat.com>
Subject: Re: mptcp: don't overwrite sock_ops in mptcp_is_tcpsk(): Tests
 Results
Message-ID: <f129cc67-f469-d672-8c2a-f2a7f991e2c0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Dec 2023 18:29:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5278973853171712
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5278973853171712/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6404873760014336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6404873760014336/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6123398783303680
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6123398783303680/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4997498876461056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4997498876461056/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/922064b98d59


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
