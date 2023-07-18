Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A417D4
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:03:15 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1b06da65bdbso3944367fac.1
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 20:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689649394; x=1692241394;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/rCkDg9OpTkw2p/OPxF8ubioJLFKpwSmS6Qbm1rW2o=;
        b=UQzv2W3JTkXE92F/oMSzp/HksO/H8eYCDPQRj0BUULFCQQd5ACBCuY9p1WoXe4m4N/
         UW4W4aZJzhE6oN8yv6MZRc4yutLIoQuXOduwTNe8psSpfUNkyIT0jSfWEY0+od8QLBz9
         6xRvrk4oJCWW7LvSmRc21kVyGL10X4Q2w0/XM+8yD24CnbRxi6yio5CSrp2FuTbgr6Bo
         K3Bma3+nuI/RnBslFEAVdckX03+Bv1Ki406e4fFx6DzoeCP+5z41TZSHFBrDdYoPC+Sg
         wMBx8FkxClz+4s0pByMQQ+DXpbp3tg2DbxndPkGT1t6oRvGeuWyrwwb+BSNwiYeeWaOM
         mjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689649394; x=1692241394;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/rCkDg9OpTkw2p/OPxF8ubioJLFKpwSmS6Qbm1rW2o=;
        b=XP7T0XNnUp3KptLWxgZ4LsUL8OcW8rV+sP0y3pvVcNQbvmNUAOdmIhtkCChqsd8LYM
         PxtrfbqN3wUKAvIYYWFicbPPLptqasDBRwlgiSlrjUBMM8Yu7y9tE+GujIEGRk4haNPN
         vaxIb5sBNjvL0JORfXL1PDP0cA8mbEITECPIYpvfizdehvLxPmiioP+4NOFDkJq0SvTA
         sqDeDf0/lqjb4nh80hJsFHIsvrhYfXr8VDooAOoulUnE3AZUDBUqlLN7b622T6MdhnmK
         TUzUSrPQf+MdN9mhtL/3MhlybHpLtLdtulsK7LWMXV51vuAgoaQkU+NfYzuuEaNBI2RI
         iwvg==
X-Gm-Message-State: ABy/qLa1B3CAJIS10QI5McoFUcqSyY+UTCfBJh8sueyttd/WOzj4Jl8S
	c/GFSYjt9d0rGLkqYQKNTYncK/lBvw==
X-Google-Smtp-Source: APBJJlFoO7VJqxr/LjTTAw56G1V0E0dMGWK7mcMNsTUVMThRcOJKXTOgFQfCFD9Mtcie+34ga+JMuA==
X-Received: by 2002:a05:6870:fb87:b0:19e:7d07:ab9 with SMTP id kv7-20020a056870fb8700b0019e7d070ab9mr12958099oab.53.1689649394422;
        Mon, 17 Jul 2023 20:03:14 -0700 (PDT)
Received: from [127.0.0.1] ([70.37.166.240])
        by smtp.gmail.com with ESMTPSA id y39-20020a4a982a000000b0051134f333d3sm462843ooi.16.2023.07.17.20.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:03:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net>
References: <20230713-tc-selftests-lkft-v1-3-1eb4fd3a96e7@tessares.net>
Subject: Re: selftests: tc: add ConnTrack procfs kconfig: Tests Results
Message-ID: <1cd4c72f-5471-1fb9-ed83-a920ecbb264b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Jul 2023 03:03:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5713341499310080
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5713341499310080/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4868916569178112
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4868916569178112/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6276291452731392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6276291452731392/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5150391545888768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5150391545888768/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6b73c253ad10


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
