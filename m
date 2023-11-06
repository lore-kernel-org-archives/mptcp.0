Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B822EAFB
	for <mptcp@lists.linux.dev>; Mon,  6 Nov 2023 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvLMGWZ8"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-79f82b26abfso153964039f.1
        for <mptcp@lists.linux.dev>; Mon, 06 Nov 2023 14:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699308824; x=1699913624; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIirWkUrSTbcsmCG+Rm9M3YfapK9eYEl8Ch1Id8KXAg=;
        b=IvLMGWZ8osKbkTFzpOJZejK16WrAdDfQgJZVG4Ob11KXmw6jKzW14ru1Zu8a2Icers
         AobZau3P0X5pfZig4/tzBVaxVugCmLLol6jaK4DKN8m49Bb6n9ydG/YvCT3YBXZXCS2a
         yJ6KpJ4ATh4WMbuOi4fnzmqQY4jxmj91/MFvDxLLF3BdoMHjeAauqeNPhyUkDUD8z4N/
         HVTfSnUaU8llfB7MofP/5nd9TP67ejgfJ/1H5y4mqUzTg/nVBtAuE1SIOYtiK/VrCDEw
         7lY7VjzQcY5edh42pQbWa9D/o9/35kBvxiBfO643K3RNyTccHNrw9RBQReY11TXHRfY1
         l1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308824; x=1699913624;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIirWkUrSTbcsmCG+Rm9M3YfapK9eYEl8Ch1Id8KXAg=;
        b=epD6HAA/ZdtBHCihmKGK5GHHAkHmLCS7UCXqlAwbsoNAAmtUeX3v6c+WgjoKpytm7p
         oTJ6cSJdAeaM48mzfxFH2Olxwy1P/ruiUEdjkHtDQVU6rTxUqebgrFv4TY4m3j+QGvuc
         88n0NjOREps5KFGSbkGeWxTMC+xqkCKdnLvLCTh+/bRJ8CP5mWhv3WwjcJXHnSQu+Ohr
         b4M9FGe5l0/CUELZ2NcEUzOKLdwWN9f7a6hJbWU8SpOucU3dUJC1fDLO3FORBwLVCUVM
         TpM5yVjrMwx1Uy62IB2RmS7zezaT/mU66RQG6efNz7v6jyiRSze2B941HUbi9UlC5URJ
         1Wfw==
X-Gm-Message-State: AOJu0YyR7zTN+sxxFHN/EvYYa+ygqp+6ulYJA06AJuPfzTo8c9HRgUd9
	VmBBRulc/1xB5DL8WO/hNQ==
X-Google-Smtp-Source: AGHT+IH+TNp0rA+gepsQu2I8fqyfw3MLI2scqAwG9q7tTaPIitaD262KJt8LlKw6nwJ+J9VciSTu8Q==
X-Received: by 2002:a05:6602:2a51:b0:7a9:61fa:9605 with SMTP id k17-20020a0566022a5100b007a961fa9605mr37917811iov.5.1699308824146;
        Mon, 06 Nov 2023 14:13:44 -0800 (PST)
Received: from [127.0.0.1] ([13.67.150.240])
        by smtp.gmail.com with ESMTPSA id f2-20020a02b782000000b0043a1483abc9sm2324021jam.74.2023.11.06.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:13:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1fbdbfebd7caa8052b764e3d78fa9fb8f41f03b9.1699086300.git.geliang.tang@suse.com>
References:
 <1fbdbfebd7caa8052b764e3d78fa9fb8f41f03b9.1699086300.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: add mptcp_lib_init_ns: Tests Results
Message-ID: <0ba3f5de-a36e-77a4-3c7e-b66db9269a24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2023 22:13:43 +0000
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
com/task/4943139908091904
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4943139908091904/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6631989768355840
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6631989768355840/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Critical: KMemLeak =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/5506089861513216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5506089861513216/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6069039814934528
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6069039814934528/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e05a56ecc88a


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
