Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793314477;
	b=yShU7VNeChmfXVaEUnAaICTpb/A6FFJ5bxDe2E9sT0ax8RU9EipCVHpeCDfXV1Rcggak
	 fwcxIf3fgLxqMigT/Q+xl6L+zS+KR078I4XADrV9kmpfhBQXkxMgRF7XDcraEy3ZETjDR
	 Ue3HyrRlHod4bd5r3eBDQiTPmIocABlrLbnR2ad2JRB+6ZrYWKx3hYqadvnCtQDxtbwKj
	 4uy+iSZHErpnCka+yvwaCaNEETuX2ai63sXk/Aky0o7tQNAYWyXIidmSo11bfL1JUEmD8
	 LmlohyeQTv6BzdsvUGS3xgvMgJBfoJh07+zyrcrsA1umW0zqhkPbICmCSovFkLH4ArQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=4nAG/XN4B5aSHSgoDVFlC9DmR6Zz9KnXErLpiHuzikk=;
	b=RdS3p3KWwMm4sypaTTGUgevMV5xvOshhMet2uSd88PMKR0fL3jNHVcYpVWTdglMZWIbw
	 sN1tjEBaqnKOfEEJASpPfJyyYVrTO1w4o2OKE9FtfExCPycaw8jPKXrScjvezOBiIKRWR
	 jh/sSbYDr6rIPtsO405SbVh5xC8t37YOuVsg/YQ86LwYPymlzTgkDfy4SvFR5GBiNBTaz
	 elSGkoTtF5oDr6UE2qh2NncNb1uNZpS01zi+Bko7CcbX7T8BY/9qEaEH5ivG6q+JdQent
	 OqijTHaezDx4HJKWzwzKrSF5jrTON1wWS1+4/Tq3t9hAyJ5wnpuwl+D29Uh4CC0bGSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiHLW9sg;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F68606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 22:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35F68606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiHLW9sg
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so56422a91.1
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 15:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793314476; x=1793919276; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4nAG/XN4B5aSHSgoDVFlC9DmR6Zz9KnXErLpiHuzikk=;
        b=WiHLW9sgQ8yjE7mzZkXab1fFMA5F/cI5MyzNx5Zqix3TqwHFeCcytdTHg+KdwEae0q
         ughtTFTQ3ulJ/jzW1QJatxF9XCArrlL6k7ZLH2eACa8i45IlRg0/LXn2RE+e/qATrcg1
         gs2PxzH5cPjFxcPk8d2WICdsZfqh1f9pJck/gmzYNIzxm+ldyG+UzM1Kj1joH04qJJu4
         dCS5MQ6SOPy8vy1jxKnyZuSWhJ0B80A98SVvyQBjj+XCXIdJf8koiVsoAhAR4cShdhsX
         pQoiliqT7t0U0kQZU0+hU6/dZgCvcBZpXA8gbaSlti2tg3tk3xQ4jPSA1OwbBjByr7Bm
         tnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793314476; x=1793919276;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nAG/XN4B5aSHSgoDVFlC9DmR6Zz9KnXErLpiHuzikk=;
        b=Ub/0XNQsE/XohpYyQw5RjxQn0LVqiJ60PkBG/R8Fmpf5kEIcNZq5mK7yPL2aQ9+juT
         XF9Znm6+FGoB1puKViRq2EUmPq07BWTTsV11TyrMUALHXtRzU0+tz2d/z8SMPMW2+sfW
         RSrxdWEbgfCKLM6lCjmk9OFmkdosxgqRmNMi+2PpkkwL6YNXB1U/gu7kMKTt2WUMXMZm
         cZzTIhZ3sE+EYO+mBZz4FNZCXGyRzmMgZwd/n7emCrmntTep4DtkbXbc7AvCNKE5gWRO
         QccJqlGlxcBrn2+nfZWQpRtMvxapx+3NVHlpf+9sgG/27hyN/uqFsiYUAw6z678D4FXh
         bCNw==
X-Gm-Message-State: AFq9FYIIlFNWhsttFrNj3hUn2gI3SWngCofdsEL+7j4mYAwgoCGRwqNM
	QAOwoiuZ1WelrfredyP6plycP+2RediZ95aNvLjCRasehMcEZarWvdYrdEJc
X-Gm-Gg: AYBFou0vH7OkWfUmS6ngkGysWMoXOaRTYwDqLH9qPpacNe+SxEBbOJgZLWa0ouoxNbq
	lmT2rTVl0EO+EjMW5VqsIudYONN3GzFytDi+pOpkYfiLJpvmMR+zBeSKfmylBh+S8wBbRk8+HcS
	30Pjinb46hi4Nb/dsuT/V1xABcEy1JjwFlY81OvJrXjy1opqoJNbRbEcFvzLiJDHyrzqcUopVFl
	tC9BcunXWCIdWLfeDOJVPxdzHM3HdUPRPrWtZM9896JFi4KbHyXjEcLR2jGR4fwenhBJTUblK6Q
	QBPnt15RQUBS45aUw+baOGeMIzFbw+kt7pZ2cIeIhjlupx7/EjQm8vtChCJdFhPvzHlB9jy9fSc
	YrYJXahgZXuYUoylt59mpcuiy9IOF807SBX6JebunKH7nT0rH5p4/dg8lLlEq9OtFeMDJ0uC7mE
	AObBkQYbK+HHDmX3pQQNr+2sy6K9SHP8mSycJexr33sWlY65wqHR/7zG2nNWoolCgcYcs5I513Q
	yLADOCb7MxtIjci114jUTlfbFLh0AcFBaMIUSV1BF42YoitPtZn2DNPAAp55XUpLfwLoK4Smp6Z
	zKxsXDo68LHOZ0ZULh0liYg80wg7uLb2nz4HPkC+LL7DC3trgfrOkfZ/Lzhd
X-Received: by 2002:a17:90a:ec90:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3ae89831a14mr314228a91.49.1793314476432;
        Thu, 29 Oct 2026 15:54:36 -0700 (PDT)
Received: from github.com ([4.154.166.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85cb1bfdsm556573a91.0.2026.10.29.15.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:54:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261029-mptcp-pm-cflag-clear-when-used-v3-1-fa96c11f97b0@kernel.org>
References:
 <20261029-mptcp-pm-cflag-clear-when-used-v3-1-fa96c11f97b0@kernel.org>
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: kernel: c-flag: keep
 local_addr_used in sync
Message-ID: <7cd286b3-2edc-1312-a94f-7ab3ab17ec4f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:54:35 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): error:sched-bbr =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/409575=
19828

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b704bed908d9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196621


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 =
Core)
