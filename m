Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17D33CA
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 16:46:34 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53f04fdd77dso332614a12.3
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684946794; x=1687538794;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLc1lkFPvI90B5MUypNexwc9+667bLFltDRdzsLQBaE=;
        b=oWAmk73jnpN0Km3mOlsRZP0StlduP4vGLXq2lt68suuAIaiOWNimIUVNG17uQo+BAZ
         XAS8mYXx27GDGJG0nBNFKjuWCQEtJUqKLj0yImgY/ybNx2Vj9LLNQZlOJHlKRv0GTeum
         2nZxCj4TgZI4k4lnHl/n+lcs/R2FiWr+Sa8unbu+zxWL3MqC7tCq1cQix/b5SS9PugvA
         oakJVf7sdl3pYW0KAcsf5+YqL4jRuOX/aUYCch5AA0wwvJftyv7LrcuSvH/ARezyl5yw
         vl/W0C8P+VHt0bZZDohLMvlaNB4GTzMOQGfC/8yfAs+8f5JI34giD8Db88iUQeaJOCCs
         n7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946794; x=1687538794;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLc1lkFPvI90B5MUypNexwc9+667bLFltDRdzsLQBaE=;
        b=AM8P3iJeWj1ZXX82ktwRN0VFgzLeRCuNRHtKEDLbbjUClfQZKrcDMHJ5pvWjINvWok
         JnfYr4r6S7zd0mFfHDgf/99EYGwSxn7xf3+m12MPQQrGM9YPa89SOt2G2jlsHBaLRnxc
         oQgDV0RjIfgDXhV9QU/YFDdlGUv9h/Wh0devT2z3JeGyKBvM9Tc2pIqJ7mJABSUFIFxm
         P1qo+BZd7WIzQ116U97t1TENoKKo6kBjGP/9kTcGOKRqV4I9Sedxp3fz85jim4heJ8b9
         nCizGz8u8iq9WCNpF8jjMPNWq2BARuQXzFH4UXud1o+W5dbQHznSHZTiRkmP6OCfCrDd
         mhcw==
X-Gm-Message-State: AC+VfDzNSuGqscz5ngS57Xtkn833ju0v/QLml6D7BnrIVbcWgRBbyyEs
	oQq9EOAGD6UphGsjZ2PWwA==
X-Google-Smtp-Source: ACHHUZ55dHcKQfG8O/noYgkUmf3995N2K8IO4hQL8CYVH37iHN0u0cRenVgo6Us2J7eavj97C6/Lfg==
X-Received: by 2002:a17:902:c1c4:b0:1af:b678:5168 with SMTP id c4-20020a170902c1c400b001afb6785168mr9227516plc.67.1684946794173;
        Wed, 24 May 2023 09:46:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.70.64])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001a64011899asm8967003plg.25.2023.05.24.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:46:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
References:
 <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
Subject: Re: mptcp: update userspace pm infos: Tests Results
Message-ID: <6c9c526a-0914-6878-bb97-9df271b2aac5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 May 2023 16:46:32 +0000
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
  - Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5532371710115840
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5532371710115840/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5743477942648832
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5743477942648832/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6658271616958464
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6658271616958464/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_fastopen selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5670478698774528
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5670478698774528/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b551debba8b2


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
