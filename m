Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A022C139
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 17:53:19 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso36367995ad.3
        for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692813198; x=1693417998;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4owI0XPU97RuQPv0K7SRS69gz+c701OuQb6itlmK9MA=;
        b=mZ+io/NZEdvq7ZNEPx9jEv2lTiJn8yYK6KPr/5zXJIB0ZLJSIiL9hnulLSqBxHI4H9
         81ZjoiB+/sWhtJFySJqQ02owT2Tj7ohVzFaCV9EZtipw/tC2zG2hQa4VZNbJVg1n3fFz
         nGLKgfZFzweOjItgUstF35MDI2vDgljPChkzBcokolQHIsFmiIh6yv9IKAZbb/VIdni1
         7Lc76PeGiTA/LIxdeIgxfmei1DbuS0sIcZngRShnKOCXzfsMkRE5jly3GiOcgO1+frGX
         mOD9nBegWID8/bjQXOz7dq2YUj57/wy30iugTFkUOV3rz8srvKm0RKuuLJI0PPvaLC8p
         7P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692813198; x=1693417998;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4owI0XPU97RuQPv0K7SRS69gz+c701OuQb6itlmK9MA=;
        b=LZ0MfoxlRNFoLLOYpW8z4YZ5T60HuFJpY+Uh4N6k4dOpxTOFL83cF5XGatSVbFH8j1
         jv7Ddd2eMcm4LVA0pEF6g7RQtkKzaW+u4TAx+PZN62yFTwB7f6L8c3L4gf+mP2Yi2mU/
         JQPWTfLDEbPjg+Z1v/RzitNVTQW7TgINcSXm7mP/5T+ftHNDuv3nJ5e23imqEXfQ3NbM
         rwTe79p/+WmIn77e2zQZRLas1Y1xzdX96woGnJTY19z7XkRyViSRU564V65yi5T5A8Zc
         keRln/9ojrjNFXGl5f4PX9pVqiAAmwfyyihxjsTSCV5L5ErN3jSrVG0achdu4iMzauJh
         UBDQ==
X-Gm-Message-State: AOJu0Yyt742viWtdb7H82jBL/3kspwI8PuQWTjuoQB2Ot4FjDKbdD7Bi
	Vdw8nc3tBMIcODFhisbhYg==
X-Google-Smtp-Source: AGHT+IH0RBTBiLDT6Xns3BqPa8SXKNTYIrphEsTXJsxTZZbQDR032883nEaiuUFOU18kBZzyHzL/Yw==
X-Received: by 2002:a17:903:44f:b0:1bc:682a:b130 with SMTP id iw15-20020a170903044f00b001bc682ab130mr10531783plb.27.1692813198359;
        Wed, 23 Aug 2023 10:53:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.244.238])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001bdc3768ca5sm11222266plg.254.2023.08.23.10.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 10:53:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
References:
 <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
Subject: Re: mptcp: fix bogus receive window shrinkage with multiple
 subflows: Tests Results
Message-ID: <5607cf73-1a92-86b7-da19-a7c13416457e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2023 17:53:16 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6616151929651200
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6616151929651200/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5138408301920256
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5138408301920256/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4575458348498944
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4575458348498944/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5701358255341568
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5701358255341568/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9e3231739665


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
