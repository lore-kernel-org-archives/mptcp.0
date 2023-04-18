Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31041FA0
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 09:40:41 +0000 (UTC)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-32ab4464280so3175825ab.1
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681810841; x=1684402841;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVMy1xKKv3dNLS1NO4OFBQ5+9j7u6VIIddo99wOn0Rg=;
        b=l6GdxhGvGprniZXXVWYYZ6Rc0HMs5Upl+4OGGzBxhPpysuGq4/idKgdJA3thd/3ZIx
         mWqQXxIkJG/QlG0Q/cW97SU/sX7TT8oHxwaG7nXtlcROu+575WK5coYcPZ06GXSY6pvM
         qdjSN/w7E9M3YjyeF2fpe5ryc9V48poTeqesnoL+oaIQOcu92yg588JOhCsz0+jvLP+x
         Eh079CG3uYm9GFNYYVD7VKsBNwt3ozb6r6tXRBg07gJYD+2NMyVS8dxFGeUYHUwKwcoJ
         VG03I9AfEOqmXI279RJiwcS0vMNpwH3wGqq0BStO8cXZADXWMSgcipbwNuIX6fM5uw8N
         9i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681810841; x=1684402841;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HVMy1xKKv3dNLS1NO4OFBQ5+9j7u6VIIddo99wOn0Rg=;
        b=jnJLl28SvU8wHpYNLpSkz2WwZq3jOlG0KQG8oN/ekDwM9z8kGzH6hnYJLjfvZTlJtc
         dE/jBHdSoOWNdkvaZTRany1sblA2WO3TXg3y9OTa5RgMc1XmOrZCG0SJWGvj6xfVx4I8
         NWz2iRw3UXgNtHIV3VbI/+j6iRb7zTHvIs2E7kqePkYEL1U8rdNt+cZysIfq+SWMDbcT
         YBn2q6CPIbqf8PkeJPHo/FoXUk5+1jpT7bW9S+TaxGRby7JpaSl3pQ5tuI1bEiejf/u5
         gTJFnbpTXAKuvXgeiEXo5wPNW9ed1JKCJgCWgDsVABh/K9woC4w5getThsOwWZIwnsv/
         Ml+g==
X-Gm-Message-State: AAQBX9ep4hU9J5qddS4wL5eXfL+FOyiHWZJnmW9K+9OtlWtU6+hcnXta
	8FRGvczGgHxITDL1iFX2H+ecYzSEQk0b
X-Google-Smtp-Source: AKy350aEttfzBb+TlkaVJdOZHf08SEvip3jHuiua7/+oEvKPi18w0Pl71i/9f9gevH8Xk9QxeclMkQ==
X-Received: by 2002:a92:cb12:0:b0:317:9af1:5b8f with SMTP id s18-20020a92cb12000000b003179af15b8fmr11744519ilo.21.1681810840963;
        Tue, 18 Apr 2023 02:40:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.86.22.113])
        by smtp.gmail.com with ESMTPSA id m18-20020a056638409200b0040f6a55f6f2sm690603jam.84.2023.04.18.02.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:40:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20230418-upstream-net-20230418-mailmap-mat-v1-1-13ca5dc83037@tessares.net>
References:
 <20230418-upstream-net-20230418-mailmap-mat-v1-1-13ca5dc83037@tessares.net>
Subject: Re: mailmap: add entries for Mat Martineau: Tests Results
Message-ID: <9413aca9-2106-4433-7780-e9a88430c8fa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Apr 2023 09:40:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5092211885342720
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5092211885342720/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6218111792185344
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6218111792185344/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5936636815474688
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5936636815474688/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4810736908632064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4810736908632064/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/77518165a943


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
