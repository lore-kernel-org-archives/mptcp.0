Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72972CA2
	for <mptcp@lists.linux.dev>; Sat, 17 Jun 2023 00:05:31 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-62ff1cdf079so11876216d6.0
        for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686960330; x=1689552330;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXTNqUvErmR5ySbdUwC8bhkZdam2iKZdA263XXTQX/E=;
        b=OZIpVVc9XzRD3VxCdB5oGnWjkxlNCJhRLfX01v7oN+oKDItyTt/W0vWUwlArhMjWxx
         YXAXeu1Z82g1ExrvQSabEsf7zzH7DTWdEvaSh4AUmhxlARmmbP7tliQmL/l96xp4uGHQ
         pUR7NcdvxApz+Te7wTMijnGiJHCk+CIn50L0ICdiRe+qHOu9z+dZclYE8snD9iOWQS5d
         Ddx38JKoxY+U8cmNcq5Wv7/UmnkXuqlWMMlgFkqJLq4tw7opZDjCp3BFy/ouFNyWJ8PR
         KBwraBBsRaceY3pWTz/lrl96rVLeZb/Laxfy2AHDeantDxZnFpmWuv40A922phs1y3eE
         MtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686960330; x=1689552330;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXTNqUvErmR5ySbdUwC8bhkZdam2iKZdA263XXTQX/E=;
        b=D6hFD/t995OJhEe3AedwkhWY4feHFlDWJk61Z/WkiZ5SfPyW6qNmtOlX6eOeEJEua/
         iWcObrW1Eul/m8WeT8Oujlgw9gKhrstV4NvXI6NyQeD0Jdt7suxjKc29zUbmKuGvXjnK
         E/YJwMiVNuSFYEssM1kPmeS4L+PWV1ZaXlUC49owStP7YhSoLSZLUhYqs2hKkR448MqR
         QTpfNhJE40GvW2LqcwP0mT5gQ/zs/ONi2aZuxIv2tOyZBRg7ttmptnTzdl2zrWQZMSSD
         gypHgjqkx+Y6EGRyeJ6PDzw9+zyLFD0xuEl9qnPUAj6gwHCRExglR/o54mrXTEKofGOD
         +Ngg==
X-Gm-Message-State: AC+VfDwzAFybA+UswoMzrb1RKR9pCPP8ebZpbXQwaOLStXURpF26dN5R
	/Ty3k0gGDrcDN1X5ghc7Jg==
X-Google-Smtp-Source: ACHHUZ6XJ+ZFkebCF8NC546xBx7A2ojmeoJvmfoBvqESQr95XaWXzKYN+pOCSMsAkufTN/TtDw72Tg==
X-Received: by 2002:ad4:5ba2:0:b0:61d:be1e:7c47 with SMTP id 2-20020ad45ba2000000b0061dbe1e7c47mr4053425qvq.11.1686960330278;
        Fri, 16 Jun 2023 17:05:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.176.196.124])
        by smtp.gmail.com with ESMTPSA id o19-20020a0ce413000000b0062de6537febsm520430qvl.58.2023.06.16.17.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 17:05:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f684967fa27c0d051ba3668c45f89ba1ba97a03d.1686584384.git.pabeni@redhat.com>
References:
 <f684967fa27c0d051ba3668c45f89ba1ba97a03d.1686584384.git.pabeni@redhat.com>
Subject: Re: mptcp: consolidate fallback and non fallback state machine:
 Tests Results
Message-ID: <abff3af8-b94b-1dcc-c93c-165bf163130a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Jun 2023 00:05:29 +0000
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
com/task/6606173932093440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6606173932093440/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5339536536895488
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5339536536895488/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4977933308133376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4977933308133376/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5902486490316800
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5902486490316800/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/963096f42347


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
