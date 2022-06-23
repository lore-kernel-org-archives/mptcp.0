Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71943C9
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 02:39:42 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id w6so10611479pfw.5
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 19:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=cl6v37rd4XFYLcvySPHFatISy+pwb5KxWrXKKZwOza0=;
        b=pnc4PT2KzY/A+toYtS5RbdNjG1FniuM6oRiRipTTAr0ZTYYCqpe3Sf3ojIXeaDTLZj
         ybaRZidu69mpdsonqaIOg5xuX9g60RjU9S5/snsAdV1sFUVWw0/6Lvstds2ji+CP0a2w
         oZG14kkLA2Y1IQqGmn3hOJ6FD+S7K3N0mu0Jb3wySw/uoOA4lrvMAVOhrgnA8zazSmmO
         INsMuSPraaLp3CJ4WeM8emkpQGAX1FMe9nLDTAGdIIWuVBd3DufJZVCZoux2YiOXgC8F
         acQehTbtiiNKEHJxr48nZd8eIX+DsPYDgcHzUvaja3IRl+VyRGKJu+nSGQ5Rau5tWcFo
         9y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=cl6v37rd4XFYLcvySPHFatISy+pwb5KxWrXKKZwOza0=;
        b=FHGP0ZHet1az0JpcVDD1VBzYxAv5K5Wj3eDZlj/L3qC+5DnVSgclkHIQKgmtWgClmn
         yE9irx8M28xnXsHDHxlc+c9HUCX7YbjfKftc/Ds5XlkoTWS97L/R4fQrvS+7A5plP+eq
         eGvChzJhBSag7RehwIa+1C55Gtw0goU89om39meTcrhaLmlW2DDgc424Y1T4KsJbPfdz
         XoUxuE9BknWEyy8mZekDdMmUt5xr1XtVc1BJUB7pYuNo+LFKRFEXAvxZ0wRMl5IrusKQ
         Ezk3zf6VAqGXTopUfI+VV28jdPseD/6pVmGDaA/o4EB7TfgePS0PMCV4XYHjbMARn/uX
         QbPw==
X-Gm-Message-State: AJIora/KRCdMwaHAqLp+G7Su5U0QT7mn6P/MuAAT7Cybz2Dax9JourWG
	MTtPDyBgxTCeELklUxFlADH5DLDQ4x2O
X-Google-Smtp-Source: AGRyM1sICytIAUUDvr2/y8EYzY0A7+VGm4eZfpvEzqZMCyMAAwE3uYKjIOcigs/317WQpsF2YYzQwQ==
X-Received: by 2002:a05:6a00:1253:b0:51c:e1e:9990 with SMTP id u19-20020a056a00125300b0051c0e1e9990mr38384833pfi.5.1655951981748;
        Wed, 22 Jun 2022 19:39:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.118.160.120])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0010d500b005251c3e7ac5sm8221347pfu.166.2022.06.22.19.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 19:39:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220623005948.291792-3-kishen.maloor@intel.com>
References: <20220623005948.291792-3-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: userspace PM support for MP_PRIO signals:
 Tests Results
Message-ID: <9c7cbcd2-c4b8-d1aa-9486-aaed50537871@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jun 2022 02:39:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5203766143090688
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5203766143090688/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6329666049933312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6329666049933312/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8e3d235c3079


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
