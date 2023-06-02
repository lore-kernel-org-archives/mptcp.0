Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620FF107B1
	for <mptcp@lists.linux.dev>; Fri,  2 Jun 2023 11:19:13 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso1682901b3a.0
        for <mptcp@lists.linux.dev>; Fri, 02 Jun 2023 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685704752; x=1688296752;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttwd8xHzv/c7dgp371owuwFerz9ikZJR7y9zMK1hMCE=;
        b=dwWcxOdLLjqHrZGqPXqSqz44lG4mcintkd1oJO67pKVXFIatgjBszUpgvOdIInUZFz
         +yqFBhMiA4N9912j9VFMQ3zva2FRG07vHiKrhasHl6OQbFKByrwK2mpXkQs0NSN359Cz
         llMGiJLSwPn9Q5Ph5i3orD5ffl6vuRFHiOGGqus269Nuk9ChGrYyskdCCEI8M9VGHZQD
         Jg2dutqVzDoMAsJOQ2QrXY7xYN01V8/KpfqkX7GM7ERC1ZKQ36Otv+G0vcPwvohgeiy1
         tIVbLvxaqb5vWTEUyzsnxn3t+6f1M9/HeDm8+jjDkpYWWi5zHTvD5+pur5Mm1DSV2zqw
         qZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685704752; x=1688296752;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttwd8xHzv/c7dgp371owuwFerz9ikZJR7y9zMK1hMCE=;
        b=J6Uf3foMHm10TVcpbQXrt32+DnAMAmt4F3bEFfcV+2TKppaS1kotwhqpXCQUhzN8f1
         i9O1Zz73zpPw8aHOkYZqXMzHKuZ6IOXoSsrZY32mY4Ea/yyMOo8fxHIerMxC747w4soH
         AJguL8EueYlaef6WOwT9idYJLH1BLYwUIm0JvFVsUvS0s+DgNp0b3pUSkxhWX5lztsl+
         DLbgVyvny9cq/WQnhAwD429Hgh8vIdB1dGmjHDKVwdLzeTe8Lzs9vkH138gd14NR+C2i
         O9rC/yb6GDpq0aDOZoudYqHTePFc6lR+3iQSf1ZHukkuueD/g+5Y80Z1aV4ipLfZD5+W
         tk3g==
X-Gm-Message-State: AC+VfDz9ddjMb6zPhhipSR5Maa2Sv9Hzoksm+kWGZ+LM9Y37AqRLsxg2
	tM6bqltKAO9e+jZfSGbprw==
X-Google-Smtp-Source: ACHHUZ4VsUWXWv2R45c06hZ+iSF+6uD2axLq9+ELAgMH6dQ0CILCqpnMB6TCIdPYscnaPPjumLWnlA==
X-Received: by 2002:a17:90a:4bc8:b0:255:67e3:98a with SMTP id u8-20020a17090a4bc800b0025567e3098amr2072280pjl.11.1685704752451;
        Fri, 02 Jun 2023 04:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.99.65])
        by smtp.gmail.com with ESMTPSA id qe10-20020a17090b4f8a00b0024c1f1cdf98sm2901218pjb.13.2023.06.02.04.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 04:19:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
References:
 <20230601-net-next-skip_print_link_becomes_ready-v1-1-7ff2b88dc9b8@tessares.net>
Subject: =?UTF-8?Q?Re=3A_ipv6=3A_lower_=22link_become_ready?=
 =?UTF-8?Q?=22=27s_level_message=3A_Tests_Results?=
Message-ID: <96921df4-41fc-ac72-c35e-f9c91092e739@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jun 2023 11:19:10 +0000
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
  - Task: https://cirrus-ci.com/task/4819198161977344
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4819198161977344/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_fastopen packetdrill_mp_join =
packetdrill_sockopts selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5382148115398656
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5382148115398656/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6508048022241280
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6508048022241280/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5945098068819968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5945098068819968/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/29577f44821e


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
