Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43711257A
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 20:50:20 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id a7so3882305ilj.2
        for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=D3bELEXAhn4UPvKBKDZHMlyw8VvLYd6fsQL26oaO+qM=;
        b=KqGvZgGySNWezoOAqft6+rc3UAzfEVUNDAUTjYXmguAlinqdRx4QLQ9XP2pxY0SGuX
         jx5O2WME7kHai8lMOAwy2drLj9D4lK9Y71yIul2cjIDg8sbbNMlFdZrt3QLPLR6Ne0Rx
         Oyx4XCxXRl40h2QluFs3ufc8v5yBat73BwQi3MM3v3WW1MBzmA7U+8W4X9/+9vsM9M6c
         Obo4rl34F2BRtkNh9SBM9WG0b8btyiWzQWXJ7lRvTm7Ah7Vpnje+VSpuZPFr+2Qj9K2G
         DbVSPRYtXELAm/M4+T6B4KL+/EIuEU/XvlTZfimlsPBnD2rjlH5dEEQGOpW5JlxL9GOR
         yUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=D3bELEXAhn4UPvKBKDZHMlyw8VvLYd6fsQL26oaO+qM=;
        b=BBlvCJQlU7VABDuB6IuumzTz8TMuUZgoIKGYBiw4f7eru0SyXNHARX0wwJtnzi/mPv
         54zqORtVk64AaMwvNxrldupcjyy49ZSCm4aRKxPTh0O1rPVyd4XeVy/y208sKnQjKHsU
         pkr9YlzrF7XZiTqLobkNO82s3++LfEQt8ivSFlxJF3UAhtiqGY9z43xlfhV2rx0zhtVV
         0ru0FZd/7HoQjlB7PGSzDTyDf2pQXaU8lIk95jtCt5lycJegspTIPGtYDKD9H8WOAUQ2
         31mB9kjwm5mvM6G2rapkOFirrvXEMt/8Lzc6feVWBN6VTBWMqDfCHcvSEnjGKyiDmtf4
         kZEQ==
X-Gm-Message-State: AJIora/Q7B5Y40/1JCiIFnm9ME2PxdjSuCKDdRuVPEWzEcXaDkrrSQrQ
	sJaIQheJ4koPGxfazqiYiQ==
X-Google-Smtp-Source: AGRyM1vRi9LBbATS2N0QUMLpdIEav8jBZuMd+XxIwOuYvuB2LIAx/nOsRXQldtGN9hB8Tl6PFZUPPQ==
X-Received: by 2002:a92:b00e:0:b0:2d6:538b:b866 with SMTP id x14-20020a92b00e000000b002d6538bb866mr11281820ilh.199.1656449419228;
        Tue, 28 Jun 2022 13:50:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.224.209])
        by smtp.gmail.com with ESMTPSA id cb10-20020a0566381b0a00b0033bab6c21b8sm6117850jab.37.2022.06.28.13.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:50:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220628190356.326233-4-mathew.j.martineau@linux.intel.com>
References: <20220628190356.326233-4-mathew.j.martineau@linux.intel.com>
Subject: Re: mptcp: Acquire the subflow socket lock before modifying
 MP_PRIO flags: Tests Results
Message-ID: <c6eac642-e70e-c66b-eec6-823625f32b79@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jun 2022 20:50:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5828656101588992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5828656101588992/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5265706148167680
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5265706148167680/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aebc91b918e8


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
