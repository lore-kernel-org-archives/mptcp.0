Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4D1B27F
	for <mptcp@lists.linux.dev>; Wed,  4 Oct 2023 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHvpbFHV"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-54290603887so67760a12.1
        for <mptcp@lists.linux.dev>; Wed, 04 Oct 2023 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696445052; x=1697049852; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJG9zP9Gs5y1lzwAau9s9xKsudGLhGq5DbzgG8m5N1s=;
        b=BHvpbFHVHkEIyf0pQwPzRvzaoH36gWG62Q6i+N2i060WMQOIBlsD5U/15jhUj7ilsk
         CrlHORDyB79yuepXhkWzfk9nmwAlkboBdRBVRShRwMqM4B+Df5czqpHZfhV6HzZ45RxX
         uSJBqGJL4L4Hfvcz5pBjJPdc6sTtdf3/hVCs1Or6Ffv9ZahEAiPXddcNTv0vRDyTDi/+
         NBcEs04OGJPI2RZ7JTnXbuK8CuKKsLN4Pv7dx+DZuwyFoWUyeWV6QdHy3T2Uvh40H0V8
         aWm1qF25EWaVmnEFxdfnLsOlddTgra1yMe7V5s0iZ7twkFgUcYoT6XlOIvDEh/e6AlyF
         QdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696445052; x=1697049852;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJG9zP9Gs5y1lzwAau9s9xKsudGLhGq5DbzgG8m5N1s=;
        b=MNBlxHxMM2w4CERaYwh31afQI5YBTfiDIsuBPvgQdLTuT2oTKCK3XsoGrgm7Ks8UY+
         Y4LnWepFQ+mG1ti2D82SfNHy9SL/yVtKCcJC7HyCuufA5GaQYK8YreIJmW+qeztjNAYN
         4yccy9+05GAXToWlNGnIlTfONI2pT19AF2tOdiG1W45AMv238B13nTYQrp4lrgzCctvu
         9Gfh7SYOtEPxTdvpys3LV6Y8ilJ4c7qulpy0v/AjYhqUI95hG/aui3zwe5u2Kx39a4aZ
         j+wrOUtugTmK4XvlCMPbxhmJnezX8k5WR9dnoVU/TZlHS0oytf80qIAbTCYD47u8S2G7
         LYzA==
X-Gm-Message-State: AOJu0YxGELeqBMW3yG8P+cFq3XaV0/CoiEsVdyJ6f0W3NDD74KCnVpFQ
	pVTJps7i8oOztOzJd9GLsw==
X-Google-Smtp-Source: AGHT+IFXqmt9GFmIZ3No/lf7FJZI4qee/EDk4EjlpbayoWKLJe7cA9FsyfVg5r3pSz4rD+sTu6iEIQ==
X-Received: by 2002:a17:90a:630a:b0:269:6c5:11a7 with SMTP id e10-20020a17090a630a00b0026906c511a7mr3025292pjj.17.1696445051954;
        Wed, 04 Oct 2023 11:44:11 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.8.24])
        by smtp.gmail.com with ESMTPSA id ce19-20020a17090aff1300b0027909a8994fsm1921697pjb.13.2023.10.04.11.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:44:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b41dd0ae28701666ba2c59170acedaafdb41726c.1696439853.git.pabeni@redhat.com>
References:
 <b41dd0ae28701666ba2c59170acedaafdb41726c.1696439853.git.pabeni@redhat.com>
Subject: Re: tcp: check mptcp-level constraints for backlog calescing:
 Tests Results
Message-ID: <a1893b30-1313-1cea-20f1-fbda393c3f32@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Oct 2023 18:44:10 +0000
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
com/task/5251580925050880
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5251580925050880/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4970105948340224
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4970105948340224/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6377480831893504
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6377480831893504/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6096005855182848
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6096005855182848/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/02e7679ef604


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
