Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07C11C8B
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elq/DSxC"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-66d17bdabe1so38459066d6.0
        for <mptcp@lists.linux.dev>; Tue, 07 Nov 2023 01:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699350622; x=1699955422; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRx2s+L2bnEAyMqfr7w5kyicSbTM13ji6fBuqLYe1Io=;
        b=elq/DSxC+iHMw9TDDpUGQRx04JX3Azi0hwdnIj0UQ4qAk6vbpgACg03E7Qlah+90XB
         GFSMSrLG8Cv+kmqAG0d+6Jx2D8qXNtuP6CSy1UC9JIw5oDOxNmfg+XKzQi1cA3O0rL3b
         M8R+SbTwjoLM9WxmOuPemeBLB9Euk9DxuHKJTWhE8MykrukX71nznjBRZCOsimNOhOFI
         MzMeNGbAAhTUz3/r4Pt8e1JGDnfL4sOxLO9hBijlA+ZnycqvFm0JwBYRGqQvaFVSKTsc
         jj2nLxtf37ULLMyNaWS66pIGz7YfmKR/0oX3BdSVdcQoRWTiDcn0Hy/F59zxZFyOR5Dp
         V+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350622; x=1699955422;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRx2s+L2bnEAyMqfr7w5kyicSbTM13ji6fBuqLYe1Io=;
        b=mcVUYFX2u2Wk2L8FRJWK1t9pzvFzvNixtJSZ6gk3NTSbzRA4gLw1WVBh2NURF/01Qt
         S6PFJtilZrFec0zO5hCKqHF9Aq/Ma8cGNNWIcFuUSze7KzmG/PG4EV7wZn3VbERUe54J
         QAfAcYLtw55F7ElXyp7kBuLNkHwj/mbi7ABCODvxfhg5v33pTGmD822LKLi6EYyTib6y
         aszXNU39lO+zAyb8JNxEr2Q20CfgJgSb7irYKaOYFK2MSx720aYzyd2kis+ISHOhVfq+
         Hrl/4Fyko4LCuxdYhtnuN22cdJbM3AuEXMJy238AU3dWAAGkI04CeFpx3gbbpOJyLX4F
         BF3g==
X-Gm-Message-State: AOJu0YzVnkhMgLezHLypIw3Ji8/Vf2FotquHZmSxLCuzY0bpJGaKUvZ2
	PuPxBW0Zy9W75gBxWdydjkcIuTJOcg==
X-Google-Smtp-Source: AGHT+IG7qA/E5iNbeGm5F0Qgv5Lenrih0YFWTAW45z/4b5XPVarJWk+QsuBUlALXUnBMAd+Ksyss5g==
X-Received: by 2002:a05:6214:240d:b0:655:d9b1:7980 with SMTP id fv13-20020a056214240d00b00655d9b17980mr44192691qvb.62.1699350621772;
        Tue, 07 Nov 2023 01:50:21 -0800 (PST)
Received: from [127.0.0.1] ([40.76.119.2])
        by smtp.gmail.com with ESMTPSA id cw12-20020ad44dcc000000b00670e7ae4964sm4212533qvb.91.2023.11.07.01.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:50:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <125303e29562b201f1f6f441ba5289b1904bacbf.1699344621.git.geliang.tang@suse.com>
References:
 <125303e29562b201f1f6f441ba5289b1904bacbf.1699344621.git.geliang.tang@suse.com>
Subject: Re: selftests: mptcp: rm userspace addr with random order: Tests
 Results
Message-ID: <1dc3c5b9-3300-cb62-abde-295ee0973c19@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2023 09:50:21 +0000
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
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5264642000289792
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5264642000289792/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4983167023579136
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4983167023579136/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6390541907132416
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6390541907132416/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6604862150934528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6604862150934528/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f83e9c69fce5


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
