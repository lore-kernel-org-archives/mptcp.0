Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635FB37154
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImzSQPjf"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7788db95652so2270085a.2
        for <mptcp@lists.linux.dev>; Wed, 08 Nov 2023 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699472309; x=1700077109; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydGrTyzoXSh4iirwMen9wrAhamnkq6ur4fUuz1G4w0w=;
        b=ImzSQPjfa3mlTSZSvyS4gFWzFH6TJAG3u20odGvQXn9t2sxasEbQyJcp3somYYGKP9
         PwZMyTRLc1M4iLQshOd/qQ4h/bzt0zXyWY+0eafa8WwBa8U1Zy20J8Y29LcF0kg4QO/0
         0EexAJny2gwfBGg2dsFScaU9XOKWXueRQKKms8i4jf4nxDWK0iIi/Bw/1S+shiiS7xNT
         n1P9KF4gvFPSP5BVqJZnkKZQKuHcb9IoBM//jDfVWvf5Elh2JxZo64o+PMZwdwOXr39E
         m4yEFNeT923COGkxP2MmpQZrg45LYK9dM+FZF4kb2dGA0El/rTookmepUDbGQ3NlMyS6
         r8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699472309; x=1700077109;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ydGrTyzoXSh4iirwMen9wrAhamnkq6ur4fUuz1G4w0w=;
        b=p7ZkEhaJ6+GzCE7Weo1v8bPVAcj6XzPVCokxfrW+ec+GAUBS1sHw/LL3MWYw2NG6KH
         W20TFxzfvnQdC8Lj5NXz0zr12Y/I2RGzaiiD/qo9P156sZma4S6vWzaPr3eYXk4R4Ecv
         bd+6BktqRY+2bV8IvoNmeI8i4H8OPY6oUnfZTarFzrEH6hHONsEZJlqEpUakROxYYVAe
         LWnX23JQ6FjYR2ogWQPKcu/4sKLW6bqeZoGxKa8LM3o5BzvNvO2AeDfmEGs+DFBQsduu
         qlE6CDjwDQPjFZ6EqvrNAdXdZZvXqspoTznXMomD21shdPwgNvLil+I9ypr5qWRudKKL
         nc+w==
X-Gm-Message-State: AOJu0Yz5SYl0J0gFRRWrp1t/2B8eARfHpard81Ltxm8ynOpcqFCppHvH
	beOvlzQ6xo0zTNMa/CUJWg==
X-Google-Smtp-Source: AGHT+IG3sh70LfcyoCKpg9ROMtfrC5YXZhGNWou3cnHhqcN44B3G1M62TUUiDVzfC4TuY+do2GwSRQ==
X-Received: by 2002:a05:620a:2805:b0:77b:b3e2:9084 with SMTP id f5-20020a05620a280500b0077bb3e29084mr2235469qkp.12.1699472309132;
        Wed, 08 Nov 2023 11:38:29 -0800 (PST)
Received: from [127.0.0.1] ([172.177.120.54])
        by smtp.gmail.com with ESMTPSA id v3-20020a05620a0a8300b0075ca4cd03d4sm1365577qkg.64.2023.11.08.11.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:38:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f2cf8a00fdf178f314b92c8809ca9deed98464fa.1699466615.git.pabeni@redhat.com>
References:
 <f2cf8a00fdf178f314b92c8809ca9deed98464fa.1699466615.git.pabeni@redhat.com>
Subject: Re: mptcp: fix setsockopt(IP_TOS) subflow locking: Tests Results
Message-ID: <06570ac1-c197-855f-92da-3c5faf4689f8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Nov 2023 19:38:28 +0000
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
com/task/6206547924090880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6206547924090880/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5925072947380224
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5925072947380224/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4799173040537600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4799173040537600/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5362122993958912
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5362122993958912/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/76fad834de5b


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
