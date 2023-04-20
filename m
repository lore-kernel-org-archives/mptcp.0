Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5E17FF
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 03:49:09 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so2379910wmq.5
        for <mptcp@lists.linux.dev>; Wed, 19 Apr 2023 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681962547; x=1684554547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggxe6PMhszlXKJWcURqXaN6Vc6e81d1ZBN8c3dAWfGU=;
        b=NXhCb8hxikanBjLWzCWzeNrtHQfLcQ0uujpIoyZTSFFW5qE6tQQlnCyKrNlGR2u6dG
         /a6VvZ0ZDMdpIjx6x89t0qzY0T24uKaJ2ora8HCe9vqrI4jfMthNYJXfMiQfCFD41/Rw
         6OC7X+115X0NhErceO2k+wTBvnhL/hW/7OA4+HVl6gClhJtGreSOP6rIw8QLowuQ+uJ8
         CkAR1nLD7atJh+IbsyaK0vr/qEb3cLBB7aklq5+1mO7ZLP2soa/3KDHICro//XtpAP67
         5E7zvHhYvfFKB7gqvcOZCIhvDIh5JV2L/hoq9aAUi07GuymaFVosedIcosYPCBKpKOvn
         Kiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681962547; x=1684554547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ggxe6PMhszlXKJWcURqXaN6Vc6e81d1ZBN8c3dAWfGU=;
        b=efFyY11XrXvhyOO1YDBOvr4BSMCywaqROSJ5TIT9oAThtUY4syXiOOIo8Y5htDVaCe
         SOnOVgSTFRL4xdXa4tvAGqKnedkVeEumTykLWlGy1hNvZ0aJ9XQpcrOKA5AaMGj3X9I+
         7bVQvlHAaUUyG28WFAwINqs0Edcde03LHMR11jN37HOK8fsB4CsCfqoHv9pNOksBFQY+
         U9WgnXFGuXPDsmGgk4FUiAK1/36DUCAXHn9JgrLF7TJGBQ+SxXjp+vOmoHBDOIguId56
         K+sOsFC4J8/TB+F5yANs031g0r2EBgMH6+hFIGyYNtw9jpTfcwApztuXA/WzO5wq1T47
         3BBw==
X-Gm-Message-State: AAQBX9eMjcts3ymUkrTM5ANFCH59kaXg9I4yIcNb4V6g8NPE6VUPYMkh
	49ulDZOKebgnhcIerCViNwx8n78cMPaE5O7ljP4=
X-Google-Smtp-Source: AKy350Zpi2GolTfDfSdmtUBMjoTrcoHpLuTHcVxGbpHDJ7PZORyL+9fZGJGPT5cw7wsR9dyWCoGP/xdp7/3q1Qrz+KU=
X-Received: by 2002:a7b:cbc7:0:b0:3f1:78d0:fc49 with SMTP id
 n7-20020a7bcbc7000000b003f178d0fc49mr1635646wmi.7.1681962547496; Wed, 19 Apr
 2023 20:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 20 Apr 2023 11:49:16 +0800
Message-ID: <CA+WQbwt06V64hW3V2xos4=CEj6PuhqRHwHBq_+dY4vBwQCfR9Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-net 00/13] selftests: mptcp: skip tests when
 features are not supported
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=888=E6=97=A5=E5=91=A8=E5=85=AD 01:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.
>
> These different patches add support for older kernels. More similar
> checks will be needed but here is a first batch not to have too many
> patches (because each patch fixes different commits).
>
> I tried to minimise the modifications and do the checks from the bash
> script not to have to detect the feature when being used in a .c file,
> then pass the info to the bash script, skip the test, clean the
> environment, etc.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Matthieu Baerts (13):
>       selftests: mptcp: connect: skip if MPTCP is not supported
>       selftests: mptcp: pm nl: skip if MPTCP is not supported
>       selftests: mptcp: join: skip if MPTCP is not supported
>       selftests: mptcp: diag: skip if MPTCP is not supported
>       selftests: mptcp: simult flows: skip if MPTCP is not supported
>       selftests: mptcp: sockopt: skip if MPTCP is not supported
>       selftests: mptcp: userspace pm: skip if MPTCP is not supported
>       selftests: mptcp: lib: skip if missing symbol
>       selftests: mptcp: connect: skip TFO tests if not supported
>       selftests: mptcp: userspace pm: skip if 'ip' tool is unavailable
>       selftests: mptcp: userspace pm: skip if not supported
>       selftests: mptcp: userspace pm: skip PM listener events tests if un=
available

Hi Matt,

How about merging these three commits and "selftests: mptcp: userspace
pm: skip if MPTCP is not supported" into a single commit?

Thanks,
-Geliang

>       selftests: mptcp: join: skip PM listener events tests if unavailabl=
e
>
>  tools/testing/selftests/net/mptcp/Makefile         |  2 +-
>  tools/testing/selftests/net/mptcp/config           |  1 +
>  tools/testing/selftests/net/mptcp/diag.sh          |  4 +++
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 10 +++++++
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 18 ++++++++++--
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 34 ++++++++++++++++=
++++++
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  4 +++
>  tools/testing/selftests/net/mptcp/pm_netlink.sh    |  4 +++
>  tools/testing/selftests/net/mptcp/simult_flows.sh  |  4 +++
>  tools/testing/selftests/net/mptcp/userspace_pm.sh  | 17 ++++++++++-
>  10 files changed, 94 insertions(+), 4 deletions(-)
> ---
> base-commit: 016e68a1441264585c15defedc5ccf883b3b4211
> change-id: 20230406-mptcp-issue-368-selftests-old-kernels-fffd69d67d91
>
> Best regards,
> --
> Matthieu Baerts <matthieu.baerts@tessares.net>
>
>
