Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4131A2F2A
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 15:01:13 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id f193so6250165pgc.0
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=GMa0ncIN8lth8yxbfPIeDtNv5rLj2KPrclLcCoNBNsE=;
        b=cES8hXi72pqm7L0fzkm56fDD4MJypaOZrhyTUHjPF3fR796wII8y2SNet34XNmuY6Q
         A4m52iOaudF8RyNvOb1ye84Pu3fyjSS4xUSUygj5Vb27uc4tv2X+XvyGYhvHq/OY+6Xo
         UEwwOWLNrtWJ1ITRmgMfXsyNCdc8SQbzlXyOIM0MJUCPg0p0H3IWArO7pXFiWOCm9OXG
         OyzQlNzm6yRSdGQXBLVHGwnFUCDEHYO0j8oqylpHvVaG+DGBsTOlQ2Rz9rnV+hfsA2h3
         wWrm9F9/8HDuLLXqoa1TXhbf/WRcvFvTDjGJkv5mhsM5u5N7wdUVDC2OdfmM7W7Q6hXm
         04vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=GMa0ncIN8lth8yxbfPIeDtNv5rLj2KPrclLcCoNBNsE=;
        b=YPT+efI4QsuxhaRGb+cS8tRJ8JM7DJJ9H2iwV6cnfmZIk7gbNOcGMJr2JF4Q/JBh0J
         /BL87W4CEVBqjzblLV/mBodLve3FdMHstT9zI8JRBjUE8uFoEWn2h/PmFKWp6n0kFfos
         k0T+et1TpRlWZJHM5eulxW2Cy+EgT0sW788rqZSaKE9Swr1md0z9oQJj4qe0GHs7OFhC
         XzLVXJ+DhmImEU/zkQrJUnOxSwYL5byy+C3gHDxteU/svgmuSh9FQ2fh5dlq9dEfOn1t
         HmgaYHNBodKnx4k9t3I2fFthmsj9Q37u9M3qpUiHG3gCi+JMJpVuXaKrwLqtuqLVijb4
         3IWA==
X-Gm-Message-State: ACrzQf3pJmGTbYmtEzJbNQEBlBaKQ1qG9oY/fAXRvjLmX6n236+QujdA
	pU/Y/31aW/+K0MWnVGzQ3lqZUFstCfmK
X-Google-Smtp-Source: AMsMyM5Msy9kmyBVfbolSyStGwGF0MCY/uDtR8gYxirWLxGIGwo9pyYpoXukD8cnB9bX+RZrdOFckg==
X-Received: by 2002:a63:c058:0:b0:439:61d6:5fc with SMTP id z24-20020a63c058000000b0043961d605fcmr24143813pgi.344.1663772472658;
        Wed, 21 Sep 2022 08:01:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.131.225])
        by smtp.gmail.com with ESMTPSA id e125-20020a621e83000000b005499599ed30sm2342145pfe.10.2022.09.21.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:01:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220921125558.19483-7-dmytro@shytyi.net>
References: <20220921125558.19483-7-dmytro@shytyi.net>
Subject: Re: selftests: mptfo initiator/listener: Tests Results
Message-ID: <b93aca13-a79e-66d2-1b24-907c53ccc8b1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Sep 2022 15:01:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Dmytro,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): selftest_mptfo =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5220647671431168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5220647671431168/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_mptfo =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6723649817280512
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6723649817280512/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5eb61bb88e80


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
