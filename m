Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD03BB4E
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVz48PpU"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67a14f504f8so14196826d6.0
        for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 10:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109450; x=1701714250; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19S1lnF32uWF8Sez332hakgajX1emjdcloncucVM2X8=;
        b=MVz48PpUuQcqdGy/KT8TFARH7m+sPQieoVsfoAwh26PJ/8YcMRDntynqqIFe/1MXq2
         RYzQYWTA7KaDXjZlrl7RNZtpIlwh6V+gULBlzgYniZ+ZgEra6MQrjdJFrTDH1rzFf0zI
         KyKXNm/2ekRxVZu+METLBvcoDRrCHn4BpdTuH57TmyjNVmEKLbkrkJDosTUWmTJE7yub
         iMD1VbS/bzfk0PPRT+9OyIu/u/qK3pfNOh3gudtKbBIcHCSrfCvJqzJT7Q7DRg3bFBHT
         2+h7xOyHVuGxaw/NMYNEfDDVqPIEmoyu8Ln0X7rKxS9yAn499fF9VucaRMyb1AtBQjIr
         6Ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109450; x=1701714250;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19S1lnF32uWF8Sez332hakgajX1emjdcloncucVM2X8=;
        b=EOZjLAiYc0Mi0B5EIwJzOdStwy9lr8uZB9t0TDiW779fKd9jS/bVkfR0Q2s7LUvQjD
         ohc9rRQYEka5CcM8bu8aOgjhuNaLWzxZACEOciwbQ8PqspDjkqWc2gXrIF3Nq1G9Bvft
         UBruT3n3wUbt0pKiaC6PMJNJUex63m3tkB8+PkAXeGwPKVg/d7QP62VJ9czlRGbpqmHz
         hxX0xobvxlZvVUR6aJyaUKj9Na3md+3HH3fPmklGUc12VZmvfL6LQr4tepWPHPYjVbvL
         aJYmexMA/fOoKc+ylxgPMwZRgNYurqUeIXo++CNx3wFAinOD3XFBQf8qDNOvmIbRkn8t
         TnOA==
X-Gm-Message-State: AOJu0YwbtbFW1/x33s0R6aio5YZJGGUUWBzfGqsyqwssFw/HhjcKkbUU
	UkH5I3OmEklKBFe9wHRgrA==
X-Google-Smtp-Source: AGHT+IHjNxYMHdw1gbr/MuWSWkrNlboOmPCKgxopuE82vJTMNpGAzxeNCHu6hZ7cZBBdnYglpYUodQ==
X-Received: by 2002:a0c:fbcf:0:b0:67a:3b7b:a465 with SMTP id n15-20020a0cfbcf000000b0067a3b7ba465mr4969160qvp.25.1701109449930;
        Mon, 27 Nov 2023 10:24:09 -0800 (PST)
Received: from [127.0.0.1] ([74.249.14.243])
        by smtp.gmail.com with ESMTPSA id u2-20020a0cf882000000b0067a3abec392sm1605193qvn.66.2023.11.27.10.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:24:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20231127-mptcp-module-desc-v1-1-d2209921bf9e@kernel.org>
References: <20231127-mptcp-module-desc-v1-1-d2209921bf9e@kernel.org>
Subject: Re: mptcp: fill in missing MODULE_DESCRIPTION(): Tests Results
Message-ID: <feb57528-797e-7c5b-244c-b14a386b6891@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Nov 2023 18:24:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5892409620430848
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5892409620430848/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5047984690298880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5047984690298880/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6455359573852160
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6455359573852160/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5329459667009536
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5329459667009536/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/139e66bd2b74


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
