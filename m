Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1C79D7
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 21:55:45 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id n4so10393805plp.1
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 13:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGbwOmW0NJnMy/LcW2yf83uTR3+VnV4fetBHyNWJkEA=;
        b=VylAsPh2TnKXhcJZDOV6z23NmSz0CHLy1tNyqyrQy8jncJUEqSj6MIqbk07zotUwOD
         j6F6A7CJrhUBgwIHBre1qxwvK4g+aWabvhGOh16vUwe0T5hivffciC/DSbZjt/RAvNOf
         gRwcZUQlmiWtFnhkpbhFcpP8r5qsnS0nCm2Y+cgkCicIGPkdmYgKEjGNWgeMlBPmwkdl
         3yBSlcdqzpWFOl5lBnVMw7718TxiGr1TfoABeYI2u/b9muhVkQ0NrDO3kUcwaWydi/SM
         qMFYOfVKzpNU3ye59IFgs2Owf6xdRqeDzIPQBl+Duthcikg4hjudooTJIM8aMIQhJ9Xy
         Ojjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yGbwOmW0NJnMy/LcW2yf83uTR3+VnV4fetBHyNWJkEA=;
        b=zTgBhuZTjWSI8RJILkbH8iRfOrBpJ9Fz7nFd7UNNT6swFdmkmm9+iQ1oJI/IKQRTPs
         njNqpHq/P+3106AKecgfU9ZbNR9yHcaD+RfQDWLYf7Lvp+KaMs3SLDXFRXUlrHfKtPp0
         VRnwRH6f6ttSA1YCdcBvgqKZ8qu0MRVxb1xyxzNymh+Lr+yswDt4JFpvAELNNZs9IPzn
         Q39DZT6evDKQjGpn4Ixh8FMyfvvUYF/AAgIQloh2A2MtupMyXZtOFMdGtqhi4hxhbMW3
         fvq7Ysx+ZPTUzb673fNYuxsZ230A5TdQ7nDG9Qs87Q8eY4g+zLQYG52CFsZMccO9CE9i
         Tnzw==
X-Gm-Message-State: ANoB5pn2F1yqtwc2gjfJ2Umr131Ww/YGYMyj96M0ti/7lww1zxJ+x1dp
	3Hvl53SDjuNFPuGDwbWNtw==
X-Google-Smtp-Source: AA0mqf4fGCgMaj5NYOzx83TSIYfD9IrXD9ZouytEVf0FGOj1x9zjGDy/07gew9Vm2gtOabXiDdoMDw==
X-Received: by 2002:a05:6a21:2d07:b0:aa:15b6:6322 with SMTP id tw7-20020a056a212d0700b000aa15b66322mr53579122pzb.42.1671486944619;
        Mon, 19 Dec 2022 13:55:44 -0800 (PST)
Received: from [127.0.0.1] ([13.73.36.242])
        by smtp.gmail.com with ESMTPSA id e13-20020a6558cd000000b004768ce9e4fasm6871387pgu.59.2022.12.19.13.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:55:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
References:
 <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
Subject: Re: selinux: Implement mptcp_add_subflow hook: Tests Results
Message-ID: <ae5633f7-eefa-77e5-4a13-499d6e0a6e7c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Dec 2022 21:55:43 +0000
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
com/task/6620708260806656
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6620708260806656/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4548841605693440
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4548841605693440/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5705914586497024
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5705914586497024/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5142964633075712
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5142964633075712/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/53ef095bcdc1


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
