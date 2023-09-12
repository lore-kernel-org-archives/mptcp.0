Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E314436
	for <mptcp@lists.linux.dev>; Tue, 12 Sep 2023 17:14:19 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-770ef903e80so213297985a.3
        for <mptcp@lists.linux.dev>; Tue, 12 Sep 2023 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694538858; x=1695143658; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLIllFb9ulvnuTW4gq3CNlr2lICgt1y80zVfTerOhaA=;
        b=DSgTwS/chrXhvCAE4UeK8kRAvhU3yLwFuiDYWnXMQVjd2I+59ixWjYzXvT6g/xuEWi
         oaiYyZdKvNgrIhM5Xf8NALv35KTQvGpQmzVln+8XZfHK9hHHg7trv/6+es0h4CegYnTc
         XxavMoAuRYu6oLD1Du37OedaOjAai5DjJvEHKXIGdnE70mhrCsc6stS5j4I+DroINi5x
         sNgUjrEJYMx4b9bfzkBB3f1JFL9ptr0tDoyuRHyisF3v2CXIuSNNOP/XpRvgjz+vFyFv
         D42CzJJ6re4S6ga3q4dWPspwxGBk5H3VZf6zIp9UBPBg3RM/Qfs+bX7OtlTs2A/GrQ9I
         LZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538858; x=1695143658;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pLIllFb9ulvnuTW4gq3CNlr2lICgt1y80zVfTerOhaA=;
        b=CdW/GDD8Hm3B+srtcu4WsmLS3yvrZPEU7NGuKHGFVEgn4yY6iqi3UhVYDEQCWVhPqX
         /6/nsm7ISpbBL+n1mYJs9/hdA0yeq0LxSkgbvkNMyWM+ssUrxsg56IGna0Q2MNZZ75Qp
         g8PWOM6DK0IhTnCtuXiiFqvM06V/WWo34RGBHn3Tuq4kDNmA/eeAc9Q302yNLJ6ilbuZ
         MZJ8nY3wqA3hgH+H2HEItmFd8UwWKjd8ieLz5Yv/5unJKFpLY8gqBroWwZtZDVXNCyVn
         I3D1SZ+zus4j/yxS069tdCkV/H1TnF8z8AUcuL+wMUCe9ChJvNpoTjIso82zTF5J4L4r
         jrQA==
X-Gm-Message-State: AOJu0YxUOrO36Lt+mNeA3I+PCza1rFch8G9gOPM7iOAImTS/bTrNDYni
	aqk7Llsg4qxNeQQPUa2wS461NTd0IQ==
X-Google-Smtp-Source: AGHT+IF5+dScrTlHP/D42GMlUeDhKXNm0wJwz3b45GU86GWcJ+EkM/26A1PvZ1ardqkwkj6KpfFIoQ==
X-Received: by 2002:a05:620a:4114:b0:76f:1614:575d with SMTP id j20-20020a05620a411400b0076f1614575dmr31941qko.49.1694538858210;
        Tue, 12 Sep 2023 10:14:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.6.29])
        by smtp.gmail.com with ESMTPSA id a16-20020ac87210000000b004035b79860dsm3423625qtp.81.2023.09.12.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:14:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
References:
 <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
Subject: Re: mptcp: add a new sysctl for make after break timeout: Tests
 Results
Message-ID: <45cb0680-1ab9-3da1-df6b-c86179eb6d8a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Sep 2023 17:14:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4801624548311040
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4801624548311040/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6490474408574976
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6490474408574976/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5176171298553856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5176171298553856/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_dss packetdrill_mp_join =
packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5364574501732352
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5364574501732352/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/342f5ef28368


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
