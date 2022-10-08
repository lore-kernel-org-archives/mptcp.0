Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7357E
	for <mptcp@lists.linux.dev>; Sat,  8 Oct 2022 04:09:54 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id q9so6217594pgq.8
        for <mptcp@lists.linux.dev>; Fri, 07 Oct 2022 21:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N05Y9mDyBsYYwfDmVMmCmqmYOhMg0yU6RRtWgOYoa9g=;
        b=TykLJvXZ0CWvIK69IPijROrnHCa83zg1yYry+BE83yV3aHS1YeYEtawsmwti9WAicN
         /f4BYukSB+Musbtj8bbMtZOgpJ3Uir19cK3aVoBzHwdcTLdsfChTr4YZeCkzdT6KvpPt
         3U1SdfxHaTKSjFX49MUjle3XQBUskfqJ89Pj0FBsL8Zp24/TuLq7N7Rl01yYqTDMkbzk
         E8UkT0Y+g+JeS3rhqGST7UipokY2ts2haG51s/C5KPsmTo8cB4b0kkQdChODm5FqNUDI
         1CmRNyS1rgRefBSsfg4LOK3h6p63FQuuNKYtnuBTy/ezRHqrxDjGLH4aAlecnU7gx6qL
         vnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N05Y9mDyBsYYwfDmVMmCmqmYOhMg0yU6RRtWgOYoa9g=;
        b=EbjXrzF6oEllQ6maFTxUjXwKhPyfC4InZEal87IRTwSZgRc1QWifA5T5koH49kGiTg
         Q3y0OTBru1dG/74fAYGkrQPEmn5JNpRd7fvGFykDu7f2QN/JI1mCnRbabG+eOsv/qHBc
         +KxqP4YXsoUKhbdRc/6RP22rlxNA9zpyYkpQWqy3jsnbuoopaYDFs7OWBxWCNrku1qI6
         aXQpPU4RwsYrpTdvMMiXDcjUpQ9GSaV7PDIIeraH8MgAqpI/G58O4O2ulNf9WQTb/Qo8
         jxjCzAgvybqJ4rnAwFDTRbG1UamcZFlpPDbHZofOf+R+OPZWIUK6WXlVhQ4wBLpD1cQE
         lH9g==
X-Gm-Message-State: ACrzQf1wIasDIOviFn40yS2NTHZlpsbcrBNs6Hwwc4dDsWCXEAEhLi9Y
	2atNMw6d5MkH+1c/0IIsBQaMMDbBwP9m
X-Google-Smtp-Source: AMsMyM6KQpsD2aDoXJNbDQlpfJw20f5dPIcR5goOWGqaiMdDIpWXHKr8so+sBi81vKUAGpPp7kiVvg==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr8112107pfb.43.1665202194095;
        Fri, 07 Oct 2022 21:09:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.59.25.159])
        by smtp.gmail.com with ESMTPSA id f33-20020a17090a702400b0020647f279fbsm5399406pjk.29.2022.10.07.21.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 21:09:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221008040015.21176-1-geliang.tang@suse.com>
References: <20221008040015.21176-1-geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22mptcp=3A_register_def?=
 =?UTF-8?Q?ault_scheduler=22=3A_Tests_Results?=
Message-ID: <11294d79-2c6f-5bfb-e11b-37d3d979eec8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Oct 2022 04:09:52 +0000
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
https://cirrus-ci.com/task/6542137404162048
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6542137404162048/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/4712550055542784
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4712550055542784/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/78422b08a6f0


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
