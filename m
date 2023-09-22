Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046FB27709
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 17:35:38 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-690d2441b95so2079652b3a.1
        for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695404138; x=1696008938; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8TsEHD5TuFC/fnvTrzMTg5PGN+b3Npu4xy/vbJkYpk=;
        b=AdpPagKIOe6NCc8ZmU5Fk6+ZUPToorcnhy+92bmO7m4OnoyPCdQAkoq9SoCf0zdop2
         orQERsYqT+ox7UXyuTAePnnvF+q63lxb+JN2RvkcLD7M8aZz4NAxELiAgzjfCj/4Xbwm
         hTasjPYVDAE2Z7VRYL/R77gFnlow51ZGkWslKHkzlOHOwJk/JLnXcEmyNQsgk5PP2L0/
         H++RSVcewUyK+cLQCN4HguiqLajPjbuZlPbNcfNPIdWkyHJmUlbPGmepBkfo1YAechNv
         cUxvg4tZrD8g8XdjI3stRXcyuOtEBOYsu9yApeamBdVC1Hg8t0K56G/Wc9qtkMf4qI4v
         AzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695404138; x=1696008938;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8TsEHD5TuFC/fnvTrzMTg5PGN+b3Npu4xy/vbJkYpk=;
        b=Og1Dw0RSUE5uLcbY0v+Mrla4t54nmilKWkzcpqDvI0AwDxt7TR+EdXheAbpQKVVS6W
         rD+ChvTNd5qFE73MLrzhBcpF8YRxmR8PNjSEGUbZcj3F2BO9ParKmq8F/OtxyWEZNT4d
         DdWNNPf2Vi0Fk5gHehe5+9c15vvD392Uaw81RdLxxc6gZNVqhY3Rbr0YDpf/EcPciYOp
         vAQqOgSF7s9c7Rqrberrx8akNV9noyReneOjwQBQO2Pq7tZlsEBhRsc7E5ymJs2raZdn
         Iouvgk+Z1KmMlK6dJKVKIBkIOc4+TU1UXOhZ44tkkFHlIErONcp8YHvSDYijARaE19Ef
         lN5A==
X-Gm-Message-State: AOJu0YxoDvFE9HB4oQygWRTy7TiDtrdDz9eFqTzmnv4ZmI11GJYrmbvR
	tGRXL8DNqpz9G68a3IBwDw==
X-Google-Smtp-Source: AGHT+IE9WUExJYMZTGvY/FGDQ3834YmU6mh3IuXRynXRUIry7XQmD8OUaZ4pCUStqEdeVv6mP3M4Wg==
X-Received: by 2002:a05:6a20:9154:b0:15d:b407:b0a0 with SMTP id x20-20020a056a20915400b0015db407b0a0mr479359pzc.26.1695404138290;
        Fri, 22 Sep 2023 10:35:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.161.18])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7880f000000b00690d64a0cb6sm3465514pfo.72.2023.09.22.10.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:35:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6e31fe305493173f6c2e33f6351da074d9068a77.1695368456.git.pabeni@redhat.com>
References:
 <6e31fe305493173f6c2e33f6351da074d9068a77.1695368456.git.pabeni@redhat.com>
Subject: Re: mptcp: refactor sndbuf auto-tuning.: Tests Results
Message-ID: <8acb8ed1-4173-9e70-dc5f-e21d405dc671@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Sep 2023 17:35:36 +0000
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
com/task/4847632003104768
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4847632003104768/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5410581956526080
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5410581956526080/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5240710329270272
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5240710329270272/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6536481863368704
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6536481863368704/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6ab9c14f575d


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
