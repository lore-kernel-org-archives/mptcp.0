Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A320F4
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 04:13:35 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-5ed99ebe076so2850226d6.2
        for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 21:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681964014; x=1684556014;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XajnOyZHDgDYz4y9bWbx997qPGL4s1VhWv+BjjPTMTg=;
        b=givIPmz0jd7aKs9dwhhNu4pRx6MLHg2RVS2LyLMeRWU6OWVpJDCrfgl9wLgN7p4bFA
         j/Nb6li9jmESGejnoQ2WGBZzMdfMBET3em+zWr6zp1p4UeDO3z2hO/yI4dvk4g6lv3vb
         Cvh9Eu/UV3KuRl5xRV6LdGSlu4H0O2/JnHaTqorv0WhWOEuJhDQAkq3UC0iiE0IxS0vN
         6/mNeFmwIyagx1s/WeyPsAYIBY1//5ihUjR43nXAGTOlQHzLYXw/Ih8R4YOF78MpboYi
         37QxpLkrqJdT67Nq+5OeVKJCSVwjuPrgPSINJQMERGpMaigejgnHarlXPcTkZI8KxHsW
         PyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681964014; x=1684556014;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XajnOyZHDgDYz4y9bWbx997qPGL4s1VhWv+BjjPTMTg=;
        b=A+YZ7wMZw/CeIdgDulvAaCWcu6lp8C4QzsK8/QXnniT/nZmU59LxhBM1ki/VajScjs
         f+dqj19HU6FDBQuAiFA8XEhGG9W1K+fObCR+NNUKT3Ltwp2aZpGMIrnvmvo9N4C6VOz+
         XrEv+N1NhrTcGIiGr5SjwFyGjNDxcl7aG923cp/lU2r8R/So2jN4YkBQHU4ss6g61Dha
         UEW9FGcPKySeGuTm/SFcBs2kLOnX0bucCypYwU5xXXEE+SP8Ju6AIDRAgz7JMXlIW1at
         1cRdVeiKGVp5ooPvsxunTFRcEqTuN7K0alss02djvq/llvmAOaFk5oIZXkI8KfKnPyig
         OBrA==
X-Gm-Message-State: AAQBX9eL6edUjLZgSd6wwVzX4reLz0X9DV7cYNNsVT3eSwGO69q/Iv1O
	DlVjKJgv5J+HH+kc7ihVAA==
X-Google-Smtp-Source: AKy350ZOgPQM9aN8tsNJaXtC8TAxU3mHUhxE4zXLbvVuyHcH14tTs0V37r19ZlX8ERYUM4YLqFWqcg==
X-Received: by 2002:a05:6214:da3:b0:5b8:6efe:77f4 with SMTP id h3-20020a0562140da300b005b86efe77f4mr1844716qvh.46.1681964014734;
        Wed, 19 Apr 2023 21:13:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.226.28.166])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a214400b0074d1d3b2143sm135664qkm.118.2023.04.19.21.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 21:13:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <177f9ca7d30f810324bf46705ac7d977461ffc2d.1681960259.git.geliang.tang@suse.com>
References:
 <177f9ca7d30f810324bf46705ac7d977461ffc2d.1681960259.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: update userspace pm subflow tests: Tests
 Results
Message-ID: <08841cc0-4d7b-417c-f33c-48322842a38f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Apr 2023 04:13:33 +0000
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
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5458994014191616
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5458994014191616/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6584893921034240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6584893921034240/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5881206479257600
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5881206479257600/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_sockopts =
selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4755306572414976
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4755306572414976/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4f0513e3d53e


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
