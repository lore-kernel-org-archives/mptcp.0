Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FDC7E6
	for <mptcp@lists.linux.dev>; Tue, 25 Oct 2022 05:03:04 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id o13so6255019ilc.7
        for <mptcp@lists.linux.dev>; Mon, 24 Oct 2022 22:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI3PZhbFzdTd+CQTXt8w1jAInNczWejHjici89XID7c=;
        b=CoogOFBNI12vsx44TaoZVEMIgcXccVTHI7sVvhkKRVu67jSQ+frgKy1TFoWuY0cO4h
         /9/uzN6qx7t4HgIi6cF7eFFgy1yVgUkZ9CVmcTiSbRQ5gq2iiFOVZLMhR4LMKmO/3fhd
         SLe63isBYiYb1qktWChPaU3P3lq2GYeC0i8ZWPzZU2muVph6/MDZmoVdQ7+oo/Sti0CU
         c1ZPPcgTUZNDcyP5atolT465Ya3cmKGYIQDM9OJevIo8MJPlRhgnQxkp7cDanbe6Gv4H
         /s5325LZkCEfuaoQDdcWYPgyxbSsudP18khsW598xe7vOiFcXu93SLSgXd9SrEX5dsNz
         9egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HI3PZhbFzdTd+CQTXt8w1jAInNczWejHjici89XID7c=;
        b=DOmsLn69bCkcrrKq+/P7876uKpwq4B+YW9eb657501POm+5pq+/OiB/9fXWgahgaO/
         mix27mEa70mxJ7BvVBM8oLcOHA3cZVnF/Zo2eXgKoLui7H4laRqgBe5AkYC1e6UuNAyM
         7A6XxUyMsLzEAUnq460e6OeLG7TYff801uFOm7riTOoUPSFP5FNt8yMpVtmh3oFrZoxO
         RK2XgjMQxQxIfn09E2ns1qVxYQMYBVn4P7YAkLOKbA7K38qNor9k0ysFG4nbQvdCpeRf
         AxpVjp18oYAAX8y3iP/lWySF6Wv+Ok2AEUz78EmIZfH0dxvZoTYB/kueszptO/I7MFl2
         iyqA==
X-Gm-Message-State: ACrzQf1siVuh91Syl+Dpm7cmZitMl9tMMhMC/RQmXj0T84HxIirdIuML
	0OgaNFvxwjFtA24V8AG5hQ==
X-Google-Smtp-Source: AMsMyM5YCJjifXGCFFQar9uVWWluwgxzcy3uhnKA9mJdgasNWqevwbEq5tJn40v1GBVGk3Q3Eea6DA==
X-Received: by 2002:a05:6e02:160c:b0:2fc:1bc4:1811 with SMTP id t12-20020a056e02160c00b002fc1bc41811mr23169432ilu.306.1666674183408;
        Mon, 24 Oct 2022 22:03:03 -0700 (PDT)
Received: from [127.0.0.1] ([23.99.132.126])
        by smtp.gmail.com with ESMTPSA id k10-20020a02334a000000b0036384f898a0sm530248jak.133.2022.10.24.22.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:03:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <95f77f38e54f9564608e844f507701c04745475b.1666668425.git.geliang.tang@suse.com>
References:
 <95f77f38e54f9564608e844f507701c04745475b.1666668425.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Revert_=22mptcp=3A_add_get=5Fsubfl?=
 =?UTF-8?Q?ow_wrappers=22_-_fix_divide_error_in_mpt?=
 =?UTF-8?Q?cp=5Fsubflow=5Fget=5Fsend=3A_Tests_Resul?= =?UTF-8?Q?ts?=
Message-ID: <c83248d0-23e2-cc2e-0344-0df1af61394c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Oct 2022 05:03:02 +0000
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
com/task/6199619129442304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6199619129442304/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s): =
packetdrill_add_addr packetdrill_mp_join selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4792244245889024
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4792244245889024/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/48b7132c4464


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
