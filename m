Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666C0EBE
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 11:09:34 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id s17so7726300qkj.12
        for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/726CIABuKonf4NqHI/E2W9KVdcHoufM82vgSj2ODo=;
        b=D2exjPJFA6UnK711otcy1zPorbkzqr8miCkdqEMlOLnQnj1BFIoPOB+Uym3Z7fne7R
         gryZadxxb1cMDFCrhGew6IssrZLziOnzYcLEn7yKBtAo7YRW05gt1c0Es2VuapUB2Tns
         wRdMIEJ9QUlwujaDLR/aS0Q5uh7jFBPL1FkZF2VnNJeB9uHsHyFgjRYr4Cjq1lEiF6Te
         bglEcqXmgk7UiNzf7I9tq3Bd4yeFDtdDehAMzfolnZMqcbwdlIjzGA9MGFkGpuoCisXY
         0e3q/WO2JMQ6Tc2lVthVcHKeo/dWbx5bxh5EtR6bMGbKlFkcs19BmpVRYy4eKfHsymrk
         7gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/726CIABuKonf4NqHI/E2W9KVdcHoufM82vgSj2ODo=;
        b=nzeGCPcXpW+7xecK79MMjmgq3R77yAjt46RW4rM6LE10e7Sjz3lJ+HrjkxwEIIxUdH
         i1ypvO3W0YxL550Ao930D0FcSLrgmhfcNNnh5FaxKPH9QeQ7Vv5qgfqbDvunmAMLyS4s
         aCFk4hO7/L/ExdHYQGzBK8+lP4ukOOzx5njZj82yjrHdIf9fz3J4twiejFspKfYumZWD
         49Yqv/jYTaQpYZIcznInP3KEA+CfokoJH+BRGzyORB06RtEbep+0VCiCPlgnJftrhuWo
         8UHd7S3f3qCBMwekYMLt3M5wWb9Lw7dTvpGoy9cvOA9LXBHxVD8OPKpq9AwkJfP3+F2I
         +VIw==
X-Gm-Message-State: ACrzQf1Dp5lpKsQp6JzAn0TMZccdB0NRS/HYggnhnxrdZMRJjlOjvW+Q
	A8Fx08yaftlGe7toAmeUJw==
X-Google-Smtp-Source: AMsMyM4GViBnIBwmZ5rhZwOQD6NbaZ2VbwNR5PX2p1ZJed6kKOzxNHn7myjesweGuZmUpUtWZeGnRg==
X-Received: by 2002:a05:620a:1725:b0:6ee:e8bc:9594 with SMTP id az37-20020a05620a172500b006eee8bc9594mr26996610qkb.184.1666696173254;
        Tue, 25 Oct 2022 04:09:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.87.40.186])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a142100b006ee949b8051sm1791698qkj.51.2022.10.25.04.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 04:09:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221025092444.6646-1-geliang.tang@suse.com>
References: <20221025092444.6646-1-geliang.tang@suse.com>
Subject: Re: mptcp: add pm listener events: Tests Results
Message-ID: <a8c23c80-a95b-69fc-1553-05ee76b94d89@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Oct 2022 11:09:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6369359325560832
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6369359325560832/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr packetdrill_sockopts selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4961984442007552
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4961984442007552/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e850ac34e772


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
