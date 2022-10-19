Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB84C72
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 17:16:49 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id l28so12109768qtv.4
        for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5vo7jMyu5yK21EYSK51EvX+g5bKbddLTabmcA88cCA=;
        b=UchE+oj1iCDYQhiHLF6k60Sq8URPXNTTuIw9LyULURCbifJesrzNA7UXQSwxky+rCo
         92BekSn9l01YJA47tSxYI07lGinBBYk95xMAHey/aRYFfze0H8vJ9Iq5BJthwtjZJ1VA
         GXYXfEpf4Fk0uT+Mmd1C2kSIIfBfPj5/c1gaT3u4qaXH3uA/YVBEcvfLxSPOiz5b4loX
         hWCMg4Z2Mk3va2jHygrTmkJm3Es3btnVzPZE4ZdmAqJFsQOufFxwkoIgMUce9zKuW/RA
         yuiXqPMyaSDAYT1obKKuEAO7YF0VSaf2KFUQCKnWinOVrFj0dMk/8sdYh5FiuB2UlkmX
         Jn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w5vo7jMyu5yK21EYSK51EvX+g5bKbddLTabmcA88cCA=;
        b=XqmpLZ4T8KfH1FDcAndFYi/mv9mfSfdGn7moRZdb9ZsX19XPE9oIG5kShfdVEDqbjT
         trsqWWyfTG2IAGyj9+PBOgjAwXggXcygwQu9absi2khwO5bd0APsDOBFxVXJiY9r5qtg
         Waadli4Y3qPgmYN3Dq2N3SAWxUA2W/V5xyWj98Haqu2ukeAcI5g4nQBY3S3Z1CXAxxMS
         5dbk9qJTy+06CRch4K/2p+paup5ldqRmRIi6np82YTzC9N/lnCtCvqiE/A+PCQFBK+Zq
         cfbkhDvkt/Mh2bUMQ+YM7IDS12x05KSZxwcDzBLnpK1KvXayklistjx8reyBPtHUQ15f
         NvUw==
X-Gm-Message-State: ACrzQf2979qiz58EIPCHbFIIlAjjvmnVlYGhFwKuvBJTb1NlhLx6TJx3
	OyYE8SBLHPuFn29T1aN7LQ==
X-Google-Smtp-Source: AMsMyM5C+KC/YhOE4fW+VzeP3NCVVmLW8uFqJTZ0KXCgZ4C7hZART/LRnmzN9lpoycbqjBLRKJD6OQ==
X-Received: by 2002:ac8:5792:0:b0:390:ee6e:5d1a with SMTP id v18-20020ac85792000000b00390ee6e5d1amr7160095qta.631.1666199808150;
        Wed, 19 Oct 2022 10:16:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.0.31])
        by smtp.gmail.com with ESMTPSA id n12-20020a05620a294c00b006ced5d3f921sm5431845qkp.52.2022.10.19.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:16:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <dafe09ca2e14c4ab45f3d9db56b768e06750e382.1666173045.git.pabeni@redhat.com>
References:
 <dafe09ca2e14c4ab45f3d9db56b768e06750e382.1666173045.git.pabeni@redhat.com>
Subject: Re: udp: track the forward memory release threshold in an hot
 cacheline: Tests Results
Message-ID: <cfe73bb4-df4c-c2dc-691b-dfb458437c9e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Oct 2022 17:16:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6084002971910144
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6084002971910144/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5521053018488832
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5521053018488832/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d7a7d2afe372


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
