Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630766AA6
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 08:28:09 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so12722158pjk.1
        for <mptcp@lists.linux.dev>; Tue, 08 Nov 2022 00:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHeSDYeYs9V+EkuT7L43HM1kF1Zsp7yf21xh4K0U3oY=;
        b=RqDUgNWlOKd5OFmaAGtNamrTzk0qYHkzKFWQrRJkoI0ictiQNzoLkyGWj6ZiYUVi7H
         v+6oTqi3dbdtqNst2/6DO6gTJdRmP++YM1z5rxV8FuGGqModzsSjeSym1+GlV2lq5bxx
         fu3SfD0h1iftPj93/olP+Wt02mEasl5v4/BSSOVTX+DZ8uXWfgF5tvOb4bBA34Fb+iQF
         6vml72MdsSTgVoyQj/E0cj+v+sk7YZDKMDTpekyQb1ZXcUP/GF2H3DL6KCL2EKZNGKbF
         3ogCmyMOPoX3NoFKOi7SXaKdZnLzkEQFSJi4FsVUpIWZa3eHamv+U+HLkyuoVmU8vHxG
         qQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iHeSDYeYs9V+EkuT7L43HM1kF1Zsp7yf21xh4K0U3oY=;
        b=caZizVR6tv6rtZtXmAJnawJ/Y5NRvKXl3sMpcWUq+SEEY8njAOvttzH0tdrlFek1dU
         bGijnG2MrJcvBc4bQufz3B0sxLsZH+JxE29A92klpholF8qkJmbHh1nTSW2RzTQIEBrO
         4M7XIIcZGWaGGX9zm3Ai9iXc4QhlllLiYEEvzZYQ9+SQIqseVoWCLP0pVQrFrOAjoaAQ
         Zj2t+hmVPTA5zghdJTuAyCQOYqCMocRXBznXVG8u/dQkD7hap0OcljwuLDMmTPERx2Oz
         HzJJU+khl8s3PcfCQAT6R3zXMVaDOErmZYhUkoAhkZ5rR/xgo5kWdhSMQO0d2+2agrnt
         MbvQ==
X-Gm-Message-State: ACrzQf0rC86skfIXmP0acpcPG99BY/PyAoWK7skZ7ieu9It9H9V9ZoMO
	yqEG2Iqr+Qhe9dx5hvzVI5o4KCAbsVLf
X-Google-Smtp-Source: AMsMyM6l34uYlZsv4WQgaHP/f6CK56xVV934L+Kb41GTSXn43SLWXZ9AXGdLSwURELluhuZquL+GEw==
X-Received: by 2002:a17:902:b595:b0:187:34f6:7820 with SMTP id a21-20020a170902b59500b0018734f67820mr39594014pls.152.1667896088710;
        Tue, 08 Nov 2022 00:28:08 -0800 (PST)
Received: from [127.0.0.1] ([20.245.39.3])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090a414700b00212daa68b7csm7297486pjg.44.2022.11.08.00.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 00:28:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bdcd868980996e3b9ca84b361ab5f561cbc2d0af.1667889809.git.geliang.tang@suse.com>
References:
 <bdcd868980996e3b9ca84b361ab5f561cbc2d0af.1667889809.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <e733bf18-2952-512d-276c-31c16e0dd940@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Nov 2022 08:28:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_add_addr selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5999423858671616
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5999423858671616/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s):=
 selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5436473905250304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5436473905250304/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5906795b5bb9


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
