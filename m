Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E5F9D6
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 19:17:44 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3420b22365fso30130645ab.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687375063; x=1689967063;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLhBHNzfUuoi44W54cHDhI5SIy/uikjOf6tIaEdJQjk=;
        b=DrvWkTt9WhzFuRWxrTWUbzmCQHum1t8y4dt6xhuvIYRdXTiXxvQj+8meoykJI3mWPw
         wbGOTGHKGlsID3c16038NJ7fZPfPWkZVQt9WFiocRl+3CaPsBKpG8EQfh+7zAn5RUV75
         /XvmJVPGCqiYMxTjFaCldog2opzB5Tq0CG2CYCU6rYcKtr7aiL1gkBAdeGEV5vX/y3Fa
         ovtGnzs4RFPRNJ2BgAHCOYmOlL0+K0io/2GKAtM2YDZKEqrloFklx1kmJrRRgCsjkDhG
         eIrAE0th3SuyzGSyvQdI0bj55dMaQoz3ddtOEyFuKrW5p7+SLCbEMrcTgOYRgpGU2AkY
         BoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687375063; x=1689967063;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLhBHNzfUuoi44W54cHDhI5SIy/uikjOf6tIaEdJQjk=;
        b=jtkC3GpOZ136EAnP4u76Q4R9LGpfEwXIBYEbj8teOLfRkcBbsWXBN40zInyxTyATZp
         oRzCtlVNDN5STsRtOGalInXl/FybKt5AYBwClN4Zj3CNeHNaT9HerQe8Qyb5PNbx0AqE
         A0atYcxL9aHllUlLMpLGmv4FSjHOV8bQBqW5Cgnv60qcFoNAHOhv5/bmMAtBzCjlx4pA
         pem7x0JP8WrT/mQdW+ryTWfVNsvL1QkuHPwe3eYBIamC+Oabw40UR+CmWc1JyKnCtAiH
         jmbBGrUQmhMwsgccWbSqpudgm7VLboRXS9QuQOc5Yi5QO5MHrspqfYwAc9jcL+cfXAzH
         hR6Q==
X-Gm-Message-State: AC+VfDxRbQZ1np1IEKjsjUklrPULFWBr568ZOvuTAgk5fFzOFmZwP5yp
	7OoGbzsSusJOjWiOHQ7H7qNgun7Cag==
X-Google-Smtp-Source: ACHHUZ7476Ygro047sjyqSsS5StBws7y+PtTknRrB9T4grOVbs6MdTD4IZWfHvLKCkw9GJAflC3RAQ==
X-Received: by 2002:a92:602:0:b0:342:25ce:d50 with SMTP id x2-20020a920602000000b0034225ce0d50mr16243879ilg.4.1687375063339;
        Wed, 21 Jun 2023 12:17:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.22.99])
        by smtp.gmail.com with ESMTPSA id o7-20020a92d4c7000000b00342881b0aeasm1489188ilm.45.2023.06.21.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:17:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230621-mptcp-issue-368-selftests-subtests-v1-18-0cae453ae1fa@tessares.net>
References:
 <20230621-mptcp-issue-368-selftests-subtests-v1-18-0cae453ae1fa@tessares.net>
Subject: Re: selftests: mptcp: userspace_pm: format subtests results in
 TAP: Tests Results
Message-ID: <6845c5b6-49d6-ebe8-fdbf-ee83d801c962@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jun 2023 19:17:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5648769551695872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5648769551695872/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5508489930342400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5508489930342400/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6071439883763712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6071439883763712/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6634389837185024
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6634389837185024/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/801393a9dc53


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
