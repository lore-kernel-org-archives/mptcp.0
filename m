Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457027444
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJCAMOgc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c735473d1aso39013165ad.1
        for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696951016; x=1697555816; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H43seFR39jNCd9i4rMurfrJZVk87vfepH7xcTKPC3kQ=;
        b=SJCAMOgc/hulzE15jrkyOPoBXIcHTaq1o47sSzAOW2BRNHYX9LLfRpRrGNqgfq96M1
         cQtRCcK4kaZOOuqEiaaHM+6zdeKrE5znI2rmFAE3tPx+BuDPB7EG23PIkYnIQUzUzkFY
         faxADOGb1fDbtHff9FU0IlnOTgS67dzbRsHxkecl6Z61fzpbaxWHNUclFTaxMx/Jcksv
         CFkktdzCxq+LkQhNgvNDMGX4JYLvCEiJ4OUpkK9hIgK9oEI2q/xTD2NjPQvZLjow43sU
         RhEjN83LEMy+fv74W2jP4LaqsZxhjLVeW+eDdi7SyrbrdUMGfWZC0DPg0ZHBhjiLeu+9
         5VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696951016; x=1697555816;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H43seFR39jNCd9i4rMurfrJZVk87vfepH7xcTKPC3kQ=;
        b=d0t24/EqNsqps4AMse3o9rtS3lI89FBmiIU8KIM7v9+iPM1EvjM6EUR0p+bKa1gfnQ
         bHq0+sWjIibltnIk4bWZHZk2K2KJgR+ly34ZTMnunBBu/nYY1gxpwV7pDnjQC6y9TqBO
         2hO+IIkYiFAkrY6uVWHpvpmuC1xTRQTcGYYpt44fpDNSzmA58puUCTgT4VL1iyQi8Hzp
         uzDGu/ofVmCN35yB6vBWColc1NHLx+nwlI92DWYHPtlDrBej7HyL1uqNCHbH8uEDIjja
         xuOZrILqXWm5kUT7eGqy7Qj8oNPob9a99+m/vCiGHCozAY+9KyEK4IgO8OdnepoYcLgg
         pqdQ==
X-Gm-Message-State: AOJu0YzZaBtkTVyaOTZTybaQMVGzvyWjfGrKXmpHX6quM2I1nhbqVadv
	HQwF17dTBM5hzovdNhc7do95gaMAhQ==
X-Google-Smtp-Source: AGHT+IF8LJ2A95/lNR9toFdntecZWkEJRRwH1n+66Ju4R6ubEitg8EIKGPh0KMkcji9YRjFujJTyRA==
X-Received: by 2002:a17:903:2288:b0:1c3:8230:30d8 with SMTP id b8-20020a170903228800b001c3823030d8mr18856483plh.38.1696951015701;
        Tue, 10 Oct 2023 08:16:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.242.91])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b8baa83639sm11885118plo.200.2023.10.10.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:16:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231010-mptcp-remove-id-0-rst-v1-2-5ce17026f748@kernel.org>
References: <20231010-mptcp-remove-id-0-rst-v1-2-5ce17026f748@kernel.org>
Subject: Re: selftests: mptcp: join: no RST when rm subflow/addr: Tests
 Results
Message-ID: <e6c29980-c113-b41a-0ac7-810d782c398f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Oct 2023 15:16:54 +0000
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
com/task/4537659796750336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4537659796750336/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5663559703592960
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5663559703592960/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5100609750171648
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5100609750171648/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6226509657014272
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6226509657014272/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b1a74ddbc942


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
