Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1213EFD0F
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653004; cv=none; b=NRNIUUHotzwrU0HRf+poi0nos4HF15vcwAj+0s+0PNAVvetVjrgORYBus0h93OJklij+dzfOB3n5RtzG3b1GSL1/6ZIg6JTvDpOsxR9B40ta3bxEet4gnIcGN5HXj1p968ioYiQ5cNGQ7eMQdsCZ0oQT8ftSPtbpbcVfwwI3pzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653004; c=relaxed/simple;
	bh=tX6fYTOREQ3aohb3th9ZLNZy0fTpsvpLe3C/CK2Dmbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=QkGJECEUpJ9snA9JatF9z1YF20ZAfIxwpJ1f+xHArFo2wTwZnn0N/ZQn8+yu3wFgp5sLE6PiK1ZzrNekFyt3yupr1VTDHUnxorT+logWp77Zag4oJixAGNkFIykBjvBRFrIIEbzKWnE8V7LixN25QEnKc+MQuiU4jmvCi7nX5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyWz053X; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyWz053X"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4756e74f8edso1520661b6e.1
        for <mptcp@lists.linux.dev>; Fri, 01 May 2026 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777652990; x=1778257790; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPRIMYDnwtJddyzaPHfDHkcKUKHL0f8bUqVhtt4bZ8Y=;
        b=lyWz053XYzB+YoNpFVFoZrVQJkoYeDOkRI2flVNi2qWGpObu0OSDGvktjDPVTpy7mF
         Nzzi+NbCnnceYlTkjFEFd7PYNPYUR9to4DKG3QbDWvDOEpsSKL80k+TicIGXu73p6ISW
         Rp+zSvBtxueQRMDBzy/i3z3eO0Vi4XKSlBDKS+EGke133AXSQA1Z6gKGue1XUqWsQ2gx
         bjaP8eSz+HBblu9B1f70Qw3aQr2Brb9kMEiipRDzAjqglHLrOFSjTYVRaymADET4/ky3
         fskLOn36+NDAYX+ml1szzcOTQPIihJSmCmdaZu4YM54/qNJHJmS+5JvDxGtCYEiwpDvx
         +Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777652990; x=1778257790;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPRIMYDnwtJddyzaPHfDHkcKUKHL0f8bUqVhtt4bZ8Y=;
        b=olFB6bCjgDeGNdXScHuWhfGII0tf3eidWla9lIWaRU0eIauzuYgurLoRfDu+1VDmKt
         ICkhAYjuRgEISI1b8cK1ud3DLy/LIZuYLTTzXiQVJdo9s+/97INFGGGc37tYT4yGrKtv
         0sgRVlBaw8Hr9IZNiu2CwJerJeTRk5ynGVHq7elLBR2tAcHsZ6JTdLHau2gmsHqvFLZX
         hDUZ0Z0H5oLSjZWtTjUmM5+BRxJ8UvPTtNaQP2Y0MXW9s8XPlHU6KdLQ8q8OpERuY2gH
         krq0qZNBtyD47IpIlFHpHGTQj9Ksz62QX7vE987krDZa464mBg0aUsXrxSWCOy7ugCkt
         MOcQ==
X-Gm-Message-State: AOJu0YwUdN6WM8EP7RJuqkKq7cV9ITNU2AQ4SqgfR1DWByxbYTm8R6WI
	l0fiWpB6AZPkKws3iVPVCV1E59h/oAelsG7ECPAtVfeA42enh7vcf5E=
X-Gm-Gg: AeBDievylQ+myxhZZI5PTULGS+Ac0OPp0pw5weBEnAXDHdPU4PohR4MnblZ37noQkE1
	8byf0nhaBmMBAndqmbLbI4Vo/rDb5qL9iYVWcZyy5a4YW5Joyj+5y1X8dNlpVmVdnZ/vl+H0hD9
	cRjNZqEeMa/Mxll/IknU7fz4AUxzrZ4qts53N8xKNa4udSftlQxtWjcEY3PpwjQ8p1+/PDT8tMl
	1gREQeHU9iKDai020sEQrNb0m2/k821iSMkxtmqmbm+gO5qH+2BA7o+VLzzbqLGILh209W2bVZc
	e+/hbkn6XfEOU/dTsKBEVS2hW10CV6Hdl4d8VuboCQz6JHEiDpL8u5xo6UKFCrsCYwNsRLkYM7k
	HBYpMLY+08qRxXHCvPfAjsOVJszYPTW0nucGbR1S2TfqseMDvAmGXcCYAIbvbmYA4MAWIrkcS+Y
	tiCp2NY8tcKkJsvpI4JFF8Vh8ED2610wJKL4nK5qBlpHIT/nK6
X-Received: by 2002:a05:6808:4fd1:b0:46a:7c00:5cd6 with SMTP id 5614622812f47-47c892785b9mr136957b6e.29.1777652990309;
        Fri, 01 May 2026 09:29:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.138.181])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76400028sm1585248b6e.5.2026.05.01.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 09:29:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Vastargazing <vebohr@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260501151454.211598-1-vebohr@gmail.com>
References: <20260501151454.211598-1-vebohr@gmail.com>
Subject: Re: [PATCH] selftests: mptcp: add test for IPv6 subflow SLAB
 placement
Message-ID: <3da1979c-e5cf-aca7-5498-960b0213009d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 16:29:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Vastargazing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_fastopen =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/252207=
74383

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/00cd781db919
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1088559


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
