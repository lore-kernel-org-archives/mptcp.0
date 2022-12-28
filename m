Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212C1C07
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 16:13:21 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id d15so16435411pls.6
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 08:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4RoMJ6DOX4qPVPdQ+5jsZxe05u/5bCGb0XaJZMfYks=;
        b=FS2Ufz3vzLNtmouuVTfcIixF6YAqGDz8x81Xy/+a+S5Qb7Fal/m8PfaPqKvecXGPpH
         DG0Wuhfk/dG1l29vKqMytpW3/o5OU/GyM2A0SzPF0eSabtrsZ26CaAe6a6BQ459xWTSI
         ZhOwJCMHl3ADFh6PMN491rhhfujb9ofc/Kr0ZteVWpflKp5MnPprTfU/g664fwFC/GyE
         uaTupFFy6IDHvCJSzbck/5G4YpiyjueqAICF3elnQF8jdwdAk6ezt1kPx3hg2iMjh4A5
         tVq+EmKSno6IL7mhOvVKwAh9yyem7Nmd2FdSjKyTdDeEH1ntJlgP34N8t0B0poaIksUk
         hjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h4RoMJ6DOX4qPVPdQ+5jsZxe05u/5bCGb0XaJZMfYks=;
        b=NrYS2c6/7CslavqbQic57+BqhPm4em7M2cG5pT0TZbBNCMZDEJ6GCEh3rR7iSUskWq
         f4c8wItpFhlbpuZNw+m5bYnlLNzecmcmE/U8t48Wgv9vgifR+w3vCZCEL8V9ZzhXlraI
         nR42bLVHZ27somvD2Bax8jB9C+twDCPb1WnRIAPc/F0DTX7/kMUWm3b5oA+JU6CxwKfe
         HanWTeV7dFPQnJBMtyDIWkUTYnPHiUTGt7+iI8kyx5U2J2Y4avBOJpP0vpf2MFeHhlrO
         VfDK1B4OfN1BwFYWcfRfdO+68icPv8gXabAE1VjYUiLcuo+WeVHFAQFpft0u2l5eUAbJ
         fIGA==
X-Gm-Message-State: AFqh2krY+j3H05ofPs5NbO8ItpUT205122wh61tCObyy91ce8mfLk4u/
	pD3ODv38jBvid+Va6/KKK/0JLu6H1g==
X-Google-Smtp-Source: AMrXdXvDsMEskncnW5V3zZ6xhxu1e7cxdFCOOZwDvVZeFnH3WtLBbGN5tl/AhYj22cyKXT0BllFCsQ==
X-Received: by 2002:a05:6a20:93a1:b0:a5:cc8f:cd14 with SMTP id x33-20020a056a2093a100b000a5cc8fcd14mr33844006pzh.35.1672244001087;
        Wed, 28 Dec 2022 08:13:21 -0800 (PST)
Received: from [127.0.0.1] ([65.52.126.97])
        by smtp.gmail.com with ESMTPSA id t66-20020a635f45000000b0046feb2754e5sm9592590pgb.28.2022.12.28.08.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 08:13:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221228101748.2518303-13-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-13-matthieu.baerts@tessares.net>
Subject: Re: selftests: mptcp: userspace: avoid read errors: Tests Results
Message-ID: <7f1e13ed-4e34-5a91-76fa-28f5bcc2739c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Dec 2022 16:13:19 +0000
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
com/task/6671667710656512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6671667710656512/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4630974129504256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4630974129504256/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5193924082925568
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5193924082925568/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5756874036346880
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5756874036346880/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/93cb3af31a5c


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
