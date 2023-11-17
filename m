Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DB1A716
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU7sXk/P"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6779fb43e5cso9562906d6.2
        for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 02:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700218687; x=1700823487; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZcBQZPw1Q8JiTo6R1XZrxFsZkd3sFbwtXXH01/whRY=;
        b=lU7sXk/P/qHSmcKUhTvXyqmv3DzMSE152lSgJ80HWwuWVdSZywPSqO+fqJ4Fqsgi4j
         Skd2yXlLpAQCMAtBsbU5MTXsiH7RP7NkO8X6qK9wHshMzrURoJp76JuJ6SXpS1DM8wQx
         4lwYtM9XGtSdk5sFRIKyh2dLjjpg9PaliL7576g7REdIHo1XgVNhLPstaU9elvx/rXLC
         UNWj+4Q1OGdMnoCvD/K4So/rkIAh1SjTjoiKGbvWoW1+bYPi51bdWp6h1UgORDpHSEPl
         BqfYGOok5n4MHA6lC65pEvAKgk8gamQGhOVBE/CDas1Re3Hcu8UtxfIaqrXQsxdojBf1
         44RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218687; x=1700823487;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ZcBQZPw1Q8JiTo6R1XZrxFsZkd3sFbwtXXH01/whRY=;
        b=VMewCa3NsChHg26LA/UXETKPjMRHEGglV1DIc5maLT8kfm7LwAKkLuQ4KezxN33vbF
         9prmTc2mdGu7fog6YeQwK1mNB5GgqFDB5715uYGz3uw6TD/opq1BwgWhH+OSu7PTk/+b
         5XzKuMzApoSTKo1E+M2LKov16Q/VbK0SY6sfJkF1O4nhm1EeQupqISTb4qyF6atXSGne
         mjh2oHtm7j18D0ShnTy6pDWUVMdogX8LkZtBcxMCdwbBSb3cmHDMHBdOceO7s8VLzDJ7
         NI3UcZpecXEoLk7xyfqL10D2kVyrp11rq8OasQQZz5FLC0DgDJvr78eVV8mLL49BSpSy
         K8Xg==
X-Gm-Message-State: AOJu0Yww/kEGwVcA/JPb7VV61l53eDge6jsNi1pgRd/onRFcoOR7Vv08
	8+7aFOZ1Ir/Yh+iI6r8Lm8ySgINgTg==
X-Google-Smtp-Source: AGHT+IG2cgSRiFssBOZdaic6Mt6gfFeqMj7TeNP2kdhwX0pU74jAz6JtYETpC+TQmo8CTziIl2xv8g==
X-Received: by 2002:ad4:5943:0:b0:66d:3f56:ec3f with SMTP id eo3-20020ad45943000000b0066d3f56ec3fmr11436032qvb.13.1700218686697;
        Fri, 17 Nov 2023 02:58:06 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.255])
        by smtp.gmail.com with ESMTPSA id pp5-20020a056214138500b0066d5220d860sm540346qvb.18.2023.11.17.02.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 02:58:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <54dade305d600cb3fa7796ee98e4b930f6c6506b.1700210966.git.geliang.tang@suse.com>
References:
 <54dade305d600cb3fa7796ee98e4b930f6c6506b.1700210966.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm userspace addr with random order: Tests
 Results
Message-ID: <3803591e-3786-7db3-163e-69a4667b5fd2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Nov 2023 10:58:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5611419840806912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5611419840806912/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4538296492097536
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4538296492097536/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6737319747649536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6737319747649536/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5664196398940160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5664196398940160/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/94b90b68d648


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
