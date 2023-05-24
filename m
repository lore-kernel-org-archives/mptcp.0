Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9C8826
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 22:55:31 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso1198150b3a.2
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 15:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684968931; x=1687560931;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSPqUmTCNS5ahw3P7K4y/VrubBrEPLbSI1/D3MQPvn0=;
        b=SyB5gUJwt6+/dm/V665YgB+uoaNzhjw+dcusfdXuLxGTtcw9SwOLP5AQ/a40rjTLCD
         T4LM6eseD0zbaQIiFgYNIh8VmBAfnxsc47Dnnurgm5SEHgENBWYQ9xdL7wND0ZD1AuD5
         utr710f49zbMLAmT25xo9T0lMQ1rIcLHTlJ57g1ml6nJYef42EVfzRcvLCAWjbLFdNcA
         /2+tpwC2fcPixOGCnGPd7n/R2LtfT3aNL4L3XX8Ace+8LNtDG6KR5WpdCN0WpGQyhZhW
         QajhJKWGYnwI0NOoMfjL64+3LN2wSTDSd8Li+2Kok2HttCSERO7xc0wmDOlnBF2oKqP4
         YcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968931; x=1687560931;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SSPqUmTCNS5ahw3P7K4y/VrubBrEPLbSI1/D3MQPvn0=;
        b=DHc42tFrWF+N2pJ1P4hoJfaMJG/UEtFgla6LTwWJ0O2KZuF6/ETmtpL978hQkRLz6v
         DRXU5xS7J1ERCiCZvEwV9/NQ0G6dcsa19K5BdjkNSsiZcaOzC61J9urfmYfMdxq3G/q6
         AM9srINDYASIrHxdiYTKCuX7w8PoaKEJy6zM6FQTfOOqEKKQhhp/zkY7T/YaytvwMyfj
         j6/BxoXcsbJT8NrYNPQWqCcGnxjzB3mr36yypLR1NZFuD1sFQR+Snvnwdb0jksVmiZ92
         ribkL0004Rq+O+evkSXlqVasGg79Xk0LHhJSOJyAKR26LlolAGu1hNkGcXB/ug7VIaIw
         ajEQ==
X-Gm-Message-State: AC+VfDwn4dodQdxytx6t/0bNmxBQSis1oDK1hz47eqZGj3qJq50XyCTX
	T/FNTWkWoDjb2OGllIQMnQ==
X-Google-Smtp-Source: ACHHUZ6pqo5bwqruSdqmtdMRJTB1yI6CpyoB/rkKkgdkIgMrsokIKAzmUtwRecppVXfHoxSksd0Eew==
X-Received: by 2002:a17:903:44e:b0:1ab:eee:c5d7 with SMTP id iw14-20020a170903044e00b001ab0eeec5d7mr18715092plb.48.1684968931309;
        Wed, 24 May 2023 15:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.43.80])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902bd0100b001ab1cdb41d6sm9264834pls.235.2023.05.24.15.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:55:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <803034fc4f174c8180befe1e859675f99784874e.1684962909.git.pabeni@redhat.com>
References:
 <803034fc4f174c8180befe1e859675f99784874e.1684962909.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add MPTCP_FULL_INFO testcase: Tests Results
Message-ID: <c01278b9-1848-1e41-5472-660bc080e696@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 22:55:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5986916420550656
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5986916420550656/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5423966467129344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5423966467129344/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4720279025352704
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4720279025352704/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_fastopen packetdrill_mp_capable=
 packetdrill_syscalls selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/6549866373971968
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6549866373971968/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d241aa733adf


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
