Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26316FC5
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 19:17:08 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1755e639b65so12589160fac.3
        for <mptcp@lists.linux.dev>; Mon, 06 Mar 2023 11:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678130228;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCGLcrdpvFfQC1UWgZ3N7iSs8nemFqhBhHOShJVKbT0=;
        b=Iq9174xo3kMZ8xYRI8iAvl4ufMPkCz5Iy7aEuZB/6uypCN4yjmAUADPEeXqqQW/qNi
         Gyv8nx3vEAnqUvZq7PB1nhD1BTfhHdiUJUX7FnmBkOtu7IJrqD2R8lGjUau1pfxxwWV5
         fOv+qYPZxMiUt+JsopYGjeGwHIvbif7b6bYhiGUaePDuGsgjdJCwy8w/s6FmX8LUgCTH
         V0WLew9eo1ujPlfPlHEY81XghfcBXys4K0tF8zPH/TllD/bKyVS/lOPEVvZMqzfqx+M/
         ySFs9aptQ4Kbr55ZuQr0GkFdvg37a1+9koDN2DYAKt+SqllV9x7M5pLPvbOgEbXYH3uu
         x3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678130228;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCGLcrdpvFfQC1UWgZ3N7iSs8nemFqhBhHOShJVKbT0=;
        b=W0apdYnSplyMqTuHP6tBAWAHHe03rSQkYze8FsZL3gZjGns3NvuBvJejQ41Fk1GaJ8
         8VhIW3xXHs8YFRwmS3M6RIew2b9LQ1YMMkUCcG5n6Dd2saIh88c5CklZkN3N34Vo+VbL
         731jq0UsmqBbXXaiBU0RV4GBFY72Kld+JHEZU/8eGe5T7XDDG0rv/is9nmnHhz8/PITm
         D+LIqu9kkydGussP7U1xyvNCzw6q/7uV57uUBoGEdTs5ZlTZ0S7Bt7Q0dq0KGt6eSQL+
         sFnoymCgA+N2zzb3aYFTOAvOjrVjXsOE50wvU0HBF+QiTQCAf9lSoBrpN7M5nwdjD1fv
         V4iw==
X-Gm-Message-State: AO0yUKW4u97BiUz/bo+c3/iTR84rZZVtFalrWNxwGkHQNpDrtpkIF/d3
	bBWc13XT5SHtrjpAHdx61w==
X-Google-Smtp-Source: AK7set9uhi4LjSHAdpFikCqnRWpp+Xqk9EQxmXwlRo3oyQiSjjdKvfpddbPXVSqeXLl25vnAsZtx9g==
X-Received: by 2002:a05:6870:d60e:b0:176:43ad:83f3 with SMTP id a14-20020a056870d60e00b0017643ad83f3mr8201842oaq.22.1678130227889;
        Mon, 06 Mar 2023 11:17:07 -0800 (PST)
Received: from [127.0.0.1] ([40.84.170.96])
        by smtp.gmail.com with ESMTPSA id dt4-20020a0568705a8400b001765ad671fcsm4308643oab.36.2023.03.06.11.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:17:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
References:
 <869ca49933fc7983c50a88f2a8b4a680e5eedc5b.1677693276.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible memory leak on syn_recv race: Tests
 Results
Message-ID: <2238086e-1bde-df26-5f45-ae0de607b1c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Mar 2023 19:17:06 +0000
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
com/task/6243033163759616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6243033163759616/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4835658280206336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4835658280206336/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5398608233627648
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5398608233627648/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5961558187048960
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5961558187048960/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6d51676e3805


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
