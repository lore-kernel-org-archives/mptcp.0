Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A5632
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 12:34:12 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id g184so1033580pgc.1
        for <mptcp@lists.linux.dev>; Thu, 05 May 2022 05:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=ZpGqO4nzYeea6gt0zS5DfT0vrRrKGiVZT69Nzx6g0IQ=;
        b=ZSJ+/bbyPsAHq19lRbVbZ+J0MCDNmyXVUBUKiMcX+HJ/+hF9I6cjzSnzLsvCe1OsY8
         ghA1hsgucA6PFJ29/nMeShIAmAEylkzzUTNmtu088BWlUtj9xndkJJaWy4Cvs/mql3kt
         DV/mAi/bjQDnxBj3K+1tGUmVWMFccaeVpHFKCtCcarUTV9OQoxYzLKA2BAdLnZ5oaGIB
         Wbbdo90KMdvq4cDLTi2yXcwcgsLH4lB6BJ2NQJjNlmp+wLoVTx8C+MIaPHfqEtwWY2Ch
         DVXdm0uQM7RveF7yflHPFSUD3AesYoVzl5cPTqS356R/AF1y3/N/AcSMuh+LbMaXUevb
         AcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=ZpGqO4nzYeea6gt0zS5DfT0vrRrKGiVZT69Nzx6g0IQ=;
        b=VsME/KfzDiNEqAsXty3/YT88v2hMwaesY4JemqDGKtUD6POcN5l/Y6/lK3g3P/JCpq
         PXHCvKuKTout6thrVynBdwmzovon+Fuo2X7qhqgKJ+1xPzbEA1CqBIooYWXvVtApbeQ7
         H+OkgLAAjuM8e/N8yGLm4gmYfjleRvD6MUG3ZqMNHRQp4GywI9zwlcNfQNicvPLEvPXJ
         2Zwv7U0TbS5NuGSBT4JrqDD4bLY7H4wwf+hGxYrzZyjU9y29ilJ5mlpc3L34ZPW8qmGQ
         dhmV1SuvjOiV56q3sjPRKZSlb08ptst9KK9mBoVKCRR9GcHuX6IohwbrcMNxI8pMMYQ6
         ThQw==
X-Gm-Message-State: AOAM5337PZCa++68CNNPgvhUlYjhfv67X/dUmv4V3lTk6JATTYJngl/u
	yfzrefrfkcOnSSrZKR8tDg==
X-Google-Smtp-Source: ABdhPJzgXezUwb1ol4S8T/G8ft2e+gtd/WGx3ZFH8k0WhMSXwcxuMSlRNgL/aSM+BaJNgKZe+dkB6g==
X-Received: by 2002:a63:8449:0:b0:3ab:5075:d40d with SMTP id k70-20020a638449000000b003ab5075d40dmr21938664pgd.12.1651754051669;
        Thu, 05 May 2022 05:34:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.228.114.85])
        by smtp.gmail.com with ESMTPSA id o11-20020a056a001bcb00b0050dc76281cesm1230647pfw.168.2022.05.05.05.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 05:34:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <YnOu5xlGgE2Ln7lj@kili>
References: <YnOu5xlGgE2Ln7lj@kili>
Subject: Re: mptcp: fix deadlock in mptcp_close(): Tests Results
Message-ID: <4331f1b5-f193-1a9d-4b5a-7508d574200b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 May 2022 12:34:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5570153533407232
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5570153533407232/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6696053440249856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6696053440249856/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6e6958f5c0e6


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
