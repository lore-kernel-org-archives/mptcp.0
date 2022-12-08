Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D762C
	for <mptcp@lists.linux.dev>; Thu,  8 Dec 2022 03:23:08 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso61801ooo.0
        for <mptcp@lists.linux.dev>; Wed, 07 Dec 2022 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd6MU7HFAHE4HFIUFfh8z/ug/K6PTIUobHtPh9xOPco=;
        b=mzA/7Ye+6LABbV9vZ/ZliPmCf3rv4Ys+IcKHAdK7buu7iw3/PO0Qu3vWjRBg+AMpg1
         QV4D1ZcnjN10iOx9JbSt4Lqty8Lgj/4nvYVpR9LGT+A1x0K1JpamLYruTdvBU4ald+7m
         dXonWJ5aRd4/2uorpsIbHg1CLCXXhlN/RChfHOdNDAgyKa/WCN5uVGcat/Vge+Wu2pre
         IERGqmBdi1yfdfdrtWXIoqYNL874/0cSjvq2Ap2cNiAHkGi5I/CQSshXETYS7mSv0Nkd
         zsGu1s0GKSobven5i6uJjhfgDthfjcZgUFnWdKI3KGC0WOXmRmJ+Wo948USlzHYSb0oZ
         699Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pd6MU7HFAHE4HFIUFfh8z/ug/K6PTIUobHtPh9xOPco=;
        b=ylaDabbujStV9XeWra/dow2z8Vti98WCAm2MYHN5C5zPnXjD7ukDPzVFyvAIMRl8E9
         z6UmbEQfQ9yWFVAK8ii4YoCPmtFKqnQ6g7SwVBYH6W6Z5RJNciOL+KiBJA5weMdIggmL
         00viK5MnH8qVWuSRsCB5/BPB25NXFIscHmLAJKXSKiTtNxQVT2LeiTELVawCeK7+MER8
         JbS2dhP+JfQb/rwAnLzU7rVSyc8iUPlW/PWA1QvOiQfWMwQwSY0+iKUD2wSX0dkwmpTh
         wssPEDi7UuvLhYH5s8YEt1wG5W+zkZNUsRDWB3bfjvxS45WBGzcpNJHpR4D5JgIlNRn7
         uj/A==
X-Gm-Message-State: ANoB5pnEGfgMeR6xHVjKYuFh1uuUB+ty1MQwm+p88/3gmOU2i/pnoeAJ
	mT4QuXh+jVYRmhVAZvLMQg==
X-Google-Smtp-Source: AA0mqf4HJe1Knxj8EqCLWRsF+G9Q5oXY5iZIvOEDpq+Ltx4e75GzozpCBVw96YfGev9lKTCGfHzkig==
X-Received: by 2002:a4a:e882:0:b0:49f:f4e6:2063 with SMTP id g2-20020a4ae882000000b0049ff4e62063mr560894ooe.6.1670469787391;
        Wed, 07 Dec 2022 19:23:07 -0800 (PST)
Received: from [127.0.0.1] ([23.98.139.127])
        by smtp.gmail.com with ESMTPSA id z4-20020a4ade44000000b004a38ccf775fsm691149oot.45.2022.12.07.19.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 19:23:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
References:
 <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
Subject: Re: mptcp: fix LSM labeling for passive msk: Tests Results
Message-ID: <1bac0f85-87f0-8e94-d23a-a0a63ed095c1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Dec 2022 03:23:06 +0000
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
com/task/4599690394599424
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4599690394599424/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5162640348020736
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5162640348020736/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6288540254863360
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6288540254863360/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5725590301442048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5725590301442048/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bd71c6923ce8


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
