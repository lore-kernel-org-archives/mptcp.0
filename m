Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01D15A9
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 05:01:44 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6b9aadde448so4257542a34.0
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 22:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689656503; x=1692248503;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn7LvGX69oeDIULYMp0hI4WVr8As8zwkO6+Mcue48EY=;
        b=jjA4TTicgAmrtW4DZ3TzUCpyVMlZrsXIbrPCEnhglxKjvZS9vhn/alFAl0+0Umr25j
         +9PkBjn8rhx6otGm4kfYhjT+6vWcaLS6h/J1oo411JCzLnz9VlytNdlKJNKwXhPvOkN5
         +yMfr51U8q+27qzrRoMDHYjM/Rlt6yquvtYsSsEtuyf6xSn9WGHRI8EwXpfS/i5lpdpO
         IR3oJ5gBX8Pa88JpT8/5gojvb8mB+HDPd5N6WAGpgW7T5iR9OEAco3fH1RHaEKQ/+aiW
         trbCTAGm4KIBRAD9539dJ6LWvI/rV9ShZI8ASD+OyJPAbiDUfvtpIyywLuDufZU1t1Mn
         WSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689656503; x=1692248503;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xn7LvGX69oeDIULYMp0hI4WVr8As8zwkO6+Mcue48EY=;
        b=KTO+achPVJZvwe1SVlIb/IfEmSScSY1WbOu2RGIxq12IF1wvV/xaw8s0l+xOla/8SF
         7S6chDOG5Fyp2+8a6xOk5Fx3F7dUfg3gb0O17Yp5Yehj/aIyLI8mtn9wrqLsCdHbaBbO
         dKVw5zmuljSHr3Hxpbd6C9SiSEIRAyEdpduMyyr4D8oXLzCIgqLL79IVbjaPF8BRNfQP
         ngCaxdPE86DBMBzTS2LoHuWS1TnRGcNCCCmbt4K5X1hgwWagN+GeEhUWIBGCQBh81VfP
         V6Ib7qare6zNNFFsowPtk3hWXe+bpaxBCkrfe0t0ZSEd+Ss/lGxA+gqm0chczRevxXjG
         ldlQ==
X-Gm-Message-State: ABy/qLYDn1iXBnyJiHpovtuIIczrYpS7Bj0dx24W9HBax7DYGyp3AUdd
	0rk+pISJMisq3Ilsnq7l0w==
X-Google-Smtp-Source: APBJJlGsJl8WlgkEnDn6If6LEop1lHU+R4n9lp0h/76Fi4m6P8FDvr7nTwMaN9yl6rLeFXQq6uNVgg==
X-Received: by 2002:a05:6870:8304:b0:1b3:afdc:6c11 with SMTP id p4-20020a056870830400b001b3afdc6c11mr14125985oae.3.1689656502472;
        Mon, 17 Jul 2023 22:01:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.66.11.144])
        by smtp.gmail.com with ESMTPSA id u5-20020a056830118500b006b8c6eb962esm545219otq.52.2023.07.17.22.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 22:01:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bbc41ae5d06bfeb5de45b94f73319d22d41dd7fb.1689650435.git.geliang.tang@suse.com>
References:
 <bbc41ae5d06bfeb5de45b94f73319d22d41dd7fb.1689650435.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_burst test: Tests Results
Message-ID: <94c47f36-1487-efd9-1ff5-ad7d7439f74a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Jul 2023 05:01:41 +0000
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
com/task/6584199117799424
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6584199117799424/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4843437464223744
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4843437464223744/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5494449095049216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5494449095049216/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6134261296660480
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6134261296660480/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/64a0c9c1b0b4


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
