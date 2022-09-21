Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705E3237
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 16:52:23 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-12c8312131fso9951152fac.4
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=pRutzTyb6yVMg3N1dWjNXd0Qn2QlqYr0ZR9nhytWzVU=;
        b=pPVOGGfZQLT6KkHJvtOn8a7tnFbPMgyIj7zwN6Trn8fjBqzGHCjWMEx8hkwn2qqs3B
         u7Oz61GvSZpwxAeIj+3olHaA9T8RHl4U1SVYrGvi0/jV/oAvXquqqDKh/Zn/ebyJSkGL
         gpzpVBx8nS9DU8+9hgypYcZpYdpQf399evI8n68N8pYgpqVtpBvwhxv3wg01M7U7z+dd
         8OuxAmh72tTL9Rdu4nScywSXqPIdC+LVuwJi94SrfuCJUqHx4Y324o+Fos5XaD/DOQQ8
         n5CnYFiVLXHxEGoHjJ13vm77lkYq3HV7i9+S+NAyhqd5o4D+bsKpyCFnzZhpAhAQGZTB
         nzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=pRutzTyb6yVMg3N1dWjNXd0Qn2QlqYr0ZR9nhytWzVU=;
        b=Pd9XHYsDfqlKIk/L2LEZ/8fND286sG8O4YH0p1TUgKBk+qikhaCUhyu4Pd8G20pqRi
         Gh6ihwnmqvT8LdO6A/korN387I9+t0Ve69xPDuAe0w2xhvy2Ml/Q+cXXLGY5eTpErIB2
         4B5oNsKeNQpvx3ZuOjAVz1u4GVy0F4tbW+CYRFOrqN8OT9/iKH83ApslXM7YeIcUXWiy
         C7HhOYkmA4L713HN5qxbKOMlxOZX6sRA2Gd6ppuY8LspMc978HcVisbumN+f604RK0sY
         NQ6kGloDrzNXNTT3xCc/6GjvfhESRP54AlLEssMYr70D4akfal0WTQpsy9PGzwK+63/Y
         dJ2g==
X-Gm-Message-State: ACrzQf10eOMBvIt//7M4Qo8roMqCpLn+T+pIIvyyS0l1EdWp1xp1Cj6w
	ZiuMRzRsZE0saf70Vx1BzyREl+o9+MQl
X-Google-Smtp-Source: AMsMyM7yBrgbspnJy+5M4bqVEC0YPzVJkcT5L8jrPiy6zIPoAwWj3FTP6ezrvikTdXpLiHvHE1Zphw==
X-Received: by 2002:a05:6870:c14e:b0:127:c700:b210 with SMTP id g14-20020a056870c14e00b00127c700b210mr5648324oad.192.1663779142359;
        Wed, 21 Sep 2022 09:52:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.224.243])
        by smtp.gmail.com with ESMTPSA id p1-20020a9d4541000000b00618fa37308csm1527382oti.35.2022.09.21.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:52:21 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220921152539.1851441-6-benjamin.hesmans@tessares.net>
References: <20220921152539.1851441-6-benjamin.hesmans@tessares.net>
Subject: Re: mptcp: poll allow write call before actual connect: Tests
 Results
Message-ID: <c9ff22ec-ad2b-c166-8351-d7e7abb31f84@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Sep 2022 16:52:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Benjamin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6174768750657536
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6174768750657536/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5611818797236224
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5611818797236224/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/559d6c15f187


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
