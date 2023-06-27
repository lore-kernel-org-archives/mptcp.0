Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77722168A2
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 09:13:18 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b7dd061e9aso16465435ad.2
        for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687857198; x=1690449198;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX3Luf7AVTsUAm72esy26NwsxWXqMWLVCrzDRCLgqBw=;
        b=g+e/ZDlS86n0kllRUn3De2slYkBWAYD+1vBVSdAV4VSF5/KXBFQmxRfPVzRbWhBH6m
         C2dDALnvf6Qie1bCF5M6qqyvT0n1kZPRph2ZNwmdjOAhGnDnn87XKPBJNDiG1rJQqOWy
         Q1QdbW1FEzptXr/T+nZSLkPNBWy8FqPiGZ60DGGXJr+DLa+6j8fH8TiLUzgKRM+TWPDE
         3vnuzv/tn1upkbc5rFYmqy1EfmVScmVYfpFRPM4T/Alad6rzdXk9JUGyJ5ovxlBcexvZ
         qbWJ+SJLygH84CjBST2kZFp/CXQO9LkZ7eSTIJEJ5lhD6GevK1wY5Th9aWU7Q9ztVIkS
         XY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857198; x=1690449198;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aX3Luf7AVTsUAm72esy26NwsxWXqMWLVCrzDRCLgqBw=;
        b=gJ348daNN+dGLpvI7OVchS2RkRUpPSKpfY5D4GoKzRmi+Jpdtt8O14kO7YEKCjD7Ft
         8r1oBlcB0RYEfalMFbpMwK5auwazL/9JT5TyKm2QWHcD78E5nBUn22Hd0MKmd7qMI1BW
         bZpOKf6JYTSK2L46Nf0RTVDTIsvrK3tbDGZRrG+fGimf3P7uGpzgbu2wRSYnceqvvjrF
         oV61aWe/yQRwhbOaJG6lTv6I39mWA8cflQy3hAoSx4VGmNXmYQ/bFmkOYnOvEaw4wO+f
         dZWPQZK0qaUk45gnGawF+hgBEnBZ4qRzoaJ79YiDD0h1P9jmsiwip2x2nyvAf2lwa7lu
         Y7Qw==
X-Gm-Message-State: AC+VfDySlUOPFj/oTqlmIt8va1fnBKZPxgKXxQXyKIDk9T9dJ43ygAv6
	g4txsqLi+6F0uJ0yFXnuO8Tn9kErng==
X-Google-Smtp-Source: ACHHUZ4ysWCpwMrW0gSQtdkB3S3Mu7hH4yRV7kma/3CyFmk0NEkFm2HB9ap3KdH+vJhgun0Tz9GK0A==
X-Received: by 2002:a17:902:f551:b0:1b8:69f:f169 with SMTP id h17-20020a170902f55100b001b8069ff169mr4482241plf.30.1687857197589;
        Tue, 27 Jun 2023 02:13:17 -0700 (PDT)
Received: from [127.0.0.1] ([138.91.71.26])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902740b00b001b66e3a77easm5536816pll.50.2023.06.27.02.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:13:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5631a5c3aafc101f6ba7a6caba9599bf982979df.1687827857.git.geliang.tang@suse.com>
References:
 <5631a5c3aafc101f6ba7a6caba9599bf982979df.1687827857.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fred_scheduler=22=3A_Tests_Results?=
Message-ID: <4638a7d3-b1d7-d720-f2db-5fb14025281f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Jun 2023 09:13:15 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5417011338018816
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5417011338018816/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4854061384597504
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4854061384597504/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6542911244861440
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6542911244861440/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5979961291440128
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5979961291440128/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cddbb44a0799


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
