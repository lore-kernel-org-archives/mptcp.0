Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AFD522
	for <mptcp@lists.linux.dev>; Wed,  5 Apr 2023 23:47:04 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id m6so27469218qvq.0
        for <mptcp@lists.linux.dev>; Wed, 05 Apr 2023 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680738424;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eek19TVmz+BH0zNNHYd23DwLeEPeGXKqTn28V/Hmp0k=;
        b=K+zUqJcEa/8+RPK8YbBjtA+3nyUOElkcWD8xrGsqUMGHfh9RbOwZ/rPrIfWv3i7Ar5
         D8Ix6yGTH83wQRfZLbcMzMZQALtO2gYnoYDKqJ9D4xxt2H1+NCbd2p6b4AMtRK72YS88
         EfZMdbhRG3GH8gqBjKr0A6YyYP5b6pL+quPiCL9g3Ep0fq1zpehzOawjE4y9YtxP+lnb
         1m7CQY7jcJ7gFnjNYgUY52siwNCFBrWaAdFvXrggEEhtZh2QRUjQJ+HAHoTDkUJG+RFe
         e3eoekWL/NrFfkM5Oawf24pYvY0FgUmeaBG2qXmuikEiGMG4Paf8/pmQ0xp5P36Rxecb
         yVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680738424;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eek19TVmz+BH0zNNHYd23DwLeEPeGXKqTn28V/Hmp0k=;
        b=Lca9KAmsvLUCEonSn5wNO23lftgjunKzaBuAMPKHFDrWgs8YTR2fyTX8MApB0Yc9Wz
         eZ51t4EIbwuMvIeng3NkL2ERDTuiVC4rsrlx7MsJbTVohS6b4qAP9V0HbSltBOKe4IAQ
         pbW/5sqrWaLfqCabHXqhsknozG/AarecTsK4OPfMnfopBeWctrUvTQgiEZUL/LrsFUwE
         bQ1C1zJbaFXrhvGh9ZFeYewwJIMYdLhPzbuPMNQfGbDNBMPnYiZgSnjKqzIECV2UvqV2
         NEvH1yw1pfbUvRtHRI74tY+IIqfLgiBnjt1nRvESOjISvA2SaM8PQBaadOeODC3+BO7y
         8ijw==
X-Gm-Message-State: AAQBX9fZIjwGDK784fgYsUbsmOu8JusFOYWgMMnhf2uK1r8j1bvfVnp8
	wl2yLfWBWduusDB4GmC9S9NRzOSQ8g==
X-Google-Smtp-Source: AKy350bgJOUKbL5J9CNUbaB0VSG7mXVH/w0zx2sVOohOt+MU0VSfPUNOzJcS/hQgH4dHhE71TB+zAw==
X-Received: by 2002:a05:6214:c2e:b0:570:ccb9:a4d0 with SMTP id a14-20020a0562140c2e00b00570ccb9a4d0mr2135064qvd.16.1680738423846;
        Wed, 05 Apr 2023 16:47:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.14.167])
        by smtp.gmail.com with ESMTPSA id kl14-20020a056214518e00b005dd8b9345absm75739qvb.67.2023.04.05.16.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:47:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <728d7ef6b46f1f38ae37a49411ca90e0991057d0.1680733942.git.pabeni@redhat.com>
References:
 <728d7ef6b46f1f38ae37a49411ca90e0991057d0.1680733942.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22mptcp=3A_stops_wor?=
 =?UTF-8?Q?ker_on_unaccepted_sockets_at_listener_cl?=
 =?UTF-8?Q?ose=22=3A_Tests_Results?=
Message-ID: <b85694a1-b272-eef2-4c13-efb65ea0b4c6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Apr 2023 23:47:02 +0000
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
com/task/6146554927513600
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6146554927513600/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5583604974092288
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5583604974092288/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4563258183516160
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4563258183516160/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6709504880934912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6709504880934912/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/db821117c754


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
