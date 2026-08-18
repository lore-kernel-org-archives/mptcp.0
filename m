Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E832B13E
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037295; cv=none; b=sp6+ox4x8ipMNQiAm963jXn6rrEdQlWl8Lz6DRc32Vq0pPW4Xp1ZiurQiWPjqz17pK5r8oE1Q8A8ga7QPOwzGU1XrRHOhUaweOGKnjqD5jBA0zC1otR7Zw6SbrOeMpnpJ7uPt4hHgU+QcJRJjmWlw5gB+8Afbr55G1k2R5kGWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037295; c=relaxed/simple;
	bh=LftSvsGnqR2USWsLEIp6pOB+sXirDBt8Bl4zdAkQS/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=a1qAPoqhGhN/L1LJotAwudt7EgYbMe/xxSTny132cVfirwAxYhZOXh/pnmlJoeq1peCdc14TKkXCzXMSEnL0roxWp6rKAD4Bg1mwVKF7oA3pGEAOhdGMKX1dLQpPqs8EoBFSMlPv9diRWPeov4klcV1OpykIqVPgHcWObVgudxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcbSfYsn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcbSfYsn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caea3f742bso72073815ad.0
        for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787037294; x=1787642094; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1eCVwfI58RltLdmPQbDVl2ibKjZtLXfQ1C7xkTshZro=;
        b=rcbSfYsnyODAy7Ivjifj7grKlXgaQbj9xrG17mvjFmzq4SHthpgHl17AKrbGTQjhcc
         /lrO8VVmCW7/RSI65/R+EdBe4d+9rtsAtR2IDhI0mzE8pUEG+AJcUoqyInOX9AoSPrbs
         qGF3GI01XleuQPd8dQ4SfnV2YJTWsgATYLcoE/7GOxbDnHqFwhjtF3DV0WroHnHGyRMP
         38FF+XmofeKmXj1Vh7sPivSYGo/1yasc1ashlb3yXsogeFJ77lSJ6ClMr/+OYu4mpaNF
         lIxIr9eWMtnJP7tolMJBtmhaDZJxy9qDgf7USrypMFcI/ztUJKLmKhBcOSozyM4+0XDQ
         MRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787037294; x=1787642094;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1eCVwfI58RltLdmPQbDVl2ibKjZtLXfQ1C7xkTshZro=;
        b=jGDdB86pjVvmIpP6spwfbV1aJcVLFRzVHMCjywwRZ5QZsCikWFbEDpF2cqdcmUuHIL
         5QvKKn1aI15r7Pa+ZpKVVNjEXUw4RUT53fngMe4Fl8/mWr4qzQlGctUAxpc0jgQWClW6
         i7BZ6EDQjbjOVF/UL9u1933HPhRBM3eB4OCUz2Pub+m02k3yBgAgHBuDIGhRHNyQ8Lp6
         ctkDX3EGF7wMCG7PvQbsgi79mce5a+bkCYwJB9n9JPLdfyxOffwi4A4Y2SuCCvHfwXXO
         8QItSg0Kn0fjX082PZDlWQm8pm+PlFiye8dHjY1hMJIJ5cffZl8Z4pw4w/XZj0Xv3XHd
         zxhg==
X-Gm-Message-State: AOJu0YzN/YPA83H31HUNftQSPrCiSiArCy0LYbkeE8pHPNiu4maaA1S0
	/6xxn/6+VRfExvheD9zOmVR4WQa50DqcoAxHXZAZq3iTNfv586VvRWIdfVr7
X-Gm-Gg: AR+sD128lwLO44jkylP6Afd62yj8080p10xs/GB5JTLR5m70Gz3KjwgLqfCjmYzXXDG
	zn+nCiYpQdEU5jMNbltkSzlKey96EreS0AW567PQl4KVb1/Xf2wL6/5dDG6kT0daiR5WriHoNxc
	zAa1itZFH9GkzKCD9SqM2PkkjJwQ/Tw8taKwwpCBT/1jm0/Jy1+iy3ym0PtWK/x5E2PYOiF2Hhs
	7cWgb4vQadOSTE1cGra7AyBIUpkhqgZZIG0wniASxeVjM9QN/RHxcUxRp9Fek7HrO9DHY/1uc88
	btOq6bpe0px07rZ9KFWfEpH8iMG0P4o2R7rjir+IKqegRu9IOXHsZS6tY+VXVgFgjnoCsEb/qPX
	oBeS/1D+wzKBa7Gb4WGJ+UVIbqRoCpMRBRMK/67vBXbBIZhTCtCaLUTda2j5vZZEsCH5E0XT/nB
	45M8GVA7fN8YpnZwWscZOAzW/5HOLB2sTUML7lZ2dP/JtFTcWlPblkWf/6wmeyaeMbyIGSWBTHa
	g==
X-Received: by 2002:a17:903:3c48:b0:2cf:ba10:6d6 with SMTP id d9443c01a7336-2d5c4f07dfcmr82341255ad.4.1787037293635;
        Tue, 18 Aug 2026 00:14:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.216.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1eeb6f1sm11183955ad.76.2026.08.18.00.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:14:53 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786947923.git.tanggeliang@kylinos.cn>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH v4 0/4] nvme-tcp: add IPv6 traffic class support
Message-ID: <2c20ef89-d721-2b10-dca3-49869a893ddf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:14:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/321070=
26013

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0547cdad1bc1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1147565


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 =
Core)
