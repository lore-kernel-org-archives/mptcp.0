Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CD1390
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 02:24:04 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-38e04d1b2b4so3080545b6e.3
        for <mptcp@lists.linux.dev>; Tue, 30 May 2023 19:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685499844; x=1688091844;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uqzlnj8hB6ht0jdIHpj+CsiIYxORREOwuidtHJZdE0M=;
        b=DbrYRDsE2AQa9XYzap0s6lEmj5Zrj3xX2mHcAEkATgD2NBI2dQhZwZKQWBcT6bxHQA
         5mIBNazvVLE5GNtCf4ljgYqkENCuXyUysHivY2RGuIJelVjW8vWm46bbwj4kBiHZxInx
         nT5Vry1Q8BTMghJB5gzBbY3/N1LFF3rff9VNJMHendYgZJw+nNb1ZJO62oiU3SEAybnF
         rrg29N1Izg0cHjj+0fBwZUaJd0MmaeuJ1760ofDlicP8hBaw2jobSq1uUB9n9zlCEIpQ
         Jx5siPI9HynB1OOrIrpu8DgsvKbFtCkJ4NyS6LJ1l6X9DogcYnTthqSeZZsoalbm1Ddk
         xvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685499844; x=1688091844;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uqzlnj8hB6ht0jdIHpj+CsiIYxORREOwuidtHJZdE0M=;
        b=X4GW+Uaw0MDpTsfNgLByNZHBLhp4qz6ofBQMvqVgfo+Qag7CfbrFvaCawGjMFCZ8VH
         Q+H2lctv7H2hjPKGNNNKLsb6EOaqf8eo4GQATJkiZTgm5CWamhVEJPtsPTusfGHLi987
         IJ/tCSUkGDwTfeE/5xZCCj4Waibhf2znuDaXQpm3gQleSJZTGN4fCnmeCc9HVTJeZR0a
         2rs2AahuJpe82SJFlVOqeqjruGW7a01aqJkMDbsYrcUNxkpIpY67ftx83LSaUCfRqMQ0
         qw0FVQXbgZRr6wiC7+lxaPltYedDufpqiMNm+JCYzOYoSdDLeDRlHyDTlLMCn5ZY6b98
         HaCA==
X-Gm-Message-State: AC+VfDyHaKVnJFIKIrKcg1MX6bcQFUWyw//jUE3SDaM/W90iUGvTKAXC
	tlYUZUwDrKN3hYazb1TudQ==
X-Google-Smtp-Source: ACHHUZ42Qr2laSKdUp/4W1/1Ez3eFuSZ4ik/LCsuOnEabw92oLQP5vdWT6P7OiFTYs58vIo5Z/0oEA==
X-Received: by 2002:a54:4403:0:b0:398:268e:4c7c with SMTP id k3-20020a544403000000b00398268e4c7cmr2816942oiw.42.1685499843865;
        Tue, 30 May 2023 19:24:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.10.119])
        by smtp.gmail.com with ESMTPSA id j131-20020aca3c89000000b0038dd5bf922bsm78346oia.22.2023.05.30.19.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 19:24:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6674159f2dbc03ebaf8d64bbf3bd2be270572939.1685494054.git.geliang.tang@suse.com>
References:
 <6674159f2dbc03ebaf8d64bbf3bd2be270572939.1685494054.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: set endpoint out of transfer: Tests Results
Message-ID: <09750f80-8aea-6684-7819-1818d5c57b05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 May 2023 02:24:02 +0000
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
com/task/4720984943493120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4720984943493120/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 5 failed test(s): packetdrill_dss packetdrill_fastopen =
packetdrill_mp_join packetdrill_syscalls selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5283934896914432
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5283934896914432/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6409834803757056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6409834803757056/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5846884850335744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5846884850335744/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/89d5d7705dc2


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
