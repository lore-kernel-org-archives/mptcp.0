Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C1171BF
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 19:02:34 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6b711c3ad1fso2134948a34.0
        for <mptcp@lists.linux.dev>; Fri, 07 Jul 2023 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688756553; x=1691348553;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oClIjOB08jkBdiUPfBZdqNtYOYZx7qxZ4f0d2zSWyps=;
        b=Mctl1NBpiHH81DhZAixAMmOi5ZIxzJDOZ4Kr6DysiHuVNqLhFSVKo0slNMDJ6ElKP7
         HYBCdYjBLE6REf21m8zinjyCNJxN0kxrNPhbw4c2phLg8eXc+c58mN4814iFCiAtc3Gn
         T15t+EXIeZivWXURDAunG4gVp4z2oZqPX5/Mzfyn/Jr6gwQcENryza9gz/8JpptdPh5m
         LAi84VeWQm2Prp0IzINhjkwdQqPdoIvE1xm3AvsgspuBmlPMrl96BqIteNX+vnvUkTPG
         a5gNSKC+P0JUi7q01Y70fNnfjYKbNV1fIwdlQpiCyLHAnVpv8o/m9Frf0UmraSVzxp/k
         UW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688756553; x=1691348553;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oClIjOB08jkBdiUPfBZdqNtYOYZx7qxZ4f0d2zSWyps=;
        b=iWVdImCc9H13GqlAMBCRVpMmTcc0NGgddmofNycAWoc1TctsIl2PAv0v8O8cJL4EgN
         E1gfMfaXoH5eFoKadFhPETNu6LUrHakFLtTYrBp33EvDmN+EaIKnv7y29qLQcgKnJvYi
         9jXT4L5bKBxueJFrpbSxRxb2kibQprbuKixzMQDSEHreY4ePnH1L2yaln8k9YSV76EP+
         iJ9J9YqCAfEQSBbPqji9QbxJnRBNOQ53bC+Qa2YFkF39ggz7aKVodh1eC74w2C0nX1o9
         BOjHJBWEiq60L31FupaQd7kyx8qjmgasLLjDCmsA50Mpi6zgVMkVzZtv0t5E+O5pQNow
         8Mww==
X-Gm-Message-State: ABy/qLZUBJUw1qZz/eMDdDnxzn5bwrRmbqzb2sr8fAoSe9X7/wEjRWRm
	P3fKXLyu/ZLESg57oGU5JZF0oVIN+X6P
X-Google-Smtp-Source: APBJJlFhvaWREW5uGBf8b1NqDv+vwW4NImRJi0YMIfhG+VEyuR3FZWACnp+wm3hkCw9YbCiczXcZZw==
X-Received: by 2002:a05:6358:906:b0:134:c984:ab7e with SMTP id r6-20020a056358090600b00134c984ab7emr5858102rwi.0.1688756553425;
        Fri, 07 Jul 2023 12:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.255.6])
        by smtp.gmail.com with ESMTPSA id c11-20020ac84e0b000000b0040397d71489sm1224028qtw.2.2023.07.07.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 12:02:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d0ba7d12992dda2ebad5b93b201d43971b59e265.1687829823.git.geliang.tang@suse.com>
References:
 <d0ba7d12992dda2ebad5b93b201d43971b59e265.1687829823.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_burst test: Tests Results
Message-ID: <a2238afe-2066-d027-fb69-d1ad70b3e236@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Jul 2023 19:02:32 +0000
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
com/task/6478787735453696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6478787735453696/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5387016662155264
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5387016662155264/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5206555876917248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5206555876917248/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5784825894797312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5784825894797312/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3f2f5bdd10e9


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
