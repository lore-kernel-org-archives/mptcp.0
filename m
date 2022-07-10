Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A01104
	for <mptcp@lists.linux.dev>; Sun, 10 Jul 2022 10:22:37 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id m14so2227190plg.5
        for <mptcp@lists.linux.dev>; Sun, 10 Jul 2022 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=yo9OstGTwWsuMwXd3nIyvrcZGqrD5OX9yiEkQJVy1B0=;
        b=T7bjkanRR8Kr2IordN4fNX656438CFKbPMU5C8DYHpxPzlfJKpDSnvAWYtFOZPi+It
         Vj7afbBtSx/KhwMFMjDTt6kDOOQ3CYswb0wvzSIZMqHEWpAMNa4346cA4XE5zRWNXEXM
         Q5bZhCKLo9r3Auw5OhLWw1VpVIv7TyfCsbPMwJSQNnX6olN7Klna75ku/rEZOqO2D7AF
         cQ4YwmKCaj+A8251pwbA12SV9M3/Fd2S5ngr/v4RJ7m6ugSGKhmOYdPjaASBfPf6uCyj
         NYQdG10il+elv9N73ECB0u63LJ9gcB5qAT2gn51DUs15OWn9BisP8ViQ+IEipZjhftEn
         QvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=yo9OstGTwWsuMwXd3nIyvrcZGqrD5OX9yiEkQJVy1B0=;
        b=D5Wi58VGXCXVryOKJ3vLPjl6ieWLHYl6aLGkoyz9zQ+GST6Q4TLKCFzFpPtT5lmdxH
         2HoFU+fuJ4LiItAERZPpaK2ytekwjy8W2plFILQPOAwAyDYeUerYgz9Ju5YgE/Q4O3lv
         2dscvhp6xE8AYqUMX6JWCPdscFtc6k5M4h3/HkxOT2n9Lk+LH5QvRqwdSvItdENBPrDf
         GCRntfMvTacIEICm/konvSH2RLpx4PT6UokMO8k9Yx1+sKC723cLd5Mkbc9X8ef8lfaP
         EWRz3ZKRDNeofmhunsPmeqUtu7ct0kpAHcN1kllxfDUB2q+2Gq/HHu/XTO5/dtR8mQjc
         3NJA==
X-Gm-Message-State: AJIora/4Oal3rPza84iRMKNYbHS81NxlwOMJmm87e7ib5EdY4BJh7RqQ
	k7DVcFnAQ46sB94Fw/yfU4VMEKNlTi7Z
X-Google-Smtp-Source: AGRyM1uGrqgz9Daf/pLf2O8AcNmJe+y7x+pY4zAY5LJO2pRphmazoDC+eMu+hmGcXCD8+Yeoa7ymhQ==
X-Received: by 2002:a17:903:2350:b0:16a:4246:f1b6 with SMTP id c16-20020a170903235000b0016a4246f1b6mr12377267plh.35.1657448556570;
        Sun, 10 Jul 2022 03:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.130.122])
        by smtp.gmail.com with ESMTPSA id y64-20020a636443000000b0040df0c9a1aasm2247746pgb.14.2022.07.10.03.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 03:22:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
References: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
Subject: Re: bpf: fix 'dubious one-bit signed bitfield' warnings: Tests
 Results
Message-ID: <7b96d4ec-0aa1-1c0e-f629-4a86a680917e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Jul 2022 10:22:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4727107317137408
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4727107317137408/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5853007223980032
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5853007223980032/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d7dfacbb3f1c


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
