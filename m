Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B4362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 08:16:09 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso1391366pjg.0
        for <mptcp@lists.linux.dev>; Wed, 01 Jun 2022 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=WVbYLELo8WO6C8P38V8fzYu4qfUri3A90Y8kEyBUex4=;
        b=h9k5vvd5RyCcTu/JiGwAGITG2Knsj1gCLlItrxUc3YSZZz6/AELKV3HAzJFx1HFhZ7
         IlnvIX4o8J9GkxkmtkhI6xL8icLDJZw70w5845ZFOiNs/qkzOyYB4cmekJjSqP9xjJNg
         Tn2xbrJQ/HE9tLf5mIJWK+JYvAWmS7H54ikJ9/vZSOUJD9zMJN35V0xfIXfebySSwDPy
         zKItPGA3wb5ux/uDXgs3ohx+6WQq4PHr2sCeKEi8TjUqJK5MS8/Pjqrlid0Pjo9TA8Tk
         iibJ3dk2yRUZQife/iDiQ4UHJ3383Qz1Qu36wi6RfEH7c5MLtw6TLIElI+zSqN1Glyuy
         v2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=WVbYLELo8WO6C8P38V8fzYu4qfUri3A90Y8kEyBUex4=;
        b=XJICJYAd8st9vS44dTrqD2eJNd2VyDcdmTwdpJxpgMxFSyTJF+2Ink96gc6MlVKNCa
         Sg7pqBBBchhlht21lLowT0ZR5ib7aZIMPPC/LUNSP3pjQ/lAb7+Qaj4Ovwakcq5grQZg
         3vrqWTIJ8897Jt/vAjZJsrZfBqNN/f7MRDsuPAq5NSDm7Dq1iqAX6P8ohnUUTzM3hun5
         S/x85QqHf3cj3fhuPcWZG9ZCW/fjCfr6ExL3kyvY//gcud36fMevs0DAmFh4061T2K6u
         XYqCPm2C7nCZaQTFycAezOeCSmTBFFUZXUvka/KH/XKWgmzBr7eErbq3tV8Vj8Z8IQVd
         YCSw==
X-Gm-Message-State: AOAM531KfHDUiaHwy9vjfd/l3nTq9h5poQQftxws1ePKkkw9F9az6mZi
	0SyHyjm6lOTKSk7zJkWVsS9ce9NIWCR2+GA=
X-Google-Smtp-Source: ABdhPJwoG4eT6B/xb1c3LOl9pIUkVzrn20wbVONm8KrZ+NR2EqL/jjDfOcEzRmS3ZG4MACZ3FE4LaA==
X-Received: by 2002:a17:90b:4b82:b0:1df:e6b4:1fa4 with SMTP id lr2-20020a17090b4b8200b001dfe6b41fa4mr33554354pjb.46.1654071368526;
        Wed, 01 Jun 2022 01:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.135.233])
        by smtp.gmail.com with ESMTPSA id m12-20020aa78a0c000000b005190ce2839csm799864pfa.122.2022.06.01.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:16:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <076285ed7f05ec809cfb5866c6ff2d6b8cd04e95.1654065674.git.geliang.tang@suse.com>
References:
 <076285ed7f05ec809cfb5866c6ff2d6b8cd04e95.1654065674.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Tests Results
Message-ID: <c90ab2c8-32ec-a26f-ee72-21ebc275bf1c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jun 2022 08:16:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6448318602543104
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6448318602543104/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr selftest_diag selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5040943718989824
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5040943718989824/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f2e8aeb9dc5b


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
