Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC115A7
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 06:31:59 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-62ddb103debso6064706d6.1
        for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686637918; x=1689229918;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bcv/gRlhULTwZ2Z7A67x9mTgL3HU+/FUWmEhvvd0rj4=;
        b=q6OG+BrqEGbgSU9rqUmZRDmulv4LEXMEucAnC1kGZKphqt7dVJqVt5Iz/pYI0HRJwW
         JQe10MiOWy6fP+tG+ZtYWKhwSOXciNGjZX7/9achniLkqi2pnDapo6rCjw78yLx+zp5+
         IUdzBZBl+09ueDADyg5S8/USBPzJehG+UvyB0pZx8rl2w9cP21FAeDE0QYkma/CJncRM
         RSe4Y4J8juqJogYnBblwpbH/wfJ7rtxyba9dnIszTYer4LotcjQfRdf8xRBE86Os611S
         hjFj08bh/8ugAobEou7zSlFnXvCtokA7fU9qw0mRsxt02BcMDPuWpGXsOBxWUb6EdcL0
         /p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686637918; x=1689229918;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bcv/gRlhULTwZ2Z7A67x9mTgL3HU+/FUWmEhvvd0rj4=;
        b=QIU8SGqSCjU9UBcoIFjHVR8RRd7Jj2CK6whwuhhlx5/mPtQyDybTfl1a1x5xwFKUQd
         ZLS/Wkk7L511Puq86tbS2o/tEJvrFvBXxMzLtPBw5tN5cCq8Mxbn04E6OTl8X/ZYSzXF
         XYL2yT+02+y81Xw6DxRZi6I5WxRzenom1yuSXPer1CDnQknVUWyr9dLZOe0z7lyvSTKR
         Zb2pEzsYn2ZCtQusLggoB4RVEKG99Ob0gEf+PjokrgAbjV/ZWCLiDFdIf1u5T+tHMdQw
         VnrpGuLmsKzrbS+DSNA7M0oSuG0QTpc8W3w0fDVCG0EvfNtiqJnEOWCkMzuchGn9m8Xo
         SUZg==
X-Gm-Message-State: AC+VfDyuPlUcO6rtj0Ub2QlgKER+wq1H23NJEA2UV39HtRr7SezH0BlY
	paQw7yCzsZwtLNpvCSVDlA==
X-Google-Smtp-Source: ACHHUZ6GVjUa8VU4T4/RY6JHrarSKG4aM1rSQ9bskBybYpg8wVfAEl6WRl2Zkc6DyZ5/3kFrNZxPaQ==
X-Received: by 2002:a05:6214:c67:b0:61b:5afc:d4be with SMTP id t7-20020a0562140c6700b0061b5afcd4bemr12061801qvj.7.1686637918329;
        Mon, 12 Jun 2023 23:31:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.123.244])
        by smtp.gmail.com with ESMTPSA id r16-20020a0ccc10000000b0062de242c287sm1969264qvk.51.2023.06.12.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 23:31:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3787039ef2a3501d890221740d2118d585eda436.1686634037.git.geliang.tang@suse.com>
References:
 <3787039ef2a3501d890221740d2118d585eda436.1686634037.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add pm_nl_set_endpoint helper: Tests Results
Message-ID: <252c0b10-4e0e-567f-966f-debe70e0aef6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2023 06:31:57 +0000
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
  - Task: https://cirrus-ci.com/task/5087412494270464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5087412494270464/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4805937517559808
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4805937517559808/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5931837424402432
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5931837424402432/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6213312401113088
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6213312401113088/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1258cf4a1278


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
