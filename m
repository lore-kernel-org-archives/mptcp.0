Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42923AA
	for <mptcp@lists.linux.dev>; Sat, 30 Sep 2023 09:39:09 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so5487170fac.0
        for <mptcp@lists.linux.dev>; Sat, 30 Sep 2023 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696066749; x=1696671549; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvAnKx2nXp9ox0Jv0OFyXrabOwd1FnwxAlUEzA9dheg=;
        b=cj++nsB6tep6naoyhP/BHENnHRYqiHX7vlbtHlZ1Fw/DunQEd7HLtvm3NwgdZ5/r9s
         LC8VNChbHP0IOhTx/zmorsZvoTKgR302x8R93triQlgCmajUZFa7qMFMJWEbZu2U8Tq/
         mAqrQ7MKTb466EpYyHHK42BXIDPD0Q/0C5m4dcg6Fk8VU6qykrEfhWOqC7f4143ixeD8
         0E8TXLlD9bsaRi4LVa0H2DI8yr3ln96JKUD1u37uwRA1Y1MChkUqsTwQ4gV6sxJ9KNdp
         rgZ5miGdVFPFoofRf10zraQBg3xlC83EiqFHOOkM2mGxiBhfuAaYYUDHCUlFNlbnSsSq
         JC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696066749; x=1696671549;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZvAnKx2nXp9ox0Jv0OFyXrabOwd1FnwxAlUEzA9dheg=;
        b=RYLss0RIW2CnkNQXEFCQ9AKjI6ZlLoTiy0mOm1V88OQRl3ICW/6p53KQHn0DeDB6uj
         d2LA3Khw7GDVrX1TEjTxPDp6T+39gwSt4He7nvM/K4xgy5N9yiOV/JkVHMBngM42j+tu
         10g94MfShWJiEs3nzIhZ1K8zhrJenj03soVpm+xdXOHwvn98SxaRtXDzBHfgnc6lyVzm
         Y6xaE4X44jwBd/U5ezpqxzX4LZGMGMWBfjtGCXaqsv7EUM+nq2f4+j+kWjSUi8MlZoYV
         bmtXZFXU447vOceHMWtsMZTwYWJ9MkKsycc5pX4k9JFVkUucuKwQsPa3Q5OndyWhRKqA
         O0hw==
X-Gm-Message-State: AOJu0YyB/o5dLqeJDCNKdQYRyNHSwZvTGCCtST6lViYlu3uWRYNkH+tD
	0hD5EmtQ3zvx0XiB3ebYRA==
X-Google-Smtp-Source: AGHT+IHswEKeqc6XxLXjTAXpLtGcsfKwVkGOq2M1CLXAw+C+kr0aMVn8OUqtKRxzwSM3NJ6ISARUeg==
X-Received: by 2002:a05:6870:3308:b0:1be:f311:4a29 with SMTP id x8-20020a056870330800b001bef3114a29mr7322585oae.20.1696066748771;
        Sat, 30 Sep 2023 02:39:08 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.71.30])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78b94000000b006933f85bc29sm5168395pfd.111.2023.09.30.02.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 02:39:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7a8234908b8198636e231d1ce6e42ab6d5864d0e.1696062626.git.geliang.tang@suse.com>
References:
 <7a8234908b8198636e231d1ce6e42ab6d5864d0e.1696062626.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_update_userspace_pm_test_helpers=22=3A_?=
 =?UTF-8?Q?Tests_Results?=
Message-ID: <ba58134b-d106-b44d-e0bc-2762a4c3da8e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 Sep 2023 09:39:07 +0000
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
com/task/5798968668454912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5798968668454912/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4954543738322944
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4954543738322944/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6361918621876224
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6361918621876224/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5236018715033600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5236018715033600/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0bc3f9bf9deb


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
