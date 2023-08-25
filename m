Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AFA41
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 04:53:36 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3a9a6a7a824so230494b6e.1
        for <mptcp@lists.linux.dev>; Thu, 24 Aug 2023 21:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692939216; x=1693544016;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B594n7w+sMmiS6e99k6XvzvNMo3IfuawE26MjtrFcFw=;
        b=dnDaS2VoB/CwNWV/r7g2xFv2AMHyvVCp7FWzJx+sHXmNjjbC5EGyvjxgcuvlQf5hQX
         DVtDzouXldB9BoNeUGIK2onL2pqDuYdiiM3RMzfIyohCNuaF3M2Hrc/+NXQnjp6FVMLs
         AEQ7su1qEbkJRkICFmtShLer1T0npIjK7/dnKpsDD8uQ5MbxSQNVbU2kYq6og/nhmFNg
         OJS8E10SLLhhZjVldgXoo+elel7uxlnbs2C9RmcLq32p4285YNLSpI6ikjPr/sqJAANr
         y2ZQxT3T0y+3Egt0KNSmR/Ft9FTcmJUyI+CJ0MCigICbZTJKhwo4oWLqp0IWMuv7CqEC
         9nGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692939216; x=1693544016;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B594n7w+sMmiS6e99k6XvzvNMo3IfuawE26MjtrFcFw=;
        b=CzwckiBKi8sm7Hsa0bhNNCzXW4uCzsw3ZAuvtjZt8T00zZq1jPJcpJyCEHu4wx/Q4x
         NWCPMh3rRSDMgp7jNbu6QudmeqA1Drg4+29N/KXjxybQuMIc8hVKs9WQRRkD9UmPDKH2
         +LA9PDJ53FhhfcfIxiH+drkZZy2YpEmJCyJLuBTAd2GUQdhN8cVgeExcakupG18QGZaz
         F2n1c0CK59PYccje0+6D0+Zdv1qG/NDgDl9++RUa9G02B0spyhR/7UE3tCD8kplhEyiu
         BmrvcopmtX7GrQcFjOioz+le3K1QK826er9kc6Avjy1YqbCtxkfWaqVzb5M3h6p6Hx3l
         1+Vg==
X-Gm-Message-State: AOJu0Yy5rCe5XebXGUZEPuvqWKXeCPlpI+aCzlYIfPnSSBODZRSf32n3
	Wg/pfGHFjX8jYwCrlq4ShRnJ6Q71/Q==
X-Google-Smtp-Source: AGHT+IHNs/wOwwEuFS7w+Nn0q+LFe3djJQU+Wfo/BMQ45JR1c9oaveQRPjbg8OaIsWM7w7EIQ9ZUtA==
X-Received: by 2002:aca:2801:0:b0:3a8:742f:acc9 with SMTP id 1-20020aca2801000000b003a8742facc9mr826485oix.11.1692939215871;
        Thu, 24 Aug 2023 21:53:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.72.146])
        by smtp.gmail.com with ESMTPSA id b11-20020aca220b000000b003a1dfa93903sm415503oic.12.2023.08.24.21.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 21:53:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <145bd5b3fbbcf5db6e2d7ba65d8394a5979bcb25.1692935143.git.geliang.tang@suse.com>
References:
 <145bd5b3fbbcf5db6e2d7ba65d8394a5979bcb25.1692935143.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: simplify deny_join_id0_tests: Tests Results
Message-ID: <84a07e7e-0439-a826-29d7-ebb7870d7ce9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Aug 2023 04:53:34 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5236949145878528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5236949145878528/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6362849052721152
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6362849052721152/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6081374076010496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6081374076010496/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4955474169167872
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4955474169167872/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6f79eddd1835


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
