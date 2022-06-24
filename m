Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D2423A1
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 18:36:36 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id f14so2612251qkm.0
        for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=DQj+AReDtimho+ZdcvYfzaP95TEfKvM6VXXAIA3MluM=;
        b=h9D41mI7S3QuStqIr+miKYVmEtOBsv44khV6UrDNW/fjMLkIRLgKmFEZurAX0LEwnt
         F60mkEzTFSqovfWPo/VESKhsZRRXukhFYtv3YGd5/54/6ZdibmJBChnTQXY/3yaeMWqI
         PdferBgmvHYh89STbEu1I/riH4FZQe/x05cyXy0dzPIyJnu/1WNeoSeVot4Vh3uW8XMR
         GBSyATL6tnBk/9QmizcbfwSxbdvCYTpo/ZAIjQtScIGEAoXxJmMTx5hBpB4LEF2l/suj
         fNsoRfnofQoVH4Iy0KIt/z+F0M8LEzQ18reeypZ3s7T/MxWqCBSXK06PjhaUEQirCsvi
         fE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=DQj+AReDtimho+ZdcvYfzaP95TEfKvM6VXXAIA3MluM=;
        b=8HoP3MO6tHHUZ8MDX5R13SlpbY6gCnV1Sm/AnyoJHNgU+djpEQC4iLoCfMFrerY9tO
         XQVaqTWJLj6Dqsdsx1MM4lzjdK4p3yreIiXORwz/ULXV4Y4BwZP59GrOGUkS6oJcRvzR
         MqI6oRaoM4fxcryPiuSSjR06FfWfW8clcG8eT0u7SuNvRpxoEG6YsWvhlUdz72hi9T7F
         ERbW9hUCOQ67G88WzBmYPMifKzKeFddcMrFekAeINOnWgDEf77pBZAbOdUV1YCabU8Mm
         xhrRzs+IsjO8q3xrcgqak+aATJHljeSw9jwC/DW/isjHHwO6RaAORpj7C4MEBNnX/+eO
         BSrQ==
X-Gm-Message-State: AJIora/rmTVS8gJtr+6GcZGC9dxBl5dCYQpmJit61J6V9dNSdZ+JT8rJ
	e5Grnmq6mVEUAP27xzOgNQ==
X-Google-Smtp-Source: AGRyM1skybFHK0ckVpJKqWkcOgkL7ZX2LD2kmHpSEizeImQH5Y/EYsTClDtWqc9B+Sx981LwUaLhaw==
X-Received: by 2002:a05:620a:cf4:b0:6af:4b9:58d4 with SMTP id c20-20020a05620a0cf400b006af04b958d4mr508917qkj.38.1656095795467;
        Fri, 24 Jun 2022 11:36:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.33.244])
        by smtp.gmail.com with ESMTPSA id u8-20020a05622a17c800b0031776d4ae3asm1777111qtk.60.2022.06.24.11.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:36:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <25ad186319f6b464aee3286c0386f2851f9a1f8f.1656088406.git.pabeni@redhat.com>
References:
 <25ad186319f6b464aee3286c0386f2851f9a1f8f.1656088406.git.pabeni@redhat.com>
Subject: Re: mptcp: more accurate MPC endpoint tracking: Tests Results
Message-ID: <9c120205-665a-d8e1-e9eb-9616b70a4a8c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jun 2022 18:36:34 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6620488473509888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6620488473509888/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4579794892357632
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4579794892357632/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e01f9f5a3695


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
