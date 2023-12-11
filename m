Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4748CD6
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I26lWjJK"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-425b9acaf80so15220611cf.1
        for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 06:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702306498; x=1702911298; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoBV20V65mLxXZ0Ofw2p/luklntXe3U3RqvtapZBn+k=;
        b=I26lWjJKX+7wWbc9VPxen2DGf2XqeaPi+piNYHkqCo4sGwDcLP5OZtpCi8vNnoDYGL
         8oguGAyYaL/zLHC/95JfUXLcP2fCZsIpxCXXEF9ntWq5UK6t9FURZwfgP48oaahtKymf
         2Rija/VObMY+ozO0G0lTgirPIQJQF6hIr7JoryqbFt58UxTAz1lMdn2YeTrPzk5ymzDn
         9kK6NUmHvN1urSnmorez/HPc4xFnZvDxjG+hbMfmGWCMtmJlhvGChWC2RmqWWguncCVy
         p3VwWo9JoHqhmTGRKrxdgWgmZf0b9/3x/geTMvILsOCKr+qA4OPjRu0FYcf8IfnyFMrl
         w6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306498; x=1702911298;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aoBV20V65mLxXZ0Ofw2p/luklntXe3U3RqvtapZBn+k=;
        b=BLwc/eGFNRhm1xVJQIMHxhMuIVFwZMFVv/D5hCu69x5R9qfmqHI1LZ3P7NPxYI4zJ/
         4UKKn+EiqLHZx6DqRY+27/qJBrOmpB5266rwLEOjBGHWaws4edya9VReiWdQ/Z20xDpU
         MoWvUOXg1NfOScfgTCaFxGQXZPRKQqSSFk+RVkCGDWo6JIpt91MDz/kB/ImyJYwydg62
         rl/Ty63NrKVGKjECuAawXY9HqaYWoszw7cYtwDVfN5c4rXDsR8YweQxyuJenU7EyWbNE
         2s98eXPW2KfKA1ZaYANxIhiwli0jSTXKMJPNuBBtfJ2beVFVI0VYmBPrUN7mzvkdotJr
         CxrA==
X-Gm-Message-State: AOJu0YywtSm1T6wCWBL4dN9GNraDusHx4lUNMo9zmSPUtumHfHqg5zcx
	HBzhP7pmcXkx66ypocu0vw==
X-Google-Smtp-Source: AGHT+IEZXWuF1QkhXE6wq79NHQYWVs36WS+O6UXtebUU4qSHCiLSFhalp34p5bpOTvZJSjSSocltAA==
X-Received: by 2002:ac8:5cc8:0:b0:425:4043:18bb with SMTP id s8-20020ac85cc8000000b00425404318bbmr7750706qta.110.1702306497928;
        Mon, 11 Dec 2023 06:54:57 -0800 (PST)
Received: from [127.0.0.1] ([172.183.50.148])
        by smtp.gmail.com with ESMTPSA id cj10-20020a05622a258a00b004259bbf166esm3165745qtb.63.2023.12.11.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:54:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231211120309.20752-4-max@internet.ru>
References: <20231211120309.20752-4-max@internet.ru>
Subject: Re: selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE:
 Tests Results
Message-ID: <d2b03177-e22e-8922-e34a-4b0e1bc47e94@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 14:54:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Maxim,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6679698382520320
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6679698382520320/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4639004801368064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4639004801368064/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5764904708210688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5764904708210688/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5201954754789376
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5201954754789376/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8c7bf89c57a8


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
Bot operated by Matthieu Baerts (NGI0 =
Core)
