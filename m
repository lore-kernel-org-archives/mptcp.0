Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F101A629
	for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 19:40:21 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id jr19so1567570qtb.7
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 11:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/Ynn4JnMi5XzrHZjlJ08o+A3l1aJU6FvcWZstY13LQ=;
        b=H4dJsBl8URKSRKyj7z6LIWAm4oKae08Uw7z+DDPrTkdz9gKAXvwg1Yiv8N59LkkKJF
         hPQlPZ99Gx3ZKofdJU9Jy3CZ159v0yMrMyd8iba2DNksfYZu7IReqhPuh2iJYSi5oot/
         48Mj0/ieNs1qj8Dl0liXQ0nxKB4cCOW9f8guJ8Lb6N2dLGzjMb9LpRmRJs9YQMMO4Ljj
         sh5KcOoLG1fW5E/GqyQYvwb2A4kd4D3hUZ7+cHidThfCEzVx6Rpf7Bh3NSGnhh34WgDH
         HPwQ8R4lhrGpWTq5aoXtaHwFmZxThTl1iP9KjFVFX6Pq/hPCzUSmKovffCrOjh0LQyeE
         FPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/Ynn4JnMi5XzrHZjlJ08o+A3l1aJU6FvcWZstY13LQ=;
        b=aLZYvcrG+FUOk82q8hh4AhmooNkZrB7+ZjEhRiGnosljjBrIpr/xLTtamwE2DA15Nr
         FH+xXKGcSgaJyvQudTd+ya5/Okzo916U+aPWxAGW/dVSNxb6tctk+U0G9wUTF+DFxy0O
         2ds4n3FS8eyAIFWb6I+IgrGUkoovckH+7BJ7WgCEKfl/JgxkBjAORdB2o2RymAbUyJAV
         0eKxmjXswxxlUfOkytOxml2n2nfJql98iUR1sjeVw1qCIJe5vvY+EiWlms4Xg5lHTwgr
         5Eel34QheIM6UmW+3aFWUu+1u5u+nzXz9nLG0x5y8gzAQpyaspOXi/Vmtj5J8ElTucaF
         SEWQ==
X-Gm-Message-State: ACrzQf1CRyUE8UouaMxMUjzfm3h9CnlBKKUdkL3tkoHAQ2T4MHQ2J0ye
	qm1d6DnRdraBAV+R1I9Lnd+AqYlj3qjf
X-Google-Smtp-Source: AMsMyM5gbivQoGVggiOStZtfpzBHS9qvYjN05YcRKV0+wBhWQBkCG8+CST+f5V2bf31zQLQBzinJLw==
X-Received: by 2002:ac8:5a55:0:b0:3a5:7f7a:9d9a with SMTP id o21-20020ac85a55000000b003a57f7a9d9amr21183522qta.543.1668109220736;
        Thu, 10 Nov 2022 11:40:20 -0800 (PST)
Received: from [127.0.0.1] ([4.227.237.41])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006b9c9b7db8bsm99499qkj.82.2022.11.10.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:40:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221110175857.3953994-3-matthieu.baerts@tessares.net>
References: <20221110175857.3953994-3-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: declare var as local: Tests Results
Message-ID: <b4dadfc2-a735-793a-a819-80a5d588da97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Nov 2022 19:40:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6014466983198720
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6014466983198720/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5451517029777408
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5451517029777408/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1b8440e198b6


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
