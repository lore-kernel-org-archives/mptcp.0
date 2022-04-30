Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531FC1FA4
	for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 16:14:37 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id n18so9496675plg.5
        for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=yBV/nus5tNjroThFBqkkhCNpTGzqz6/orQaEH2M4Cr4=;
        b=PMAR4HaGVx9fAO1c/Rf5WexuFKq0Zb2dkFD18OA6DnkH9cZEuyC5PxlMV0FkL/yqNs
         jryERHchEOMhmY+WvbUWK2Khpota2EkKZvWOA2Rb+J744a8/zwHXEONQ6OUO50g7x9AI
         Cx23OQXDPyNXxANnMdJS0r8ARwqnpZ6LlUgUbwr2Yah3Bcq7jk5f4xPfO48jcB8HGUai
         mqxUqZm9u4D6h3CCPOSxZ95sJFpPYj+6VdfknvBjDv8cGML/2ZVwwqklB/mmgn9B/5Fd
         XHAQDdsajHsnSTgmr7nDQCxX0QPSHehxvOV4mvZz4BokEjA81BFVZq6rSZGm1788SwV9
         cc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=yBV/nus5tNjroThFBqkkhCNpTGzqz6/orQaEH2M4Cr4=;
        b=YalUddozxh6MK4T2RiUBVgYIFBmZnp9oVTCL1BVYT7wB1L8Jc3OrBwZT1ptB0xjrnB
         CJY4OVD/ZWGP1c1eRhseT5qt42acu6RzoBGaBQuciG6/jgi8H3HJB9kqv+CxBRtHOD6B
         bZL1uyuD/NxrF0I20GXnsWZ7/kYBJqPKoYY4aI2x/wh9BhmKwJZBpSQSg3npo8HttG+P
         6jjp4MAFaklY0IsLkCWmvKcemrE46yg8xnqZytaFD2C/7nl0WVDGX0D/xQVTO9+ZmKIu
         FmAz/UwgdPiZ4PuvRFn6WxVZauIygA0M/zWeIK5Ipj75cIdmePdY25sveTCncEQxYQMi
         W5ZA==
X-Gm-Message-State: AOAM533inHlU1KXZOEygdcXiZnQwNTnrQAv1qVnTkrhBOYi/iONER2EN
	W7A1RiIp+QDDB653g7aIZA==
X-Google-Smtp-Source: ABdhPJwZJptVZ+AWNhoWo06Q3reNa6d9AZ/HdA5Y3Ui5Ot5C7wp5hSj2tnudLLt/GOeLdK8OW+6aEA==
X-Received: by 2002:a17:903:20d3:b0:15b:151c:cadb with SMTP id i19-20020a17090320d300b0015b151ccadbmr4548562plb.154.1651335276567;
        Sat, 30 Apr 2022 09:14:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.2.151])
        by smtp.gmail.com with ESMTPSA id i15-20020aa787cf000000b0050dc76281a9sm1713542pfo.131.2022.04.30.09.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 09:14:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <47419fbef3ed25bd1bb9d641e4817b85ea55ecda.1651329059.git.geliang.tang@suse.com>
References:
 <47419fbef3ed25bd1bb9d641e4817b85ea55ecda.1651329059.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_bpf=3A_v?=
 =?UTF-8?Q?erify_ca=5Fname_of_struct_mptcp=5Fsock?=
 =?UTF-8?Q?=22=3A_Tests_Results?=
Message-ID: <7f57667b-3e4b-d394-d7c8-748c904fd7d9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 Apr 2022 16:14:35 +0000
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
https://cirrus-ci.com/task/5168408332337152
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5168408332337152/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag - =
Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6294308239179776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6294308239179776/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c71199312813


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
