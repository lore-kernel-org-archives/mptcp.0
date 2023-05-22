Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D713AC9
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 17:11:44 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ae4be0b1f3so43952705ad.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684775504; x=1687367504;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8J3CSDCxqTGRLphM+wn4g96XTZWM/hE1S7ZS+3646ik=;
        b=TO1Xym27jbUrT5oJB9bI4gkHzMNsEr5gxh2hpqrlv6bww4WS6u2nawXZItAzUgNTIV
         u5/POaumK2p5pwusoU+WvfJKZf20XBJ0DjEyespVaatAGb87qUO8SNsvjIjb2D2NXvHB
         +vmQninlrV+wbgt7wR7YBFOS3bsD8HDdXl/V1uL8evyebwXg7tPsgrF0c6+tin3gJv1f
         w90FLhBl8XiGyiQbta/6nedtSaGo9uXrK7iVt9zc7/z2CEWvtYWHbTWGipYEUQs90ftx
         Aj+voferbMMzboKGu9vLgRBZ5lM7ADeVh9N75459oxFLWzDNVmaYO7gtCYiYNOMGwO2L
         4DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684775504; x=1687367504;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8J3CSDCxqTGRLphM+wn4g96XTZWM/hE1S7ZS+3646ik=;
        b=ZB8KnpwimmUidAbJvxYjILGnUtiNEXXzdPMeTQcyie0tYr7/omXd3mq1aueUImdWl2
         NAKf/MWbdAsi1shAhxDuG6qdPbMJEyd+mNVlPgDsyGzE1OtZN9cGIqj3gXUguowpnrKV
         RvA+/MnlrbNiQBG9UbkCYtlVTl+aw3UbiqYT04ehjk6eUhOrtGig6/2gBoxXre5YcZo3
         V7jIwcjox9HG/2ArmYHqPWvIxDfbDFFVSKl/qFWa5z0OhyLDTXPdd5YZML+idoegTXsa
         Y9xpR+PJACgbx38h8USa8r2yPmATcEBPzs99uw6tbjdbT/Nk0SQr0/wEKmOaGo3NyshU
         FD+g==
X-Gm-Message-State: AC+VfDzu2UW0acCl8DCkYlhoSG26W0vanb9c+WSsMIOQa/DnvKQDgY9c
	wDtr4Fa5FaUhU2MTgi/aCtWeSVAhlbJH
X-Google-Smtp-Source: ACHHUZ7PTHGQ81rBXOhhdQDr5/4001YqhXs/lGDA4z8jQCOgfmWblnDOstMn6DCqaePzu36GawrT9Q==
X-Received: by 2002:a17:903:32c8:b0:1aa:e938:3ddf with SMTP id i8-20020a17090332c800b001aae9383ddfmr15775673plr.7.1684775504032;
        Mon, 22 May 2023 10:11:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.213.128])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b001acaf7e26bbsm5110219plh.53.2023.05.22.10.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 10:11:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230522134735.2810070-1-leitao@debian.org>
References: <20230522134735.2810070-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <ae4e4000-6097-56df-d335-036da24f5ea5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 May 2023 17:11:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_simult_flows =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6387214687404032
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6387214687404032/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6716020874805248
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6716020874805248/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4979839803850752
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4979839803850752/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_fastopen packetdrill_mp_join =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6105739710693376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6105739710693376/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cb52d7ead662


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
