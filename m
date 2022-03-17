Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586C2F31
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 17:25:14 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id c7so4886941qka.7
        for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=FkGxokrvq8Ns2IQ34j5MCDidUbI/6GPOEQW3MYxMWeU=;
        b=VZ9/myBwIhCJTnDUfU3JqmMyJwNMZ3UWzD7UIIYsnyCpyfDwF7vx/eW80YwGskZaZk
         xDQv5JBf+asAF7XUODj03Nkx6tzZ8rU/LvUdO9pQ1FpLc+g+kehhSBWGJ4UpPsL6z3AC
         Aky2GiUHk4qLaNNq8lAoqDtWX56J8DWqarG566U0MbJHf8gfg0tl7BczjOrG9NszrSEx
         wpzCnycJCGYzl7e63FzaLQz1kPl8h1Be7yFIkLBQUDs5Fb3X3jarlQnJuD15ihfhPJwm
         qXi35NCnTiZSdCExJjYJjtyG+vdm9dQxcGDhpFd9PVDLrCpgsi5N9zXzt4gK/jaqVRdl
         bGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=FkGxokrvq8Ns2IQ34j5MCDidUbI/6GPOEQW3MYxMWeU=;
        b=aFuQQa6zBT7a/OnwSAiTtkQV5FXDnQurrXTn9HoNSSh/KQwfHq5s0EjlMIRgC1HbpX
         ws/eqpJSOjLz66tMV0n+FKnvfFA/agiGtRuWo/oapk3XuSapKCYVSjMZBRK9HdaPb1Mz
         hdcXpmhaX9c6tjXZxJQopRSq9t0kL4Tc7ead/qPE0GUpL1COFkepzoLSXF/+8lBv4lAr
         Fr5o100sFLNiTPoiihaRBv3PlIfIRzfCeCBeEupyDSG0E0GkZm71LmRIptRI4saS0Ci4
         n3XSSV2G1hQ0wYLkHZ+VvFEZkeqSwzaf7iyuPiaJ/Kw+aZm8UVf9lFJjZLeTZnUEqd+b
         Ms4g==
X-Gm-Message-State: AOAM5320nfn+7J80lBpgHoMdiCeaPdz6WguWthlb3bNmu6bs0AjqIh4J
	+3BUjiVtYp/g6UZ1kSYwng==
X-Google-Smtp-Source: ABdhPJw1H6TR55pY1+rHkRb9xC5N32485gApulx9+5hgrmIHC15N3mI7ClSWD34k6CordXH5EeHguw==
X-Received: by 2002:a05:620a:f98:b0:648:a980:5161 with SMTP id b24-20020a05620a0f9800b00648a9805161mr3529364qkn.545.1647537913490;
        Thu, 17 Mar 2022 10:25:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.81.69])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm4221125qtx.58.2022.03.17.10.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:25:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220317153453.665359-6-kishen.maloor@intel.com>
References: <20220317153453.665359-6-kishen.maloor@intel.com>
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Tests Results
Message-ID: <364cbe53-99fb-f407-e1c5-cb745e598931@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Mar 2022 17:25:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6641200433201152
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6641200433201152/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6079457634025472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6079457634025472/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3e17c518d8ab

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
