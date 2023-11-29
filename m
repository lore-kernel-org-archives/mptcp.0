Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAF1DDF5
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDXRDv6t"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1efb9571b13so3899869fac.2
        for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701261190; x=1701865990; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h00o8I/gT12+Qze2IE2b3xIBthrh3WmsnSbBC02aC0=;
        b=mDXRDv6tKL6j07HvbxskK2DbYnvBSnXkabq6CfYIMrWva5RefL91xLcCEKT7X82tnp
         5mq2izc/wG10RDy5TPRHEn1E0d4sYcB/eDcJTYpzv/jsehTmfL732eKqpAE1GQfXHRl4
         EGLJnRv8A1EwVOrildcHD1l6ttQSV8yubOsFxPW2A6Q915uq3BOpJIOOrxwv8kEe6tU4
         e+m2pGiGEElnKKImQ/Te8VKfBwWqHX3Y73UymCm47WCEAE6ivnpKka2RIHeim6b7esKO
         lRdJmWpB3uuYZHpJd2Abc1s4zP41APCcC2ngO05SVoQnc8c+RL9LRpdiQlau7H9o9dP0
         42Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261190; x=1701865990;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3h00o8I/gT12+Qze2IE2b3xIBthrh3WmsnSbBC02aC0=;
        b=uuyXmrWlKb4MgQLZulBEhh/Qi88d7KDJSoxkoVPstmem6eTm/3r/1ufqXCfkpGGUxh
         Fv5AnmtMT8Vhimovw/GhjcWtXMwP2vbnWyUCe+9pPeSPRsc/mp0h3+QNaj17D/LFh+n8
         bC/RK5B576//vPYyiIu6NAp5ZE9xViwqHAtW6GS6gvnX7YNeUQ/H7BIS1GVkgY8Yaw5I
         cZfAu44g9zw6IdHudxfYwcj4kCHlGh9u1kiWxvSwBkNxPtIbpCigbVpXGaTNp7mT8U43
         6PexpSevEA7in7DQgiPRwpNQWPlShmh9zAA+9DCzsqAItSWjuGr6/H/OU1epLAPTGwwh
         h/uA==
X-Gm-Message-State: AOJu0Yx/CKrYGIXdOo+8AJ0QhOxpGMgAWXVqwRTIFfQQIvU0np48jb1f
	K7HNTh30pinqWtU9dgpA1A==
X-Google-Smtp-Source: AGHT+IHF98gKF3A3zeqo2qvkLI01dh8jTctwA+Rz+s3CsY48YwU7HmIZHfPfI2/xhZSbPC3NcPmDNw==
X-Received: by 2002:a05:6871:4082:b0:1fa:a593:7ab9 with SMTP id kz2-20020a056871408200b001faa5937ab9mr1408096oab.45.1701261190403;
        Wed, 29 Nov 2023 04:33:10 -0800 (PST)
Received: from [127.0.0.1] ([172.183.79.3])
        by smtp.gmail.com with ESMTPSA id t7-20020a05620a450700b0077d85695db4sm4245912qkp.99.2023.11.29.04.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:33:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231129113403.157953-4-max@internet.ru>
References: <20231129113403.157953-4-max@internet.ru>
Subject: Re: selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE:
 Tests Results
Message-ID: <603f5af9-d9b6-0f1a-9225-a02cb1a9078e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Nov 2023 12:33:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Maxim,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4513395882328064
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4513395882328064/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5076345835749376
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5076345835749376/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5639295789170688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5639295789170688/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/6202245742592000
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6202245742592000/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f1ef5a357e82


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
Bot operated by Matthieu Baerts (NGI0 Core)
