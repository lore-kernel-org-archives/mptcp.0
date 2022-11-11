Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512A2582
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 11:55:34 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id k22so4718702pfd.3
        for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 03:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COD1Log/oMLixjJ96zqWAf0jyWR2Tvj8/qxe8vqi5iM=;
        b=Wb54OK2vHN0LeU71fpJuFIBz5IzxizoFJTk7cszIw1kFkBk46B/4Es5CJHqVpWFIf8
         +I0YyJd1hEcdskD/sMuhMVTq3ECatW0tZudeN+T9XzzaxpjKThAsyLffNSXf/bmaS6sC
         VUR7Pu8VI0fRTAuDtg1L3TPY7hg+VNs6Y6qBFGJ3idgIGrspcx5SPXlWIe6f7h1sxg2x
         odEDXiKK+fBg6CSaLd2YmsfShCIl+rI0rNYJb2HvEG9OQibYKhHEj73HUq8IjC42o0/m
         qNAr2aR4csVoIPm4rJHIZFukzq1Xuo0/QRmwnAlFcPVTuVfS/feIJhdNDVLtAikGXqcr
         Vayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COD1Log/oMLixjJ96zqWAf0jyWR2Tvj8/qxe8vqi5iM=;
        b=JBpluUOGk4cUMKDPCelkA8+ulHvOz+d8Vr4HFHJcjizbHMHc7+hYpHL8Kvs8uZAQOc
         q7vVIX3FQp0i+a6chiG0OeiBc9/doc7iw9zXqGmZC3ONGDdGTJZ5EPpewYMTPWoj9G0F
         Bw7WoXkAkVMGVlr4yvavO1s8SUMlogmKNsR1Lgkkk0gBrd5boWka6b+kUj6plD/ShvHx
         6cV3bBhVsq+lVAxjptWccyby5eOTraQbykiGhx3+zWDfa36T1dUvzSudYsGZcSudz069
         37PpDiwEJyUZgKLcMp7tDx2ZJktaVXWnnfxVO7Oy5cpsPtU6AqxpabaKK7JVM1/kUHcw
         QQgg==
X-Gm-Message-State: ANoB5pm8qog0y7R9/MpufO1ZwnTvtad+kpCJeaSuaZkgTUfADNDtg8W5
	sZm2w36AStsIjLvY+HRbln+l1F4iVA==
X-Google-Smtp-Source: AA0mqf6aC9oElTL/HYKBQFVa+YQrYrJZerN20eR8g+BV9X2GR1BKkhy25m6w9oWp1BDsuVTdJhwIzw==
X-Received: by 2002:a63:454a:0:b0:46f:b888:164f with SMTP id u10-20020a63454a000000b0046fb888164fmr1314970pgk.386.1668167733593;
        Fri, 11 Nov 2022 03:55:33 -0800 (PST)
Received: from [127.0.0.1] ([168.61.65.186])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm1481507ple.268.2022.11.11.03.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:55:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <508587c12b02e0f33388aa2fe30add27eb8c13c8.1668161791.git.pabeni@redhat.com>
References:
 <508587c12b02e0f33388aa2fe30add27eb8c13c8.1668161791.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_Squash-to=3A_=22selftests=3A_mptcp?=
 =?UTF-8?Q?=3A_mptfo_Initiator/Listener=22=3A_Tests?= =?UTF-8?Q?_Results?=
Message-ID: <f7fd0ef8-69a0-e629-b990-e701262e4a65@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Nov 2022 11:55:32 +0000
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
mptcp_connect_mmap =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5533446215303168
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5533446215303168/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): mptcp_connect_mmap=
 =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6659346122145792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6659346122145792/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d2547fcc926f


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
