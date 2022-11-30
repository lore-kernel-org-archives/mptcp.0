Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D9F3214
	for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 13:48:22 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id g10so16710032plo.11
        for <mptcp@lists.linux.dev>; Wed, 30 Nov 2022 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J24aZiDdviha9UIm2lm7zN5t+uqPHg9R7KhN/IVznJU=;
        b=q7yV6sl2gvNvqkQ6FahPdy4Pus4kPNl8OLrfaUuYWpE27gXgROJYGQePxACfBWwSFY
         wiVYC5BB3Rsu4lWaMv7LIBpsyJRM112RRVZQBkeGO2iu708M5CfQN/GLhxHLmo1RF2tw
         grfQHg3UABl2DNFlKI8fZxy87taK3aE+kAf64adtxGhILSZVXiggP4NthsdH3GnSYMwb
         CZWL7Ij1V4oWyXI9Uog3No6JoiGCuOvEqObjYIMyvo4LUekBzOf3HkrKEF26fcKB3+RB
         OxiA5h1C6Qp68sLy44yi6sICbgZIl4EJnrIhw1Qp/0zL9uko357m6mo0kAf1yd+/QiJ1
         UXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J24aZiDdviha9UIm2lm7zN5t+uqPHg9R7KhN/IVznJU=;
        b=FGDmHvAHpzvTE+RUKvO9HfDN2bHbZ1glVFlOIrLTSzqjPiKogXEsSGuOg/UCyGW6G5
         atDwAvu6Wjj1TVlKnbQEAp2Zf3cqav5Dh0FYcHJJaDv6bj6u1J4SZKOERuLueLGegyzD
         UOt7d7x+MposvV2WJuwKsnmw16sTeBBNWE46EFuLqk+yHjPYuE3jiBGjpXWtAV1JMdrV
         8U6c0Oz1NmACJ8HgfiVgBhx3PYN9Rp+hayDURzuoOrt6UxB2dbhRC0taSbys3BC6ItbL
         IOLMkZHh8yIZtSGTi8mL4lioS1/PNpeIYtb3raCkWt2lGTcbSsdeMGi9ImWYU6skq7Oe
         nDQA==
X-Gm-Message-State: ANoB5pnZzVsEovNy3uqc4DP5mH63WW70VqaQWtSERWl3XG4m/fmHueEL
	rDiIEWfkPBHlR5NJUvX5yEkEt6HIGzHB
X-Google-Smtp-Source: AA0mqf7ppqZ8hXWIas6JMyTZDx2g9FW4XNJyBhuITHUF57FPyYlXWw6NsRhuDWXFLaI3KkyGLoUMXA==
X-Received: by 2002:a17:903:c5:b0:187:4467:7aba with SMTP id x5-20020a17090300c500b0018744677abamr54143988plc.61.1669816101728;
        Wed, 30 Nov 2022 05:48:21 -0800 (PST)
Received: from [127.0.0.1] ([20.245.54.129])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903028600b00189758e2babsm1479575plr.125.2022.11.30.05.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 05:48:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221130094448.4119946-4-matthieu.baerts@tessares.net>
References: <20221130094448.4119946-4-matthieu.baerts@tessares.net>
Subject: Re: mptcp: use proper req destructor for IPv6: Tests Results
Message-ID: <1fac7c86-7e6e-0a3a-39b4-c9d39c5302bf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Nov 2022 13:48:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5358507365498880
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5358507365498880/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6128572050440192
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6128572050440192/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bc00aef00e2a


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
