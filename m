Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D0ED6
	for <mptcp@lists.linux.dev>; Wed,  6 Sep 2023 09:42:18 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-76da121478dso204716285a.2
        for <mptcp@lists.linux.dev>; Wed, 06 Sep 2023 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693993337; x=1694598137; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh2qWVfJkhIvKid72zy+LQ7q06yYjTqKbYo0LC+Ibko=;
        b=iMu5h88cE8P2LVkDdxWUkPPehW9O8ftAHmjVO2a9fXxPGy4XpCyp/iSgVWng4jZyWw
         kiTVkr5DlYIs/HtvxOAFI2e6g0udxOrgWXzMj+s3x/9y7K3jx2nS1ycApHTQ92RYZjqg
         jLt2C0Ep2YUdW3T7JQZXvMUdj/ik3aNITwdGVwiWtDe9PQdQH4fuWBqMl3oPmYC3SMWy
         s/kUwE6z+Mf4SCP1c/E8To8R1w8OGeo4jzbzPZSkj7MBkIBHNNkAJ+/eKABxjvsJoELR
         DiEmzDXJZ5gPx1smfOyX0v6fPVdz8yiKJajR5P8YChSwlAC8tygrO1bXTEDXxa50hksP
         XeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993337; x=1694598137;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oh2qWVfJkhIvKid72zy+LQ7q06yYjTqKbYo0LC+Ibko=;
        b=DQc2XusPJ2WRlJbsWQj5PR7XcQMJ/WSt5Pj4Ovw7cS7NsoAhcxS/k90ZVE960IVodZ
         IEnrAfP9xX6U6DPxxtIfGzAPntRSntl+WXE5YkqhxkvyvXTjAsDYkbRWBs/QoiZu7zZT
         jpSg1jishjRZoO2k04x4PvBo0eGBJX5mN9ZyQjJfyr6WziEx0aKSdpwvHtzbOBg4WwXr
         bGI0cC5TCX0qkepYp5DL0XSh1L+YPzD7K1ibq0ZYrajBrz//bLHwUG4WIrV1Vb7IXmDf
         r4I+EBkzPU5B3b7BxJ2navRDYGLLHVaioCEeXyFJZSox5njItyDtWQU3tbGQay891nmp
         C+zQ==
X-Gm-Message-State: AOJu0Yxe+xrzwPqzy4cIy+b1lN2mEkNJK45GfKFKp+W1bYnU+wOK24xt
	VwWF5cKVlNPR4wKXKztyTg==
X-Google-Smtp-Source: AGHT+IHo92rvLIQxMTlES1ZxVsu1JAvg6V4FSLRIsgYdu7IHzBVqrXcj295c4ms7FfaMHbZ0add2PQ==
X-Received: by 2002:a05:620a:2592:b0:76f:1c78:42f8 with SMTP id x18-20020a05620a259200b0076f1c7842f8mr17631545qko.7.1693993337547;
        Wed, 06 Sep 2023 02:42:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.44.157])
        by smtp.gmail.com with ESMTPSA id pj23-20020a05620a1d9700b0076ce061f44dsm4831387qkn.25.2023.09.06.02.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:42:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
References:
 <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
Subject: Re: mptcp: fix dangling connection hang-up: Tests Results
Message-ID: <d3f685fd-bcb8-061b-b897-6e26a226b3c7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Sep 2023 09:42:16 +0000
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
com/task/6431617787363328
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6431617787363328/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5587192857231360
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5587192857231360/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5024242903810048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5024242903810048/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 3 failed test(s): packetdrill_dss packetdrill_fastclose =
packetdrill_mp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6150142810652672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6150142810652672/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/957900765691


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
