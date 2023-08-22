Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7279C8
	for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 09:05:26 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-76d873c6e8aso282912585a.1
        for <mptcp@lists.linux.dev>; Tue, 22 Aug 2023 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692695125; x=1693299925;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8gPizQtZrNdTigOzbrQO+gSCiP0MjPbddOvvcNidq4=;
        b=dwpyBpuqlNG/w2ynX8DjcRPBiBmSUoYro4I1Vb8h5PnrL2osy5DpVMmDttnGRsOXRA
         qMvb1syXU7Pq50WhQFsahBItlYP9p/CGHIXrYrqNrAmcG8Ogk08ClH4fOvmdACnsQQsl
         gPT2JzetixZmanLyeeP83Y8biHoVU9S7M4zTKRgNIzjtdfljrGx40qmCY34AoaZmwh0s
         lAq9gNFkzgCtH/Di9oxS1ZL///IO4BQ4zDi65zBNDbA7ODTfKgFlC0eWNLYQkvJsWUEF
         1ehFkXC7RWJTRJJdWQqtCwDU+MSSF8NKQExyg/saGSIY7WCvlNwGOMVhk1g+tnEe5QIy
         yUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692695125; x=1693299925;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V8gPizQtZrNdTigOzbrQO+gSCiP0MjPbddOvvcNidq4=;
        b=Mvs2KmTC0V5hMMOzgJJkWCMkrNk9BCHzWndl/Dl0T8YFbpieWdFaOpcDfaDizzyF8Z
         Xt2f4p2PYMdEj5o8dSteSU59Qf6eaV+A7mg8PQJx1Yv8xUMqDJBILZEzWLkLbdJV2bxB
         3I9t/rMQGVymlZFtPfxzcdRDHpISK98WopqsKdIAs80PumOpx+WxPC4K4SHyKjLLflOy
         p8o+WoXcmGBz8iVbZlnTpKo/zS035cN77EzLyGJYvmOxJ/fyf0mO25qUmc2Tlv0cB2S5
         5LgzmE1UraV+l4gPGD4vsnIw+/4tnk8in3NeKWExab5MOF96UPqJv2y+rkGS9KGZyygX
         Jn2w==
X-Gm-Message-State: AOJu0YzOQc2m8phFRLf9LgzNrhsXTMRZYJ4OkXxL/1HGhn8IfotP9zs3
	IbKU2O4eC6PvJbkW0BxJpQ==
X-Google-Smtp-Source: AGHT+IFWkHQ4ibSh1LUn0cCJjh2jY9rfqeCoMSkuTPHJYxUAp6vwsMqmf+VMGLBMvoDvXLTABQ8JHg==
X-Received: by 2002:a0c:f5d3:0:b0:64f:4a97:6088 with SMTP id q19-20020a0cf5d3000000b0064f4a976088mr2947699qvm.9.1692695125266;
        Tue, 22 Aug 2023 02:05:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.179.102.215])
        by smtp.gmail.com with ESMTPSA id r11-20020a0ccc0b000000b00647386a3234sm834209qvk.85.2023.08.22.02.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:05:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <065ed2c95b4ceef822232e4d0641427af6e27092.1692690157.git.pabeni@redhat.com>
References:
 <065ed2c95b4ceef822232e4d0641427af6e27092.1692690157.git.pabeni@redhat.com>
Subject: Re: mptcp: process pending subflow error on close: Tests Results
Message-ID: <a303404d-1f5d-c7ca-6fa5-59b9516d9dde@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Aug 2023 09:05:24 +0000
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
com/task/4696377448464384
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4696377448464384/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5822277355307008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5822277355307008/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6385227308728320
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6385227308728320/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5259327401885696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5259327401885696/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dffd1aea5f08


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
