Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07416D18
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 16:27:16 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1a1fa977667so5320598fac.1
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488035; x=1691080035;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4EeItILUoHK1BsVi0O3aLq066OAW84YRdIMnHTQUDQ=;
        b=aqA6Uyb8X3m1uuG1XdTis3Us2XP5fE8hMVIkkSCm61ViJmhmcOPzFud25O54L/sJPH
         DkH6tgntBIo87UCbqTJzvJ1EJcXlz1y1iT6XFn8n9VHE5FT/WH4s2mdOHsUHPOKIg41e
         Fnu4l1j/141qxEsHB8SqUrZnKWQM0CaGEIA9n/XNv5f6bM6TvvEZzOKntsomP+HDvaWM
         F2FJUdhKeEcfyU70vLWSHrc3sJE+iIeFMciC5+hnHKYC8KWubAmmRFYWVglTaAgCO9fL
         gNQtMcej7bF/vXggntctp5cWoyQf5WTD0FjdNTe+C2El1IYVOZ/UZDr+HD5fl0XF7Jfi
         qKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488035; x=1691080035;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x4EeItILUoHK1BsVi0O3aLq066OAW84YRdIMnHTQUDQ=;
        b=drKxLApe6U+L0dTAQw35t3LHVgX2dGzKmAcv40YXmzpXMCqwX0bOcZlRsd9b8w4e2w
         g2HimI8s9Rrymat5XZbwUju0y/74Je2Cj/b2y9j9llEyFST9riiEfwWnIzgPmFH82kcd
         29m3vfuVRKsU1LPn3x0N9SGkcxkNYufHwJAn4ikATFDkRCkm+d4EwMEfUpUApick+0LY
         Wnqh/98im0RbY3544SIolItXGcqkbx3psR4wQmKnbowQgRa2LcPuvgGyS1h+kgqA6FlJ
         uURiy/YcTzPYGoljPudoDBx33WYDTSufAKk6/3cWrpmwuQ2wtRfZGEIt80j8TCNtwaQN
         TaLw==
X-Gm-Message-State: AC+VfDy5EbtDH/TX1gCXhES7Ps+AEFKBfUQ8mliVTujix7WZAOK/FCgc
	icMgPpFruAj4PFhqUYRLiQ==
X-Google-Smtp-Source: ACHHUZ7pmrGjLc2BUUUDblSSzpqXInMhvom6AaFYq8qaooUk3qGwvb/BT72HsTdrMNcVOvfsTnAh9Q==
X-Received: by 2002:a05:6870:9a02:b0:1b0:43b6:e131 with SMTP id fo2-20020a0568709a0200b001b043b6e131mr15911499oab.5.1688488035543;
        Tue, 04 Jul 2023 09:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([65.52.35.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a9d7550000000b006b45be2fdc2sm9080950otl.65.2023.07.04.09.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:27:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d462c557c05d60a217f14ff77cd9702ed3ccf2c5.1688481634.git.dcaratti@redhat.com>
References:
 <d462c557c05d60a217f14ff77cd9702ed3ccf2c5.1688481634.git.dcaratti@redhat.com>
Subject: Re: Documentation: netlink: add a YAML spec for mptcp: Tests
 Results
Message-ID: <06cc0665-864b-1297-1628-aba3b357eb6c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Jul 2023 16:27:14 +0000
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
com/task/5355795404029952
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5355795404029952/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5498766208270336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5498766208270336/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5879087089057792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5879087089057792/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6558435488038912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6558435488038912/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7fd2fda71223


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
