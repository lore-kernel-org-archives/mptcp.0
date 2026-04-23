Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D73806C2
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961848; cv=none; b=DKNgIP9RBIVl/dYzqZPu4e7rHblUuiozuzGwvsGab3hltOpZ+yjSLPfmk1/n9F69Tk7mEAND9kSYh+SjiT2Uqv2g9rj+6V+cqAjUnW+A0cmMIBFbBbzCb6/4wdU+mJJYlV/QJwUEMNM570NspgJALGqGure8etrwRyQ4padqPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961848; c=relaxed/simple;
	bh=3Kq9PNDIK9EpwtbzMKdaebhmjkbpnjZxRltYFL2Zkgg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=bAKNESrzkXa00Urk+LYNIQyddwlorT7ApE73zZ7LgbmARTMOacVi8HS50BpLPbINpGdpuPp0erO0o/F/26zq7Jd2MvH5rGReSF+pxYw9wEBlHT/jBIonxp4XMsTHfwGmshn3el3mgRxmbkDy7GfQxHH90BZblnM0m6+k00F3A2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyWmIf4l; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyWmIf4l"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so7928272eec.1
        for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776961846; x=1777566646; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLPgvbfzmlYeam/MlElW8psiQzbAZK+WXdUdLDqTY0s=;
        b=pyWmIf4lHGma8LYvqMLGNhJj/WgXN37zyB8c2ydU3GrqksDyanu08jdYxwT4YFSRCF
         k+MVh+B7arVN9chWeJAHsiFS2hFvjkwwtszVlmma9Yit65QuidNNcExe7GD/t9x5Ix9e
         sRkB6pyWBWTRfTp6r6p2x2MSSo95QX/zebFIDN+M55DX1ola0n63hqWHCzL0dtfOvsOW
         jD1wQiD9qjY33yjVLcOivXf/6PzD0+Z34dcyDDcLS3Twh0Fcj8bQommAxU1CPHpUNi04
         51RNuI9XhzoblZRZ7EV2GktKdfnt/nIGuTa02eNoayzNojHMnG+sGqCsHad9S7HPTsGU
         jQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776961846; x=1777566646;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLPgvbfzmlYeam/MlElW8psiQzbAZK+WXdUdLDqTY0s=;
        b=M/ANckd8HqW/wyMTLdQgUajADTfzdzcGIiJFw5c02FEoLKNZscCDM38oxFnQ6V8MMp
         Oh2F6b6KA2xqJeyeAFT06vikTYFA5x0lzRs30WEihZXw9rtu8m+AWEgIpB9vkxPbWnaL
         TUFRmRAsbPULOVxAzPGkeavFLbY8uXtEdEMMExeYymr/qvg+Fcn5XM/VHdm7ZoXoH99c
         UK1VI8CwDYRtPYNnrMNhBj+fCUrxD9SbetmAnS44+45gwh1IfU7A1Iapy6M1Qhb0Vnjq
         MfSh+Sm+AohcNJClh3JJHTih38CNuDNhnG3N7pLBJiUzLY5Eml05w7j+yK31dJ1NNWg6
         qGRA==
X-Gm-Message-State: AOJu0YydT41HXOLEVIxtxRXB+GC73c0VZMWngXllVR6Ml7w+P+Vii/Eb
	7uvggqC77vgvIoMuaVBBJS5/giWXMPSC0RDR3ZAYJt94E7A6fjMOD4Wh1EnO+uw=
X-Gm-Gg: AeBDieuvHWHgU8pbLFIDjUtW5Qqf+20K+r6/42XT5wdta4ymhCiRre9neYzjhe04+d0
	BV+UAQ/91+1EZRbXL2K0cc3yMJgzt/Pt9hFLiTRpjyMpSbcmgTOe/PIK7J7SAA1tPjsofimycH/
	RIWRbh3nsu+tbq29HMgqpn9q/CdA4Nc8EUmY5Ry0LQbZHyRxWCwUajr+a1UDk1mZK1LVeZumAHK
	lSEOSlrxcfd99kYR6r7m1fu77IG1GTUes48t+PhfnnAZY9z1tOj9fTGFqvoR1T8VqjqY4usp3zP
	DJ3DIYwyvCbQAK/Y1QTVvDi2+50Di9wBeXmniLNwItPNRUsZklG696lDs0aLSYKoI950f+2GWVX
	lDsGV13+aEL43mZyOEo8iFtQFD5tBu2cDIHYgblhESxpu8JKO14uC8OG4SU5L0zpYjILdqlplsd
	d80rr11/UVnZyMTW6MOxC34qF/Ok/TixYoJHeo7Nc2dKpEKUXf4bqK6YUPIw==
X-Received: by 2002:a05:7300:f193:b0:2da:1874:f39c with SMTP id 5a478bee46e88-2e4657728eamr15245558eec.12.1776961845979;
        Thu, 23 Apr 2026 09:30:45 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.82.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53dcb487bsm28718399eec.31.2026.04.23.09.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:30:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260420085613.4650-1-gang.yan@linux.dev>
References: <20260420085613.4650-1-gang.yan@linux.dev>
Subject: Re: [RESEDN PATCH mptcp-net] mptcp: update window_clamp on
 subflows when SO_RCVBUF is set
Message-ID: <57d69265-a2f7-f8b9-cc66-80a5d2d88657@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 16:30:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/248445=
02734

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/546f74028ce0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1083201


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
