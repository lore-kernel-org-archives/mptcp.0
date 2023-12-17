Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3621FAD
	for <mptcp@lists.linux.dev>; Sun, 17 Dec 2023 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZzoz+ZG"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b7df7d14dso39583a91.3
        for <mptcp@lists.linux.dev>; Sun, 17 Dec 2023 01:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702804367; x=1703409167; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwHA0hBUjWnNQ76kWmE2DostegTwLrlGAIHP/8NPFfU=;
        b=aZzoz+ZGShy06wvUYVRGwFvW+nVJC4VAyt48eLtGv4wgi0nDmHxXVF1DDoG9iz0x/B
         VwagM7yYmEI68IYSxDGjRudGjGL9Kshe4UU49N0nc0KNqIa+Eoq6tQBGPxPYjKJWyrnR
         5tgMM1hLCEqG4HuT+nzICXVcstSUA0OLrIJWlblQTTmhd/Ay7Hp8kuuvDyvUg1B+m2+6
         zkQkVXKrww6xBBM+0C6ZbGDWwmE6l3p/TiAR7SRKxvow72pFy2e4ZJ3ML0Fe0g5qZpgi
         C6xYrfU1bRax3i+nGmG58TBCnQOiVfVrEbst3AWvooJmegKIEL3igXUZkxlJ4nu9b2+c
         +mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702804367; x=1703409167;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BwHA0hBUjWnNQ76kWmE2DostegTwLrlGAIHP/8NPFfU=;
        b=mS3W/ZrN+7hrOH1FaN+1I97Ao9EoiIRTOh/Y5fTBhzWwY17AdpWHLL+ZMWju/xPUrB
         HpIn4O7UchlTvw765/LABzjgQ4jt5jKLQ15GH4nLnLDc9sNn1g98fFPZVUqKT1nHOye0
         intxSLr+zOIvRq+XX7nyUri+LEbqq/EDzc3MOX1CGenvnQdCkd6WkfzKfczKPf3jk+2o
         loLRodezFVkIJt8nO6wM56LwuT57ffkZVX0Az/aaoqFqoQ5AvAQgXJ+e95o8/FmFcqAJ
         cVfGrkugHOxhsAahnWZ3Yag6gA+TNoW4DDOoNg0mm1D2QL3CQVwf7jiz3atl3IDZZWaB
         WBFQ==
X-Gm-Message-State: AOJu0YxPNPmGbc5Eg8/zV9+HJS6sIUqA6iujclu5qe2W6AtI804HeHax
	iWV5MoTwpdkDqYlpNAciDA==
X-Google-Smtp-Source: AGHT+IEQXnY7/f1IEtauXnKnMrGhBZFceZAXmk/yrInpAtgeAeZXQWVY56BWHk5p23Us+xyQNPhLzA==
X-Received: by 2002:a17:902:eb8c:b0:1d3:3e61:eec6 with SMTP id q12-20020a170902eb8c00b001d33e61eec6mr11856180plg.18.1702804367361;
        Sun, 17 Dec 2023 01:12:47 -0800 (PST)
Received: from [127.0.0.1] ([4.227.114.102])
        by smtp.gmail.com with ESMTPSA id iw19-20020a170903045300b001d37bdc4934sm2836480plb.110.2023.12.17.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 01:12:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231217075348.4040051-1-idosch@nvidia.com>
References: <20231217075348.4040051-1-idosch@nvidia.com>
Subject: Re: genetlink: Use internal flags for multicast groups: Tests
 Results
Message-ID: <2ea9f1b9-b538-a669-4f2a-3924150a0dea@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 Dec 2023 09:12:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Ido,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5304333823115264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5304333823115264/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6148758753247232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6148758753247232/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5022858846404608
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5022858846404608/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6430233729957888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6430233729957888/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/45531a413139


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
Bot operated by Matthieu Baerts (NGI0 Core)
