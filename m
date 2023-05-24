Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A266087C
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 17:04:30 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6238417112aso6300816d6.2
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684947869; x=1687539869;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CckaC9RqZxqmrLnN7KDWIA+8oBwymf16NFeSudB4ia4=;
        b=iTTmhsXSIra+TrdG7SD7OUtOEe063P0THIjVhel7cLseVEUGxlKWLr1UTdRGa/AG+c
         u/fFszl9Sbq0pEaysDpu7qDfBN0Pk1HbqYOMnpfPTYp8Td6FzPLnRI2vYNoY50B46BGm
         kAkJeTv3NzLtV7vm8v5Zpr0t2sPtUzrvfEHlh4MDxZ43m0I1j0dwcMLEvt9y2dOaIImu
         AiwEyRRdEc9iUIwqGfMM4gWcZG2jZxrv0jcJX1Yx3GxLSbvODYrzAFcbCZOPYxaHPGho
         2qaS6sdlhDex/w9an4L7iy1rM5zpGyOoyQCT4lMOIw603MKcM37dr4bBuZscCFOKa+lF
         kDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684947869; x=1687539869;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CckaC9RqZxqmrLnN7KDWIA+8oBwymf16NFeSudB4ia4=;
        b=ei5wh7vzwctdxjQNj5c81z6Gvi6KLl+4yy3rVvZRh1woyquto6I6qe5df0m0wBnv1O
         XEFArjHXOBD/vpdJ78qKa8VK4VLP+eoE86oUAGV6eAGufvt/q7PrtqVMEOL0LA6nNgHO
         G/A4W29iDrF9o2mdqimMhEK4kUniXhtdYzdNR4hyrD/ovybtXPYftEjX6fvrr1Ty69xm
         5ozoovRAyz9ZNh9W7KnCqgupSOu1j8Ggi9/z14LJVV6/uZkvT91yR9IY0t9FiKAcGHei
         vCvANIo3pksyE3GsYHMx9T1gqSh+qnQ2ZPAyaSr6t6zRTPai3SaOB1LQPFNeKuBFhPnh
         hM4A==
X-Gm-Message-State: AC+VfDzPXwJwxYpjg0jcuC06ghY/kA0Smu3phIkAitn0p9V1NNyTDl2q
	XYWK3NiSIH3G1blEAGCRKQ==
X-Google-Smtp-Source: ACHHUZ55dKVYevR52jzNii0937IFB9rRXcaEBwKF0Cdze2wZiRmQKJ9rx7cxOyJ3ypk5BCzQ1TfGww==
X-Received: by 2002:a05:6214:2a8e:b0:625:aa48:fb76 with SMTP id jr14-20020a0562142a8e00b00625aa48fb76mr2309851qvb.64.1684947869128;
        Wed, 24 May 2023 10:04:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.124.88])
        by smtp.gmail.com with ESMTPSA id lf19-20020a0562142cd300b0061b608dc4c1sm3711683qvb.94.2023.05.24.10.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 10:04:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
References:
 <930270fbc3358d0c423357f770b679745f8dc4a8.1684935727.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add MPTCP_FULL_INFO testcase: Tests Results
Message-ID: <d566ed23-f307-70f7-6687-25d72dbc14ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 17:04:28 +0000
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
  - Task: https://cirrus-ci.com/task/4503925617852416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4503925617852416/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5629825524695040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5629825524695040/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_add_addr packetdrill_dss =
packetdrill_syscalls selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5066875571273728
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5066875571273728/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6192775478116352
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6192775478116352/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/63022ec27b06


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
Bot operated by Matthieu Baerts =
(Tessares)
