Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE82397
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 16:33:52 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id y6so3540119qke.10
        for <mptcp@lists.linux.dev>; Thu, 05 May 2022 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=7ukhYz0pHc1Dk4Y2cplfGySSywiPK21WLLea0DcqGVw=;
        b=ZFuyG8vCBVcdVCrLtj30VPcmnjzZ+F8GwY5pCLgvqwjqklPgguz3G40BHIezITCHeL
         5x4wryUGmFE1MTvYoDf+AmBY5YmmKMrzI9zFwVlW61ABTuijihpcJqdz3xgVowIVVnX0
         ORXigZ1EiaAtW/rCKdgLpp7DfQ5IAGrGHHjkwXZhtce7v/b2/wrVYi79P9JM1f6MJbaa
         4szIqaFxMF8x7JhriCxGryfkCad6HwaBRxzoX59KSXCKl9WxAUusoNg0rkcoVF/Q9HHu
         s5hKlJj+GXuPBbhA7RPOdpskgqgIqf+NpLmQftMNgVFxqXuU++siqaSx6V3LxJpy27cc
         xd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=7ukhYz0pHc1Dk4Y2cplfGySSywiPK21WLLea0DcqGVw=;
        b=YNIA3tVdE6V9urgtVrMLozjdigTJgut4mr/pdukBpMvqQOCb5ok30FG60IkotZ29+n
         yXwhdYwGVr5U47niIcLPlBrEklxTu7Ge/wP5q1VqY4pgkORQtKjuk5mK5ozBk3/Buo+h
         xOx5lQiAjytH97CWrFLH9n6F5kk9yjl8uptou4nCPVwUZtc87jOz0XzGbGDxH/mRUmwE
         PZMr1/7ZvCHqTUQGa+De/P6gQ3D5R7bzcdl+h/Yx0xEXW4EIgL5vCYj7kQhXKG0ZpQd8
         IWqDgN35FthO0u/hxWV+trBgqUmtD8awn6DNVNQ9SEmAvfMaKgNBprk+zMS/sj9y3oGH
         lOsg==
X-Gm-Message-State: AOAM533E9AowqWU3zGGhdgDFhb64gkN9EypVaKiF7u1ucmI3O+WRrEUY
	zKU6TAU8q9QF1iZKs89yjg==
X-Google-Smtp-Source: ABdhPJxh280RzgmpYc2hdlfTcZST5S/pq/+BjpyuIxnr4kt7PtjJV1OVHI6bRd5MXPJrxWuU/HZVxg==
X-Received: by 2002:a37:4454:0:b0:69f:c339:e2dc with SMTP id r81-20020a374454000000b0069fc339e2dcmr18023936qka.771.1651768431515;
        Thu, 05 May 2022 09:33:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.110.181.137])
        by smtp.gmail.com with ESMTPSA id i16-20020a05620a075000b0069fc13ce1e7sm998336qki.24.2022.05.05.09.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 09:33:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1a8201582e7fd63db7b5c9c4077af1ab1953c57e.1651763323.git.pabeni@redhat.com>
References:
 <1a8201582e7fd63db7b5c9c4077af1ab1953c57e.1651763323.git.pabeni@redhat.com>
Subject: Re: mptcp: fix checksum byte order: Tests Results
Message-ID: <f58aae63-a7af-9aa3-a3c4-f441baa9646c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 May 2022 16:33:50 +0000
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
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5796430060191744
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5796430060191744/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 selftest_diag selftest_mptcp_join =F0=9F=94=B4:
  - Task: =
https://cirrus-ci.com/task/5233480106770432
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5233480106770432/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e13b663008d0


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
