Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C77134D6
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 09:53:30 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-39aa1517037so380385b6e.2
        for <mptcp@lists.linux.dev>; Mon, 05 Jun 2023 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685958809; x=1688550809;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC5weUe67wDpcvqSr98VURWpBYwzZYzkhJwNbpt9ZYY=;
        b=gffVOHe68GzbO1TfxgZYxbQQ/J4x7pxgbQ1dttl7Jlat8VYKdVr+4ycfBOI1Lf02q0
         3wJLcl9zemBUPPFNs7vpnlk4ntd8MseXofxckUv5TjpoHf8CQSPt/VUy4Xq4SYwmmZ/T
         4vtlokSXAZYglEJkeHH7bR/4JH2njHJ26m1RXetDJ0745n+kmwHNFEEfFreSbkDCfTRU
         l5+ILV3xFWLoFQHDfW8LdQO2YVY6bqN4HuUdptNf9+dQJrIVhCRUJuxKfNqGFjNgoyuY
         EYxTC6yPAGJrOUcyfLUtZ1Q9XDIrlsVh3tgVybb2Z0bLQ1oHevX4U3i533rHomO6KVOT
         M2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685958809; x=1688550809;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PC5weUe67wDpcvqSr98VURWpBYwzZYzkhJwNbpt9ZYY=;
        b=FetBX5Pa2D8MuKVkFkL+uk8+1nVNWAzNi/RF2JdAzZ6yFhNOcfJOUudKtSWwXGk2wZ
         TNV7tOWd2jETp45HdTSvgcdIec0GtBkDH6cZMuLDK6p7JHNircVtaWEJZFdgs1NJvJu/
         Sa8pL/8jpQ2ucCidnSKBNC+mnOTulr/9O857QmTYfY+tAheISU94DBexaWXjfoTrnGHo
         0qlJ8iH4gMCwpoG7Ts+V0ErIB0ru9UE5fI5+Z9A0LzczZBLCHgWEUpz7/Qi/cK0FoyRR
         /rgQCoPyVZDUd6rr2WFWqntVniADgOH/FDUyIpTaiZ0JxUOmaPSbmc9i2yipexAKMz7r
         TzHQ==
X-Gm-Message-State: AC+VfDxuDMNge8nWZ2zGP6WQ+0ABRS7oQ25DF3XGLtd+NuYicNKWhM1m
	NN2j8vJRo30sUAkGd+BEFA==
X-Google-Smtp-Source: ACHHUZ6+AwoJ9iOYWRXEHygxQmCoTp7ZhJiEJ3TNrikVlMb6pXwhI/RvoLCmloNlvJtqQ2fkr8FwAQ==
X-Received: by 2002:a05:6808:28d:b0:396:4bbc:9a36 with SMTP id z13-20020a056808028d00b003964bbc9a36mr3156790oic.19.1685958809204;
        Mon, 05 Jun 2023 02:53:29 -0700 (PDT)
Received: from [127.0.0.1] ([157.55.189.32])
        by smtp.gmail.com with ESMTPSA id b23-20020a056808011700b00383d9700294sm3053266oie.40.2023.06.05.02.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 02:53:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <99a7be9d54bccc4e35f0fa892d7caa5b4da5b3c4.1685952776.git.geliang.tang@suse.com>
References:
 <99a7be9d54bccc4e35f0fa892d7caa5b4da5b3c4.1685952776.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add pm_nl_set_endpoint helper: Tests Results
Message-ID: <1ab1ee90-2b6e-0041-dcfb-01294fe3eab3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Jun 2023 09:53:27 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6709769281470464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6709769281470464/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4563522584051712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4563522584051712/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5689422490894336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5689422490894336/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5126472537473024
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5126472537473024/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2dfbdea5a550


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
