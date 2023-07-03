Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6CA34
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 07:52:10 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6b72c4038b6so3258986a34.0
        for <mptcp@lists.linux.dev>; Mon, 03 Jul 2023 00:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688370729; x=1690962729;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2OYnAX6sWdkomy/vqCQPu1oxQQsBJE2y7KVuii15cU=;
        b=CVGbKtlQ0+DsAgmy6Rp26JIaC+OA6otWMGEU7lcTvAxAJU+esRljhwyH6H+th9HZNi
         61kqqjnEF6Q87Yw+khB4uYz0SaEXTcSY+nO1CpmkaHIstwYh56MUn1zGfH/MPdDqYa09
         Y983dQqSu/ZYrNDFYxsZXYM1Cr6mJvRzy0k2XbBZoevt9g0nCpoHHpWPJoj8wJu699Et
         lTTrqKcQKobr+VusNyHX74UNyqsklJewTDNC+NloNTdk0ZRHajLYo02f1ZZ+oD+suBaI
         bLA3Yy/jJqpEfi4HbmVmlJTy0t3swrfI2KL3YCUDWasVWZcoX6WO0bJgX3ENcV4l1sKK
         b8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688370729; x=1690962729;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2OYnAX6sWdkomy/vqCQPu1oxQQsBJE2y7KVuii15cU=;
        b=VJ9fjIJaLYjILYG/w0x3gp2olfVZ2f8YPDHrblu/NzclFU4b0jf7UC4GhDm8ApyFLU
         oyEGNkX7sONM74hJ5XTO+bwgXm/OogEHYUJ8IzAxjZJ8EX8vx1nL+6KuvXVOVlkNvbZQ
         orbtiBzizlC7DtPEvdC41xYiLCkwizx3+biPoJ+hzcolS9S7Vw5ImM6pr56F+Tz3yO8u
         NMQjbInVynGUF2u2q2tjYJNhqOKXXUzei4FZ7cHm/NFKsB6voD+CqQSznGjB0o9R46ZA
         nNYHqd9jJlXH5zhsY3HCqjSSFtuYwDuWdM+vKfb2OfqbkO9YVORJJTuhADPBSWp+W52p
         +o9A==
X-Gm-Message-State: AC+VfDzZHxHeuHWKa/tL5AKg+HohjfxXvjxRrxYHx+8eckrfFAbEtiQY
	Bb/WGgjFUtDirEaJS4Z2LGKMfzFjPA==
X-Google-Smtp-Source: ACHHUZ7fD9iMeD58Fi+E+FfHe19sPcoSE+zE6cyZqYfa3jHZynQ4Fx+h578aGMI4RMc5Kc00BrLZOA==
X-Received: by 2002:a05:6830:2012:b0:6b7:1d64:ab84 with SMTP id e18-20020a056830201200b006b71d64ab84mr8527207otp.14.1688370729203;
        Mon, 03 Jul 2023 00:52:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.168.146])
        by smtp.gmail.com with ESMTPSA id v4-20020a056830140400b006b8adf1bc0csm2480362otp.33.2023.07.03.00.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 00:52:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e8796c911cf43d2d27c7d29d152bdda8de3dd284.1688366249.git.geliang.tang@suse.com>
References:
 <e8796c911cf43d2d27c7d29d152bdda8de3dd284.1688366249.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add mptcpify selftest: Tests Results
Message-ID: <1fade44f-45f5-d063-5dec-568babe6439c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Jul 2023 07:52:08 +0000
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
com/task/5904799128879104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5904799128879104/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6467749082300416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6467749082300416/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5060374198747136
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5060374198747136/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5341849175457792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5341849175457792/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/de52c09fbaf4


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
