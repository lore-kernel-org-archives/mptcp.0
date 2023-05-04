Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191E1866
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 11:33:27 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-61b58b6e864so3787396d6.3
        for <mptcp@lists.linux.dev>; Thu, 04 May 2023 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683200006; x=1685792006;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJm0IsBu+6tygWrl9EDaoMS03QEdOWOF3GLm88J9Dgo=;
        b=jWCDlHYv6uBat0dZHwWb6tzEEhy7w1vvizmx070UGMPwerTC6Hior6Z7LZDs8MPzAP
         xgEeD5Ll1vWrUrFOhtbm9O9932MwqM73KkTTPyv+jKkAzRW2L/mvvYW8/sr3nY6PqWYf
         8J2pC0Satrwrxc3iVuJoKGywBPCM4hjMGK8NroZ6wTRo+gW3Kun47aWKaNYWgpMF6hxU
         jsHHlYhdmN6YhPeUeckJgvt6Pko+pRojjJlMBL3Z1H5TKf4PDDaCzEwax+AEBaw49odQ
         LTLgER5Oau4QOQgsY5W4jLxNyRvJDY010el/hP+7Zb51fg18486mPTHyu3aHClwbIm5N
         oKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683200006; x=1685792006;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fJm0IsBu+6tygWrl9EDaoMS03QEdOWOF3GLm88J9Dgo=;
        b=V/fFwlQC+7hVCHuh6KQJxIZ+2FEzR2PS31XMC+IA2CJASumEAxC32N/2u2OuwLRyUS
         oaB733N9oeZ6ZznFRlKJ0mEtzCO1cCO/o1Gk++MbLAtRM+fLp3l3DzxMD+C/2iBrPiK8
         +jh47DVeCa/1mW4bX+qAKFiM5fWi8ZS6+V8mlcd3TUAW5pG6MymgdO4qSI1ULzOFtk+7
         aCbkYjMEYAeZeLH9cVqLLayzTjdpLoLo4DcGvRRmcdngxEF/QLygi3FdmbTRfdNwJ8f3
         0j0e1w3HNsx6zKbzoWIgIbXS/M6zTF/ytOjBZrNSnHp8qyc0rC4Vnk92jm1fnoyrJ9Mg
         22oA==
X-Gm-Message-State: AC+VfDxTCx3zngTinl6EAvArFe53VCBdQDmR3gDMmY/5KTzV3zeEI3U1
	5811pcvNZXL3GJL06+dLCA==
X-Google-Smtp-Source: ACHHUZ7l8uxm0c8mYfkT8QOozVD+kKA4qL+w6J772aAFXdtLtD7+exkFmQwzWk5MqYoC7iAbiL1mdQ==
X-Received: by 2002:a05:6214:260f:b0:614:da60:f45d with SMTP id gu15-20020a056214260f00b00614da60f45dmr17273854qvb.30.1683200005905;
        Thu, 04 May 2023 04:33:25 -0700 (PDT)
Received: from [127.0.0.1] ([104.45.205.25])
        by smtp.gmail.com with ESMTPSA id 21-20020ac84e95000000b003ef5dc13bbbsm1845332qtp.85.2023.05.04.04.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 04:33:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2be8d0226ca5ac72b1801eb128fa9028d4886b46.1683195386.git.geliang.tang@suse.com>
References:
 <2be8d0226ca5ac72b1801eb128fa9028d4886b46.1683195386.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: do endpoint manipulation out of transfer:
 Tests Results
Message-ID: <cc424207-19c8-181d-7a76-73dde896b699@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 May 2023 11:33:24 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5027630777368576
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5027630777368576/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6716480637632512
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6716480637632512/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5590580730789888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5590580730789888/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6153530684211200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6153530684211200/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f1f2e11c97ec


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
