Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76D117ACA
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 14:46:09 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-75afa109e60so271864085a.2
        for <mptcp@lists.linux.dev>; Tue, 30 May 2023 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685457968; x=1688049968;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuGT0391/YiyOVVljW77mF13n9LKSMPacBNPKzjKYaM=;
        b=c/KhB/RWx81aVuvbunnjoSPm/oCYB4jd3iESPYBriGNHUgNun9httV8KfRUSC4KhG/
         8sj4N1q+xzIZkhQ+6HXT0GbvdreXd6HHXaxvIwiMk1rvhQ3PCdgXTtxcxlEkke3aMXRO
         kQtEBNKCa+o6l78RAy63+++I99YVauggqsRcz6rRsg+pskwYIviTlRHWiY7qfn7fJPOW
         wpKYLWndzsiO6tmjOIudCTP75+eP7rZXzo0c75bTBQizpqqNiZdS4jvjs1E47G5c/P7J
         XwkX9bd+hX0wlHaJHUHy1z+INgAcGKjZEvnFoTCD6lVXM0gZOHOOLJyWdWnvNKfcscUc
         owsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457968; x=1688049968;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YuGT0391/YiyOVVljW77mF13n9LKSMPacBNPKzjKYaM=;
        b=WyD6wUzTMsMrljBijU1aZ/pnyBcdFJJqOXFZ+i0ICK/APMtNkc5Az/CbnknYaqGNyW
         2mH4cpKuX+YZSmealecoHrEak/HToUsohuJvPAJ9/J8GsqiLwUuYPp88FfTebxx34m2n
         9T7RdzIOYDPaIZn4yNXu3IdTXS2JkdOq6+CgQpFCBjUr6iRJTvUQ8KWvHu4oqWeqg/1E
         3H0q0+8hC8hsoWhbFuEtOvjs7Pih8Gdh2CrkxLzL/bH5wXGZ0U8498rzn+2Sol2/SsC+
         z4e/NcADvVWKRAiUsN4c5ibyB+a4gGN8UoFu6H7EnNFQA0ge/PStjDeCJbiweoE86vRI
         g1gA==
X-Gm-Message-State: AC+VfDzQ8HikIOwrbeLOvbaB6MsozZQC+Z3MsTWDppLq/bpjz857Grt4
	/CmkaYvciNp7ZlExl8Zxyu44A0mKP/Sc
X-Google-Smtp-Source: ACHHUZ6HBSGhpbroDHTLZ/C+H/RsXHynVmsExusm8G5iT5SSGejZ14RtWt+oKy8Pow/Pcp37hMB+Rg==
X-Received: by 2002:a05:6214:2627:b0:615:a787:6d2a with SMTP id gv7-20020a056214262700b00615a7876d2amr2646044qvb.3.1685457968569;
        Tue, 30 May 2023 07:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.233.49])
        by smtp.gmail.com with ESMTPSA id jy3-20020a0562142b4300b00621430707f7sm4672125qvb.83.2023.05.30.07.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:46:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3be9b9fa90210c4543212c088bc7b4ebe4dc8ece.1685452619.git.geliang.tang@suse.com>
References:
 <3be9b9fa90210c4543212c088bc7b4ebe4dc8ece.1685452619.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_burst test: Tests Results
Message-ID: <eb9e5322-42f3-b155-4b58-19849ed15d04@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 May 2023 14:46:07 +0000
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
  - Task: https://cirrus-ci.com/task/6149320072757248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6149320072757248/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5586370119335936
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5586370119335936/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4566023328759808
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4566023328759808/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_fastopen =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6712270026178560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6712270026178560/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ae3dad1762e2


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
