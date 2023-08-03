Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7A6FA5
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 05:32:01 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6bcb15aa074so439978a34.0
        for <mptcp@lists.linux.dev>; Wed, 02 Aug 2023 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691040720; x=1691645520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiEW2E0ve/d2pIG8Mg+RZsSzTDc5S56cN4ekrTlo7Go=;
        b=cLq4bl4zupj52yJz1JlTAd21+PwuHWeovjOY9GdMg/1Kncyo1EmEqvR42bI2FSpZu1
         H8zYWgeEzvNV0cd37HPGi3OZUooUtWlaIAHKUc5Fh4+rBrMGNzH0mosoxcxQueG6/vV1
         M+WxYlxn9ZMZEuBtk9vcdaY0TxGfQfh9F7yVPfcTY55yDG/FuAOKStGK3UYbP8AQR61p
         wz27tofySuFVFEqXwVfpb0TSkB1uK/XZnNST8rsjxc2XrHAoSiCzjOqdu6QV9bvpuIOy
         QF4FXVXYjECJJ9QpOJe5gRLFw56OBYbeSi15tY3r2rOiiD/UO2pAncyDij3sDsuJGJYR
         UbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691040720; x=1691645520;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iiEW2E0ve/d2pIG8Mg+RZsSzTDc5S56cN4ekrTlo7Go=;
        b=KEbLpztr5hwxA3MrEMd/zaPdIca6BXVVxqUJMSXbKSmxUMghKK+HOIXwxV/UZyY4oe
         OT1Nzcb9BM9dLpcPPlgZ8oqwaPD/3TmWcpxPmNDi/V1I4Y5svVBrEC6paT672OBikBXg
         qWix3Xs1NAS5SwPxlcz+LKk+NASN5e8JEq52dm2SwKO4pG6veB1Vu/SBnUTEleG99ktD
         hAIQHUy7Ov5LjELXF9hHQSCkVmJB2j1yoOxQdAusxOfFeU/KlXIj+VacwIBkstyX19Rd
         E6rhfVAbXR6pUhVJNIoVMjT5pYyOGoWOpJ+aaTxBhoMy+ma3LrSHdF00W3/2coXWg0DY
         mEpg==
X-Gm-Message-State: ABy/qLZr4ajxDYUjqsm9J1KSvOGBpMDr+LDsdhAxUy963qVroP5cLuXS
	EZIneUJ0oaRAWHQ2IMEYGA==
X-Google-Smtp-Source: APBJJlGAuBPQcgeS7oiQ+3PtDuvfQDndU+YiQ8ClTYUFfPS/J6qhp2A8M10/CxZKUV7nCJv6wH2iYA==
X-Received: by 2002:a9d:7cd1:0:b0:6b7:5777:f63e with SMTP id r17-20020a9d7cd1000000b006b75777f63emr14293566otn.9.1691040720272;
        Wed, 02 Aug 2023 22:32:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.84.170.23])
        by smtp.gmail.com with ESMTPSA id n25-20020a9d6f19000000b006b9742a7575sm6623958otq.63.2023.08.02.22.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 22:31:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4f65c2b44b82e8682abcf5c5b91dceced0f07480.1691036765.git.geliang.tang@suse.com>
References:
 <4f65c2b44b82e8682abcf5c5b91dceced0f07480.1691036765.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fburst_scheduler=22=3A_Tests_Result?= =?UTF-8?Q?s?=
Message-ID: <959f6f89-82c2-7105-c8cc-a35fc5632f9f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Aug 2023 05:31:59 +0000
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
com/task/5651357470818304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5651357470818304/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6214307424239616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6214307424239616/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5088407517396992
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5088407517396992/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4806932540686336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4806932540686336/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1f357c615e99


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
