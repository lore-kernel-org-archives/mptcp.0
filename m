Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893C30FF2F
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457998; cv=none; b=EkRT3hP0e/38WTiNdLRgWrnUwJVWauRCzNdFRZIDdN9C1m4iXfNsACyDCn2iWn+71b0ldVivjgcmGAm4chIuC6Mgc0q1N/f7NTm0ONhGbTfd6haMzEQ/aKchH1RCv/blJIBUIBrWiGsOEbF8IEUmn9nedNVqqQKFilQ35oE/vb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457998; c=relaxed/simple;
	bh=yEZsQYUfCaXRIKBNXZthV4SRPipoxYmChg2GPituqsc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TwmJkswz2NFn3kEehb55KOa2FU9MbTQIvFXJ0feXNqoKP9X4+4bWF2rshfPl0cS0mogh9AtOAYcolgaJDHWxngHhaLOqeGPsQLZcU5OmmoBZRWdxFUKYX/LrcMXKH/wKKi5JPEPjckPaR7ZVoIwbLQxp8uClxGEnqQesdwgmpE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArrT2NBD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArrT2NBD"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso4459696b3a.1
        for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 01:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763457995; x=1764062795; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43wq2vkay2vVdkKH8mHAYgTjnhaK7+KTnROPaszgtII=;
        b=ArrT2NBDaeYiiUBL6xIEAsnuNsgoKhbJ0Wnjy2rTIV5D6HhnR6F9z5mSKOt5XVjvkb
         e0NFCelClv5BQBG35jf4cHt4WyKkv9cEADBlLvjzPGrIiyhjTpPzlBTduw6BJymZfFXC
         AvnO951sZ3gKfJfjcXmuS+cXTY73KBB6s1e3gSCCTc3OHVo8xNPQY6PovF2cC/kgV5tp
         f/um/uaEv3YmmzvsSgwMt2PECIaiIxrGKX3sscVlouEcn74m4MZmIZh3EZYWycykQMq1
         zodhSmNXFlWN9UEIwFWoyXrdJl9qDe8VaEzP8AThsE32j07tfrOsiL/YnnTwJ2XWq7Ps
         +Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763457995; x=1764062795;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43wq2vkay2vVdkKH8mHAYgTjnhaK7+KTnROPaszgtII=;
        b=nGOe6k7bmnsYh4+ltDIOtsBQE9m/4APi+8Js+LRvnJ7sjFbdWBspPlds7JzAx0rMF0
         f7UF2Z3VnSeJ5w/jTx8HlffEyhOH6N05RB4qObPPR0qcqKVIgG7P+Bgh+XSl97IZz8up
         Ic6A2sT0T7oa2QBrkOU3WPMF1N5PXYw7EKFDBqTvXVlKCMcZYjqVGBAgOlNBK0lK34O1
         QbyT/mVuvMHaB+A2m5K8VGPFColch1fXB1MHDAU2jq7vkiyTGqJF4eBNI5OSaT3S+wE3
         zmgMkksf6mVy8suxkRhfJe/IZlXaLmZl1y2/LWb4aZnnoyldQ+ovJrNoKy3GOte/pQyz
         qKYw==
X-Gm-Message-State: AOJu0YyirMk7nHWZu9eO4FFniMRAm4aVTJ2cL9MKIP7jM+rXiJV2/b4S
	aCpOcYrCDuGzlQFM0Y7Axi7SfA86a2UlVuTyaZwgcjdjMI2gotMbgIo24uUY
X-Gm-Gg: ASbGncslb7sflux49dQzEn/a4/Wy30AQgkqX9lNBRkP0WhsuFa0Xcp+cJqqwRbofXXm
	pkB+g8aTEK0X3M9oYWxzXdKDxBYpY35D5pjwaw/P+Dld/h/heA2oozjK9qnBPKnfrv6k8kud65e
	U3pZvmX17PmFcd4meDLWpUYBoEurXS62NE6dpyLguU8iBS2hnHBAWAVsFGCOUoE7sUcDtPVlD+9
	EN3/LbsJfiNGhAKCn7wSYT1inwHE9lc9TZEfOei9GD9l2qcew565VPZgyFBsb0tGKLePLfX7k9u
	CDF+z+MgBhM33aECsPWCByt7bcWewWAFaQxo4WKhbYeXPJEM1ansRMRqxbcmWb0/F8mPEbIRc7c
	ykariw0GUznEIJ04Y+E1kIjj++cKuwXiYsNCdYwNAnU7VgdP+KdR0BonQjC6OiHoif9KGSV0WBA
	vAnc4dFyxGzqG/1XuYyHeKWGrSTw==
X-Google-Smtp-Source: AGHT+IFaiBe3BB7gchXw7Zpna052F9eQhkmky5AvapiwCcrYxoYKvY0m1NIUjieasszl3XixvyWT2Q==
X-Received: by 2002:a05:7022:1503:b0:11b:9386:8272 with SMTP id a92af1059eb24-11b9386848fmr4432502c88.47.1763457995247;
        Tue, 18 Nov 2025 01:26:35 -0800 (PST)
Received: from [127.0.0.1] ([172.182.201.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11bf23d6967sm23085555c88.3.2025.11.18.01.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:26:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ae97ac245e5031422c18b3c2c2b37c3aad33cc23.1763451700.git.tanggeliang@kylinos.cn>
References:
 <ae97ac245e5031422c18b3c2c2b37c3aad33cc23.1763451700.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2=5D_Squash_t?=
 =?UTF-8?Q?o_=22mptcp=3A_implement_=2Eread=5Fsock?= =?UTF-8?Q?=22?=
Message-ID: <1ffafea8-e164-3a14-4b7c-b36bcb5d2baa@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Nov 2025 09:26:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_add_addr =
packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19458572479

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/83f9ba0e2bf6
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1024705


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 Core)
