Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA34F9E4
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 16:41:28 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-414d37bd1e9so34350801cf.3
        for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694450487; x=1695055287; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF8OH+KsxK1szZFGkBCNT1KjVBtuPljw6JlIxvdghmw=;
        b=VVzqN4kmNv/9nBCO3N3+Gc2dC/4ES+p1MqFiRrtrGXiZ81wAsGmmdEzOZUz2Bbf2u5
         8CdsGzW6q047c0p6+b+w4VOE39ahfa0+ok39YtKgu0RjkUAsTCRlU4H4OOv9NTKfAUDg
         SFikG0rGG2ulahIGqWqXSbxZPZAPzbQiU2KM7w4/BJugqpQsf1b6UOpTdBmHPC9/4Csf
         k2WPaICamhhEgSY+mLcuqPXpNCkcYtJsPIPwGmTA2SPYSwk7G09wgVswSlszVHHLBdSC
         3y+oopylmhFhLar4pOdRlU5Wxyi4nS7ZWSGOWhC2hMs3lNRab8pWMzHxS2XaymcHSmKT
         HoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694450487; x=1695055287;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rF8OH+KsxK1szZFGkBCNT1KjVBtuPljw6JlIxvdghmw=;
        b=eK6TLdOStTj61ea++5zjHC+MRb8eirzMeF/jD2Vhxxp6ZBrVnR1FobfnIPwnZv8XW3
         +oR/+j908/qXqij2/gHEoWp9Q1vHPwQBCe41PtEfe0+ZIB3iRyCpS37fXTHm1MeG04WC
         BMSJ89tMKfC3OZYOfYtenPcKmLO6aOqz4H73vlAsqbkfDWV274LYl8xj0dIe78loIkPC
         w4uPwaz0YAitrTzuSdg7v5ELD5qehHvNbKbMUHnyfdYCB+7YjDudzGd1JEBneSd8OW2u
         0b/pX4uV8GUDgmNuoWhkI838ZkCIpRDzvhJ+8gmjhbhNW6eRN4G5GkOZevFEYmrjajqe
         K3jg==
X-Gm-Message-State: AOJu0YwlG6GXmqEzP9DectprDMLopb8sYVcHzNoqlbMMqGla2/fcaaZB
	0hQjZ84sH3uCYKpP5BKER22czLhBFeE7
X-Google-Smtp-Source: AGHT+IHOvPax68DTWF0/Upt96srPc9eZTf6Lg81S18OFJ8irm5X3VL3bAfr/2xyMBg6KIYahz7MlJw==
X-Received: by 2002:a05:622a:428f:b0:410:a9f8:c7e6 with SMTP id cr15-20020a05622a428f00b00410a9f8c7e6mr8892884qtb.42.1694450487110;
        Mon, 11 Sep 2023 09:41:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.226.126.225])
        by smtp.gmail.com with ESMTPSA id b11-20020ac812cb000000b004109fb22216sm2705122qtj.79.2023.09.11.09.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:41:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
References:
 <fe8c2c5502b7a924bdcba6621486e1e68861f9fd.1694426964.git.pabeni@redhat.com>
Subject: Re: mptcp: add a new sysctl for make after break timeout: Tests
 Results
Message-ID: <d6eb3e7d-0f84-5665-3222-3e63c224b232@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Sep 2023 16:41:26 +0000
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
com/task/6528270489878528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6528270489878528/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5261633094680576
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5261633094680576/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_dss =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5824583048101888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5824583048101888/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4698683141259264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4698683141259264/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dda0c17574f7


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
