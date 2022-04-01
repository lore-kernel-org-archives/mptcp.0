Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C5137F
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 17:43:05 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id 14so2450113ily.11
        for <mptcp@lists.linux.dev>; Fri, 01 Apr 2022 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=VDEXrujHw36zF4OlZ+HWh3ywSxk8OFH0OTPNcMkEuYg=;
        b=OiSmoX7ASrk1O4WEgm1Qx3qDe3dyN7xWVwiSVgTYgYqOyH1/73kzl3/Xhv3KFFQaZ0
         b5e5b16uhlySuW9N0xVHEQXspwnyjrIPVfGfEMMzpmJstTY26rAZ98ny4FN4t8jIMV1d
         azH7ecByhcNjyfFpw6AKxNGdk+lZWfpns1LgDF0URR5gUnMdtQM9oipLHJ96Gx8+3fj5
         Xs2Wb5pIde8TeT/nEnqViMmUrNqcoIfAApGH6Beox/zFa1ZwZbiGXVKbFQhWL6w4+t6/
         VQ7mE0KFUpLx6tFXeOFTB1vFCFhKKMfyxRk6oCwlosk8b3ubNnBHwR6K1XjigXSdiuV7
         SnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=VDEXrujHw36zF4OlZ+HWh3ywSxk8OFH0OTPNcMkEuYg=;
        b=QNHoht1gr86XrC3zTc7esP5a98VHdPV1BEPXE8ustvlU1WsN2uRfQu0+D9+5IJKovO
         z+xKc1tN7YJ68SYGNvrPA6DoMkOy5XkAC2+BfpRuRPIXb6xy2wpIJHeUxZbWsIf+asWz
         xXmws1noZvaS/YcQv69mQmguZEammmfkbvymO3p4i6ylZ/KDLz57IMU83MjjOTjLGtfL
         ifHme14MjnCqKsxGucSywEfOLMxarJj59swKSX6jEYv199XileM4tzoWowxEpQ1OffLj
         ZYxMJKCICGhxld7C9BaxqJwsc1l1FX5LuIZkIWcAKb2CSYo5VFkyd+97FHYgj72AoRQG
         ldRw==
X-Gm-Message-State: AOAM530HWr92q6ZNE4GGFqEQQS576N9w3laca8H/Zlis9IzDI8g4U+z1
	ErBdbdzxsgbT9xZw/V+FEK4pjKTXBQ==
X-Google-Smtp-Source: ABdhPJwK9B8PQs7MOfo9IHJerG/nVxBnWmRq9iMGTuTzt4DB7H5QY8u1nUEOs2lqemdEgZjxAIelaA==
X-Received: by 2002:a05:6e02:1a23:b0:2c9:c008:8ad6 with SMTP id g3-20020a056e021a2300b002c9c0088ad6mr444392ile.98.1648834984149;
        Fri, 01 Apr 2022 10:43:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.69.174.177])
        by smtp.gmail.com with ESMTPSA id p3-20020a92d483000000b002c7e1877f5dsm1629782ilg.37.2022.04.01.10.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:43:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <83cc1b00132bcd16a5dda7a7636aba252aa47b04.1648826372.git.geliang.tang@suse.com>
References:
 <83cc1b00132bcd16a5dda7a7636aba252aa47b04.1648826372.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add MP_FAIL reset testcase: Tests Results
Message-ID: <61b2c21d-5b21-e882-f821-98d71844b8b1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Apr 2022 17:43:02 +0000
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
com/task/6121269912403968
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6121269912403968/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5839794935693312
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5839794935693312/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/729b24964314

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
