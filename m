Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896892917
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 14:57:26 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id u35so2122862qtc.13
        for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=axq7PVhXkWYoR7kD5JxoangwM/EcKnnhFSj0yN/63vs=;
        b=ORFIcuCghm1gVVzwclD2murZXQuwGxjJVG16zFNbSVaQ8Bs6+SBO59qb7QaZPDe7l9
         7C78tQq7W349MABXsIg0Unsqb8/ma8wAWwEqACK0+2N6pqmCAaEuQJrsvvHqg8u6brX6
         97aIkGEXrd0p8Ew0hXmisdwK/CTVsI6GuKx5eIQ/POXJCCf+HtuAZP7gYqLwtjxbM0ET
         RePT4UYAEp0j+sQcEFCon4YxeCQqFeFX1n+B2rInZ6hFmzgzKAzgYW8QvaFiVNofFlin
         UwW7InWyAqLAJAYn5A/s3cOr3+NEfvNBIl2IoZt7OTxCusxBVBIezl37WuQhvfisJM6p
         WvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=axq7PVhXkWYoR7kD5JxoangwM/EcKnnhFSj0yN/63vs=;
        b=fl8ZK/0KlA/C7NjPGrVTwKNzWhY6+j+uHzTJhiuG/jHRh7JYyJK815V1PGyAyFrHB3
         KRDtJHuSK1GBHgjcenY3zvucx3tkCbOhjh4yFxx0EB2qRlQAdjOHh3Yo5EZkRiIEht6a
         In+Dljkn9mrFDrlG/uSZV+YVLbCoPqJ5Uqgus+6Ev/bYvwyzZd4FErUWVhHg5gLw9Ftw
         fHPOH2CA6qTdHWJqA7S0Ty1DamNtzz5qcA5MdJq1NtvSACAHjAp1YM2m8kOFwn6EzWXO
         a+OidIRTHdF6fQ7grT4Sd9AwiXKCkNykby4f0ahgFN/kN48JQFhBMkdygDtdT/LAPuhS
         eqow==
X-Gm-Message-State: AOAM533Uld7LNFTnT/h9wRGvOakljiC9+yXXtUFTNevtwVi59L1gLkJz
	u1Rx5NMV7ltT1k0bI94H8Rn/bi0Vvg==
X-Google-Smtp-Source: ABdhPJyLOUBR3mL7pAbz9Gtldc4ha7dI1sUcjDy2p9Ba0cPrW5kkNaPflQqTNeR2kirMeFLlUXQI5A==
X-Received: by 2002:a05:622a:105:b0:2e1:d653:c325 with SMTP id u5-20020a05622a010500b002e1d653c325mr24672191qtw.75.1652281045348;
        Wed, 11 May 2022 07:57:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.29.147])
        by smtp.gmail.com with ESMTPSA id r12-20020a05622a034c00b002f3bbad9e37sm1297362qtw.91.2022.05.11.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5e05ab9275671ea3018eaa02028197817715de65.1652275377.git.pabeni@redhat.com>
References:
 <5e05ab9275671ea3018eaa02028197817715de65.1652275377.git.pabeni@redhat.com>
Subject: Re: mptcp: stop using the mptcp_has_another_subflow() helper:
 Tests Results
Message-ID: <7e790e8f-49eb-9aee-9e82-7960832d7edb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 May 2022 14:57:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5945895240859648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5945895240859648/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5382945287438336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5382945287438336/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b6ca0ca322e2


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
