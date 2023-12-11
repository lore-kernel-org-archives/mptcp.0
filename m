Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097A2AF13
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBoHrUV+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d0bb7ff86cso39449775ad.1
        for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 03:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702294633; x=1702899433; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRbwjv9OuBA7H8v2gv1PnnimZ/WbIcEEUpfmAQ79YyM=;
        b=LBoHrUV+bAfJM2fN6wjFL1R9K7gPWljcyvOgqGXoj3ATBCfMs0F2+shoNQbcEbz00k
         +A+37GTSNYxNruSjtu9XQNSUjPY7kOQ85FFGuXBxaYaixf04tlk1GA/Kq8XF85KyeJei
         X+ZybzklmauM+0lE0QDER1vwHwzSIZhXY8vP960/uyHrGkAyv9wOGH5C2Kf7rk3usbq5
         T0c9Xmlbn/hYJqOQekzevMmm616NhYLqEMaQ5kBI285y3H7JIg2BnvTYWWyRkEBHseC+
         oKVu2dWUybCpUHNdRaoKvpxm5hFRyHtTNPr+eboKze8M2H4TEIxvqs+empZsbVt+3R9l
         dQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702294633; x=1702899433;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRbwjv9OuBA7H8v2gv1PnnimZ/WbIcEEUpfmAQ79YyM=;
        b=UXAmlgNxzDNXeqBa8a10izccMxAfLmngENZDmX0auIwQ1hDoTHZlpF+JDv+2hzEXER
         2HGrskShmYRXIAcfr8dVtfpKJADHlpptwWa6NFNDLt3WrSI7aAenImGifeyzkX49STSF
         4rU22/jVc1s8ABZggLCsnm2UkYn5BuvihCjypv0WZWq6XoSoOIPQmuPgfVIvSZQ8HMDo
         +TwvCyOPsLjKCngSceCXCX9FBi/nCjiqHX/UGZYmvIj4J8w/KuQmcJYRI4juNTPkwEnw
         RzWfQwM0eQQSBjHNshQW1q78YH3aYnvww3h8erET6LHSWRBJ3HSQUTUflbsB9Q7mO/Gi
         ciBA==
X-Gm-Message-State: AOJu0Yya+RkZ+ibTbOQVrg/hLhUwPBYF/OxWYzokNGmD6/CKl5WQ+tg5
	CouprcRs9+53qR7BRcZbxQ==
X-Google-Smtp-Source: AGHT+IHLtaVIYx9Le2K/TGyVYmXv7UoUplVbcfWGhj00cBKaHEHEt2YGaq+R94IODU5ThPtn50AHCw==
X-Received: by 2002:a17:902:c7cb:b0:1d0:cfd7:f698 with SMTP id r11-20020a170902c7cb00b001d0cfd7f698mr4872012pla.30.1702294633424;
        Mon, 11 Dec 2023 03:37:13 -0800 (PST)
Received: from [127.0.0.1] ([13.91.68.211])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001d087610dbbsm6456673plf.55.2023.12.11.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 03:37:13 -0800 (PST)
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
Message-ID: <f6cf86e8-6abe-2568-ca92-ef16a75fdce4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 11:37:12 +0000
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
  - Task: https://cirrus-ci.com/task/5188990798659584
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5188990798659584/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6033415728791552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6033415728791552/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4907515821948928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4907515821948928/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6314890705502208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6314890705502208/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a709a8608c85


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
