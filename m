Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B917E
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 00:36:48 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id mn5-20020a17090b188500b00246eddf34f6so2108056pjb.0
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 17:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681259808; x=1683851808;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB7QOkkW6N3JTmDwmmf6eAieT7UdIGXZyy4ObqUVB4Q=;
        b=j/+bpvf9LZaFqpe6DGV3FLkxyKaaF1gciayXKpuhlRoJ4GfvKBr+hlbbfff+JtKAzw
         LaHZG/RjMCbDSJJrhv9HB0GSNGwEKF61g83fNjYVKAxOKVRyExRR3w0fzvybrVSFkdcN
         g1CrA00tp/ODCSMdtr+bbQ6OfZGhNN8Dy6XIj3YtYRHUxrwqXr76hVaBj5WCnhRGM+vp
         lJWEhuC5QnEKxVFtkq4fJNmAk1vTHv/Tbrl4J44VGGRTzf7BQ2807pgnea/l1NNMf7np
         rY0Q8km89gwt20udA7dmGwNhm/KHJygDcZlCd2Daue/o0vtPdo4BAVTRDhuZ3xffLF0/
         Ze0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681259808; x=1683851808;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IB7QOkkW6N3JTmDwmmf6eAieT7UdIGXZyy4ObqUVB4Q=;
        b=BegJ51QjwQjK/lG2HOxC1D7l+ZaVvzxmMz9HJejW1JNDPaiGF+cGJGkD5kO+RzAGwK
         rl02RmUYOQ8tpx1McxkSxOproWVjLGG8q6lF80J5BgtNuJHWgL8wGdaqKbsyvPOL3k6J
         CwPQ3xpF1+lmf8V4MDnORfRbubZC6SJVFqB3JXdqytfbnGkYJznSo8lB0VupgmkBC2Mq
         gk9RWivKHgK0MKzkINMQOUciREACPCSbaNnUn1pOsEAUEiREvB4Vp3H313s76e4WYoMf
         rodgRbHqwmtrmDJ9p05GJzkYBihNLc8A2yAHI+svirDycKbYa3Z5QzPJzxIFdBPpIhP/
         OkoA==
X-Gm-Message-State: AAQBX9dd6ArIrTbKiPaKMmjSwY5YU2EuXMrSkvasjDxpPY07SiHk64c2
	mIDaSfHoIyTtMAbrFuyxHA==
X-Google-Smtp-Source: AKy350ZJ/GTKqVRg505bxXaX8d7dpUAT9nHKIm0bLscnPu0Q+L1/aRGaTSVcBsBt8vYI/XPOav3Vkw==
X-Received: by 2002:a17:903:280d:b0:1a2:8c7e:f315 with SMTP id kp13-20020a170903280d00b001a28c7ef315mr15787957plb.21.1681259808160;
        Tue, 11 Apr 2023 17:36:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.10.193])
        by smtp.gmail.com with ESMTPSA id bb10-20020a170902bc8a00b0019cad2de86bsm7545924plb.156.2023.04.11.17.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 17:36:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <484c6fbff67a4587215d88e17f3a6688eb2c9ea1.1681256534.git.pabeni@redhat.com>
References:
 <484c6fbff67a4587215d88e17f3a6688eb2c9ea1.1681256534.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22mptcp=3A_fix_accep?=
 =?UTF-8?Q?t_vs_worker_race=22=3A_Tests_Results?=
Message-ID: <ca2d2cd9-1e3a-6ab5-e249-3092f58a3aef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Apr 2023 00:36:46 +0000
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
com/task/6728750830714880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6728750830714880/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4529727575162880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4529727575162880/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5655627482005504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5655627482005504/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5092677528584192
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5092677528584192/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f3b6a3c53df1


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
