Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171426B742
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803845; cv=none; b=IpCBDOPU8qGITl45vFpI+GnRyc/iGfibBfi4u2PJB6lT1Rql5/l18XaX6ghpE+vaNaUIHMuR+34nSA+ROYMmGYEcFKkqLW/9EzjSefb+8P/158w/zbtANihAG7PLOOKIXJqMF9QOiPDHddiQ0s0lu/TmriWPuTH6WLlHG1gGEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803845; c=relaxed/simple;
	bh=ttK34wglBMfkuSOFIbKcPL2cinPyi5WYDDeMds0g4qU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ZT0nNyLGgeEo9kf8afmqSEcgfK3pol6XF/yrKgnVoUVNf3Wr+EHa/gFi2uiD0ho3c+s4H1jQxQgITLAqdpvJxLd/l3JCqXj/34iq7GmpyWtZlVHkThQiBNp5AFpProXNArAGiek/7spkooOnd57xv0+UBDB8V0SXNaSrJIJIqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yqc2bYnP; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqc2bYnP"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30b9e755555so7545574eec.1
        for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 00:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782803843; x=1783408643; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWBXNrwov5y5IjtJOk2VZq400pGCfjKd1V1uHlPkFj4=;
        b=Yqc2bYnPSMNMimyT34xt374GM3EA7vVI6JMAcMZkNbVEwC8mLJ7et9+voeaz8KN+y2
         m9HUUkC/8XcjvRrwFrRoi+ZX6LGO6CqRHIUl3AoPbEQhMctRPqdfvOZHsSjjAJGf0ZuB
         5w26NL10y6vq6/fTupl0ZGL+PYTBjDtuvEfVfY6sgf5Z+KaVtMFfvhDn16VsVFF7sG6J
         yTVNYjYOkhn2wbSEQfYFOrsjqlFiG6fbkZ/5DIEOnYIJhSzWmG39HJHhY4fLcdj62l8d
         ShSZX5KxPDfPlai1JSDhxXQ+E7dXWjRxF6bTp2P1NiyvaWRpI2Z1eRSipxR0Fhq5ex4y
         ueDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782803843; x=1783408643;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWBXNrwov5y5IjtJOk2VZq400pGCfjKd1V1uHlPkFj4=;
        b=R6XXWJy2IIRdIQDOMeodoyUDwa4anlt9WZm+si3FuYH+m5a1eqakZbV3Z4/2R2kFnv
         J1pXGZx+jOA4aQL26md9c2Y8m+0LDPrsnF1Nmf2XaSC7kbCoh7pHJbT8GnE1T+ji7Sus
         i1T1BGfAkNrCCxPLirAGu7cahBiHRboSiYYWBvXRtfqzIEKqWKWjQKga3lSttK4uLVHx
         +Cj/sJjGa6mvXHRcNYCRPrtEDij4KvZ7iwYIho1GpdqSoTC7CHbaIERugSIBD2eP1Wu/
         BRV5uoWKzxAZTQBYZ2JspeREZGJnqisBy2oOKxlNH2Q7iSY55i5W0W+21sy7/8iSLYWh
         kIPg==
X-Gm-Message-State: AOJu0YxC2dSs6dXvH1aNLA037gs+Osvmrwzq07ULzD1ShYdDW3JgKYe+
	WSj6yCEHc/70mODaI14wF43LjYN0VB0i68gZU8SL7wGF5Q1W1PfTpRqzUFKl
X-Gm-Gg: AfdE7cnnh+7wFi5hvVOspWRmH73qEWxpWKjothZj3PUvzIrLrLlmuReNDhGXd3KhaZP
	55/rnE2vePTrk0/m59KQfRiUB40ecSDr7+5erbRJYZAXJYW2tQ7uMJtu5QRlfgLxp0I7zcybD+T
	sG4Y2Ob8mSavmaQ1XbvlQ9eva6V15ASw29hQn4gOEWRZdQrTLA93wMONf+YhPSLizqk1Tv9xYBJ
	67KH4+PTOZaa3lXYnXI2kHae6Jfx+insXMkkQ5rEGKgudDfdvXWGAATmZI9g810uf+NrKskWqb9
	BIBtWBP83EGSjaywNNlcgMxLrYQGurTcO9gUC+GVgQRQ5G3TkvQdrmMSsH5yzzqpG7Al0vEYSpm
	nmpXdBIF1/v0b5UAJ6nHAKoSIQnqa26ibJgXNwMfujgjOCgin1D92fCZeTSmX6TNX2GBk9mmm+h
	/JWDOMlhFvr5EZBXqSlr3Tx9hv
X-Received: by 2002:a05:7300:181e:b0:304:886b:b07a with SMTP id 5a478bee46e88-30ee1225e75mr2288498eec.14.1782803842946;
        Tue, 30 Jun 2026 00:17:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.186.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2fb6514sm4292977eec.7.2026.06.30.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:17:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <df199842d10185a73084c79aee9cdc91888adb6a.1782799160.git.tanggeliang@kylinos.cn>
References:
 <df199842d10185a73084c79aee9cdc91888adb6a.1782799160.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v2] mptcp: pm: userspace: fix memory quota
 with RCU delayed free
Message-ID: <ca3d130c-edde-15a8-095e-a2a2460665f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:17:21 +0000
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
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/28424924302

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a56918fdc117
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1118650


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
