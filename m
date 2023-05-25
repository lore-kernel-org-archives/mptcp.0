Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7951FCC
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:35:52 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6af6f309613so521662a34.0
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685003752; x=1687595752;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yU4xUQPoJJyliLlu8Lea1nAC6qEUNkBJWaQB5332cFs=;
        b=Ua1ADk+pK/h7e0LySNBjkdTExaNWMHmzgIK+K7i/YgLVW/+J92PktK7lmVniAn8/Ak
         xyGrZ/NmqMm4CN0qTkOn1LmyC9/H7K2njF/IGPlCdkeIW1jErenXMMKLwk8lCsixhXP3
         qcUePSjXEyh1oBKPQ7a3FpxWkp8+I8c/aXjoP6AjqI7kU5NfxzZVd5vqFW/z3N0TLjEO
         TZaZ4VD3DojeghsJYzqTGZfNDcZSKxdT4XV8qBDM7w6fW2qM0Tvl2/wyYZUM6f3+Rr7T
         OiBcdNOxIxufw/c0sjKsehcnTguvoJI/pZv9f02mVGqx+pd+6uUu9e/9znur1pEDl5Xa
         bMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685003752; x=1687595752;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yU4xUQPoJJyliLlu8Lea1nAC6qEUNkBJWaQB5332cFs=;
        b=M+SgXjMorVlxBWTZo1lqCUmd3oZb7afqJg1EzAZQyKiZipT/3s4MHldRnSumNq+TbK
         cgxBSstoujfqtzDnegvtSJhBaD0pPI7dNb3B2/uDNoLQ1RA1jCaHGCssAENd10wSUour
         elSMMbuw/kmxwYfXh516pELphWsMGQ+CLTfK/vrH8pZ8jHIzl36qz4EKMsyj7cA9Iz7o
         HekRZOs8HhDT4AsF8qJ2xc1Nm3fUw2BNp77mYIzt0Y6BKnv1KpCjmlndpcM/c0aj5izd
         Xc7UOQM34cmJh0xsDyA77U5DUfFP1adTUI3fvLqQ0OU3ba8aEbwo2iyHHZ7UZRD0dVYR
         FGkg==
X-Gm-Message-State: AC+VfDxDNj+/BYduMggyLUElb3APRQs7IMId3mgJ/kD8BUQcW5aPgNmD
	eprFJrOljGZbbd+/FimVAg==
X-Google-Smtp-Source: ACHHUZ6YFkskd4VHdJgaSrA/qLvjCYpcGc7xLjmNZKTrzQ8LxiD8ae0jUTYsdvbvBsb9IRxIWq54PQ==
X-Received: by 2002:aca:b98a:0:b0:390:5cee:53e0 with SMTP id j132-20020acab98a000000b003905cee53e0mr1100485oif.23.1685003751852;
        Thu, 25 May 2023 01:35:51 -0700 (PDT)
Received: from [127.0.0.1] ([70.37.167.59])
        by smtp.gmail.com with ESMTPSA id m184-20020acabcc1000000b0039604194114sm298986oif.13.2023.05.25.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 01:35:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
References:
 <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: add MPTCP_FULL_INFO testcase: Tests Results
Message-ID: <996e5fcb-d6af-66b5-0902-77d829676ba4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 May 2023 08:35:50 +0000
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
com/task/5296261184618496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5296261184618496/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 4 failed test(s): packetdrill_add_addr packetdrill_dss =
packetdrill_fastopen selftest_diag =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5014786207907840
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5014786207907840/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6422161091461120
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6422161091461120/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6140686114750464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6140686114750464/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0ae31b1c5534


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
