Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D82BE7A7
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789300952; cv=none; b=rgomPNzoImbHuzJ9ikzoUZa9pIYsO4eiV4oglWqn/l1ZPXpqa9gG3qpXsmodH1q3Ljv0tJ9fR5hKv7fwZdRM9qQ3dJQPaVz0ljDVeCwH0JthCeKRiIpXlYi/2ujwdsXrRJ7EF30BX9B+SNvVtnyPZzErvaSSfBU3WIWQtuua3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789300952; c=relaxed/simple;
	bh=HSuKe5vH925LgcWgoDC6iv86WKrZFuVFKoNyBs55Oec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=eYjjtkja1ZYkDuH/Tqb4gn2+bP5xlhXiyM4rcxruBcioBuWvPyTPYnIhv9AOX2Cmlj/WNqLQA4f5EnHW0pB0sC+Qd+UJxrgzQK45W7bHa68YuIyJ/+dE1J6SghVfPhIDFqWJFTcSqKxm1jELhIaO0gJSECCaE0DLf6SMhU2Kvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFKSKXfD; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFKSKXfD"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe20aso16081786d6.2
        for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789300950; x=1789905750; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OxV4TqKwIXwSZD7J1OXgceZUnUilmoY0g/iOgRO4N84=;
        b=NFKSKXfDcI9wHZdaJbyVgo/HHU50pPUAYuVVc2Iz/x6xWIoOZbad+NunVOrAQ35whG
         bMgqG/FTEdRIGXo6WdVbjvsXVsLbadk+k/yuGBgC87N0VkUrRdTnwAgs3YkKvHKz/zLD
         rZTs0QfFHMPm4YLG3abykrzF4BtlBbhE5uFtuiuLvsktKEpN2rccfTYMPtETQsG74fXt
         cNxZ7mQhXlcjYOO7ROMyX7Z159L9zaFeT/YNK778/MmOuHZOeQI0x0O2tsilJ2A5vGBS
         0ZSlhSZkeO7p3iCTCkDbc0QmZJfNZwTB7T2zHXSj8xcuRvJNsdznR9nAHEfoQrPPQRkJ
         KpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789300950; x=1789905750;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OxV4TqKwIXwSZD7J1OXgceZUnUilmoY0g/iOgRO4N84=;
        b=pm95kTg0AgEfTwRI8FeN1TnEz8gX1vJMb7dK4bC1IpkBnnV7n87Zs805FKIptT1R+p
         Wr5Aqx/IdGAKvDBbKHgyY4yupXgxwMWqueZYlCoHHOUxKMX4kkqUkmF6s045VbV/tTdb
         uHQKdTR2PdQfghIRrRoYpZHFHJYIOU12VltxsrCzqr1TdfB80PPVFNm/GKSqLHA7jRq/
         GiEr3mWrdECl7FkfLCMtJll5J2kxFo1q0rZIx1XEq6FuVAb/KujdNwGhfLihHkdLgdKV
         +fgTxSoXJxWgA9x92OWggHgLgD7vlhoUlVLmP3qFgF8FahHf6ZtFEFs+CK4nfKUgHJfO
         q0Rw==
X-Gm-Message-State: AFuF++kNpnT112FDlrTQr6I4bBwxZO2GM7p6wNGYkFoDOx6M7m9qi7RH
	9qvsXAEpjeTZNWsYWkpJYHsUNEhIVZcFCIBSxH7z6kYAcQOltqalab4=
X-Gm-Gg: AYBFou1MYui7/rRfJJNKeFWCE5Ei3zTtmmGifBdPjtwRLd6rwz9/toMLDHNXSQEeofG
	l9jUmfqNwrJm4EKEdyWoRy27HyOelw4HMWVuf59GLEqzjONLDh63kOqCbi2yp4BUJNSetAr96qO
	7kWXaz0PM32pALtMlI+DgS3yJ8c7VuaR8W1ywpWc0vi3+ZjY7oFTqgadKWDD573d1ZXT6pvhatk
	LbFmGcCOnCx71vCqrd6wOvcWvHiDe9gJhkqojO/+HwdCPaRXfXnt1N+xlMFt4ty57AZc4rqG1CQ
	+yPUY1MfRbFPqWD7vHUbra7NSgWWaoQWA7POi+F09LgitX6vStfvddLCG+zzpZlcpk8GxxL7zkG
	W3cX/ChTFo1J+MAZOq08bEpmhYmDq0LQbVWFmdo7v6QnZ/n2AFcnB5MPn/pkR9NNIL51irxUy5i
	TD/ZVQyhHeDqU/DV481uO7WYSHNUaIkSAPwIHVIBInUXCtWr94hvx0JXmIDf33niHm2/Q3iBhZ1
	Ca9w5ZSFA==
X-Received: by 2002:a05:6214:d4c:b0:90e:7e02:cc42 with SMTP id 6a1803df08f44-9121daa7fbcmr101239816d6.23.1789300949725;
        Sun, 13 Sep 2026 05:02:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4dd2f2sm70619626d6.44.2026.09.13.05.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:02:29 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Mark Amirkan <markdamirkan@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260913-b4-send-mptcp-recv-error-v1-1-4eaa3684a8b8@gmail.com>
References: <20260913-b4-send-mptcp-recv-error-v1-1-4eaa3684a8b8@gmail.com>
Subject: Re: [PATCH net] mptcp: return sk_wait_data() errors from recvmsg()
Message-ID: <eecfc2e1-0719-b588-04b3-ebcfc0a28105@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 12:02:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Mark,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/34752330865

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0f0aa4cd42=
56
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1163763


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
