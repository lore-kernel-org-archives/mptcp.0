Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725CA1C05
	for <mptcp@lists.linux.dev>; Thu, 22 Jun 2023 06:26:02 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-763a2cc31f3so13557785a.1
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687415161; x=1690007161;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP9ULyv76925QvohHRazxc9vF60AFHWVx3DBJW89CpM=;
        b=a9bn682HIzGd865ACYUov+nzgGoeJcNcPGLjbDHwSFrfR2q0eX/SbO7dR71b/gDZCL
         gwUEJDPpmZuGs05xkjrrHhmbRmeWppWBaHRQaJvW2tEOhWmGHH4PUEJaWkFV2GsfxJHM
         /8oADLF9Cezish4PJvF/JqxiMKMCKawDkxQyYpV3AGovVEM4Wga1rRtns6k2G8KVKLvY
         /Ve8iZH00UEhSw1OJ42PTjz1ZQICzsIFFxpoopLx9P5H7KN5zU2gOSD3Yj5vSkJe+qtf
         wdoIM+o385aaCB9y/CPfN9iqWV36dpFADoUnPQTaE6fkZJ/lw7CTrHDfYEgMCky0md9G
         yJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687415161; x=1690007161;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WP9ULyv76925QvohHRazxc9vF60AFHWVx3DBJW89CpM=;
        b=BTURnF4b5FTtYJfUsNuZnfmW5cyyyb343ZzfrYSsoSzO/x8DNnJ1fN2/E7x60sGe34
         aiIr9KDnk0xwh0IVhziLh2AcugjTBzOTvFLXpnFGb6Lm/EQ7FCEAqFdvTb3QDyc3g+Fq
         0ybVqYbR7PKAt6nb9+cF+zvKFrHvFo1vKmwDDIoVA/Gl0B5NFsV2du3Aj23sBVJEzAP/
         Rpz+N8UJ9+B8rmzc8sQXWQ4ilPaNAkifLGLccuGkqG9r3PZcoBntts+sGnMMBP+SbOSC
         bbJWl0SWSuINjXgYxYr3k9jZ21Zxx0g4BQXglk+8959fr4HMd9zwwuDsrEHzrcYj1q/z
         k1Dg==
X-Gm-Message-State: AC+VfDz31aCrSK7S3lsRXKbX+W/svyW2Yindxd7z4dpbVGJG+NAB2nZi
	Bk0YZtyqxy8+GIfqYlUsNA==
X-Google-Smtp-Source: ACHHUZ5SFApkG7SAI9Md4RxmEZ2Rbelzc/fZ9WZlExIP3MtITcDjApHvYKZMMJawsF6fiQNuB4WYEw==
X-Received: by 2002:a05:620a:6089:b0:762:8448:f0b8 with SMTP id dx9-20020a05620a608900b007628448f0b8mr11614478qkb.34.1687415161072;
        Wed, 21 Jun 2023 23:26:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.191.76.25])
        by smtp.gmail.com with ESMTPSA id i18-20020a05620a145200b007625382f4ccsm3054864qkl.69.2023.06.21.23.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 23:26:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: "Yueh-Shun Li" <shamrocklee@posteo.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230622012627.15050-9-shamrocklee@posteo.net>
References: <20230622012627.15050-9-shamrocklee@posteo.net>
Subject: =?UTF-8?Q?Re=3A_scripts/spelling=2Etxt=3A_Add_=22t?=
 =?UTF-8?Q?ransmit=22_patterns=3A_Tests_Results?=
Message-ID: <3f349640-50c0-c29b-4342-42469db4f62b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 06:26:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Yueh-Shun,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5655707131838464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5655707131838464/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6218657085259776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6218657085259776/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4811282201706496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4811282201706496/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5092757178417152
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5092757178417152/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/14fda5c08232


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
