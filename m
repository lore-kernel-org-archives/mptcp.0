Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0110EF
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 08:58:00 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id v23so3127580pju.3
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1oJrjVgN6DsIHqqrjmqgFldxDINDglud31b5ygKqgI=;
        b=nM5QI9avxj7MJQu9/p1tIc/lERlmYpjtRE5W5hzwRdXHHAi+Ce98vsH0qZUXPioWlu
         gER8LZeYV2V3saZvZIQCzNyFGFVxSt0InJ6Nib83Mw067nYSuwQkR7I/cTJJ0lzZMN12
         AMlCHXdzyszarVoyeWX5okI21pWIYyLxh/ClJ5w6uBGn0xaylKonoUItUZ9escC+RAvK
         5d8Qk+t00q0MrOl2wxGRX3QnSB0/MaATajwxTGz8XL4DDlsk4xq1TC/OwO2QiFwbjvkX
         ac+5yuCgNQsqKI0NeH99+L4TVS3bn0Fyd07Gto9qJAP/89/2VUit/Txfnl3txga31n2Y
         ZVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1oJrjVgN6DsIHqqrjmqgFldxDINDglud31b5ygKqgI=;
        b=fUh1DpwQtunS5AtUyZ6DXrkAM4Q3CN967nzavVRY/4U5W7DCE+KNyS8VmYH1WI96Sa
         tPA9VQrjFmpqaTfPKoghTvEoOXGqa6NBZ2HUzlUxrT1ybmzqMAK9uhp+9O01kK/ln0vh
         kClYF5SC6DyWXaIo5YftUDjU68xv/05M5t8WODa0T2utTXYBxX9/mpSc5JiZSxu8+RXg
         0EHYwy7fIfgYGsm6OymckrI4P1OEoprMNyvMOvVQaReIUgkaD+3/GP6A2Dq+89SzCmrN
         TI8QxqICvMds2Nw50dflnXno/flhS+VYhcIKnN5Jur+pfNR63C8yvUs+vgujX8THvdTv
         IH9A==
X-Gm-Message-State: AFqh2krgU2Ow6HGqDUFcbq6s+UKWt03tmo0OtLw4wEWHt9cX47sEn/no
	a/glXECMfNaqsLMXkkW0hO6U4DKEHRCr
X-Google-Smtp-Source: AMrXdXtFoi1Aq2HSouTcQuUSRiUF8D1iBJPx0XlQWYGBfTxjuQoc9zolXA3r5k4AKcua/2Y1EgwxWw==
X-Received: by 2002:a05:6a21:3393:b0:ab:fb31:be13 with SMTP id yy19-20020a056a21339300b000abfb31be13mr12057639pzb.37.1671440279796;
        Mon, 19 Dec 2022 00:57:59 -0800 (PST)
Received: from [127.0.0.1] ([20.245.188.36])
        by smtp.gmail.com with ESMTPSA id x12-20020a63cc0c000000b004468cb97c01sm5841283pgf.56.2022.12.19.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:57:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Menglong Dong <imagedong@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20221219075048.255811-7-imagedong@tencent.com>
References: <20221219075048.255811-7-imagedong@tencent.com>
Subject: Re: selftest: mptcp: add test for mptcp socket in use: Tests
 Results
Message-ID: <76603ddd-9883-bafd-2d36-982e4f632007@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2022 08:57:58 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Menglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6683962794311680
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6683962794311680/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4643269213159424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4643269213159424/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5769169120002048
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5769169120002048/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5206219166580736
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5206219166580736/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/93db6277a7d9


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
