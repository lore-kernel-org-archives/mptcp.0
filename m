Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419315C6
	for <mptcp@lists.linux.dev>; Sun, 19 Nov 2023 04:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENLjSCXm"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-66d87554434so6723616d6.2
        for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 20:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700368756; x=1700973556; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hu5Sfg8j+XZ+P8XABQlH+Eo6WMIqT9Dd2Gc7lrXYNvw=;
        b=ENLjSCXmOHvAazeC9MAkcz2sfvLlYUMeg3Zp83cT7L+N3AkTQWDAuUIybEoL3x7sTZ
         tvZ6UWSvWVch2hEzR8OGIu0l7BO9pWkBEemG1Ai9D3uZLePUdzIQr4SL4mO35jzoZhwU
         WO9NIzsw/NVOa3PERVbas1sV+MqpFmhBog9VyTcyDdcbLKqneUxIzFCaGzwcZzQoxbh2
         gN3g648j54XzQEqxb/m45Gl08gt06LGoaO3zrLSEl0ahbPJEyKld2SmfN0wTPBeYwJWM
         yrKmZ5PXPsOHnSmxk/yZb5ysAgz1ItWLvd5ubJQCJUail9TMc50ynQ5gxTQdb2j2P6LG
         bmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700368756; x=1700973556;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hu5Sfg8j+XZ+P8XABQlH+Eo6WMIqT9Dd2Gc7lrXYNvw=;
        b=nSvwgNeDNCWerXZMcVcMuR0K5o7mGllrBb8aSkfGC87hHkcow8EFanDhqSP7PcvZc/
         SEm3udX0EdzuuiqqVIInqS3hRLMdby5bBJjQQ8C/EkZlh3CBq875uYGQlMlLsneWx9u3
         dDYVvYgKzT7JVlIqVnnUEI8hgpVqp+afkmY+LRpjKmx/0YQ6UNNCFY4Xq2DkE2P0+jU+
         zgoHMhifV2qid9h/z6UO3mWck3Ji04+II29wBsAerEjzUzJUyyynz6G61xqvJC1bwMpZ
         47tVp3A9kaWIwVwJVlXSiaJqEqJuKrgmUqhZi5rYLaaYfUinsGAwSF/6galtafA2h1vY
         PpcQ==
X-Gm-Message-State: AOJu0YxPnsAjSTvFuOax0aL3QAyGtv4XvNbC6YcyJVEISkWGEQ2JASLh
	dbXvCisykyMlUASmOeLrW+c/8JPW+w==
X-Google-Smtp-Source: AGHT+IG43NZMdYDMmfVy/no9hz2s0c9H1zAbYepXEKeXiqC+1VwNZHog4rrHmTyJgLY1wL+I+vf2PQ==
X-Received: by 2002:a05:6214:f2e:b0:677:fba2:21e2 with SMTP id iw14-20020a0562140f2e00b00677fba221e2mr5333599qvb.65.1700368756055;
        Sat, 18 Nov 2023 20:39:16 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.21])
        by smtp.gmail.com with ESMTPSA id v6-20020a0ccd86000000b0065b0771f2edsm1880196qvm.136.2023.11.18.20.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 20:39:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231119033006.442271-1-kuba@kernel.org>
References: <20231119033006.442271-1-kuba@kernel.org>
Subject: Re: net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules:
 Tests Results
Message-ID: <a001a72e-117e-2e17-9eac-92a2e8fa874f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Nov 2023 04:39:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jakub,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6162446965014528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6162446965014528/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5599497011593216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5599497011593216/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4526373662883840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4526373662883840/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6725396918435840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6725396918435840/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8a3276e47eea


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
