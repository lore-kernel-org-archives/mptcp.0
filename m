Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8C28E2F
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 15:56:23 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77acb04309dso37512839f.2
        for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694706983; x=1695311783; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST1QR/PHn4y1ryweMvvMnUMgR4MKX+hbRy6o7XoFq9k=;
        b=Jxea+SPlc87xYwb2uSMyJckRYRCJsmOufN3bncrxD2HAqpE8WWoYrj5BJ+eaudU3Aa
         7d4Mt+5MBX7hanAtVz0tZ2n34wA6hTU6bKOvEsiUdPkT1BmS3LbDTE8s3Lp7qWY7d1X2
         B3sX766r2ZKiZxMnkSyst/MqUeWJ+ApADIhVMCPcnirxIEzLHdFy5iN9OEoUSWDUWHOF
         uW8qQNSyG5/JUmiJySAtD0KMucJQzQTmac2tpG/MLuD7+DxPXMAfIyUT7Tj0LYVv09J4
         NOPjv2lMzqHLnvgTchHhsCnDGlC5nTmLWb9CzWZiUs3Zkz8xvICXNdZHht68V+8sy26h
         YWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694706983; x=1695311783;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ST1QR/PHn4y1ryweMvvMnUMgR4MKX+hbRy6o7XoFq9k=;
        b=L7W6Kp7bVOVtdUZwn8Sj+N6xsoivMq5Lh23PkhKBLTiB2/F+inb4JMOatJVU/f7ni5
         HsnmuZy/uRiM/w51IBXcj8jFHUZBonJtHpdtwTW5vc8hy69YDM+wLDKmIhXWk6rEmBTM
         BBN/Fwok73T2ivgdYKM0iXlKFsPEf55SMpxFHSBbYeBMneDdYa5E6eY0s5F0YYPuXld/
         +p4oa5sFrpMd3ojyT9GnjGkNSxH6lmVuSMM98JYQLmGCCExf9qz6iB1yAF3nQYUCnZ3n
         vbBhk6D85bzpOvpuHre/7yTIbgWsQYP3eBjtiruGlnpZKp9NOLDVA65CvCZfw4P8uU4p
         +3nA==
X-Gm-Message-State: AOJu0YwVQjNCv0sAee8X6ryerLKi0+7adKOJlb9OdD7tpSC80Qhf6VU/
	l3oMEx0TFowXHI/290lhdQ==
X-Google-Smtp-Source: AGHT+IHrH0iWp/YFsctux1ZpVRR3NldYexTDVtdZVDBEjk5Jm+T6E6b9bvq1COm8ukApeOACgnPQjQ==
X-Received: by 2002:a05:6602:2c52:b0:798:d82b:7b02 with SMTP id x18-20020a0566022c5200b00798d82b7b02mr8309697iov.4.1694706982693;
        Thu, 14 Sep 2023 08:56:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.123.120])
        by smtp.gmail.com with ESMTPSA id gc6-20020a056638670600b0042b05c1b702sm504489jab.12.2023.09.14.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:56:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d379239e00cd08312d3cfa0229b60772d3ce0205.1694702984.git.geliang.tang@suse.com>
References:
 <d379239e00cd08312d3cfa0229b60772d3ce0205.1694702984.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: check no_initial_subflow flag: Tests Results
Message-ID: <9f7cc421-77dd-3b54-2a17-f7b4696ca3b6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Sep 2023 15:56:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6408327622557696
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6408327622557696/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_mp_join packetdrill_regressions=
 =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6126852645847040
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6126852645847040/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5563902692425728
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5563902692425728/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5000952739004416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5000952739004416/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/644351872382


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
