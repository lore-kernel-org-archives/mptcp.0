Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115FFEC1
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 11:07:21 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 184so12786392pga.12
        for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=nHtPuuNEoh7wQdSY3GeC3BGBJH6kffZ2CKxfmtndIKc=;
        b=G0kM13vTCI/YsAzqx2Up404cqOAxZUbF4UlPAVVfjCR+BzutyY8GVaqXYKTRjR6wKM
         9/WWkbHJwvD9/i0g52w3zHZDWnRtI1+c4Lne2PpZZX+zMR5TLcVmyX96zocjRVflg5db
         JqT8IL11LayCCI9L0UAi2/HzjsRwvkftSNIfxMFfvYcXmvglpt172zKLINcqn35Xxodj
         SuzyrCs12sIadesYB5th11ZuWamZ9nIVdBEMnj8Xx64skX0WxsFHfd4kbwQbDoN7PcxC
         pf1yWU1ufoPIaG/Cx9aPj5JRD3mNg10Kv8/Pshv1BYKZLMWNFicQVQsMBzeMrdOqSEeJ
         Su0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=nHtPuuNEoh7wQdSY3GeC3BGBJH6kffZ2CKxfmtndIKc=;
        b=chl6QLdmBRFr4MhMdMBBUWVO5udlGoRWkJM9Yjnj53ptUdLwI5TU94MV6rRnaShQqo
         JRv4Po2MAMpv8Bk6UocCAYdoU2PASRSYUXneXx4W8nTugWKBRze/+QiLPLfj3a/ZLLIy
         j8jX4Ck8//6F1NALHNz/IArd8syHocFYyfczVg6wo0dnck+1r87+kmqXizcyZmEy8Swx
         J2P9/t3PbzWWqxAQf3xisdIIEhcSOnaApPSDfnTCXvlfGs0htKJgForWujlOA8PhJbPq
         xj5lDgFu54G3hexOKo+0XJnry7hc/0toEKWPYpSKt74tpF1Aqeihq0SuZaS7jSu9FeGz
         F2eg==
X-Gm-Message-State: AJIora+egYgj2LlmkJ0p/XO+PRVOBTE+0hqXsGSWfBR3YzPTjJZj1jcw
	KQCFrmOTF3IAvQ/65BuKOw==
X-Google-Smtp-Source: AGRyM1tkXi9ZT+Yte/9YF/SkdWCw8Py3WqX/fLCexUgbfzFG6eqnxFrJYCcwRBcibdpQQjEbCsktGA==
X-Received: by 2002:a63:3d0c:0:b0:40c:950c:398b with SMTP id k12-20020a633d0c000000b0040c950c398bmr13232572pga.58.1655809640274;
        Tue, 21 Jun 2022 04:07:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.162.240])
        by smtp.gmail.com with ESMTPSA id j11-20020aa7928b000000b005251ce498cfsm4916426pfa.191.2022.06.21.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 04:07:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <23316da1666099022ed050bfd6ac2540aeeec198.1655804700.git.geliang.tang@suse.com>
References:
 <23316da1666099022ed050bfd6ac2540aeeec198.1655804700.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <e3c0481f-3b4e-45c1-36fd-92b474f6a93d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jun 2022 11:07:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5666112380600320
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5666112380600320/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5103162427179008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5103162427179008/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ef10ef82aaa8


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
