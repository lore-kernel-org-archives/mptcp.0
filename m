Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C549364D0
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgEwDjOo"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b9dbbaa9a9so3646308b6e.2
        for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 03:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702293863; x=1702898663; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O38VUETJT+58SgDTZ6MRIFW7D5UtPIh0vF4u6X+2mU=;
        b=CgEwDjOoeP5DvzBPlL8mRA2CgeEc4xPDGMyYgFl95QcUP6DwioT600SW5f9zhk5Jm1
         CyDDKr32YRBs+NttmwIGv9LtOHPDkGqGM8fQZa76bh3H16azc5+UjYkzR4ST8/zTuF5l
         YP6HR93hTMNCVrNUDlZO5bH/SVda+6ulc3FVPZx7ezNo1thUB6ZSeNbEQRANdV7fR9li
         8qU+lDicwOJZSV4vsYiyOzpAnn1sfjaCAFoa6IdA3BZE/Y7JH+RQKJCc1LroqV1b01LK
         uWgolzOCLIKY82keD6reJMqTskMbWW7vFmkFBYsBWtmkmX27HcMIzJtdbDDuCvpnahG0
         gNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702293863; x=1702898663;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9O38VUETJT+58SgDTZ6MRIFW7D5UtPIh0vF4u6X+2mU=;
        b=a+6twjLEGcKaFisQceoAcVrmfzYMUW47BEUBQVtj8UK5ZRl2RsAelmFTJmqSnaNL8M
         K7wssX99GqWJm+zpVdgIUbXm8hrkOGHadJWm7+d7L5vfDntpxCRjVB2FvyvECbwXZiZ3
         jrAS8Bf+k2IUuciP3IrDr25nBiI/MwmgSbkPJhpIAcEduth9CWg8jHRjNIjywE8MzUnN
         Kz2dwwq/QKgweOW5yGHhCkPniEOpkaGVeeXRxIvCd8S0rMk+yBlIxk6dVGPXfA0GeMDK
         84eURrgPQiFy3XoErb4mTWjCih3wYYgypzG8HQBx0tG+NpaZX3XuvPwYh2XAMX+w6XCZ
         PfXw==
X-Gm-Message-State: AOJu0Yxb7D1Qoranp+8ec24iKZyMObv/AgTohK5dbIJo8Y9X/9kSjnZ6
	s2akuft04LKXx3JxKzKrVGxBZ2BPjw==
X-Google-Smtp-Source: AGHT+IFCcJIynP6i0J28IG4ZscVxNGyiTRumyGIpbXdKZ8mfDQNI53ZqSLk4wowun/1TeHTxO2Pr5g==
X-Received: by 2002:a05:6808:3a16:b0:3b9:db4e:fccc with SMTP id gr22-20020a0568083a1600b003b9db4efcccmr6283501oib.11.1702293862935;
        Mon, 11 Dec 2023 03:24:22 -0800 (PST)
Received: from [127.0.0.1] ([74.249.5.179])
        by smtp.gmail.com with ESMTPSA id rr17-20020a05620a679100b0077f0ae46fd5sm2853020qkn.16.2023.12.11.03.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 03:24:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6bb5f7f97fb38b71312104c9755ed9ca24e8bdb1.1702282411.git.geliang.tang@linux.dev>
References:
 <6bb5f7f97fb38b71312104c9755ed9ca24e8bdb1.1702282411.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Tests Results
Message-ID: <4831ee39-da39-90a0-bee1-2865d9005b18@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Dec 2023 11:24:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6001690181107712
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6001690181107712/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5438740227686400
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5438740227686400/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join - Critical: 2 Call =
Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4735052785909760
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4735052785909760/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_fastclose - Critical: 3 Call =
Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6564640134529024
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6564640134529024/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c6be3369e827


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
Bot operated by Matthieu Baerts (NGI0 =
Core)
