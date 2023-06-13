Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976E3C25
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 10:57:11 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b3a9eae57cso20560195ad.1
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686653831; x=1689245831;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRfPbyBLW4xQDU96TSj3VzrxV1TToBIygbq/zqOCERU=;
        b=egeBu5I0TPjxgG5+/ce+mwqGudqUhrXosQyrjZNG1mpQcUcHhf9wU5qsuYcc5yUm0f
         YyzYmk+b/0LDRWryIIaPlEokuQoD1aeHisn2/FtQIyfBAjQVUgIe64pxvcbVZ/TLmlqc
         QFrDKIuymCLGfhIhbmlhdzlKDDkTMnU39+bY/eSFxL4HcUYIO+5JgnUKKNsFJjcbSceo
         1AqfGlY1bXOM64xDJIYK2FNjvbpR5vEgy3+37Sg0L4/p8obhvpbRGu2Pa1YUS1eSuR4Q
         pNNXPbvT8ejivEsiY9pfsktfEY/ABTW2dbAmbOs2pFfHh0jgffR3JWwmPwuNthGD/Woc
         A8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686653831; x=1689245831;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lRfPbyBLW4xQDU96TSj3VzrxV1TToBIygbq/zqOCERU=;
        b=bepl6aCHaZqyaY/YCAIkFzGl8LsXO5savVHiMJnQgEhwror3F/vOxT/9fcj1R5xKlt
         fi828YsOuflpUTHRv4aofpXybQi4f2klEs6OWi8Q5x1GgqRsfEuIiDWl85QzZ/f5Sfw6
         cgM0Y6B+phiqwVjNWTzVS32OHGfOJzO5LDIFPk98aWlknxRchGH5qd6GyrUBygdhDFHN
         3Vta6iVx/QVeD3UYjKbUVBuUY4jeRXsqvPc7nXbi5fzMrke8m1Uz1gYM06vL/jIA+dy+
         8mbMhErK8EHYU2fZpwSapBNPDCFui9VtLyk0dabWyM1tSYm5vKMzyyGIiOxOh0sWYmL5
         qopw==
X-Gm-Message-State: AC+VfDxQVW4rN8cJOLz8OLnt4xtWYlpEQTWRMDxCYi0kxqwWx1shUtK3
	3gHUKepQyxdvOexqfRk3wA==
X-Google-Smtp-Source: ACHHUZ4mt6YaI0FhPXncpGS+LM5r/KQnJdUR/vVEzTcrAR/WG7RFK2h76Ddqjq/jZVelwTEg6QWEhw==
X-Received: by 2002:a17:903:2284:b0:1b3:de1d:1ce9 with SMTP id b4-20020a170903228400b001b3de1d1ce9mr4744838plh.25.1686653831365;
        Tue, 13 Jun 2023 03:57:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.88.116.99])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b001b02162c86bsm5539948plg.80.2023.06.13.03.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:57:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
References:
 <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <27af6d40-dc66-c65c-2891-2225403508b3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2023 10:57:09 +0000
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
com/task/5825819981905920
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5825819981905920/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6388769935327232
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6388769935327232/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4981395051773952
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4981395051773952/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5262870028484608
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5262870028484608/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/08b13e6560ac


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
