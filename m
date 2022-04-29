Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED321869
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 20:48:21 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id c1so6767196qkf.13
        for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=9D3ixt17AUPDfykmu8reX94wvwstrKSdOzLnXzxN8Hk=;
        b=knE3pL1tm4cn/Lnj4leBBEYG8DBLMnQ61ekGmaj2fR0ivSk6VHDL/nXBKSCs203oyU
         a9I/1ReQz8OydUdKcybPWpBDUoB6xkZgA2Pguec22VbdOMzuPi1kulvla4qciMwquing
         rrolJz2RLcM1CFf1JWa4kUAu9e+1EFQF60e+zHYulDOABjP9K8TROhpMFhrPu9rvzoaE
         0Q1vH/aIhv+fvnpwpU6+VStVjZlMF1nwcAa7Vgx9jYtz419JAmKf6mLkprNsRSdNGiMY
         kv/ypdjTM19tGtQ/68lScYtKFOys3nkuxB0cVoqILGOU6+XmgJp3qu7TfvXifQSz9Jrm
         /GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=9D3ixt17AUPDfykmu8reX94wvwstrKSdOzLnXzxN8Hk=;
        b=XD1afEwkgYMoahvBu9VjO7rxzO+c0sdDNwlgkG6XgteNNfDeUG/7+FBtqTp9jiiU9P
         gWH4FyiGKGyWJvsuHYF6Gk74AHfA1jtYZuQ+CGkhEkkHtLizo491ffZqqWAVl2od0UcM
         tZLkeGe4599l5RDcuirV00Nf9dQopFpCYvZMcMx54fV0ezsCy9F8Q+eD7RkKaIRSGiix
         zzc2oP0MBrUwE5Fe896b+bs0grWWHow3DdAjt/83wors347txFrc04Wwy4LOP0h+5bXw
         334xKsv8wGRRMZ3tvgh5lvSOt9CHTuC9osoaulgJ/TPCkgBIJoeRfUifXdRX0D1pF6/A
         HIQw==
X-Gm-Message-State: AOAM532Dj7NL/Iq684Duzr4MFMsrY0qBZ+8xJqJnmLXcMOoHu1nXM/XV
	h/6KtpIoZf7Ge23P7atx5Q==
X-Google-Smtp-Source: ABdhPJxCNeV9BGCvde4ZEN1H3QL/nwji1wp3IW6iiTidB3wxzASqhAeIlsRk/puwIRs7hbdQF3VYLQ==
X-Received: by 2002:a05:620a:288c:b0:699:b9a0:b61a with SMTP id j12-20020a05620a288c00b00699b9a0b61amr706069qkp.233.1651265299910;
        Fri, 29 Apr 2022 13:48:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.230.66.101])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85151000000b002f39b99f682sm138377qtn.28.2022.04.29.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:48:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
References:
 <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
Subject: Re: net/sched: act_pedit: really ensure the skb is writable: Tests
 Results
Message-ID: <ac5ee441-3063-f528-7bdb-f9bb606fa309@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Apr 2022 20:48:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6080231416004608
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6080231416004608/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag - =
Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/4542105128271872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4542105128271872/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/09c42a988d35


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
