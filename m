Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81B39FF3
	for <mptcp@lists.linux.dev>; Fri, 24 Nov 2023 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeixPQp1"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1467265a12.2
        for <mptcp@lists.linux.dev>; Fri, 24 Nov 2023 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700849991; x=1701454791; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGM5B/zVm3m5wksmiF/GT/v9sa4KNKqX+HsYk5l7sTc=;
        b=TeixPQp1sH6rjywSrApGEEp7EoP9RrFnAxNgRDeiu3OcA5pkE4MlLXaF87YoxWVX9p
         wZg/aRAfyVz99EjMxsOQaqVeSfE5IxQYo3nwm5RAdbmE7CVkUxK2UCVknFjZJgCRDbTU
         10JMLJBW31tm/El98zgiiRQXeawWIy082LktlTPcXG8bxzqdJCl32e0wa+1yhKISY515
         2dV6XgrjONKkd+6viU0gqX6CHuULLbkS+gOFPgcw/QtLiyfqKWQM6EDkoVTE2OO6nZtS
         of+nXI/XbwSRgqIpLe6hmoBgNfg9Xx6R3xKh5G9GuovO9Tfda2/mzlrXaXehknsZlDyH
         odeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849991; x=1701454791;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGM5B/zVm3m5wksmiF/GT/v9sa4KNKqX+HsYk5l7sTc=;
        b=gIa6QLvo56HnKHkoh+UGjuvL+YK5D0lFwH58eD1S6hdhSCXNWm7DlD+rwbkp6tmMwW
         FD8JoVLN0NSK68d+F/eHy5G1YTgpIJ2OuW9OH5L+shU3BFDK31xEfmTROwqfnupqDDya
         v0cUMgaQH6qMo0l4b2oKGcQQZgd9uWyK+XH2gND9iarpWPjZnRCw3HJ07foAdMpVYlbA
         gTYL9ngB0PtNBQe/5xaWXkhWiSzzoQLm6ZXFSvANFF6gNCCelMHCJCH11wb16Mz9FzDv
         xY0FeeE7n1cXDu4agaNQQVNS4Xe4q8MjNF/f18DXPQ2Kvas2XznNJl8vB9SbowfIDL49
         yGjw==
X-Gm-Message-State: AOJu0YyCFO85fixOEg0eYe+izfic9zyb8UBNEIFTGdN1Q2IY9ywFwU9k
	V27SW8iJS/m/Xlvs85JERZ+REKVUGw==
X-Google-Smtp-Source: AGHT+IG7TJy1ysmwOhjkw47W7CO/7fhAsGnKMGhPXeR0UW8pP61LIWYAwrRsoXfpAQ71EiVvfALHKQ==
X-Received: by 2002:a17:90a:bb89:b0:27d:198:fcc2 with SMTP id v9-20020a17090abb8900b0027d0198fcc2mr3944922pjr.33.1700849991092;
        Fri, 24 Nov 2023 10:19:51 -0800 (PST)
Received: from [127.0.0.1] ([13.88.100.227])
        by smtp.gmail.com with ESMTPSA id s5-20020a17090a5d0500b00280469602bcsm3475263pji.2.2023.11.24.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:19:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <16b3bbadb28abcca8a16ac51c915b5b10085cf36.1700841412.git.geliang.tang@suse.com>
References:
 <16b3bbadb28abcca8a16ac51c915b5b10085cf36.1700841412.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_add_mptcp=5Flib=5Fcheck=5Ftransfer=22?=
 =?UTF-8?Q?=3A_Tests_Results?=
Message-ID: <8b8c2cab-be72-61ac-32f8-1e6863b7ca72@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Nov 2023 18:19:49 +0000
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
  - Unstable: 1 failed test(s): selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4534944538558464
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4534944538558464/su=
mmary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4781943947001856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4781943947001856/summary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6581402502692864
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6581402502692864/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6570048135888896
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6570048135888896/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/00f10d68f33f


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
