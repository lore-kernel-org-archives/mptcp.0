Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE1125CC
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 19:09:33 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-3f8008cb772so56592471cf.3
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686078572; x=1688670572;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDRqLHd/6iZ0IMOo0pJUsuHIpnVRC8cGptd2wQQjLCg=;
        b=g9M1T57YlVB2c8QLUG3B73p6eBcx7Gx4iq6Wp/NCmu1b1RkDrgEfbCgvzE3+Zn6b1Y
         iXfpF4x/vRP8NTTYz+dxYYNf7qe9QSI0grA0dhHxu4ILjA4rqkOs7yE+6SoUGOwIUUok
         lBHVW0Yl0IbtnC/e8kGqurQOFzK33xDI36VcG9ZVEkbSxuG0caOO+RwsevLwm/0ut5n4
         eWDwY4FqgA2VJm52+qcCr1A7i0s744SoTaRgV+t1Df5mvdv2oh0KnJyW2pnBlYxB9Exz
         fbbK1BThrseEUuC+Q0W8H7VtYJG7Su1m9S9CxFX7X/uWE2EcYK4CYgClTgHwkKaRmuCq
         aRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078572; x=1688670572;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDRqLHd/6iZ0IMOo0pJUsuHIpnVRC8cGptd2wQQjLCg=;
        b=hBABwddtmYxwRfF5tYdHFhU/7yJDijZkfJ7PGoUGOkg5C6dMaoGW4NdeIrgc5QM3VM
         73k/91gXM6PJdkGZV8XPcOxM+OppsfVAoSkMuvRKaDoIWX6RRfM82HwnjaMn13H9JbGE
         mHdsqHcCGqX6ndI1PCsapRqyesh8l6GZu5k469AvjbIym9CnHwqJh2l9MuNtxcvSwvq6
         eUbl7PUE8WTb0eEKQQozZ9WD/erP27QaYyegThw0M5VrIeESHpnvvrYMdVeKTEHMzY+h
         BgJ82WFSdNPBzHRZgs43LwKHB6XXTuL1wVP20ytu69rPwvNun/YcjDtW0Qm1fRSDVsMz
         9mbg==
X-Gm-Message-State: AC+VfDxC+m59NrsuLUItjyp+qWZtoTGiIDaxUj4jU+xhpg9R3QJ4Cx37
	wKBftqUGlF0CyPpf07epE9os5cw3ga4f
X-Google-Smtp-Source: ACHHUZ49+okJ0VH3PXvyh0tHxjpkHtGn8u9dfvEUDywOw1EIF1sMwCfo/x3cOuGBRJT+Kep8wo01pQ==
X-Received: by 2002:a05:622a:2c1:b0:3ef:37d5:49e0 with SMTP id a1-20020a05622a02c100b003ef37d549e0mr824016qtx.21.1686078572121;
        Tue, 06 Jun 2023 12:09:32 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.204.49])
        by smtp.gmail.com with ESMTPSA id ff24-20020a05622a4d9800b003f9baa693c7sm59162qtb.10.2023.06.06.12.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:09:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20230606180045.827659-1-leitao@debian.org>
References: <20230606180045.827659-1-leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks:
 Tests Results
Message-ID: <14ccfd46-2000-992d-a196-608dc5f9dcdb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Jun 2023 19:09:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Breno,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5521599395266560
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5521599395266560/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5732705627799552
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5732705627799552/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4606805720956928
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4606805720956928/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6647499302109184
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6647499302109184/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8116764b617d


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
