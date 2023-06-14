Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7026101ED
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 15:59:06 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3f9b4a656deso21174681cf.0
        for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686758345; x=1689350345;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbYPKrDPaJbUqoJX1XVZODpC21+VZ9rHQPlAeKSV0Ec=;
        b=LXKyA/4kWZQDUOJECbjvUC7W3g43v+3vAUeBhGeiSmIhjJop7Y1mnvfL5uYtE/meW+
         YR75bTOctjoja/GVpG311QOwxJoeY6zzIuUdN4m0pzIq/FlPf/Nvxn6tNpsrXvkFHN0o
         c8uHDOd2QGmJw1FvhHT9t47QoWpCxUWPLUvejsoGcO1P2bpvUQmCPgjcmohz68zD0EaZ
         PuBh3SIoBGqm7Ab6ncEPIMt2Hm2zFemt9o3qm0T2xlZUsJSdcFp6IT5hHkD45eK/Zqwr
         Oex3daBsawQdy9bVxJ0+dOZTbrQRCH0J/NQM/LuuzrgjNR0nC6LXdO3RobhFN5vL1lrs
         kz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758345; x=1689350345;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hbYPKrDPaJbUqoJX1XVZODpC21+VZ9rHQPlAeKSV0Ec=;
        b=FviL6DZnaQUHPtFkLunB1jHrHv5u1y0RXUKDOITt/lRMLRp8JCK13/CXvIjvoVQLmV
         nc+yM4gC2uJ0L1xP6IepxHdEk3HgiUwKS1A19TVN/dfOu7HJ3Mywtmp9FmbC3KEz0Zaf
         TO4dvyjPBj8K9+e+gjsSZev43T/g5NBwI2eHR8w2oHexVh3OTgemgIcPVAhqA+TQ5Sf2
         9zdMDXQAh5cQ0aaV8EhdZj9zTMT7ivnWrQ41ItA3FlN01jzivGoqRdk8rsyMnR2WeOxW
         94XdqPa1sN3ZfrTjo9zfXi3uSNowWGC+KwVyjMyFgi4gEfS9EqL+8oKTv925RBcfWRyb
         wOZA==
X-Gm-Message-State: AC+VfDwDe/pa0k5dRQO9lK/CpbXKfxaekEpoW92AsCiQhqvk/kUHs0He
	ScU1hogqRD95evY7i/YHKQ==
X-Google-Smtp-Source: ACHHUZ4PjmaiH7LeW0v2DSZF4MGr1MvAZ54dc1RHjbJzSf/urHVqHYLnysHhVbCB1VWwpJiZ9P88vA==
X-Received: by 2002:ac8:5a09:0:b0:3f9:af04:e9f1 with SMTP id n9-20020ac85a09000000b003f9af04e9f1mr2973736qta.30.1686758345522;
        Wed, 14 Jun 2023 08:59:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.41.196])
        by smtp.gmail.com with ESMTPSA id r19-20020ac87ef3000000b003f27719c179sm5069838qtc.69.2023.06.14.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 08:59:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
References:
 <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
Subject: Re: mptcp: ensure listener is unhashed before updating the sk
 status: Tests Results
Message-ID: <c0a91355-cb5d-09d2-bef7-db1798fc586a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Jun 2023 15:59:04 +0000
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
com/task/6584668695298048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6584668695298048/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4755081346678784
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4755081346678784/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5318031300100096
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5318031300100096/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5880981253521408
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5880981253521408/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f0f6781d86e4


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
