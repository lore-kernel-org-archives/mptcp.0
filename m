Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A27F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 08:06:18 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id ej7so1793677qvb.13
        for <mptcp@lists.linux.dev>; Tue, 17 May 2022 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=erVdllx2mhdsDqgpSt//RZr2+OgC8kPjppkI0KyRpHk=;
        b=UCgSDP55mEUJR7S7yl0SlUeyTPnoKqQYd2eTsZHUkNZF9r5ke321bTyWAebvSvvN8E
         ++f9s8bwBrFPw0P3Z4mOqY4T0JihHAy8LmpY+WHteBPH5a4w9hrRBZheb2YHlB50Ns7i
         wA4rW0tgxuEugz3Zc5H1mh6idbKK5NzvrkeVLp7TaYJAg3W7RCUuWxiuc5y+U8LsnxJc
         g21L9raf2PTKyhgF8aKGEI77vGDaZo2hHtsvFcbW3fggiT6p/tfd1Pr5e+EalRfclmfF
         3U+RBtnS9ZM4WIUiYNLF9xYrYeAVqz2nbuiUL8zXFcKJbZFgP+P8G+YCB3nzRS23/F3k
         laAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=erVdllx2mhdsDqgpSt//RZr2+OgC8kPjppkI0KyRpHk=;
        b=MjimpWn3X859CQctDAhVMRsCvCvGJa/KxrHzZzHWb54gHlnZDbtkvt9gh03XgGk/wf
         ExwX8/18rV2ZlfZ+z93YX8CKnXmBjkKwCLuBOCxOzb+EiT1QLRMFyHsOJo9waqMWtgLi
         H6nzdFTVDZkdM4LTXIml1kai1HJM2gtHIR5ptiVc/4k55odLXRQEW97PnLgT2+DZ/UAN
         /4B5F0o8R3g6KAFN5uNNmBJV1EjiQyT+RAXEGYPylsp3Flzsww7M1dpalybsT/NSn/NQ
         yNNxXIfNC8+dNppsgR5Cn12aNcT8s6XEVPMa51xJ8y6KHSD63rKVJMyRr4Oh/QBh9gTw
         Wd+A==
X-Gm-Message-State: AOAM532rTMyCGHms64c6QcN/ufavKuI2eiPjbAxwGSNiSQSwasCS7mPg
	x4SdzyZ5BvlamBpsQWqq6pd7HkuZBA==
X-Google-Smtp-Source: ABdhPJyOIjpPi68sAp73SCXL6ZJZ3fvM8AvjWWYbK09GiRuS8gz0cBfKIdrzC3Q8MpXt3TLlO7z9KA==
X-Received: by 2002:a05:6214:cc5:b0:461:c073:6e69 with SMTP id 5-20020a0562140cc500b00461c0736e69mr11984082qvx.128.1652774777587;
        Tue, 17 May 2022 01:06:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.45.119])
        by smtp.gmail.com with ESMTPSA id 21-20020a370315000000b0069fc13ce1dfsm6913151qkd.16.2022.05.17.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:06:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4ec9eedaed38a5ae4b5bf04320ab5b6bcab8dba9.1652773325.git.geliang.tang@suse.com>
References:
 <4ec9eedaed38a5ae4b5bf04320ab5b6bcab8dba9.1652773325.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_add_?=
 =?UTF-8?Q?bpf=5Ffirst_test=22=3A_Tests_Results?=
Message-ID: <cf46e135-ea3e-362f-bee3-90a14f74ab10@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 May 2022 08:06:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5549153072709632
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5549153072709632/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6675052979552256
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6675052979552256/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4eee192e015b


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
