Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD24C7A
	for <mptcp@lists.linux.dev>; Fri, 15 Jul 2022 19:58:04 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id v5so4447157qvq.8
        for <mptcp@lists.linux.dev>; Fri, 15 Jul 2022 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=8nW/hzl924tiCtZ2qR4YZNnS3tu1XaJFDTxtvVKqOuA=;
        b=Ilbh+IL7sbiIlTf51/ocjWldA0chsvwtVD+JJu6FAPiIaClrgZpDlDK7wl3np11kqM
         lHC2Qe6JZf5jl/S2Rwcbrklb6tn3GLZueGyS6G2ynXi7aRA/Zb0rVWHk4m4p9lz31moI
         vXmpBWDbhbbKqeDg2CODCVfi61yxIXF7OSzRS/fOwpMCcN8exeWH0ILx7KKODP/FENKs
         iwVfOiAiooHJFjk29wYSSvVxn+vv8naZ9z5Dv8pAge6exV2YGkujU8NmkkZD3cF6m6GR
         cparhaluT/WIvcjMHTtfDS9eKNmQbA038Tjo6CIuaBG4xzkiUj3FS8DDdZqS7lPjfkj0
         y4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=8nW/hzl924tiCtZ2qR4YZNnS3tu1XaJFDTxtvVKqOuA=;
        b=zHLlwZSQHq/a/sY+QA9NkQiGWIm/2zuO4CJ62ZZZWhkW9YDsmNkjTWwHjsBVG1NCpp
         I0mKRqAXELqehxauAZgLkUHzdI/pN+83qTggRueDX1Cqe354rCKHMjkraoaXWWL7Ho7r
         a1PDTKsUkHwxkroXnk4G8KGTHMufgJTtd1g0fCpvzCa9jr3lAzaXbjLyP6KfgHTT87Tw
         ZwAYVkcfwuqI1iTMm/XLyw0zljJdytJ1XPH7d8YE65j/llDnlrMqi4CN6hYTaRu3TkEP
         YEYOycIAfImO8lfYuM4ExOlC7PQiCjN0nn1BLFSI//DzvUfYe+StZL7zV+F6OaqQ7DF+
         MyYw==
X-Gm-Message-State: AJIora8+QFt0yCIfKMDfd/QSh4U0d6pCsnBnjrhV7R+EF8pu2AmYFhOi
	geazUwJwth5ltue0eQrRpkYof8RXIidsY/c=
X-Google-Smtp-Source: AGRyM1smvoIm9mrICey3Zfer89FE/Q7vD64Px9yfbBGYy0EOG3lbvg6lPnq4/4jRl/irua0celC3XQ==
X-Received: by 2002:a0c:b258:0:b0:470:5709:4007 with SMTP id k24-20020a0cb258000000b0047057094007mr13251592qve.83.1657915083106;
        Fri, 15 Jul 2022 12:58:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.42.196])
        by smtp.gmail.com with ESMTPSA id do16-20020a05620a2b1000b006b5ab88e544sm4785483qkb.124.2022.07.15.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:58:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220715181207.522021-1-mathew.j.martineau@linux.intel.com>
References: <20220715181207.522021-1-mathew.j.martineau@linux.intel.com>
Subject: Re: mptcp: Do not return EINPROGRESS when subflow creation
 succeeds: Tests Results
Message-ID: <9a8e0dcb-8f63-e0db-8205-70675d2fd1c1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Jul 2022 19:58:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5658593952268288
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5658593952268288/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5095643998846976
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5095643998846976/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9d357564def1


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
