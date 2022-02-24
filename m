Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1EB6ABC
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:34:09 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id q4so3173423qki.11
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=JDWsZl5feb2oBrakcrXe24tn7esuIM9C7qUDYwFmpWI=;
        b=Lv6Ih873f8SOC8CgrkMWz+r+j0OhsHfCLY/Jj9lFceV+co+rlqzGeYJ9ZSwj+tTzpf
         uVdXOiX1qj16eXKM/AKjunkaj+8bdPBltsOFvbd2ZuGRAMr+WuXCpf7iVhFQsNk9r1yE
         MGr79W+nU2W+CAK3sMh4YNqL0x5XwF8QNHw/u9+bTcOAQgkerPLuITtd62ECLtLp77qe
         T/C7smpD3VKO5R3YiAFAWzDlYWPaSBugUjxjHxLVgUwUt/5qV8aAcGFUYpKHAzUsa5QR
         wXIldWYq+hLDrwzoIiOBVVT/CStvwveVzmcHilPzbNzvIFyvRHGam4BJ1QFVNi2xvfqF
         TJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=JDWsZl5feb2oBrakcrXe24tn7esuIM9C7qUDYwFmpWI=;
        b=fM/JONkCmBj2saOLoEvEJvWT71KnODdpmPRwOSK3hq0l61cRhPAUmYY0JLfyT8Zml7
         TBk6LalAO97yJwRbZDpWS7/UGI9Md9QTSFCmmXosCM16grIehcm5bdftaU+bXmEtHJ0t
         bx1IBrWXNtrQ82kFFlEt894LKV5PYUCxtabhb2cMDeVMTcUE8IbpBime0QdHArekrT/m
         Plb6rVax+ZHNzy/ANCYdkCFX8cZYZKGMtlQwGPeHr1GvUU1dxlg1jKjF3p7kPhcXr1tD
         MGutiUv9B0KF5iIDaUdhkHZHs8nn/44n6atIrzPtaO9WLLK3c0X3V2M67oAfsdIyFRHc
         0fkg==
X-Gm-Message-State: AOAM531r0yWGaHYMxg0pEtIAWplTvLez/O1zTL+N7pU98eXOnfDYLxny
	lu6hEcdH5+kEuuThsHOxWZj02dYMKg==
X-Google-Smtp-Source: ABdhPJwibiaHZqBs/Dc5pEME6RT6QITzEdE4avd+wS/4yxla7mBW0Hn7PTAqmoeXeUOanQ1CzLllog==
X-Received: by 2002:a37:6593:0:b0:47b:a835:728a with SMTP id z141-20020a376593000000b0047ba835728amr3372784qkb.657.1645745648934;
        Thu, 24 Feb 2022 15:34:08 -0800 (PST)
Received: from [127.0.0.1] ([23.101.133.134])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85916000000b002d6844c51b9sm440290qty.86.2022.02.24.15.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 15:34:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220224232226.259304-5-mathew.j.martineau@linux.intel.com>
References: <20220224232226.259304-5-mathew.j.martineau@linux.intel.com>
Subject: Re: tcp: Add TCP hooks for detecting MP_JOIN on a regular TCP
 listener: Tests Results
Message-ID: <50792aa1-9ce4-6f31-225b-d1f179c49981@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Feb 2022 23:34:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Mat,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6161624997298176
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6161624997298176/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5598675043876864
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5598675043876864/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0f58cdeb67d0

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
