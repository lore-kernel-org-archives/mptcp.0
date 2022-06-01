Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B282562
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 16:02:38 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so6719903pju.1
        for <mptcp@lists.linux.dev>; Wed, 01 Jun 2022 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=CBIhShLC6JaeiJK7eMWMMkS2trzal4a0bL6tE+b1GjI=;
        b=Q+jzAdYEUq9SAgekCQVNBuggPOatqj813xtooWIA44q2pPotZz7bJDPmdMo0T44Dkd
         vFacQG0cWswKBdVXDGJQ0v+tD+W/1aC1w8LSiGB0qNGs4Vw4VVDA9LclJGOKdLKYBuW2
         VMe+hWEaxChle3z8vloLZoTgz2QY1H1kfFB8BT9eAofjnkfcl6iAIHaxN2KBwidr+4qV
         XUNSEXTXct4r/K1kEoiLxObTXG2pGwWZyvD+OSya2PHdM3L96/TOsDw0LKdjbVEyhzCD
         TH3WZx7QM2esHOcG2K8do0ucXUp7ecqEmkWxNLdwJRFPVkO64aKIIRaZXYDHXxELOr7U
         Hu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=CBIhShLC6JaeiJK7eMWMMkS2trzal4a0bL6tE+b1GjI=;
        b=8FU9pIRlmTJKrFjdizYUzB8X6kKavmmeDH8vk4MfVJAj/DU+7goN52vD/rT+Z8qEnE
         syQ9/b93jMGaCuwvh9x/cuNlZnNfv6LPEAmzV1rtdsZxQL5mGTkoITCedH2FDB5iVAcU
         27b+CFlk+3KO2W8Kg9LROiBDr+Gl3tYhZTjc0jbRATI8i+x2Qu5a4tG886kBy2HJpMDV
         qdiZkvpiWQ42mkjfG+c1TjmkeC2hW2IlO6vKR0J5lWD6v09mgW9g9cFpQTGg5wA5QT5o
         cF6dtxYHgU8O0NxlvdgxlKppG3KFlTLG/z0mM/z6TXJ19rIysz7pJpumeIARjh8bJdjh
         gQ4A==
X-Gm-Message-State: AOAM533MTl4CY0xzXnByiquI2hMaYv886O5wCVR12faSxJh1V+R5q0RF
	l6zDLRxy0cG401J6dAqowIYOa7Q6gDLT6k4=
X-Google-Smtp-Source: ABdhPJxlTmg09ktTe/F3uECBxi8wGSJDHb0Ww0XAGEYQNQHgvaejYQ2VwNk6hAmiZhBUGcGo9zRLdw==
X-Received: by 2002:a17:902:ef43:b0:156:9c5d:b0fe with SMTP id e3-20020a170902ef4300b001569c5db0femr158895plx.158.1654099358166;
        Wed, 01 Jun 2022 09:02:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.37.57])
        by smtp.gmail.com with ESMTPSA id x9-20020a63fe49000000b003fc7f2eb6acsm1528906pgj.55.2022.06.01.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 09:02:37 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com>
References:
 <94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: add bpf_rr test: Tests Results
Message-ID: <ec766afd-eb13-458e-7dd6-64cc0b9f0cc6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jun 2022 16:02:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6191871876661248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6191871876661248/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4951362948562944
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4951362948562944/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4d61a8b660c4


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
