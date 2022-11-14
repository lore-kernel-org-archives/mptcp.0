Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF679FB
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 18:24:01 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-12c8312131fso13426571fac.4
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 10:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb0bbkILKMuC9gZ9g9dOa1gJ361UD/kmrFrA1kLeM2s=;
        b=c7wBfSCmX9vnsaXbWgLp0YYj/0VbYbI5c2MGelPG0SutLJTZ2gaSqBSDDSfyrQnPgG
         e2GHjkgS3McjDhkPkg2ZGibTt270tyWFvJKl4kReokg6cdVe9tEMArCTAhLuErc3avl3
         3kVBxA6sJfv7CJKwK/547UlhgND1b3NHhMkn11CCkgiQ7JjCO6sEYxkyxqPyPKnq6gS0
         xneQgUXNRJrUOc5otQXoqb86cgW4R5he+hGc5ozlfp+GPBhG4KpswUalXZ0pUmf2shGv
         kC3lW1PjJPXEh23xq8zZTuA2Erj1pftEdPaLD+v1Trfig4U2cJ371rP2f/qrG3KO7G/5
         PmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zb0bbkILKMuC9gZ9g9dOa1gJ361UD/kmrFrA1kLeM2s=;
        b=gqqikx5nGJkyfmqqTrcZxL9ttMKkhODRy2tjOiLTxCzJDPMTt0QOjMR0OPkwCURIzz
         4v59Bf9+4+nIIzNokMZEL5j1hzXL55Ng7t8mr4iibriOeM9+AVAbzDmteId2JZZOVcj1
         KPnae5DIO1NUwP1OdztgooKYNM/4Eo3lqNU74FWXvg8MW+AqCVYubVkhAQWlEHjLvB3a
         Doyc8R70NuXwuj0yj5E9EZr+b99RrH6y3I4YGlL6SHeOB6vpsA7yYGSTgNbtUrywqHUM
         CtgRaiE0RrLs7bzUktm8Lsh+h6Hp/hPRuS7ysmzpodMvuqam3AMRHTkkVblj+Gw3gZvn
         85Fw==
X-Gm-Message-State: ANoB5pm6DORSAWXdJ8JGAvw62yqRQiHLtpRz0KNEEL2GUi5il0p5svAT
	zB57NiQlGvBf+kbFFSXTYSAe98A8nVwn
X-Google-Smtp-Source: AA0mqf75xRB5bbHYLfc/aUFB2Os9LkSrGkWZA1jLuAWjAZuHT/tYz6XhtwETJPtEU9ylnkraJG4QIA==
X-Received: by 2002:a05:6870:8186:b0:13b:d07f:f29d with SMTP id k6-20020a056870818600b0013bd07ff29dmr7634923oae.96.1668450240113;
        Mon, 14 Nov 2022 10:24:00 -0800 (PST)
Received: from [127.0.0.1] ([104.214.109.130])
        by smtp.gmail.com with ESMTPSA id h8-20020a056870d34800b0011d02a3fa63sm5274975oag.14.2022.11.14.10.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 10:23:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221114164601.861295-6-matthieu.baerts@tessares.net>
References: <20221114164601.861295-6-matthieu.baerts@tessares.net>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22selftests=3A_mptcp?=
 =?UTF-8?Q?=3A_mptfo_Initiator/Listener=22=3A_Tests?= =?UTF-8?Q?_Results?=
Message-ID: <22628ad4-c7a0-98ea-c680-9ae73c30faec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Nov 2022 18:23:58 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5358371401367552
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5358371401367552/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6505649375281152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6505649375281152/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/55019258a7ff


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
