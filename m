Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E715D0
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 06:04:10 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-74e1745356dso137302385a.0
        for <mptcp@lists.linux.dev>; Fri, 05 May 2023 23:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683353049; x=1685945049;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDlm4FqE6Hh7j/SwfmMbzvaSIcAUEBiFGChESIR7CFI=;
        b=eg2M+TmIJic++fCXV/wT2UwuXCCNk5kS9puNbBFHTh9bRJdmahj5v4N7Mkr97oeOno
         El3VtsNnfnlLbF73hk3F4FNnAOVK0zJ0b0Ju+jwCdsEWAOzeNmCbLZaC8Gc2ZAaFxOFl
         EDg+wPiAIYF/JBtcj4LDoHGR2y5BnC6+4U+QuCn611d8bGfJ2Gfg9MT5A6mx5VimVaSY
         q0Q+sw8dq7BD0BNFYYcMqDO56FvJ1xiF1ilbHkTtmIIFoo8bqZ3i7nyb4xXIxTP25UAN
         E0dX78z8nqP6PbnUkHG6ja1UC5KeiVmP903X8YlsVXDlhhKvE8U/lRaEiUWMlAmofKpw
         8Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683353049; x=1685945049;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDlm4FqE6Hh7j/SwfmMbzvaSIcAUEBiFGChESIR7CFI=;
        b=KSTwyBphWXRoWCJkCKf38cMTnoKReJU4CC3mg+q/RNt/JnHBTgzkBuyaSGLu22K7gT
         MpEkCeEsL3DZkt/jSt/YAxriRdqjjHGcSalX+CQg9ZzH2iePWKmLT+zB046foVyvkogi
         ZC32qE24Mbqs3ID4KI53n8ei/kN90S6BrrY/l8v2RMPt2bxguDjKdhtROGx1rLqj4gyx
         XjYYvhdFNnFpcgmGRewgwTgGOXIS9LHKpFLLTuzzR8SrS5PUicgFuR9n+6D0YzXB+jty
         rQNqJR1YtuOUO2n56DWOz95frtvUGVnX9uJJSToREV0fD+q5EJ49/1tPWWMtd28Mq0rq
         YKMw==
X-Gm-Message-State: AC+VfDyw3lPsSZf8gqMCabQEpDQ4t3fULB3/4GOFnJMSfbZlTmXE/ugL
	XleXE1OFhgcD+1SB9Aos3A==
X-Google-Smtp-Source: ACHHUZ7CXOUBpsDSkaK+sR5IL2guT3HwwycVT/LKNs6uQ+53U/XPPWl2q4hDRh0QSfAp8Ks/EJHjkQ==
X-Received: by 2002:a05:6214:27e8:b0:61b:5a60:329c with SMTP id jt8-20020a05621427e800b0061b5a60329cmr4280950qvb.39.1683353049303;
        Fri, 05 May 2023 23:04:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.255.7])
        by smtp.gmail.com with ESMTPSA id u16-20020a0cb410000000b006210d4d5277sm223069qve.21.2023.05.05.23.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 23:04:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b38c982aef1256dc235a108cf0156a66ee3053dc.1683349666.git.geliang.tang@suse.com>
References:
 <b38c982aef1256dc235a108cf0156a66ee3053dc.1683349666.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: do endpoint manipulation out of transfer:
 Tests Results
Message-ID: <fc8d4fb2-5bf1-95ef-dbd1-1d7b07198595@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 May 2023 06:04:08 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4872423376420864
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4872423376420864/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6561273236684800
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6561273236684800/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5998323283263488
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5998323283263488/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5435373329842176
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5435373329842176/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ff090e8a1d83


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
