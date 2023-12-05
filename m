Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306DC38DF4
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCqyTWT4"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d852ac9bb2so22533537b3.2
        for <mptcp@lists.linux.dev>; Tue, 05 Dec 2023 02:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772032; x=1702376832; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ln6rxsRsZfVNsvYkeEnRBsIPRMXgX0wOcV4/iZPeLM=;
        b=nCqyTWT4NERWojNyAru57YkOBnKKspiZk/QY4dfw87TeWlE/nR4FuJikXy0VCYlIA+
         gR6eY93wsrD6K6GCsChsfzG/85sMBHQCe8IVnCRtXC53fxbMCLpvAGwsNz+iKC5QIKib
         D02+noPDknYoOKphodXd07zurx42DD321jvH8RDuixI7jgudB63N9mnfWU93grFJFBW+
         JPXwG30ojFJeUOU7QLn63G7FlKYYRzxTz/OPi1YxMVOpeGuzSpvXyEMenR8GbSeCgaDf
         8XllX8cgqbrN9bT+7xh8j12GVfQj1PRfYoBfYDTOqtM71WOiStYrQDkd88UHBnuQ1MYF
         EdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772032; x=1702376832;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Ln6rxsRsZfVNsvYkeEnRBsIPRMXgX0wOcV4/iZPeLM=;
        b=APi/9q6vXSZqvMYq+SLFuJJ8Plim1y/XUGggcE7GwdlGI35K3IHIG7z2MVnEQiopRi
         O6t/KjEzcx65M1ttPSR7Bl9GbWwTTDwh5dMsgkfT6I08YLtFGGlaycCBCpbfvv/9T4e9
         HOXhfwwPL/w37D/2ckZf6Ayvs6DMoOVFKgLaeuTDydlB2bNFYiG19Ypzy1q8Czw3G9MR
         615jw0Ck0El9kjyxI3F91fIStLauILX2UgvykHuQCk2H11h7myWN/byyuEY+D3FQEQtq
         uIblDJaYmwwo8JC4pfndZJMMoHdnsZSvC2ZmXwojmC0B3c+YdKUq1qXHidVe2VbPQnSJ
         wU0Q==
X-Gm-Message-State: AOJu0YyGP6t446Ch2SavVUoDki2V5ChuPuk5g9rKHyfUOvWYg9WQIbNA
	dlPEIkUyO50C/mtnlOcFSg==
X-Google-Smtp-Source: AGHT+IHJonR/2/CANQgAWNiS7IjE2MoPpW18PhGH7STRVYlD7hZ0iOkbCUoeo4QPF7dwKP3KGMqlpQ==
X-Received: by 2002:a81:ac62:0:b0:5d7:1940:53d5 with SMTP id z34-20020a81ac62000000b005d7194053d5mr3887403ywj.77.1701772032021;
        Tue, 05 Dec 2023 02:27:12 -0800 (PST)
Received: from [127.0.0.1] ([20.55.14.253])
        by smtp.gmail.com with ESMTPSA id k13-20020a05620a07ed00b0077d61831eb2sm4962976qkk.40.2023.12.05.02.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:27:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231205091221.2657807-1-dcaratti@redhat.com>
References: <20231205091221.2657807-1-dcaratti@redhat.com>
Subject: Re: mptcp: don't overwrite sock_ops in mptcp_is_tcpsk(): Tests
 Results
Message-ID: <91f419ff-4ec0-f0e3-1004-1ead9922944f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Dec 2023 10:27:11 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6556569052119040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6556569052119040/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5289931656921088
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5289931656921088/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5852881610342400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5852881610342400/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4726981703499776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4726981703499776/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/68ead4ff9b66


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
