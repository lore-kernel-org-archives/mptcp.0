Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350041426F
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 18:16:09 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4021451a4a4so8492141cf.0
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688062569; x=1690654569;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrLgzVnq9L5yHrIbPo9Z6mkp7xJNDuGIoe/Hpyk7s5U=;
        b=YPNYLGILsO4uiZYa3LL7pbI2Ghc2y0pza4aEAuNvcKljgsdCdHGOuhd4JIBGU9Fwtp
         eLxfRo65FrazZn0L/G94+vSpYMJsqv7u7b4lCmqvWr3wJXgo0vYrLbWqYaI/AeB4nMfE
         /za2e7acPu6B1bcwn5L0+VqZ1PbOitibhRqNxO3NaTmqDfKid3e5nbSUYGE3R+hWT5+9
         Jd6dbCcm8i2/46EfGZOEMnknzfEfC7gfAwTvA7XZuwvtwBVHhblNg9S//q6L74EiXo3e
         PqEQbTSmSSC6LB7PkVaqPaGtppRK1TQJQB6dSIAXvFvXUpCgtRxOS4ILWtSSt+d38o0/
         gM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688062569; x=1690654569;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nrLgzVnq9L5yHrIbPo9Z6mkp7xJNDuGIoe/Hpyk7s5U=;
        b=AgS6V8NuT3fjD0mU6IUiFyOvCYRKRXPZ7AUwG+oE4xJL+vsgPOivzAvE1MucnxTHPS
         B3c2WwINaM0rxUTMHOgqMG+qUqxRzhB7d8R+CGz/yuBh8kiPwykgpBPaOy5lBeQyYUfb
         rbOiXa8u9tkegOlHHUvrQLUbJ06FBaw/nNdOOXmkzOFI4yDUEuxDj7z8NJFXfRBxFqst
         IjPv4KnoairRvFA6H2F9bdeIJ6HkuIRf5pLdAnNg4/84uYfF2ZKTUA/Zk/TwdqNHcRWp
         wHCfa7fSEqmY4rndFZ62TieY18icEh/3+zzPR5ipZRCw8Ztu42sJtop0XN9ScRuGOVYu
         2ReQ==
X-Gm-Message-State: AC+VfDyJkJJYPUBm+3fJ8e7+34IukuSoT1VaaGsmP1GqDf/49nwRax6I
	Nx/CcD3ppOmvMcyzHG5aqw==
X-Google-Smtp-Source: ACHHUZ5cG2nZQjH+OdxsyBtr4yuHjyV9FVw48kZ+m3dU9DFE8p+76uLkzyJHiA6Cm3REYlF7eUzAXg==
X-Received: by 2002:a05:622a:56:b0:3f9:adf9:a708 with SMTP id y22-20020a05622a005600b003f9adf9a708mr235327qtw.44.1688062568860;
        Thu, 29 Jun 2023 11:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.233.50])
        by smtp.gmail.com with ESMTPSA id y16-20020ac87050000000b004033c3948f9sm113602qtm.42.2023.06.29.11.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:16:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5276902ce9c5492bd2029fc3b46bfcb927afb18f.1688004307.git.geliang.tang@suse.com>
References:
 <5276902ce9c5492bd2029fc3b46bfcb927afb18f.1688004307.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add mptcpify selftest: Tests Results
Message-ID: <1655e94a-b677-a306-e758-320cab0bd9e8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 18:16:07 +0000
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
com/task/6390325636235264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6390325636235264/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6576252639772672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6576252639772672/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4982950752681984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4982950752681984/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4831537535909888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4831537535909888/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b4e806c4ee0f


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
