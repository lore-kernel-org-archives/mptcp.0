Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F87E9
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 00:44:21 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id c1so27411636qvi.11
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 17:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=S//cw6/C/VEKagUr4/OKe7NsNNuotmR9ChUws0Ymwns=;
        b=KShBkeXmeutRqdRUB8FKHWvfUy2/mNBx1hEezKI4H+wKQwClS2uGNEwXdDxZ4bt6ZH
         ZfBa0i07l7Wl7vhchE3GDX6Ecw8Sg6f+e+4k4kisHqEgbiuTcahIG45CqYgznylv5i0+
         wu3fWd7cPmUiZTXJHNKnHWRL3LA9H/KU3vqYGJrEs+wxE6VeH5Uao7CHkm/hfojbMKrY
         +oQT+A4wxkEfbp6yHdEZ+Qd4ulgklAGaVIvmPlGvhzVP4NKQWXTbt0yebOypcNczchpy
         77BF5qxNVjBX7iHTa22YocYzBdWdw9Kydgk1hJvq7QikpHm7glaur7IoEgO5KOwnuCeH
         mQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=S//cw6/C/VEKagUr4/OKe7NsNNuotmR9ChUws0Ymwns=;
        b=Sdv4MpeYsdhSCVPiOJg649amJA1qrCwdgsjLvz08aOfgsRYRp7EsoekBlM8FfH0X5D
         //eYWEZegqhwc9RdrwDH6jACL0IogdPT2rapEckrn9/GdiGeXMR1RBquKziarFwn4Jz2
         grtZ/7LfFYbnN8pEam1Eu4DxvynlQe9sx94hPG/nVs4d0zHg4fEMDbeMROAo1sR8SkD9
         IaAyxPb0tfWC/0BTrZfluIobAZ+KtsxinuUZ3iWU7/UceNGIsXYJDCBhkPfngdyg8TyI
         tY9z6wSzcUmTIjc1RrRpuTSSrNacKwrQzB9HvLHlb2q8amshgtqvmCqN/zbdrLQ5VdEp
         sjEA==
X-Gm-Message-State: AJIora9uPZJ94vs4x9SS5W3hXHCVUP1VyeXXqWrK2YQHsqqt4tziOJ7v
	bPWCkVL8NIyPnjW30Za8XIQKNG78zWSldSk=
X-Google-Smtp-Source: AGRyM1uzXko7AHM9fcKoRKoGZWqsO+XNFn48FMWeBzvSgTSVwgrYd7qEFqaHNnUyOEwn4a8CiQVR/Q==
X-Received: by 2002:a05:6214:c66:b0:470:5251:cb4d with SMTP id t6-20020a0562140c6600b004705251cb4dmr9346337qvj.131.1656549860689;
        Wed, 29 Jun 2022 17:44:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.242.75.163])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a414100b006af039ff090sm15759850qko.97.2022.06.29.17.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:44:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220629225327.657202-3-mathew.j.martineau@linux.intel.com>
References: <20220629225327.657202-3-mathew.j.martineau@linux.intel.com>
Subject: Re: mptcp: Acquire the subflow socket lock before modifying
 MP_PRIO flags: Tests Results
Message-ID: <f48eaa13-d30c-563d-0714-dbc44273f498@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jun 2022 00:44:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4757612108447744
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4757612108447744/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5883512015290368
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5883512015290368/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8a2a284523d9


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
