Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4E42110
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 10:18:09 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id a11so791108pff.1
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=pWQEuW6GppmbZHoxmnGzlqjn0HRtwxOfR+ycRYJkjG8=;
        b=GrVEmqB4qysAjiu3pzOLvMRUHii1bNXb6E1nyNwP6GIQwePdr73zde2gdzKGEMG8eL
         +PqxDxujIwfHbtvcjgBHTh9V35oslgqykryMnpFNtq9r17wjB+4c8Xd0HSc5RpQsXjEy
         E4O4KzIOoxoK5LQlOuCjByfmyP2mcLxlPmhg0IwJ5YcalMorI9WH7Lm0lIDQYPppugW8
         yNjDtULzS5OauHCsRVr8+I8IYyBBhv6ywhftZYRyF5wAN7/XjMxB635hN7Nf86eu+h6O
         VlK2116GNIxDYE0Lz1+JOVoGe+YA+y44n72Qzy+3h9qiTZ7SR0XDf0gkVOom9TxVs/v6
         jcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=pWQEuW6GppmbZHoxmnGzlqjn0HRtwxOfR+ycRYJkjG8=;
        b=PFCDKTfImS/uqAt9KyIwimTws+h0pPoZED0GhAkGdHSTTQ5/q//T5TPA9ndFYCxEoc
         iNpWJ94V499eYng08nvskWJjjoykZjj6fPWlZcu4ItyfHs0O55Dk9xswZF7VlpB896Za
         1lUnt8A8uLy685WY8/bLffXhYYZ5VwTSSynrPn4y5fynTEdtMgI1rxk+cZAzRtPWmxAX
         xEk/Ip7/dS6tBMN9cOWCzk9hHuCBeawXjv1IyrRlRms40SzMSBJB9CjZZz2gwHHa/Cgk
         PokRoEx4/DW2v8/8SfKlPXVtFxvzovCdm1S2eShE5kfEz3RWzIEJlomDudYHiRhOD3B3
         cw6A==
X-Gm-Message-State: AOAM5303gvY3Pwd03VmTr7HS2c490zdYBaX/DBvOxun4js/9XhZwjrLY
	UL5xh/yr456PTICefNA/oYacWv6BdQ/n
X-Google-Smtp-Source: ABdhPJwUjO5i+YoKx3CFKiyhTQZ3lScG+I6tpdgWQLg1024Y51mFUl2Dah2FRSGo9zH/LOQau9ZlnA==
X-Received: by 2002:a63:82c2:0:b0:3c2:8bd5:7238 with SMTP id w185-20020a6382c2000000b003c28bd57238mr4837795pgd.440.1651659489006;
        Wed, 04 May 2022 03:18:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.245.81.246])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b0015ea4173bd6sm5566287plg.195.2022.05.04.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:18:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <613074c6f6136ebb652df581fbb3d7de02fb8e33.1651655175.git.pabeni@redhat.com>
References:
 <613074c6f6136ebb652df581fbb3d7de02fb8e33.1651655175.git.pabeni@redhat.com>
Subject: Re: selftests: mptcp: fix MP_FAIL test-case: Tests Results
Message-ID: <009a4aec-5da1-2b5b-6598-f2f697e90c81@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 May 2022 10:18:08 +0000
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
com/task/5254781382950912
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5254781382950912/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6380681289793536
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6380681289793536/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9400da9d2b14


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
