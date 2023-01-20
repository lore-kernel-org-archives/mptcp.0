Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09517F1
	for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 11:00:16 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id g3so995981ilk.1
        for <mptcp@lists.linux.dev>; Fri, 20 Jan 2023 03:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JSbDVswx5dPGAHaWadqYSYGDYvjIrD3GIdHDB8gAJg=;
        b=pB2HcEGj/ijPf/73zTZ6o9E+hDOefxaibxOmgyCZOfOrDwdWHOQxEny+zRbQ4X6CP0
         IWkAtA2sfx5Zsd7T67c9GS3+5IHTmUxHfDAwXvlcjKFaQ2lr8BvY5NIja5FXokWeB35A
         EF5ixfIun40h36h3i65gdLajoQ1pZ5Sc3e3DhHGw3jPI0yKj6qZHat/MJ/Ln9BhHgszT
         2ftzHGxv8AhwqkoplXO1RCaQ07GeIMWBilrd4x2JfpcLTT2/T3S6wtXpKvgiZe9RUpwD
         0DeSEkNASo6wGtSrCf7d2uizHoThJ7/o1jgkpYBc9ldufdOobsY340gsiQ68L43pzd9+
         mJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JSbDVswx5dPGAHaWadqYSYGDYvjIrD3GIdHDB8gAJg=;
        b=chReMmfB1dbvojAprUHuGk9N9iHkLqLsFoD//wEsaVi6aTVrjlA651K2eVnyfs18R9
         5oXFxC4rSTQ71sdYISovD/nGryOmDvnSuXX4kMt+rl91ofQv3zcKoQ5eHr4Vvi8y2Kw2
         eW5GN1MIi1axFMS7MvmkZb4ySfSUY67g8uP4zn8pZFP8hqD+RpMsOPvJmZyfImIQGrLr
         5BPOXSB59qglbBBqFziXWhd9F8UYhPJOhjfEKqZWKDhPP4YJjDX6fRQTON62AbEEk7Pv
         SFOee48QDZdLuCQBnp9yuT9ZiP2ABp4ywyDo7kcU8DJ5AUWTbJMpnayvIxwWdhVZ4ReB
         OKAg==
X-Gm-Message-State: AFqh2krvS4MMIFdG7xhOVbauAYs+/fUh+QxGcka7roMquNDxkJ+9imd3
	0IIpm4XA2jzMkOCvsbNjtLzQa1Go0UQY
X-Google-Smtp-Source: AMrXdXu5+k6rydmDvUrvdh7HCTwYmeACHgogojbF50ybubu+0E/JiO0McIPeMgWHuMDQfO3TKXU0Ow==
X-Received: by 2002:a05:6e02:1545:b0:30f:579c:af3f with SMTP id j5-20020a056e02154500b0030f579caf3fmr668137ilu.30.1674212415338;
        Fri, 20 Jan 2023 03:00:15 -0800 (PST)
Received: from [127.0.0.1] ([40.83.43.49])
        by smtp.gmail.com with ESMTPSA id q17-20020a027b11000000b00363f8e0ab41sm12047745jac.152.2023.01.20.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 03:00:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
References: <20230119224411.24410-1-mathew.j.martineau@linux.intel.com>
Subject: Re: MAINTAINERS: Update MPTCP maintainer list and CREDITS: Tests
 Results
Message-ID: <a513c7e8-103d-5e6b-472e-810e793e5615@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Jan 2023 11:00:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5888767819513856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5888767819513856/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5044342889381888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5044342889381888/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5325817866092544
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5325817866092544/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6451717772935168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6451717772935168/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3db9f7e9b80b


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
