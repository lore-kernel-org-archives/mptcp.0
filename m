Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F4AD41
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 12:22:44 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-794cd987ea6so66664639f.2
        for <mptcp@lists.linux.dev>; Fri, 01 Sep 2023 05:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693570964; x=1694175764; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc6AXjgCf2LTGQt7VSiz+36h1sz03JQcCfMbwKWgKkU=;
        b=kTcdbAb4/LhLhuqSykBXqnKRz5DM3iFlJfdcJLpwHzXAcCEHYhgtlc36juVM22B5Uu
         sbY+1hXOFp+sZ/EQphhsQBtzEOawLozt3PLegvXGIGoeCCNqbpEMVnKdoeV/wWarWVGU
         alyc+zgRF8LFyu4xin6Mn2dMcornkvucvoNc1CrF1ZGTyXUTEbMUUD7AdirWvDqdLKio
         g/PLhrPrwqCvGiIj6FVTZLpz1yt+RhGRfv2safJNHOIASQegSren1AF16zlibzg41svz
         noLbGvUPwF/7LgcCDlTOGsE/yARCi61dbMD0ZPQL7i3L3GIF4IiiJR6yGx2aGAZRYBU7
         rqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693570964; x=1694175764;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gc6AXjgCf2LTGQt7VSiz+36h1sz03JQcCfMbwKWgKkU=;
        b=i/QAJ7HjzENkPDHrLOUehRoI2iql+SeiyApFU77ihIcvDV9ZROGq9TbR7v8nCtVJf3
         WxiZcWgUnE3XIbO+AbKwtXBmYx+UbGMhvd8VPcWZGmyn2UG7fkVkwHoy4EfFD4fio+nN
         Z+FCmSUscwZ0TC/JBURfANZCl4CyfGFySsIdNW11804M+pqPOr7dN5k2DVEaoCtfBk5P
         IrArUFOarl7FcQs9/qk4GF2Ek41rbgL955gG7qVjNTxjrcp1FXyYivDThm4TiJhjprPa
         b27OE8YacgtC4oFFGgpcrBwGFg51XGdWV+gPU4phOT/0SBDGtbQHlsr8lws17qRurU/T
         kEFA==
X-Gm-Message-State: AOJu0YwY/pU2IYf2T9tTwsG8R4B9FoSJ/fFFLJKx05DkbDYa0C0+CYSD
	6ojIbPQ80IE8AeoFOPFM0JPUlkXJQJVS
X-Google-Smtp-Source: AGHT+IEADue9fjtGL9wgpG5HRyKYbITJmotnfO383zQhFv3Kb7g8ebLw7YKTQOY1103aVwBteVnX1g==
X-Received: by 2002:a5e:aa03:0:b0:791:385c:f8b0 with SMTP id s3-20020a5eaa03000000b00791385cf8b0mr2275759ioe.3.1693570964051;
        Fri, 01 Sep 2023 05:22:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.89.26.210])
        by smtp.gmail.com with ESMTPSA id ee21-20020a056638293500b0042b0ce92dddsm1016306jab.161.2023.09.01.05.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:22:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <382adc94e31c46ade28566d5787dd9d531329c51.1693565414.git.pabeni@redhat.com>
References:
 <382adc94e31c46ade28566d5787dd9d531329c51.1693565414.git.pabeni@redhat.com>
Subject: Re: mptcp: implement connection level timeout.: Tests Results
Message-ID: <6e418bed-eba1-55e9-af23-741f6526fb32@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Sep 2023 12:22:42 +0000
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
com/task/6412989272686592
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6412989272686592/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5568564342554624
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5568564342554624/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5005614389133312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5005614389133312/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_mp_join packetdrill_sockopts =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6131514295975936
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6131514295975936/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/28508caef7ff


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
