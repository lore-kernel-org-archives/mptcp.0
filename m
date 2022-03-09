Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2637B
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 14:30:26 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id w1so1990662qtj.2
        for <mptcp@lists.linux.dev>; Wed, 09 Mar 2022 06:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=Y+hfQIrhYehqHX153Vpu265rKe6haJG8PezdEvYOd1E=;
        b=RzEVXvGu8Lu3eSISbVOmMMVO4XhfrHU2nm95yyX3YYbRhAMKmAps6tMxOkaujc3spJ
         jCcYSSx0OuEgrBl2zrEx7AfMZKQDe/ESa83ol0bIs+e479HbQa17vc2wEnajNFwPwPKH
         RKGlXRacdOd6nYIRc6rw05xyGCTMSxl9wY6ZKGCWFhY6zb3q0Fv9NXTeJjIm8ROYwOKX
         1Ucv4SzTuewQZvbHNW3soHl+KcCOrxIGgWold9YISA3n/iP5gxAtAb+7/4M2HjuGXMdn
         nW7lIif30SKhPc4YjyqkS0fwNK8fSV/bhDBULKH6wkB3vh0KMaxGQLQVzK4lX1Y8euJn
         qq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=Y+hfQIrhYehqHX153Vpu265rKe6haJG8PezdEvYOd1E=;
        b=bSbVxISrUF5RfWFf6EGgFuIMte1XmaCnGzvLF5U9oe0B8+fA0fyI7qTtf4IWqw+xZW
         Mrq5VELVAddcPhDC23uV0kHWQWBNcmE0vizz3aIKFFI97UeOXsBgMVDTbVA5mtCSvZu5
         g6kolabQO7lTc7K25h1K+i0Kp5pMl7RUtnIpJava6rM7BxKuVpgDCXl9dG0uQFXPzhzt
         qzLv52KFhsZSmDK1B49ZaZsjCelsI8gtwWe5x+DEEDSZ3aNSNZ/tuPWe9xIDW5O8NsIW
         RGlLGk69m/oIwirBkzoaoWjyrxKcIRS4oZlfoheU1irjG3Gr5dSN7SlUo7/H94O4QVaa
         lQwA==
X-Gm-Message-State: AOAM533YYFPC8LYu9zMMT97dUf6IKeLjSc2F3c/YlgKz7BDeTsekhRGi
	gBzF+iATVi6h5ASmjFtOg7SEJ3x2D6aC
X-Google-Smtp-Source: ABdhPJyGa0TW4iSUGefr6hWobWI49/EU/gDCB9Donq/+BhpOxV8O15O24jvJvtkQT1Rm9r2eQ51xmQ==
X-Received: by 2002:ac8:5a56:0:b0:2ca:df90:1aa8 with SMTP id o22-20020ac85a56000000b002cadf901aa8mr17879446qta.686.1646836224979;
        Wed, 09 Mar 2022 06:30:24 -0800 (PST)
Received: from [127.0.0.1] ([13.92.124.248])
        by smtp.gmail.com with ESMTPSA id o206-20020a37a5d7000000b0067d42fd49c3sm399599qke.4.2022.03.09.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 06:30:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f278d5dda12571f464f4b97da68a6627de3eea95.1646829006.git.geliang.tang@suse.com>
References:
 <f278d5dda12571f464f4b97da68a6627de3eea95.1646829006.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: check MP_FAIL response mibs: Tests Results
Message-ID: <f9dcfe4e-69b3-a173-6546-9de070d05c4c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Mar 2022 14:30:23 +0000
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
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5689563053031424
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5689563053031424/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5646932549828608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5646932549828608/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f5598ef0d924

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
