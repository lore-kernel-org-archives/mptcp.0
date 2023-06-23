Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AD8F5D
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 14:08:50 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-763a2e39b88so56963785a.1
        for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529329; x=1690121329;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q30isuormgi6dbtNJFmx1u6pgeI2UySEaYp5So5Sfs=;
        b=XnOyyBy+ZtC/RvKMdy/ahGZ8rtmXYI+hyf2STOZhdQH69pEGHudxy272YXWjYrsnkt
         PyzhyqGPYDYhYKUJXxHnREu+gLFpSmfQS0kxVjTOue0Ab5FeiKBxXS2qqHBNOLtO0fwp
         U/pYGZDbCGxb5qFxPNSz55l1FwvnszgdwWQYdVCzaztdWedV5L2SkaQiOZe8IxaK1+ye
         InJvNNwkbek/YWGXrIcBHqnHeUC2XdscqG3GOtF9fJAFPiGwJaqghAjmC6B3k1R9HLGH
         4TZCIJIwBuQCG4Trvy9mIa1tkgedSCr4jbd2vAGnWnbMUeJiRtlydcgk0qONAkZzpfYy
         KuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529329; x=1690121329;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2q30isuormgi6dbtNJFmx1u6pgeI2UySEaYp5So5Sfs=;
        b=Xu4GN5PYHX2l7Mh4b0cgX6fNIHeDrWWkv5fEtdCq9jkyD6uA3vZH57VPH+a43neOPF
         C31euy1McVTK8Tjq1m4vwZ8XDC4tgKqk5Mn5AolZNlXMzPSAtHvcQFmA60pwy/sqePy+
         XENJv+1R5BLEhozs57Eg4/v3Vh3I6YUPcJpzsbPfDNaqj9enCDUJjFumT63CAYoTkDwb
         kKrxpD/0rTUT2fpbLEAdAYB/akigxlqhGyzjw2TdR3g5HwZIaHIxkKN6HvMFWbIq5FVW
         uKIrCX1gm7sjvyT9pDzMQZQP02WfbIWjPSA8HdHxT44sgMfLgx1zxkokvccHA9HQJvUq
         rwVQ==
X-Gm-Message-State: AC+VfDyb4WFZ7xOMeJvafqQZ/eQUKYlNlzWPiP2bwrVDMKmVCX4YlpEF
	X3q47KvGHY/dB5dAiR8rWg==
X-Google-Smtp-Source: ACHHUZ7RWUgcbrCLkK4VzCwjCWr9hKN6/tSLkkYoHjbARfia2fyeJPYJNNyM71KjJ+P2G4pMHrM1wA==
X-Received: by 2002:a05:620a:44d0:b0:765:5441:3193 with SMTP id y16-20020a05620a44d000b0076554413193mr1094052qkp.6.1687529329162;
        Fri, 23 Jun 2023 07:08:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.217.71])
        by smtp.gmail.com with ESMTPSA id 15-20020a05620a070f00b0075f01c8f0d2sm4550670qkc.92.2023.06.23.07.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:08:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <70e1c8044096af86ed19ee5b4068dd8ce15aad30.1687522138.git.aclaudi@redhat.com>
References:
 <70e1c8044096af86ed19ee5b4068dd8ce15aad30.1687522138.git.aclaudi@redhat.com>
Subject: Re: selftests: mptcp: join: fix 'implicit EP' test: Tests Results
Message-ID: <df6a23ad-23d8-7096-6db6-cc6babb8cb06@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jun 2023 14:08:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Andrea,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5461583669755904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5461583669755904/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6587483576598528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6587483576598528/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5883796134821888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5883796134821888/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6347206848937984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6347206848937984/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ae11ceb10975


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
