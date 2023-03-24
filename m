Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707619B
	for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 17:01:03 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id z1so1012699iot.11
        for <mptcp@lists.linux.dev>; Fri, 24 Mar 2023 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679677262;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SXIKDB5DhowqFatRksbwt7OwdqE98ROKbu1tqATTA8=;
        b=FBLCcJRP2cl26yZNe2HpBtW3aNDDBr5NjQZPz42yN+Mp6wSdG3HUMRV4/jmqqGefNv
         8tSPRkoaKN79DaDsHSMTNJHHupGGCE6ZEwvtxsGgVrDQNLRfQJ2MyQ5nlDEt0tG2yP/q
         FtANK876FLesqCTVcGxsIp9fpEoPL/gj9cA9r6BRP+6fczZB5KplqIVhn4j0Y+arLtUo
         ZkKolreEtAk0ju2R/oUX0StIzOhT94D69rxNnnChWOAnEgLz4WnSfJm5lRvz2j20FZX5
         DPABzT4KjzoIYLMkZb7xViiuY8qzQpSRk5YZeRo4GTdBnjESZmDLwisitPASY3XzxoNS
         /Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679677262;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SXIKDB5DhowqFatRksbwt7OwdqE98ROKbu1tqATTA8=;
        b=OKcsht8C+uF/EZEcNwtRF5c2ZBTGdGBPzW4RgEcbt8LXejf9qB6mXFfWGDdxxRI5qA
         f34f+k1MhDkR4rnmBWUm2knmo4wGHqCVKR4BoUGKzTa+yvpG74BLTVDhQlPm8NRpYDb2
         TDOq/8mjqiWP8x+GqOZgAlNybFhw3lp7QR8EJDCZCqU2Ep5jQzmBTnAmypNB35OyWRzr
         SfvagkS5iIrBFQtgLTOaL5RMNaJFqar9yH/hg4oeMmpeLHlVKRpUy9ZmgHnS5QsUErT9
         vajnlgQC+Qu+nHgMCp0X4rq8ItNKifT3KZ+gJzBb35HswhZrHGyxcZhQLEbi8oY7AIeX
         TJGA==
X-Gm-Message-State: AO0yUKVhpmkDA44sF4M7dpS6GuMW7Dn4n4nLeHwK8JgqTTooGzxG2jye
	CG+Pa5zVf0F1FrZv2IS0Bt76w6M3zNhE
X-Google-Smtp-Source: AK7set8CIET3PO6VMwZAcj35Lfmkq2tze13jPR12UpZBDos6Osi+GVkD1Mfg2jJzplss0zMnvWFxeg==
X-Received: by 2002:a5e:d60f:0:b0:74c:bf8f:4c88 with SMTP id w15-20020a5ed60f000000b0074cbf8f4c88mr2516769iom.14.1679677262179;
        Fri, 24 Mar 2023 10:01:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.122.243.243])
        by smtp.gmail.com with ESMTPSA id f10-20020a056638112a00b003de9d8de0edsm6982526jar.88.2023.03.24.10.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:01:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0e9ef531308d693bb8ff32af03de3827e33940fc.1679672048.git.pabeni@redhat.com>
References:
 <0e9ef531308d693bb8ff32af03de3827e33940fc.1679672048.git.pabeni@redhat.com>
Subject: Re: mptcp: stops worker on unaccepted sockets at listener close:
 Tests Results
Message-ID: <0ba0a273-9785-c005-5e80-4312443159a2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Mar 2023 17:01:00 +0000
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
  - Unstable: 1 failed test(s): selftest_userspace_pm =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4774799919022080
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4774799919022080/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5337749872443392
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5337749872443392/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6463649779286016
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6463649779286016/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5900699825864704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5900699825864704/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5f82cc6fbd3f


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
