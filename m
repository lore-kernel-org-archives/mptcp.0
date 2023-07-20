Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290918C25
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 16:52:49 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b8a44ee159so6576875ad.3
        for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689871969; x=1690476769;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnbN+qovx+yErrcmClqUnFsPxZTVmhAB8DQHXA/9q9c=;
        b=XYVE6izo0QqVBR8+h3vHZobs0s/yexMhyy6DB28aQJF+PjLGO2JU55tAMX3nHVdw97
         z+Pk8Tu4VlMOqg2J0Ksb/wBUvoyW6+DIiIOFw6Mxyc0BEkfgf2jrD0YNE23HBv1I8ny3
         uI3OyFl82ME1i6nX9GgRO2Ayvjy/s8fos3WzrH3YY53HSEzGeM5Z+9+BCrOmVfzcDw8w
         zC4YURe4Vc0HkxaMRrkTpcZXyNq8FsNrlWLL0sKprHOdtHHSj+5A0NKaEI0WwlEOQd6+
         e6oGsk7o2ySXOJ5/TCSzF8Ri3UAxm8MpeV1sMFilradEbrY4MfnsHmJow2yxo1SuQuda
         CjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871969; x=1690476769;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnbN+qovx+yErrcmClqUnFsPxZTVmhAB8DQHXA/9q9c=;
        b=Uuxq0TvOjwTTyWxHaF6UQDhHPWa8aW8MrgPVig9W438djY1fVCO60O/WKNFuCUSJ7b
         FCPDC5VYhvc9g5CTDqvspnW9vTTbWS4Bw9/GTJBFJTUJHm63v0icHzVaE5EtMEoaifd0
         rcMPkuv+uAxniaJIlanISGF949CjZj5ox8YUr2IYXHvTPH4koOJem0plJiU3hub4ndKn
         a/f3OOYW04TxkTwvGKg+cwWlbRLZr19Zc4s0RAqAzN4uKRl/UIuWzgMmBoBwEEkJextg
         q1a0aboZRW5M0Uw9PyC1PCrk+kpVc1KJWOEXZ16oxp4AVMN8a4vjmCp+sRaF8lnZyrSR
         Xgtg==
X-Gm-Message-State: ABy/qLaEgqhFjfcQvA0zt6C8mSApmTADilC/CrW86Gs7kZozSkhUSpfX
	mcePN+P5Z+al467inBTPUg==
X-Google-Smtp-Source: APBJJlH34XIyvWIEPFirj1gBCxH5mH92nFdHwBiGp+5xsIIRl9xX8UpcYSimvrLuDdoRhjYwEkabXw==
X-Received: by 2002:a17:902:dac1:b0:1b8:902c:f8e8 with SMTP id q1-20020a170902dac100b001b8902cf8e8mr3070055plx.60.1689871969079;
        Thu, 20 Jul 2023 09:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.43.87])
        by smtp.gmail.com with ESMTPSA id jh3-20020a170903328300b001b9d335223csm1648377plb.26.2023.07.20.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 09:52:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <35589ab7fe16f915945f6402e28adb82f34a8287.1689868234.git.pabeni@redhat.com>
References:
 <35589ab7fe16f915945f6402e28adb82f34a8287.1689868234.git.pabeni@redhat.com>
Subject: Re: mptcp: fix rcv buffer auto-tuning.: Tests Results
Message-ID: <c8113534-54e2-faab-e222-f1cc844f788f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Jul 2023 16:52:47 +0000
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
com/task/6629653914320896
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6629653914320896/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5151910286589952
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5151910286589952/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5714860240011264
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5714860240011264/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4588960333168640
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4588960333168640/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9cf465e6deb8


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
