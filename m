Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784634CE2
	for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAjh8Fnu"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b0dcbf3672so812125b6e.1
        for <mptcp@lists.linux.dev>; Thu, 12 Oct 2023 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697145302; x=1697750102; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQRtbAuw+tq7cFMN74E+zlT8YrBg0yeNCxJumPrZ9pE=;
        b=gAjh8Fnu40iQIRDSMIl6CEHrkDVys6zuRMDPPOaTifIdTcJ1ZBrtuwAkmnw8+U+PLn
         UmIvreoVs4/yKWabBosu2oCR6wUhFWs0hHS8z7mXvLBYG8Xk8feBUqBsQW835jhE6W8c
         dow0JsCGi/+clXPeFuYVUUYi565n5WzYe1wbXXDBJcmFGxAIZAJ5+NDwV8/241IMcn4s
         NSgPwP/Rg29BY72WLu38xih4fYoSfVfgyjzEYczn7lvwUOBshTzhMWel7C5KgscufC0T
         9PfoDiIk74mH9IeINBxyDYK35eaSLwCM6et3zvNzdU2dNskyosILJacOhnYEWCAW1tp2
         6jVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145302; x=1697750102;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jQRtbAuw+tq7cFMN74E+zlT8YrBg0yeNCxJumPrZ9pE=;
        b=dfi6pQ/tu8MPLdi06ngwFO5SotOaL77hhdhjhhfM1WmkxEgy8PRXLzwL0p/ZAE8mnP
         yEVq278UlrukHsS/LT0uxl6MVsiKaV9TyflOHs6hKOvvhyuWFwBIZ19hsqirSo7rZefL
         wNVaulqrPChjdGGdLPW+614djKOAMWx8oZRj9kUwHn5Cq2e15eGQfouDfxsBrpRABzB/
         rtmH/+5LELlMDGmX+74EPNOAf1amGQnNrA126LigD1q+qW7zrCvnmoxFS8g2Ak1kAw9l
         TuRF/x0lJyJe7xXc0rslsXWva02955BNY7eXxNL3lm1Mw1B/df4LCJSn9aMGQO02v/0h
         pAbg==
X-Gm-Message-State: AOJu0Yz8jJrJahDqTHEMMbzjeiAiI6n5dLgcuWIBY6oRPco7fgHoC861
	/hoTiwgPMTBpPPLsABZJ7w==
X-Google-Smtp-Source: AGHT+IEmttYXfsxo9WGU+gm4/XtWRHtUCXteHsICcK7Sfjm7D1BiKioThONVh5bypxKN6PB+EHQuCQ==
X-Received: by 2002:a05:6808:1146:b0:3a4:316c:8eeb with SMTP id u6-20020a056808114600b003a4316c8eebmr39643853oiu.40.1697145301770;
        Thu, 12 Oct 2023 14:15:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.46.49])
        by smtp.gmail.com with ESMTPSA id da19-20020a05621408d300b00646e0411e8csm104360qvb.30.2023.10.12.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 14:15:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0ee2a306b00ef868b993e2426d9d51e14882bd72.1697125647.git.pabeni@redhat.com>
References:
 <0ee2a306b00ef868b993e2426d9d51e14882bd72.1697125647.git.pabeni@redhat.com>
Subject: Re: mptcp: more conservative check for zero probes.: Tests Results
Message-ID: <94be2640-2d86-4cd0-ed73-a8ea234071d6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Oct 2023 21:15:00 +0000
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
com/task/5346035443171328
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5346035443171328/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6471935350013952
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6471935350013952/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5636778166583296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5636778166583296/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/6190460373303296
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6190460373303296/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/742d67fc90cb


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
