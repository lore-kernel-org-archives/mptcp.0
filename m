Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504C200BC
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 15:23:31 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7672303c831so75696085a.2
        for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691681010; x=1692285810;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3rjC8XcJBESGUE3z4YdH/fOG4q6kanTTxeX9gHsDUY=;
        b=p/n8sKgjfbmidY+EbFfv6tR8K+CKVmLK2NJ9H93Z4Zjs9gNuUC9DYpt/KoTdWhfTHN
         wRZ+EWQrLOmCnmAE4MA7SQawpWrhewQxeoYpgMFRg3v3YSrQPc66YGjjQM6KiDvO2ZvB
         bupS3/VCS9bzPwqdIN7b/renOO2o31j+kwSaHyG2nwtV9MrY7ueEjoFL+bgtaM+hJa5q
         akdVFF138Qae43fLyX/yy2DgXlzT9xwdw24qof1pl41p0yq9CfCstisOL8GeXQgpmcVz
         vSxDj2wCcLO5iMZ4I+MenNrQnY88zRNEkudrGtmNSj668nmwlrbHwCqF4qBBbPZ2oFdy
         e5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681010; x=1692285810;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R3rjC8XcJBESGUE3z4YdH/fOG4q6kanTTxeX9gHsDUY=;
        b=hqlMplLFCWnTISsbOU+wT8DTE5iTgVpXRMxnCfk9Gveo1OSXDvv4/XqzxvXkMNMX3N
         gNaA5dvdkwO82xurlYAcCQgFBxVzuOXmsvx2VmmYZW2Bd4V+ustnVUF2oz9pCMw9b2a+
         Xbtk67MJEYrY3AvdApzgbluMcOB6iPDhs9/Y3Udrlva3IZ0hVb5aD3mgvig3B5p5CpCR
         5HTG2yOmok6uSzDscE1vhXnnX58O+t6cQkPdHx/fFM/U3WdreSOzmVt/N5WfG+qexGe4
         qja8eV27aiQnt7XBHDDwX0Umj42W7xcrMC3ls/kiGkK7xAh5DCw+X43A0t97ohCvweHo
         wrXg==
X-Gm-Message-State: AOJu0YxRZ9C05nBkmwiUNL9ngD5yTgbzqHNhu96HwPYR5oSveRV37Uas
	e1UfLiD40v7coAzeDX5T3A==
X-Google-Smtp-Source: AGHT+IFW9mBd7+TdQD017HipJ2RIPZq9TRwZVwSjBCbkaaXkbTkZvtbTjoTWLHpAv0jRc/rcZUpE0Q==
X-Received: by 2002:a05:620a:a0d:b0:765:aac1:100c with SMTP id i13-20020a05620a0a0d00b00765aac1100cmr2396491qka.78.1691681010177;
        Thu, 10 Aug 2023 08:23:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.48.65])
        by smtp.gmail.com with ESMTPSA id p17-20020ae9f311000000b0076c94030a2esm548033qkg.114.2023.08.10.08.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 08:23:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <550e3eaef481581e8c78ff4e6548bf27909b0936.1691676509.git.geliang.tang@suse.com>
References:
 <550e3eaef481581e8c78ff4e6548bf27909b0936.1691676509.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Tests Results
Message-ID: <a891bf0e-d9ce-9c7a-6308-23a6c1498a52@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Aug 2023 15:23:29 +0000
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
  - Task: https://cirrus-ci.com/task/6331847710343168
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6331847710343168/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5487422780211200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5487422780211200/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6050372733632512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6050372733632512/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4924472826789888
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4924472826789888/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/95a1a1a4b69b


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
