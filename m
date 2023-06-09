Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736151DDDC
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 21:01:23 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-19f6f8c840bso1079722fac.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686344482; x=1688936482;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb48fYR8jrFn4TFcz8O0aPevTHAqYWJY0yRi+xYlMCY=;
        b=WXV0ZqRke+TvrSYNe4yQO3D7FjOEPqjjUunIho7BfwGc8ql8kuvZkztnDbURnKHTxv
         pBYgqqEWGWIBqWNy/vS0N4ENAvPj9JTnQzq2Y8hIXqyB6Z4ZvvzrE/k0t/L5Bz5Ql/Ld
         CZwcWxPTsU4Uv1cMz2wKzLHsizDIVl9tb6KPg24D8d5pcXV69mfucEsGR5i2Wp7R4Zzt
         bO4t0LRzhk3Pq1NV+2IyFqfav2QO8z0ZwY+XdZwBzoxQtjeFQSnzct8ngpWJzMUr1o2Z
         Cx1KchKYU6Tf1JFVo68TpRzMuQiVuo7z97inUxV6hVTpOxhiQ31rZTnTULqk3yt0cocq
         ZHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686344482; x=1688936482;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nb48fYR8jrFn4TFcz8O0aPevTHAqYWJY0yRi+xYlMCY=;
        b=gbt2b0wjxWKEMlsTS8wwIHPD4i4f1LwQrW1a6722BtCymurYFVqm2aIIw68p/oeuKN
         r/9i/jkv93HGd/Adj6agE+fPxb4RHPUf/9/vXWvpqwAFpYWL6SZxDDd7uXYREgOPWTNK
         Xl2T35xFRdFLPZiFPJFsHCRSSe4UTE2I1KpC+VCDEXpemDhXPp277wPWDtguEB68KHuQ
         rrxdWJAD8mCcyfdYk6ClfPK70buXtcKIwL3Aj1+hDpGEwXDE6m6civB+W2DoKIrPGZgA
         fKkqPPwrlKxEY3mtzOyTC4V+xYfXbVazNOWHS/l7Of/CZmq6ZAYR+1GKNSjuRj/ewkZS
         re0Q==
X-Gm-Message-State: AC+VfDwjYON0DgkXk5m24EaTy6+kTnEnenqUDahjT53Js9JEC6yBPhTf
	dTQ5vOxl86gPXhoIMJYQfg==
X-Google-Smtp-Source: ACHHUZ59uWpPey6Z+at26gOm4fz84XsPikYoHZqBwAK5EZMAZvCSZ0Z0tVlYR0YE8O0JfG1Wfq53eA==
X-Received: by 2002:a05:6870:87c3:b0:19e:c567:6020 with SMTP id s3-20020a05687087c300b0019ec5676020mr2068154oam.38.1686344482195;
        Fri, 09 Jun 2023 14:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.219.148])
        by smtp.gmail.com with ESMTPSA id b17-20020a4aba11000000b005255e556399sm1131943oop.43.2023.06.09.14.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 14:01:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230609152800.830401-1-leitao@debian.org>
References: <20230609152800.830401-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <5949cfa1-a01e-0872-6b0f-508f4ed4d30f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Jun 2023 21:01:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4979209920053248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4979209920053248/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5542159873474560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5542159873474560/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6105109826895872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6105109826895872/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6668059780317184
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6668059780317184/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fad5651699a5


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
