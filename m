Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944627F6
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 09:45:06 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id h196so19259473qke.12
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GwfBEEmvzs7ZFO3JpgVpF3CQdY5SX6c32mW9hS7hei0=;
        b=Htl5ibj3X5z4zfqQGIscDfxUojnHNDsD3hGxwgOPEtAtmFQ3Rl4cOXR3JeuC3quTqr
         7VEaMjui/uB3whXeCl6NcnN5tOoMsG02D4fPwiDL8Hp/HkfzL+afBmi6BvQ4XsaI6Uxc
         CSKqFMqbYlGt3HtpmnqFB18ICOn3SLSSEGZmjlXbAIZryK4vZFlL0q6pP8Bgj0ABiE0N
         T2+k7FZAg2zbZKKp/ih51wej7LLKSI+SBl+bMlKOp+5kQOPVgrTz88dqMqj67HU1JXD4
         OrHBewasfKwoem0rnpqZWY8y7zo5uZt+E21zLq0tFx1yv/O35jCk1yfBXOgzWjX3GMRH
         mS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GwfBEEmvzs7ZFO3JpgVpF3CQdY5SX6c32mW9hS7hei0=;
        b=yVE68tkImB9i+KA8LgrdlnO1UUMn7P1VguJwT+lxkjlZaVL6PtkN3H5thE9p7lr+UP
         BJfNa0Xf0Ug3aqjIY1DBPzlhr4JDl34n1WiBTbMF/m5SaqjYp3H+nq28c5TKu88hqr9f
         XVakGGjZ7zn6gpE7YAvglQchSbM/lP32aGGwawromNHJMTMuRBBq/ZTSp3SbXI56o1Fg
         8s4Q4UvUXsgolxUwFn12kGFL4GXj2vMscsDCt2wcMhQU7ckZkJnzhX2UNxIRM0lCgzYu
         KIOKLx5T29mwAZt1K4a0KGo5Z4jiQlQKZwG6TgQTkj5dbgox26wFRD12hax+YK2pf+s1
         xSxw==
X-Gm-Message-State: AOAM531GZeh1M9bWS+hYQVg7NVwuBHzsHlxg8ZOjNmE3BBIbVJAyGTTX
	5LiFdFtuWDeXAt0gZe+HFiyOWaWppQ==
X-Google-Smtp-Source: ABdhPJwBZ39EbWfz3TKopTlkt50XpIIUaIp/6pw64ANk3Qb4FyiNjQHc2BgllSvZ4U0fFiDjrG/HEA==
X-Received: by 2002:ae9:ed97:0:b0:67b:2755:310f with SMTP id c145-20020ae9ed97000000b0067b2755310fmr2636636qkg.117.1648719905436;
        Thu, 31 Mar 2022 02:45:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.230.65.29])
        by smtp.gmail.com with ESMTPSA id w3-20020a05622a190300b002e1f084d84bsm19752062qtc.50.2022.03.31.02.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:45:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <edcb9bcf557a7205a8301f755688dcbc22b279e6.1648714427.git.geliang.tang@suse.com>
References:
 <edcb9bcf557a7205a8301f755688dcbc22b279e6.1648714427.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_bpf=3A_a?=
 =?UTF-8?Q?dd_MPTCP_test_base=22=3A_Tests_Results?=
Message-ID: <2e63acec-06a1-5a7b-427b-a0e89e35cdf2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Mar 2022 09:45:04 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5976582060769280
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5976582060769280/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5413632107347968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5413632107347968/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4a7e6dd72b59

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
