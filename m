Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968F15CD
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 06:19:36 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1bb58b4c513so4958537fac.0
        for <mptcp@lists.linux.dev>; Tue, 01 Aug 2023 23:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690957176; x=1691561976;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69P0VnmetoQhvkWWJnoNX6kgjzGDOMsryTG1kKKIVMo=;
        b=dJmBv4zTN3GwN2O77NEiGz9wO39T1sB9AP+X8xN7+0oEq9R4Q9cucRARh/TFIsoTEF
         q46PpGmhfQEGFVdh/dqzeXdYXV5WiV5UL+JA2KGlB8s6/V5xQDoExQLWdgGjoTVKt+OR
         2RmWgKF7a69twqiRimbCj6vpqGlvOIPFl15IqB84v3gswDr2vztQuVmdaOE7AznVtaLp
         vk9plIJxl1zmMn7WLO2bfcY9JJ587WDiYc9BbXSsGm4NzALo1tWjVoJwHzzeoxdAD0vH
         Ndv3EBIN+JaGan2ZNnMlcxU5IxrrFPXyf7oacHLX45TBnPlcI7H/OqnQBQc0v/0izy8j
         i3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690957176; x=1691561976;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69P0VnmetoQhvkWWJnoNX6kgjzGDOMsryTG1kKKIVMo=;
        b=ZPGHD3q+aglm8j5ZjeNnUwd7u/S8cVumqdTvZNuPGq9bt3IYT4Sbh7HlVOr3rE2kIx
         gL7PCQSvEvLOP6zUNFCM4TNfrcoQkmL2e7voj9nK8Comu6KEJFbA4XebfroIVvWnNaLA
         EOsz28IdkowXVQ1JOF28RXLmiO7fzqDY5EYFzTzf6j7BL8W6VKmZR+9fNNImHv+2Sg6T
         7ImtFL2Og+y2An5s1XT2T2nVDycEf9uqZLXtV6xlWiqlHjpAKDT080bkZaObojHEkHPH
         kZ+oRru6iGDckdH2P89gagK8I4u3jRlBhgxEI/82eMl3yj5TACkIdXzzipJ/9v32OcuC
         bkKw==
X-Gm-Message-State: ABy/qLakJZi6EymzWTrZBk7OD9oaT0msjLkubkY/5PL4ePH28wFX/+qV
	lzCR870T94mZKWqPj7HwEw==
X-Google-Smtp-Source: APBJJlGxSF3SI9IsnLD8tbRr50IKA96EMzLp1er68Ioi27MatJxkuw0V9Kc25IkH0im6jPAlIZA4rQ==
X-Received: by 2002:a05:6870:14c5:b0:1ba:db23:f99b with SMTP id l5-20020a05687014c500b001badb23f99bmr19616649oab.27.1690957175605;
        Tue, 01 Aug 2023 23:19:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.170.164])
        by smtp.gmail.com with ESMTPSA id kz11-20020a05687c320b00b001bf480733c5sm361154oac.42.2023.08.01.23.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 23:19:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5dc7f4dbc799ddb5937c24dc002727c0fa27b70b.1690952908.git.geliang.tang@suse.com>
References:
 <5dc7f4dbc799ddb5937c24dc002727c0fa27b70b.1690952908.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <867c4d81-3e34-2449-b8b3-a3b5988786cf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Aug 2023 06:19:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6597383929200640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6597383929200640/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4767796580581376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4767796580581376/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5330746534002688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5330746534002688/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5893696487424000
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5893696487424000/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b56b7cd37f92


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
Bot operated by Matthieu Baerts (Tessares)
