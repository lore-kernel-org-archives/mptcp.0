Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3F1CF86
	for <mptcp@lists.linux.dev>; Sat, 14 Oct 2023 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCPS0iDc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c9d407bb15so27071815ad.0
        for <mptcp@lists.linux.dev>; Sat, 14 Oct 2023 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697305835; x=1697910635; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwLG7EzfKUEPVTppQhtJxVppwmG31cJsfxLxHoDTg2Y=;
        b=VCPS0iDcVoBl01xGj6fg3byqY7Vok4az8KfScp6spGlydXnwaDAPMhcpmL+zz2xbis
         ZB4CNBTR72pyVBGpHq4wYcRvDz1U0Pgs5Xd7wg1sJBSqAd5vYJgNmZ2Jr1ZrQ/cBy8tr
         BYHZ9ZplXQkp+8klSAWGixz4ghpzJiDGYNcDxs8jHhqaRLIv3+ZQWV47zcSqg2dYUmit
         OMlCdgG1CJbk1xFFnauUNSLFy4+tcKpT3bZrUMXVfDqHZLvM9rbQ3r3U6WnTyIKycn3G
         f9nMrlktcX/yA8bcKHZibWXw4pkBuCKIgqlb79mwV4zPE+LC/UI6M9cfnHDyOUZu0lQH
         qk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697305835; x=1697910635;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwLG7EzfKUEPVTppQhtJxVppwmG31cJsfxLxHoDTg2Y=;
        b=vMwOTn+/qJcIbujkowGL1R4sG/YGVYwlFBOxuLJu40ubCcJy8RJTIugfoS/TZd58dm
         QwiE17RqC0nUPMWk0YK7gEHteAlNc3p+a9gEsTrtlZKxSGAkpoAfGgAmmLwdszGTu/Yl
         qBmbOmMVjtrL7DZjL7cc1rxKEoL3L49CCU5H8dbZ+p7BmAlRG4LNKLCypD8ryWnDLueV
         +QsNuWz44lsbsD6qurBOxzbpVTlM6Wxlle0G0v61mkgogGSOtZNBQxRGZL3IeYhNa+qy
         npep5g+J1R741bEBlh4tlX25EuCUkpnaq6Zc4wh4q3TXhDAuXOCuEMKVuGBkGNgr1StD
         0Qvw==
X-Gm-Message-State: AOJu0YwwAFxIiPPrxNEGmshf1yffkQ4UiEr21uwIToWFCGlrDKDGug02
	BT6kZv/xBmhUxX3DTH2DdJXn0JU2jQ==
X-Google-Smtp-Source: AGHT+IEVxhvLDu1vttut/KMZPtIMU+I2mkDaNB4YqEWqijTsZlF1YiU7RHs+5ro2GrlxnZ2xeAFDww==
X-Received: by 2002:a17:902:a604:b0:1c7:37e2:13fb with SMTP id u4-20020a170902a60400b001c737e213fbmr28347235plq.55.1697305835537;
        Sat, 14 Oct 2023 10:50:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.177.205])
        by smtp.gmail.com with ESMTPSA id je6-20020a170903264600b001c9c8d761a3sm5806617plb.131.2023.10.14.10.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 10:50:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <41268eba89466b176262dc6113528af49f051c41.1697301801.git.geliang.tang@suse.com>
References:
 <41268eba89466b176262dc6113528af49f051c41.1697301801.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_update_userspace_pm_test_helpers=22=3A_?=
 =?UTF-8?Q?Tests_Results?=
Message-ID: <53d32646-50fa-aa52-a5e2-925cb48b9dc1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Oct 2023 17:50:34 +0000
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
com/task/4966758906331136
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4966758906331136/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5529708859752448
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5529708859752448/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6655608766595072
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6655608766595072/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6092658813173760
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6092658813173760/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/097680584902


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
