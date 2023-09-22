Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DC1775C
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 09:33:26 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ade101217bso1179785b6e.0
        for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695375205; x=1695980005; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4g9yHkKXcf3wCkV7QJXJWnJ5f5QYMOe63wb1G8zrP0=;
        b=l4nB5gjHeGU/Ze3tcMK0rXEsMQtQc5mmHYFhmTRu/NuFg0EqyVcA+wPrt/g36xoSTj
         dyRqrcxk10Y8h+b8mUt24SykGSFYwg0yegCMSKt4BX2Op20DY21ZsOGJpI6VooVe7+zj
         rmB8rSdJeiQ82kF3l8HMq8zaZxow4TCDkKg+0QOQ/wvJi89V4Z3t7ul3Bvuwovakb+s+
         0QxRNizn1+vnFuwk+P1mbY5pt5ZO8gdEDrpvfNpcLyO1rX8cwOjQBbt+j3GtRLvu2eUy
         lfMpa/0dmGnJo0EYLzdMApVaTh3OJoJO47nC/Xl5bFUWjPmysORVBgxbDcYHhKz17Ptv
         8fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375205; x=1695980005;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4g9yHkKXcf3wCkV7QJXJWnJ5f5QYMOe63wb1G8zrP0=;
        b=wjxBE7BdPSsCj4wlFYoXrnKndiMTIb3CbjMwUOyE6VXnFlKYsUiOMKo67UHMHIo8Qj
         eA/zOiavXoqytyOqO6519K2EJB+jpUl1n0qOVnNC712H6z4gxww3AoTXIyP2JX6rp3Y0
         4xaM/I8/Q9gwbyJS6S5rmKcwa5jLySk3XdIV4xMHRuJWo+3pllR5+m4v54uOx0MYwszP
         6J0TPMYbUApsrkLda2r4MHhmY578EuUtV4yplenseLA/CxQ1CX5sYRlfTXM7UtXFNH4v
         hpw3uveu8ipMqfjak6omqTmn3h2LC4JhsIWP+M4b+l46VhKpE9kuyYV3uFYLpYsZjq3K
         WByQ==
X-Gm-Message-State: AOJu0YzqHrzZdO0lWuP9D8yMeZ+CPYjKOu8Sv1RWGunywCrHBmcASFrR
	m7H8AobiVemKScFR3dJgPQ==
X-Google-Smtp-Source: AGHT+IET08vUcCIisZd0RfCQsf4sC0rjAPLZ6Zei+TXpQhH8oC93cJwAefEqwbqsvudgg4mAcp9l0g==
X-Received: by 2002:a05:6808:1390:b0:3ae:1cd9:8e0 with SMTP id c16-20020a056808139000b003ae1cd908e0mr892947oiw.39.1695375205212;
        Fri, 22 Sep 2023 02:33:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.245.228])
        by smtp.gmail.com with ESMTPSA id k15-20020aa792cf000000b0068a3f861b24sm2764243pfa.195.2023.09.22.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 02:33:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6e31fe305493173f6c2e33f6351da074d9068a77.1695368456.git.pabeni@redhat.com>
References:
 <6e31fe305493173f6c2e33f6351da074d9068a77.1695368456.git.pabeni@redhat.com>
Subject: Re: mptcp: refactor sndbuf auto-tuning.: Tests Results
Message-ID: <c10c6e5b-057d-e827-180a-1b068e8ebe77@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 Sep 2023 09:33:23 +0000
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
com/task/4631115017748480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4631115017748480/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6319964878012416
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6319964878012416/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5757014924591104
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5757014924591104/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5194064971169792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5194064971169792/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d8c91c576df6


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
