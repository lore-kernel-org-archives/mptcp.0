Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1227D62A
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 02:49:19 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id fz10so2107863qtb.3
        for <mptcp@lists.linux.dev>; Thu, 10 Nov 2022 18:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkFcGutfGoAeRN71KxzlRRWDruWH/4W0vHIRtY88NXQ=;
        b=e1aKfxM39F6oz1kEFx21mffsphd9WeHFIm1MBxEw3uFShMjoK33C+RPKjG/j/DL5w7
         +Ybw8R5kPUeZcTvgwK6uXr0t0N+wM9QqAX780gBAyjlK1FSpJYUDBHZ1ne7ibqPGYemG
         vGXot7kNKjSlcj8PPdMyR9SX8v8I7GKSPa8lND9iCB+B5j2yt0IVphtkGiQ91FRCpctt
         FoFh0xBvPteliUFTnAWM/ngx+dGUaVBOsZESHpdo5DxwdQRe6JbFueE1YD3jw2vd+inb
         Kzr+XKIpnRJeHuxmFXsLso7uEtHiXWtpqfBDRZcBTsMWQpUEEPFSrxfa/lKhlmNyu+UA
         puqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkFcGutfGoAeRN71KxzlRRWDruWH/4W0vHIRtY88NXQ=;
        b=wiyIVWZ5RHZI8T2HVJASnNjxkVX/RH4Lza71rcMrvG3mdRvSOT2pWMEkxz7apuAnVX
         IJs1oj2dyS2Shr5tRKQ7t6N/KVAHG1HkxOQS00peTIyoQHBfvABwkgk657lYcnSJqB7q
         3Q+xrt51QaZUEDKTev7mVWPlJW4j4SkBtRga6Rn5RYCWXYBsh3vBPyz65grxvLyMTHnV
         NSUG+kpzOYS68hnDLiWY3e6B4tFbttYUp98In4HUSZeFZNdBfmhHjjrwsJAWJu2HVhdo
         gafABjbvw2iYWh7OfSt24mnEo6lnz0zeV2uiL3DMulooLkcFA0yF4YP6vN1XLCKKNWRX
         a4NQ==
X-Gm-Message-State: ACrzQf0dVfR2MkMieh1pVHIxqmv9vaMxbg+wBq4LfT2SoKQ7yLmGZo/p
	6l0+2f208mtf0jQ8cHntKo7pW59qCGXh
X-Google-Smtp-Source: AMsMyM7kNU1OI8WYP/+iDpTqDDEQNQCs7TM/IHI4hnl1LC2XWhPmjnKZRrIObVvLXzAGw2YKo2YIAA==
X-Received: by 2002:ac8:5518:0:b0:399:4a68:c578 with SMTP id j24-20020ac85518000000b003994a68c578mr2727026qtq.202.1668134958983;
        Thu, 10 Nov 2022 18:49:18 -0800 (PST)
Received: from [127.0.0.1] ([20.119.253.223])
        by smtp.gmail.com with ESMTPSA id r21-20020a05620a299500b006e702033b15sm758803qkp.66.2022.11.10.18.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:49:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221110160017.3641527-1-matthieu.baerts@tessares.net>
References: <20221110160017.3641527-1-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: fix mibit vs mbit mix up: Tests Results
Message-ID: <320538df-a389-b2c1-5a8d-3547e451c9a0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Nov 2022 02:49:17 +0000
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
mptcp_connect_mmap =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4553270654926848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4553270654926848/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): mptcp_connect_mmap=
 =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5679170561769472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5679170561769472/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ef1457226f20


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
