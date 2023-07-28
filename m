Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098C3D86
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 05:59:22 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6b9e478e122so1496293a34.1
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690523961; x=1691128761;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmWBOkpCOJ5pjRuTr6ezx++hKCCcTo9lgxSIRl7iSMc=;
        b=mGN9rCALdrFuMf1O77NAiY0ziNFVAxjQkpTC4KCwVkaurrCkozM4VR3UWWbxTg5L+5
         yaTH2mVHBxlnY39RVTkEtcCdZWeEkJiiUNfiPWXLbK92EGpq0VwnJr2j5Rna2v+ZKJl2
         uaVuDG+NKWlcCJWsiZ2Z8O8DbzYDWifI0+EhZYF7ZywQ45Yu30HH96IPkASvO/q++yIg
         TU56PxOAb/VWkMoblo1Cf5UCI4KvvI0iFJRHzj8gKemeP3+sa/a+1P8WB3d/wo0rZWox
         UkOtub1D3MjNzy+xb9FJmdbnN87zS+heTLsetXz+PLJlHqy0yoYT9tbp5nwq2EKZqiEY
         yC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690523961; x=1691128761;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmWBOkpCOJ5pjRuTr6ezx++hKCCcTo9lgxSIRl7iSMc=;
        b=MI0ImFhF8WJRBis+J2ceXkqIin0VpXdfOH3JLxRFx0yNkeiiRH7yPba3cFt4QHX2Hg
         cqsAHOLOIisSowHsjPmXYNtLbNwEVlL66z/qcB4nhetuIdEYBwcRwa1395ilSDngfAxp
         dnbXx2Maob7BX5eWhx4ZZcJBa8tpiI9ysNN7uxDFPPfx7HfQwLmaX39MI0/SlYHBuhzc
         9G8sJE64LvhwFyNqx8vy8/cjKzXTJeRkKv8307BVnoNSFoQBa8F3VdToo6Csr3yAEmJr
         7Qbe8YXSdl4iMjCYgpoUycwihbMYAYv+b7AThr9vsD5cuisoG4auJntQ/XIiAPxKmerC
         x5mQ==
X-Gm-Message-State: ABy/qLYQBXf7vkGXduFtk1TSQZ8v2QsjN8UQWN3bH3nuRl/eZxDk1cA6
	8RgDwF49MfS+HPRHvKZjsg==
X-Google-Smtp-Source: APBJJlHecK3fO/d6nMGYv00iKXOTyMG0PEdEs+gZ2rICWI+4iSESphZsdi38qGDcaeyIZvFUPpQ02g==
X-Received: by 2002:a05:6871:693:b0:1b3:f166:72da with SMTP id l19-20020a056871069300b001b3f16672damr2110540oao.41.1690523961088;
        Thu, 27 Jul 2023 22:59:21 -0700 (PDT)
Received: from [127.0.0.1] ([23.98.137.108])
        by smtp.gmail.com with ESMTPSA id u2-20020a05687004c200b001bb015f61fdsm1459049oam.30.2023.07.27.22.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:59:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ee258a29aba5deeede5aa200f53a1d7e9284817a.1690478147.git.pabeni@redhat.com>
References:
 <ee258a29aba5deeede5aa200f53a1d7e9284817a.1690478147.git.pabeni@redhat.com>
Subject: Re: mptcp: avoid bogus reset on fallback close: Tests Results
Message-ID: <1c30c2d5-3c5e-dcb1-e0af-fbbb70e2fb27@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Jul 2023 05:59:20 +0000
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
com/task/5479657076686848
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5479657076686848/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5901869541752832
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5901869541752832/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6019432879751168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6019432879751168/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6605556983529472
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6605556983529472/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/48e86d20b7fc


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
