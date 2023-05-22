Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B5171D4
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 20:28:48 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-62382464ca3so27731896d6.1
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684787327; x=1687379327;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uluf3LmYAyoqnJFJ2pYj8P9TQEjva6d+pulL8f0+7uM=;
        b=U+x2yFm3aejKhjOhqzNmZbvCmqwW+1crKk4590lyofgprKHA72qhwxJcKburJawsnp
         pTdSSSkEdRocvoP8GcUdm4tAOvhsx/5vWJfzdB628VVrEboNvUZzY5eD3OwJegr2baOH
         VjaTAe/bgS9fBxzcD7RgSuzREp6tDxN+eVHWrz32GH1rrvDtV9XVxeJf7v9BHQrj6KPw
         1rfXPeHEpeWwHD8WB0n/w/ceQNKyqCve7tT4sxfGTPHMgNJ3rAsvvufhjlnDJSyl/Rtl
         dV+IHg9U0f2fphar7u4N8RdbIKgpCHcXXYdabBbbFPdc+yOdkSwuXRakrDinqFb631SN
         UkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787327; x=1687379327;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uluf3LmYAyoqnJFJ2pYj8P9TQEjva6d+pulL8f0+7uM=;
        b=Xrk3bSBignb4IBY/IvVISfLIsb2GxNtWJ/vrIS9ww6libsEACd2Db0L5J++yQk+0gH
         zFC/4EkLr2mM2T4BntUDgoEbwAro+NtViibnKJ0T5W1soC1wHiV/IgWKN7t14DNcsZTF
         ccqyCEOncSBuK0Jx6gU2ecb2BajMrpXhx2QnUc7wjRm+oyvupqnbbYtm4lmWFYV9P2lA
         qq5xqRLAgg+4o1C+txiTz/iDSBnl3XXOghGPkpurKZCEI9mbSVBzqclWibqqoPkdbc7V
         3sEUZ7xUh65Rfdh7ykfYTVYTWTu5oEg56d3+PgbxuIHGXrkFvStp6uIMqPHG+AyGm3Dp
         hA3A==
X-Gm-Message-State: AC+VfDx5HnXfXSd0OtbZZLPwrqLvulMByE3OK9x6oyULDzHqsWSgyBzD
	rbfuchFY8irtlS2zJ7SjbbOR9fLNuu4x
X-Google-Smtp-Source: ACHHUZ7udSy1hWtV8haJbeDbCqiSIZmBpjDOGA07F7ghalLvx/IQAfvRXfjn23SCQmH5M08Ke/vMQA==
X-Received: by 2002:a05:6214:27ce:b0:61f:1a72:6c89 with SMTP id ge14-20020a05621427ce00b0061f1a726c89mr20113852qvb.34.1684787327538;
        Mon, 22 May 2023 13:28:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.6.24])
        by smtp.gmail.com with ESMTPSA id z17-20020a0cf011000000b0061a68b5a8c4sm2201852qvk.134.2023.05.22.13.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:28:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-37-50313e4f83ab@tessares.net>
References:
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-37-50313e4f83ab@tessares.net>
Subject: Re: selftests: mptcp: join: skip mixed tests if not supported:
 Tests Results
Message-ID: <d51c1eac-d7c5-fe83-eece-6e43f6602aba@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 May 2023 20:28:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4875564574572544
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4875564574572544/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6478117737332736
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6478117737332736/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6564414434836480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6564414434836480/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6001464481415168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6001464481415168/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7220c4c22b88


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
