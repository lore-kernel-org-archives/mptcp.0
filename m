Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7F79F0
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 17:53:26 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-64d1e96c082so2625554b3a.1
        for <mptcp@lists.linux.dev>; Mon, 29 May 2023 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685382806; x=1687974806;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFgoj8CWjJTi1Uv9xwNZcCp2fgG4sIM2eM7E/TFWIL4=;
        b=lgx/jPGgzYwnjn9sEFPJzND8QYcjyknssmCfR0n+8H0cTcIbYrsSMEt93ifXo+l1TH
         1+Oz2yfPU9r2MJq95DjVln5T++chHAUPOz81ikwyt2hiJUQ9QorfwDZqcguDjEbrgF0w
         NtZf+lPEOetMwObXDey9GlG11JXiviQ82/XZQzgfXe7dLEYH7pUHgt7PjlMxLAb4oTmy
         98E0tV7+qAvJZ51uomUYFrzeHSSoEkSzU6PJSWcJIXNh/2UufPsThPgjSsRjXmgFnoy9
         9yFR2vuItmh7uHwJ238kLlciGsFqxyy4g0hmp5gjxwPwCgDmRHq/dxXOoD83tKF7MCsb
         4UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685382806; x=1687974806;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFgoj8CWjJTi1Uv9xwNZcCp2fgG4sIM2eM7E/TFWIL4=;
        b=FrhejIlchv8z5WPNT3TONhikX1MU6g45Erbrjrs3JwY6ndIp4K2REED4S0u5lu6qaI
         HWsxoXqwfG9PHYaZrOmNSgRZx8FlR9GKiQlvSMu3iua40xSZyRH9oeC3yvlFBjfIgSPQ
         GaBT/9cygEYfCKixW4hQzJ5yc4IFthVrRuMLN6MzOq6Ss7k/aGfBWvfmMi0uAikNiIKu
         H0+KbWYaBRYHtWzrHCY/eSmisB8Jz60j7GLLgwnzDdJ3EWEzoMGSiTuKKdOoNFeWBms5
         hYUxbyT9vH14GiOL3nV2C2VYXOnCyO0dVVnJS6bQvpsZyDJb3waOZEuWO509WFaa3u7Z
         fL7Q==
X-Gm-Message-State: AC+VfDytm5g+to4Gl7uJeqJyNJfyZZO5GkKjw/0UimIsAtb4qlEeRfsI
	peQPzzBzuoRQKY08b/ax3Q==
X-Google-Smtp-Source: ACHHUZ4OVCmU9MGCKp2JxEfhtU1T25vSVZ+It9gl0D4uDkcO1bfOzGsO6mWoLkuVZPToqYaLfwTw2w==
X-Received: by 2002:a05:6a20:a11c:b0:101:1951:d491 with SMTP id q28-20020a056a20a11c00b001011951d491mr10770996pzk.6.1685382806099;
        Mon, 29 May 2023 10:53:26 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.227.55])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090acb0b00b0024c1f1cdf98sm9135886pjt.13.2023.05.29.10.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 10:53:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663.git.pabeni@redhat.com>
References:
 <42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663.git.pabeni@redhat.com>
Subject: Re: mptcp: fix possible divide by zero in recvmsg(): Tests Results
Message-ID: <45463405-b85f-2be2-a1e9-45659d7d5841@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 May 2023 17:53:24 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6203727577612288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6203727577612288/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_fastopen packetdrill_mp_capable=
 selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5922252600901632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5922252600901632/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4796352694059008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4796352694059008/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5359302647480320
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5359302647480320/su=
mmary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2dfdc2932f2e


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
