Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770D8C16
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 12:04:33 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-62382464ca3so13506016d6.1
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684497872; x=1687089872;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXTQCRIzTAW5E0IrZXpEY1NrMsXlUmAiJUSHSMZICog=;
        b=IWQ3bVnUtL2zqD+Qrz0mvgq2dIUjJURNrEhGY0t13EjL/B5KCVnTxU8sw1CTm99u+0
         DLmmffqZI/wMwJX3NEa8A3b20emnwQUHxBmsRMyYmjCcZDDDxpmrCV2RbbAaeodmUakR
         57KTmORXLS63ni8QtPGzhVd/aXrAUTHELzAV8i4uxgaEyaBTLlCLRQZTZQaCTz5OPIjn
         DWFVOiwlH+pmRVmlO4Ef1t+7M+2Z0QlTXS7xdG1XwW0Hdm6LLWnuOsnARYKQtPRnndc7
         NosoiqI78BSLiB9crQXXVcMmwEOgNw2WNNDRy0RT/FqFTcFmWDbJBSQ7u5liCEiI7ccI
         2a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684497872; x=1687089872;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xXTQCRIzTAW5E0IrZXpEY1NrMsXlUmAiJUSHSMZICog=;
        b=MRnifuVbUnlIN5oegiqYbOZMfd7BWKw+vO6j8ABwZeO0Fo7rXkodjASCUqAYnNjc4j
         rKOYBUBUdoQDFN+xvnrqkWP3VHX0rEM+NnZueKeXr8lbJVJE6quNzHCFdD9c6h6Hheui
         /WyjMdDmEKE8MBBFzvDWbK8gj67+hoHFSODDRqIbX9DljeFhMbmj4diYO+qIDr6JmuQ3
         l7kzZZnQcUU5oaTxbbgB3D6qIYvixOei3YkEQklmdCiet2EagQmd5WacE7OICkaEgVpP
         O8VNi3BfnjH45+WU0dloONO/4nBr2eto+kQyoAcxzkg3HD842VIKQu+NCRgwjUla+1r1
         4MCg==
X-Gm-Message-State: AC+VfDzoyhxqfcWL8wtHkcQM/xyIFW5Snyw5JMgoq5n3Ci0ZkXwqWBqd
	k/L0DPGz9rYKrNNqEwYD1A==
X-Google-Smtp-Source: ACHHUZ5nXpAoWMJMg6DhYZCYknTmyV/3JQZ1Y01OC1d5e6n1O6hm/mHaD7y4SjxXTqGfnLbHFjLBbg==
X-Received: by 2002:a05:6214:3016:b0:621:700b:f9e9 with SMTP id ke22-20020a056214301600b00621700bf9e9mr3830382qvb.3.1684497872274;
        Fri, 19 May 2023 05:04:32 -0700 (PDT)
Received: from [127.0.0.1] ([52.226.113.40])
        by smtp.gmail.com with ESMTPSA id pp22-20020a056214139600b0062106d10b9bsm1257230qvb.82.2023.05.19.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:04:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b2f6b47d2d9d23bf00211ed098c2f0d3227175cf.1684362296.git.geliang.tang@suse.com>
References:
 <b2f6b47d2d9d23bf00211ed098c2f0d3227175cf.1684362296.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_test=22=3A_Tests_Results?=
Message-ID: <1be7ff2f-0b30-3a18-0b68-2d16c5f599c1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 May 2023 12:04:31 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6168255878922240
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6168255878922240/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6731205832343552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6731205832343552/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5605305925500928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5605305925500928/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4532182576791552
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4532182576791552/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/abe0cca432fc


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
