Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2A9168CE
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 22:04:07 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-77386822cfbso895150985a.0
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 15:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695938647; x=1696543447; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJNCsqZ5s9UY1t4UJAedwyzkwQsHacst5/+OamBnMiw=;
        b=Q7QMjhcN8XoS+6Izr/IJ/Sq9VziiDMYtm8V02o/ef5i26HW0W8YkgefbvxjpfLf2LE
         vuE2CdGKF+ysvzK2BcL22QvBU6tFwruUTKXpizcpnDLT5RlNxnttgRXXvMll1Ik04XUA
         z4uaXrDX+boJDzPXTheTpyTFmSHc8lKfZZdOASU0XseMZtMwQAxWn2JHKTYT+ZjmWXj1
         5Po4gmwm49dquyznabf70EIkKb0oB6Y1QiJ8q1hDp7SCqoppyqF+lKxcyitoofcs+/WQ
         TWy4aWzyMbZaqQZYVF71QCospLj3LEV4OI5FD4uiH2Xjd9yPd9T0/k94tL95dCgx8dUM
         2clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695938647; x=1696543447;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJNCsqZ5s9UY1t4UJAedwyzkwQsHacst5/+OamBnMiw=;
        b=uvu+ysvM7l5Rj7FDKD5DQz9ojBtYVTaVACBnhOndyHjSbU2xWiGKQrs8v9qF79jQYY
         1zmXnkow61lYPa4of/haGJnGR+hIMI71rGHOdr1+6DbcMgcI7ivbYyMIeFBgSHyOUwfB
         ATQUNQGhYamhiDyh62azYSDbgupN/S+w8u5Lsc6uPbTw5b2cURys5pBqYQhE5A0kl/At
         p32j6ix0mpPKF69IluVXVuSmiSEo8SGPaN9t3ehavrHDjhGX3gehOCu3g778aVvEtq4A
         5O61YujE93tOpRNv8WaeS7wPGHp8wL+hnXghaYt5ItS4JMxQTJaq0ULSp09zjRLGyQow
         LlRA==
X-Gm-Message-State: AOJu0YzPn6IwIWyXh1U/y7KpY68EAzE3MnB7HTAFoo592+pD6JC1ZtOB
	c3I0TCDs8plEzUEwuTwdpg==
X-Google-Smtp-Source: AGHT+IFt4Eh+4TpzLMo0PYnAODXR+Kp6EfJeHdpEMfoqHOIPhFyl/q3qm3vs7WcfSVQ/KQRxWUZa9A==
X-Received: by 2002:a05:620a:1928:b0:767:954:a743 with SMTP id bj40-20020a05620a192800b007670954a743mr2887212qkb.51.1695938646716;
        Thu, 28 Sep 2023 15:04:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.134.86])
        by smtp.gmail.com with ESMTPSA id jt8-20020a05622aa00800b00403ff38d855sm6391416qtb.4.2023.09.28.15.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 15:04:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <de9b9a8f31290a56012b2f2c925988e86ee83b3b.1695631132.git.geliang.tang@suse.com>
References:
 <de9b9a8f31290a56012b2f2c925988e86ee83b3b.1695631132.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_lib_wait_local_port_listen: Tests
 Results
Message-ID: <955bec0e-6af2-dc58-8bcc-c68a87344876@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Sep 2023 22:04:05 +0000
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
com/task/5872240877633536
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5872240877633536/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4513562668826624
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4513562668826624/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5375865345802240
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5375865345802240/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6122316556402688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6122316556402688/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7489646e8ff0


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
