Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F59BE4D
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 12:11:44 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-570c51530e5so2308232eaf.3
        for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692792703; x=1693397503;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k98CO2urYyF0bFB94Gck+GevzOOobY58tprrp2t3G0=;
        b=GuZMryBFD9UH/YSGTVYLoj5rR9/tECHzKT54tKjBFZtUDOFrmrmcGk8f4J7JSg5Ll1
         KxE4VzTs07cVIE/D4j4zL3M6SNP3/6b5YJyMTZX/o1IKp63rjX59mbos7tPpQWo9Axw0
         w/+r1RrCDjnyN07C7Zjh/2KC/61TLh5nNIWjR18fhEn0GM7S9zfNQN4h0KN59N2PsFK8
         SXagg+FOKNfcxnDSQ+iNcNpz79duqfoQQcsoAs06yrsD/TMcVjC2fhwxRSCgG7HFw6XK
         YInD3K6R/LHi7bK/B6ePtGj+gFY8iFzyyUicl+hy0SBsJIoH5/amRCMJYiI9jfV7dGWI
         7AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692792703; x=1693397503;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4k98CO2urYyF0bFB94Gck+GevzOOobY58tprrp2t3G0=;
        b=CMUKwCadeC41ox22x+dav9UcOzLCp235WEd9X/0Liwj4xM18O92UboClfpuhIIfO3w
         IXhZTM/zwHApQtI56r3OI+l8AkZRiElgAACFbFDhUD9WHZ+onoX0VeYWdc61HafdpG6x
         29rNE8IfywlFDp4TmDXpUNuDdKS5/9OhHRtjaTHivleQBnJm3GfTB6OXCS5GKhLRaij0
         lrR4ZdeV918Dh8Ef10Bm84khjmqRfGQNEFwJfDC2DUuLd9n86nBpIDhEYnbiyyFHsTmO
         zzUrMS25HkphPNvqqxwAjRTdWszJd4joL5ctV4B96q02YkaaMp+EFjXTWtor2Jv9KYB0
         LAbw==
X-Gm-Message-State: AOJu0YxuWkVA7D8w4Qrk6xddqkltLbZFc9WCEjvr81NWku+EsQUR6T+H
	rFCO53CBiXLD8zSJtrzbzQ==
X-Google-Smtp-Source: AGHT+IFNNUdBXYWiIlTib6gQmeoDdmyURbAB5kZ7N7sEtUZpU4PVKsZCpZZQcvL366KR/wXcwiCWbA==
X-Received: by 2002:a05:6820:41:b0:56c:7120:835f with SMTP id v1-20020a056820004100b0056c7120835fmr13078761oob.5.1692792703647;
        Wed, 23 Aug 2023 05:11:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.171.105])
        by smtp.gmail.com with ESMTPSA id x15-20020a4aaf4f000000b0056c91e89f6dsm5637603oon.37.2023.08.23.05.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 05:11:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <486891cb494ba4e9eeb02b6e220ca670dbc80866.1692788531.git.geliang.tang@suse.com>
References:
 <486891cb494ba4e9eeb02b6e220ca670dbc80866.1692788531.git.geliang.tang@suse.com>
Subject: Re: mptcp: add bpf_burst set/get params: Tests Results
Message-ID: <9da0943d-dafb-6b9c-0d92-cbb1f2c8a0da@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Aug 2023 12:11:42 +0000
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
  - Task: https://cirrus-ci.com/task/5518608940400640
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5518608940400640/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5729715172933632
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5729715172933632/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6644508847243264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6644508847243264/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4603815266091008
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4603815266091008/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ac786dd759ba


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
