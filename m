Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576C8835
	for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 17:09:16 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id ga7so22328238qtb.2
        for <mptcp@lists.linux.dev>; Fri, 31 Mar 2023 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680282556;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yT5VK1ei5Vgg02uIWM/3jrNiHxpBj0WmTk4HRphneXc=;
        b=p1QbmzRD0MRoNJvkZPhuERB+GNdzK9id9UN6FMrIfC5MD07V19hpvZSM9Mxy/M/LVc
         CrB0u+bTmd+alAdKn6g63Lgrrsxr22kErI8gMEk2rBFwo5F/mb5d192TKAZTEHiEpBtG
         jQdBUZ9nyFqoaWaf4SEMPUJJvQN6AqJ/gUgbwPvQPxZZxjgOl5xL1ig3r1QyW4hqZlvD
         EucE85LXFxAheqQW3d+rw7D/f/eFZCn7CSriz1b0ytstmjPa5QwgHfa0iVJ67sN9lAfN
         9ANGjsy1hSuBISLNXcLfjdFLfISTR/w63ncuXSk7WjZJIzOl9VllqcL1oEtAyG/tzyEA
         ItTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680282556;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yT5VK1ei5Vgg02uIWM/3jrNiHxpBj0WmTk4HRphneXc=;
        b=FuOkQKkCgIpcYy87qxG4yP1H+LibdUAnU7fwos9USrIEc9iXOcTaQSbtkDjrLgAwAC
         ioTc4SPpLpz1FkD/GrOxSaXCbjK/0YHNGUGmJud6co/1IM/xrrovTITaCoU9I1VCPPA/
         KgD/bS4oqRKpQkcnvPQkni/pi2tj2GzIb9v9LjUCxbojHNJAyWODb4x+Dyr0I5ikr7qC
         C/5J3mKXW82dMp0K0Zzb226OpzgJZyn2cMCnHLplmf2Rh6siu5hx0pab+8YIMhg+bfiz
         BccqmElXogRU8Y6qnVU+arkIZoPcpmqbeo775N9pHLtJK7wQOWk+2dJftqPmZx+pzy7J
         BJQg==
X-Gm-Message-State: AO0yUKXOV7Jh+6CACM7ZgnleTWlMIDcbbHMLP92MISp9oWXoHaa8RUIe
	5iJ5O7ekF22wf4h8HUUYKlFnLaLcrRR5
X-Google-Smtp-Source: AK7set855et2ZwdPKbDaIht1YHEOkBNAI2X5grcAMyd6+dm71EwTnhtssui1gtCPsG0gE+zlKXPVqw==
X-Received: by 2002:a05:622a:195:b0:3db:573f:8f7d with SMTP id s21-20020a05622a019500b003db573f8f7dmr48446657qtw.17.1680282555761;
        Fri, 31 Mar 2023 10:09:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.185.158.57])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a049000b007468ad71799sm791527qkr.64.2023.03.31.10.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:09:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b12779f37770dbdad059232c9cb45fbd56afabd2.1680204074.git.pabeni@redhat.com>
References:
 <b12779f37770dbdad059232c9cb45fbd56afabd2.1680204074.git.pabeni@redhat.com>
Subject: Re: mptcp: fix accept vs worker race: Tests Results
Message-ID: <a5a2508a-39e5-8d54-2828-6e06376a3167@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Mar 2023 17:09:14 +0000
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
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5776733312385024
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5776733312385024/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5213783358963712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5213783358963712/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5666683801567232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5666683801567232/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4932308382253056
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4932308382253056/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f3b6d044228f


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
