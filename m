Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265A21DDC1
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 23:31:00 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a6f87b2993so2496617b6e.3
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 16:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690846260; x=1691451060;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mXKqc+k3XiDQXwxrD/zdsXznva8H8kO8dWjG8ISct0=;
        b=YfJIPK/Div3uvKidipdbRJ2tu6w3YYhAWnEB8Lwe4A4Vby2FIU6GkLIDkBWH5pA74W
         /SN5aScXZHhhWkCKL59rOQIfSuEDM8/RHv/tx7imBidfX7oOoMNBJUFKdwD7wkjay8Qu
         qLHdXpahOSxwleu7G9Sh2o3eOGhaKeAS3dTO0eeNcVku/lgya9tuO0J/LPOFZ+XbQXx+
         gPqG2IIoxbA1zAsOLXaOniSYESstNb8v2RVEm3wYS3PbhfLBGXjFzgZSK4OHIxBaf96J
         Ig18CjlK30i0mxgxUB06nPWYhkwk8IrTyj1IFgjqlSqhRUiHZx8++p/GL5X6dOgtV3F1
         cOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690846260; x=1691451060;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1mXKqc+k3XiDQXwxrD/zdsXznva8H8kO8dWjG8ISct0=;
        b=D9OOh0+tosSrWCO6+aZn+c8gVWEFyDnWs79oE88KofjcIhhvyp2/AnxogzWYBljpUh
         rrasocls0PS5CWbxTjAQSUERbCSuG7BF49uZpsKVQVDSjz5vul+GNJY04cHAf0anQhEB
         tfdcrAYd9c/Jdh251y0d8x/TAYPoTntXUWH3Q2VAqjvj70MEieedE1U0m44okcCdwpJH
         YMWeLtFJ/Od2jaroP/BuWrrNJsgYoqPyIH2a8XzRCladRTbef/AIe4127i1pD+lD3qwu
         gxFufogk6P9rYAafjRaloDxPChHJguXUxxxuw4XS8S1Las9HOPl0tIgGTV5LBdANG144
         D9pQ==
X-Gm-Message-State: ABy/qLZ2MGY3k9iM+ULgBiG0AkbdmwSjeRRR9kA19jIvTiQqr9pV8KfT
	Z/L1ZHLLBFDyeu/tBanEDg==
X-Google-Smtp-Source: APBJJlEwokv9da4XtX6BEY3v3iOgBXfYZc0BbIduMybx4N6a7tbSHddQjr6zKC5VcsckZKjwxpzpyQ==
X-Received: by 2002:aca:1c15:0:b0:3a3:eabe:7fc0 with SMTP id c21-20020aca1c15000000b003a3eabe7fc0mr10751892oic.7.1690846259799;
        Mon, 31 Jul 2023 16:30:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.245.144])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b001bba373919bsm9085672plh.261.2023.07.31.16.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:30:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
References:
 <68f1f65f9b5542fd200f995844f7ed71bdfbfc30.1690840586.git.pabeni@redhat.com>
Subject: Re: mptcp: fix disconnect vs accept race: Tests Results
Message-ID: <6bc65f8e-1467-323d-af4b-7e6a14ef6b37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Jul 2023 23:30:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6609590159147008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6609590159147008/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4780002810527744
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4780002810527744/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5905902717370368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5905902717370368/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5342952763949056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5342952763949056/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2cd41a724bae


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
