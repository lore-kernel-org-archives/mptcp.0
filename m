Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AC3D7C
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 15:16:44 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-625c092670fso2856786d6.0
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685027803; x=1687619803;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNAvkrUrI4ak31Fbwyf74Kawaudh1R81nLBM9VE//jc=;
        b=kmCjRMKboJdi8bMbR0nibDNrwtweI9FrAbZdy61kIii05shY6rNB2XMW/vlZo+kcr4
         XEA2sYknTbEbo92ji/43TSbszXacHuQRq9zAjDniAvHSPZsLIKEyujTCJgB5h6ixSObP
         nYmC63ChdzhZP9E56djbBEZaeo/Fc8Go/dG2REf8Zv4zExFd0QEEijB4NYgkv/7rOj6u
         ppYcjhWvUcktk3n8OFpfCV/RUtwkeVa7rDOs5X2BHvEcnMDNjoF7mH9Relc4VQMQ+knq
         xpXf5zXgKuSxNN8DPoAAzj2ii8Bg6GhTIt/GWa9qBPVZ6IWSwnWiYFXR0h3kAVSYG+IH
         /xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685027803; x=1687619803;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uNAvkrUrI4ak31Fbwyf74Kawaudh1R81nLBM9VE//jc=;
        b=NZwNkI4d1qSiVXUBRrL/zXThBGy/sEtG1EaQrH7TY+au0t2eP5NlMqbxF8JGdqfr5O
         HmkIzlyW57NzJ2ZLgwiXf7hjcQcMhWfkeDb66PK48EEs6dmNDTO8VOgCBBWDKfWBmh+i
         JH1X8KbmxtlaDQKQsn2WDEzvAELTBShKE7Q+uPrrtfdNh/9Oi9A2QhXf0oL3qKeSL7NJ
         vi94gWwQTvXGiRaOJvRE1LsrhYRJKccwN7gK7ogBoGGKUl8myVVZPmH1jgWtRfKcXvrA
         m67zfApuFvCsE3a9MUFHB52Ub+xUk2s1ougSLYneNrXRt3KJdJB6e80OCYC71RTK8ia/
         jnbw==
X-Gm-Message-State: AC+VfDx7ZnZvM8yT9kvLqzz0mHtsOZGuedXoLdoC0MsbOTC7sQZbhMI4
	RNcq7WRRr7y6YeZVmKlxmg==
X-Google-Smtp-Source: ACHHUZ4beL3hKkBax4L3qerjf0bi6308aOXWcDwc51Zk98wbS9bd0t3a/IfzUNNaLnmKNa7CydgU9g==
X-Received: by 2002:a05:6214:f28:b0:625:aa1a:b6de with SMTP id iw8-20020a0562140f2800b00625aa1ab6demr1668406qvb.64.1685027803432;
        Thu, 25 May 2023 08:16:43 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.205.86])
        by smtp.gmail.com with ESMTPSA id q9-20020ae9e409000000b0075c985e387fsm460553qkc.20.2023.05.25.08.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:16:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230525125503.400797-1-leitao@debian.org>
References: <20230525125503.400797-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <75f1717f-ed99-8dee-9807-e5c5eba5cee2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 May 2023 15:16:42 +0000
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
  - Task: https://cirrus-ci.com/task/4575287673880576
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4575287673880576/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6264137534144512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6264137534144512/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5701187580723200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5701187580723200/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_fastopen packetdrill_mp_join =
selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5138237627301888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5138237627301888/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bdc8dfae657f


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
