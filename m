Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420EEBE
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 06:00:05 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-690bc3f8326so750344b3a.0
        for <mptcp@lists.linux.dev>; Mon, 18 Sep 2023 23:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695103205; x=1695708005; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLee3VGWSi2d1XY1JFvEPdUY+i58x55/E0SKjDiJAoo=;
        b=Ohvy5DSRAkTw7PIWNY2DRKog9EWuioCe5XYML9D4t376V4l6rcdZ2wCKluLQV0Fsdo
         PDS3hzDH2h8vAxkOXs4hpr3WVUaPTrjXHPwopMChZf00ObFkR4CL9jBiWW/8GWKJbsop
         Wbgt20/WYLOxgkJlwoE88DZ4wwhNVXdll2zqNGKD9Xj5o0M+N9+GYUTbitPdbwXrotO2
         UZPKK6Vr4IJCQQmb5S5isRVnbmefjdLBp9uBLL8R4KBXD50pGvyTqa2lPCPMWaUJzFgt
         dsRT81eNDCQLoA19LBHJ+rFjX/NCMEf0llrv1Azjh7Ygh9Y/xgqfswMdOj834zRKebjZ
         Isyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695103205; x=1695708005;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HLee3VGWSi2d1XY1JFvEPdUY+i58x55/E0SKjDiJAoo=;
        b=s6LQFTZ3Bvw69VZ2NDlLKbqZnID0ACI65dWdQILrefqB5JbS/cXifALNzhZOY9Yl3F
         13GkmTo3Cgx1f/wuxHwvkyQi+tg9ue91pp8vb8cuc/pQhrAidDdCDtIgRL0ITE3LZHW0
         WLHcIIs1T/SF+RKHsru4VFnRV0bpOnHgZYNWtvjfSepngJkpJygko6jNnUYn8JH4kMLx
         rgHwM41brGQhlUrIVENWTp3xMxZWMbaTE6w8ZDKvpHzKQsXBeSselDl6Ro2zRl7dqH26
         1jwuOFXcJ+CvggLJsxz4zpPzpjD+Tew7ys88IOYTbW4bYvVl+M6zU4+9gSPE56Nc8Xm2
         GoeQ==
X-Gm-Message-State: AOJu0YxG9bDPzbsqlCZvDU52uRu/J/eN/EBlh/ULtnS+e3norjHv0bNG
	b1ptIuuMSSflzxK7/23EFQ==
X-Google-Smtp-Source: AGHT+IFGJeMQPy+JfkRjmraDDXz//DHLKx3UdZFl8zOZUUzQojh8ZOhuN4bg3wU94qbqX0xyCGggHg==
X-Received: by 2002:a05:6a20:100c:b0:157:eb44:fd2e with SMTP id gs12-20020a056a20100c00b00157eb44fd2emr9311736pzc.19.1695103204893;
        Mon, 18 Sep 2023 23:00:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.102.120])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b001b87bedcc6fsm9242337plh.93.2023.09.18.23.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 23:00:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <32a7f528dfd2ccb083f99dcec9ad8b3ba9717686.1695095289.git.geliang.tang@suse.com>
References:
 <32a7f528dfd2ccb083f99dcec9ad8b3ba9717686.1695095289.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_lib_wait_local_port_listen: Tests
 Results
Message-ID: <68a31d0b-a314-99c8-7275-d83826408716@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2023 06:00:03 +0000
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
com/task/5092263475281920
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5092263475281920/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4810788498571264
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4810788498571264/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5936688405413888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5936688405413888/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6218163382124544
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6218163382124544/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/39f55eef611a


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
