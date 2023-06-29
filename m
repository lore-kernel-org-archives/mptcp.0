Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10FFBF1
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 22:01:12 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6686708c986so1125871b3a.0
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688076072; x=1690668072;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDBgY+NTS1dDLNmVkRJVZwLOicTXukuP2fhLq3oKxWU=;
        b=QNqBgPf+0E+6qTnbRQijsFHRQ3gLKebpfe962DQ0ZMSDZKfPnQlfJFUOluhahKJZeD
         3l+O7vZ6NJ4f8L/8v9aVCRdZ8VRQU/A8XVHjdbkhTbfKldJaee5X3o1o0JmHRPPh7B1/
         dWH5/pD2hhu0XuKW0MawcTzTLw1+tjWoEefoNlHcV0tzsVzS2roJdoF1JirL6KRVnPCq
         jWEcV35/7o3Lqpn9jBBLb+kiatzzLpFcqCb+zpUcZiih9rj3P0rqBvuOH9XdSkmC+J5/
         eKLhDqdUEGRSFYECXX5QxQoVjsVBs1WKH76Wf1Frnm4bWlSNzsT/jLgBYmduAqH1npA+
         EErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688076072; x=1690668072;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDBgY+NTS1dDLNmVkRJVZwLOicTXukuP2fhLq3oKxWU=;
        b=X3Z0dqRPHyLPwuOw/8DXQvHly/IhTC1/dppf7aZTjO+5Uw/74uJncpyv9mR6s6jxLn
         XHaBhNre1k5Ul2xGKr9wfnXf6vSFjj/077rr0KCHPTDW9ASkQB0KeWg85zP+Uh+Y4FFb
         YfUdkCbM8UzJuz/J/1JDyRh6TWUMEEVxER2beQVl2dC1cHdQyvFFTpwBN5hCtRh/L2vm
         bM2ynqz9quW++58S6hWS8Y8YH0Fq3tPJ02T6smycYsnk1VM3+PHxWnz1jMA6XkAyC7e4
         gmEs8zaYCTn16WeFEbozVPqfGPts1ZinLACQ8frJHtcgCe1B0b9VvlrJ+RrYCAQE/auM
         hvKQ==
X-Gm-Message-State: ABy/qLZXFbwTM5suI0tVgrq8k0qUy//UJn6A8kk9aHjEHA/xjqVI/mfa
	qr8nvToap3p8mmpVm0JRzQ==
X-Google-Smtp-Source: APBJJlGpz8lvWGhUWhI4tHjkcpQQZHyhdxW8VFyWEXjg0dmvXIQRVjEkdUiAPNzEXNeVtSUyN8co0g==
X-Received: by 2002:aa7:8f18:0:b0:675:8f71:290a with SMTP id x24-20020aa78f18000000b006758f71290amr1193468pfr.34.1688076072144;
        Thu, 29 Jun 2023 15:01:12 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.81.224])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b00678afd4824asm6577191pfo.175.2023.06.29.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:01:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230629170551.3043312-1-matthieu.baerts@tessares.net>
References: <20230629170551.3043312-1-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: depend on SYN_COOKIES: Tests Results
Message-ID: <bcf51b8c-61e1-63e1-3f0e-e630fdfad4ce@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 22:01:11 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6364453776654336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6364453776654336/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5214121377923072
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5214121377923072/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4739152520937472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4739152520937472/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4725594617806848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4725594617806848/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e5c49b1c15ad


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
