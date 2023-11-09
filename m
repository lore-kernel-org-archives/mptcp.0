Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174F360
	for <mptcp@lists.linux.dev>; Thu,  9 Nov 2023 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9Vl+JDC"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-41cd6e1d4fbso2264901cf.1
        for <mptcp@lists.linux.dev>; Wed, 08 Nov 2023 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699489648; x=1700094448; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ljfco1fsuqaKR/RW8IBAQuiCD6pyslcEPLinaIVX14=;
        b=N9Vl+JDCSHvqWXWaWEvhz5BEZuDMxpB70ZNRWWajNa0mngArwaBtZJEZlwlGQXYvx4
         I1GVg2sHzFfCZIzq2rUgSMe8AP6RN3acW7K7d/tfgkZq2jN8cq7Cjht7AgY4/hFF+a0q
         hwowZJhpM6/nT6WoUTUXsuCzhos/uJecc1MXbzp9Ps2qhnB84nDP6PWPnU0JteQg74bN
         u91UsubWoSLWCHewtNS+fZcJzm6DDeiP/8+MYvkvAVJQs0KtWfw0Iwbn46K594b+7p7b
         tqANP/AePbtFgDkwfHFKL/HRt+vStJwd22Q/FAe9LQcS8Djys6ASAuHk2z/40z9KXSBn
         DnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489648; x=1700094448;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Ljfco1fsuqaKR/RW8IBAQuiCD6pyslcEPLinaIVX14=;
        b=A1d1KSRO5yR8zaVqdqgBMLJYzzl4q+CMfWnKd7OwZjlM8xgQNy1DAS4Wbue9ykHshI
         2bUetdpucEwgCfcgxHgvvcKlFRJJ4OAXt0SgDaHIExLfyIT1XhxQkTDUD/uAf0OpfImH
         UeAorpb+AZc6Zs/1HYKZ9T5dRgCLvcXyTLUNKFB7M/ycdxnvBqXfE2RMUCccniCEoMwS
         I5hpbOWbmh/ew0DDoCo2zEavhS7SrfReU7Y6slGncCMTaq/0i9U8bNH9f2FTTbCOwe4b
         B+c1sBp77I3Nu9UlChrm7XLI+qdbY9sVdFsqrDQYhr9x+pr1skhAV1Y+bO4DCT32+10x
         gEPA==
X-Gm-Message-State: AOJu0Yxvc1U2nVltxNiK4MFssVE/rAHLCopDSa5lYknTq3lqtnrnM+vG
	DjsFgPHUO5kiji1ZSmXMHw==
X-Google-Smtp-Source: AGHT+IHwq9JskzcNM3XjSA5hLtweyi+gypFui9Izj0D+5ixXG4DBzMF23VF1lnuRqrQAFUHTkXcz1A==
X-Received: by 2002:ac8:57c3:0:b0:418:12c6:467f with SMTP id w3-20020ac857c3000000b0041812c6467fmr3529035qta.3.1699489647560;
        Wed, 08 Nov 2023 16:27:27 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.253])
        by smtp.gmail.com with ESMTPSA id jr23-20020a05622a801700b0041aff9339a2sm1424214qtb.22.2023.11.08.16.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 16:27:27 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f2cf8a00fdf178f314b92c8809ca9deed98464fa.1699466615.git.pabeni@redhat.com>
References:
 <f2cf8a00fdf178f314b92c8809ca9deed98464fa.1699466615.git.pabeni@redhat.com>
Subject: Re: mptcp: fix setsockopt(IP_TOS) subflow locking: Tests Results
Message-ID: <c9565154-e603-73c8-ef40-20fea04076eb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Nov 2023 00:27:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6216342865444864
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6216342865444864/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4808967981891584
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4808967981891584/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5371917935312896
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5371917935312896/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5934867888734208
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5934867888734208/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f0a09d7ba823


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
