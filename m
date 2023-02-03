Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEC1863
	for <mptcp@lists.linux.dev>; Fri,  3 Feb 2023 09:12:36 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id s8so1100347pgg.11
        for <mptcp@lists.linux.dev>; Fri, 03 Feb 2023 01:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REHFOUHk/w/1aCcOlNasMjfToK6BSbWkyacvOqZ5ASU=;
        b=XqyjSKQaO3i49YehMJtjPw798dgnBXGofr+IYOUhv2N4FfqoXRmDftTs8zSBcuqptD
         YAdOlGpwSsVXiVPkRvHq4Eoj/fUXgRsq82IvjxkKFl/qKH6OwkigTo9Xn5WG9L2RxqQc
         ef8atl4R5zW8dvl1qxUDpyiyijEiqwbR9kP6qQzOTG8x/g3qo5iTtW0eJ3PoFW//Hwej
         iqBOQOQ8Bu1vsjDsc3X37WHFuaAu6I3xvx0NhEM5o1LMGBIe0z6k3sLV2GQP1VWbw0do
         qb8cuYFdaxNleAwgJppSCBYv20bYtnP3mR7Dnfe1dxDj8lBwDe9oHMLFemdKiecvOXnb
         PqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=REHFOUHk/w/1aCcOlNasMjfToK6BSbWkyacvOqZ5ASU=;
        b=Z/zbmYxjHXaZQ2s6vBjPJMY4rsC+kbj03z4WiY8PgqJspcDkLBLhhIR9ZiHMp4xda1
         6CYs3lFmh/ucp7qXF3TJOoqD/5avW5yOoFYN/NH2IYYSpJQzk7SAzX3OnixlgbZ0U9Xb
         yyHPCzElci1BvDY7iJZojheOaqHMVTpvhyXnuTMUzUGHdEVDMoieJt84IOc601f0xcKw
         La31s4rUTsMSsvh/UxBkNA8pVJYbp+RBf4jmvxvx1JqddPgW4YybjX6Neb9XDsad2dJA
         YQ+6Ze42v8IuofzQGdrg1YZmp2LgZCUU4h9Dkm+bdgeJFS5zByrhBpRkeNN9yNjgcnNO
         PHdw==
X-Gm-Message-State: AO0yUKVcV9EiWqoPEc19aWm0aySzE4JV7dqoc/e6O1f3UIryTZmMqiea
	e/EEwO2w1cSuQ3KyLu/oJQ==
X-Google-Smtp-Source: AK7set+G5vlEjf5tqU4w/8d5UxnyXI89CCrckOXU6wgYTTaiDbxKfuOK9v6kIO1LBSDvVhfEqyrVaw==
X-Received: by 2002:a05:6a00:1142:b0:592:61e2:f598 with SMTP id b2-20020a056a00114200b0059261e2f598mr11190365pfm.26.1675415555857;
        Fri, 03 Feb 2023 01:12:35 -0800 (PST)
Received: from [127.0.0.1] ([138.91.230.179])
        by smtp.gmail.com with ESMTPSA id o185-20020a62cdc2000000b005815017d348sm1193736pfg.179.2023.02.03.01.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:12:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com>
References:
 <7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com>
Subject: Re: mptcp: update userspace pm mptcp_info fields: Tests Results
Message-ID: <1c4be86b-58df-b84a-61bf-18d12ee994d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Feb 2023 09:12:34 +0000
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
com/task/6186399657885696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6186399657885696/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6749349611307008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6749349611307008/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4510743937155072
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4510743937155072/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5623449704464384
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5623449704464384/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/546f0a06b189


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
