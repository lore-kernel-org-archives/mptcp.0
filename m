Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747D3D64
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 08:35:15 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-63d03d3cac6so33137826d6.2
        for <mptcp@lists.linux.dev>; Wed, 09 Aug 2023 01:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691570114; x=1692174914;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIg/Gt26qhuPc99eUSU4qN49h8DlQa6K0ZPzRrLpReg=;
        b=LhZdzThrDT9cr6FqEmA8GOJd2beKY4m5NwnERvmzC3p6GovuCQKxV1qBNGikmDz/Wf
         L+/rObmlDYbQURP0oTMYeE/no3yyFHTBC5VnClgcd44RSHmcmEyhuqjOjCcKGJDhzW6V
         jyEy8SzQ/l9VnaK1+ZflRoukKDycIcyt+olwAV0IrmbYJyZBnCkh/Tl3abFsepxqliGh
         ayJhknlzD9ZiEJQqeZ9IKT9BWnMjC4aLXKI6FnFiGJHx6NLk83bMZ08+Ir2QVVtE4AoL
         R3J8zgOZ7N/CrNWO5+JW/euoTNusFHix+m5mIINzNEnsCMmNd6RW9HS0jwT6v4f4km/X
         1DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691570114; x=1692174914;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xIg/Gt26qhuPc99eUSU4qN49h8DlQa6K0ZPzRrLpReg=;
        b=kozaQggC/TkH04I2LhBUJ5V5BjDXLE0U28rbpx3xMOad0YikrXxEgVeviqkyUbpKvN
         M6gscovgYnlhZwRDfnDJPIt+RaO3yQ3s22xUjsfK7BpQHAzLDY5B0jQn57ds0OR3gXvx
         xDkRO8lpUXOw79tT2xYOTRtzqvwnH4z1FwQtxgtqHCkIN74enUTztp0sQFzd22U4iKgo
         6+JrwCI5yJZCVhBuUOepTfAglFKa9y6jv51Jlo/2WlEvPcMXVtdIfK248F+/0TM3uDZC
         k14UQzeh62RiD4uBrBdUhjUBKA4v2aV5a9WWfkc3gm3cpxYeDaY3rRb+O+0rL6fvUuxA
         fTcQ==
X-Gm-Message-State: AOJu0YySDVoYAxlQS+0spYbDyrV5JXpayDTD0yPkwoxCjNwdWG/u/m+C
	vmO1ajSIrCAHUy9y7xFShDAR4ZQcIg==
X-Google-Smtp-Source: AGHT+IEADjf44G4QbydDFLvxWiyCIcXD5QJYYzq9snjqiuOPZZrgfoXzCZzc4C7lS2cHJHM5sLKnBw==
X-Received: by 2002:a0c:eccd:0:b0:63d:ffe:2cd2 with SMTP id o13-20020a0ceccd000000b0063d0ffe2cd2mr1798542qvq.44.1691570114123;
        Wed, 09 Aug 2023 01:35:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.71.49])
        by smtp.gmail.com with ESMTPSA id p6-20020a0ce186000000b00631fea4d5bcsm4282932qvl.95.2023.08.09.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:35:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e03195dc58397af6258c193c6a5a8fe457d20c33.1691564649.git.geliang.tang@suse.com>
References:
 <e03195dc58397af6258c193c6a5a8fe457d20c33.1691564649.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: remove id 0 subflow & address: Tests Results
Message-ID: <189c383e-9732-d710-27ee-ac474861b523@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Aug 2023 08:35:13 +0000
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
com/task/5155611524988928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5155611524988928/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6281511431831552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6281511431831552/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6000036455120896
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6000036455120896/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4874136548278272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4874136548278272/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/49bea109b80c


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
