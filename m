Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671570;
	b=i+pRTx/ENPHbSNxgl2L7+lC/zr4ljzyy7+GoldvnjlozPiF3C5YLaen3bUrBM2ir5gtj
	 CsSkukB6NKThuawDl2AkZCW9NCqLX2P2okQAcyzCqKeOVeiyfm2L4h5bLMG2+h3a/CeHu
	 Sshb8IBGRGKP78U7tdlJmfUOdBBGPI1OCh3WIxLRFfNVg/Y1UqowRlDTT5HDablqFukPt
	 3/Tc45jRX67Hkfyvv2ZfVigGysMwKEONGq0kfKBMzccx7JF2mW4yaTUiwO7AGoBa7yZnU
	 erJK50XyS+l5V4ePfi/Lur+Pvx28KwHcfOkPY9GlOOVtR89gTbAJHV1Nm4pNjVQgbWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=lDWhau9ouoiuycMRKoP6fih0FqpLZmaYNH0fMjbNcwo=;
	b=Y9SnKoLLkw9ogdyXCGbniRZT78miaj5jzepJnYI2suxoOe2HhUvfVQ9poo/4kvgZSAOc
	 OF/Us9FkdlR6NSZFnuJzIym4q2jfnp4QZIbkTEn3Y4s1FlteeQAku8w+oslyA2r+LK/vi
	 iX4xTbZy/qxGcfJMIc8lnjIn9/KJRJkJyRhL8GOG9X5DdXDFbhuOSRhXWnD7ruZMmIz2s
	 sx3yX8wamKRbrMid1HVRFHIf8wcz/IKSsXtWaPrgnj9e1BxwFE7WvHeP/FUAfNr72UhLA
	 7Xy21sA+QGowFIItu8n3BlKrc1HaBwDTtUC2rClku0vIAG0hMT0B/uBrksgraYVFomA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tT1C1CrZ;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A2606A32E
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 15:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E94A2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tT1C1CrZ
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55d03bfd477so3579271cf.1
        for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794671569; x=1795276369; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lDWhau9ouoiuycMRKoP6fih0FqpLZmaYNH0fMjbNcwo=;
        b=tT1C1CrZe8uKHcHM434pI0WO3KIOVyevE/IyV6VurBUoydv+SmfT9BfsnuDivU01JG
         3ZCey+OR5fwDfUPowAdfLUXNL5jllY2xtR+zP9efwDJBJxodWAzbcldVsIsWdIQCPDwR
         F/ueADUU0LaBuebSK2Ii8YVwbkmTd1dqWl2AUXyXvObbqqvDbs+n9lj/FicqJkbGaA6t
         5u+V/raBzqRr0wt39QWjNw1E2tL+i36s3FuxBwsQfGxeFo+B0VeMV427k3UGdJiaw1S+
         cgoctbjNEOykk8sSr8BBBjSi9XxJKGtbbrpOBleXZQNb8qSpOCFKqMijIrr9CCm9x2Xo
         F/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794671569; x=1795276369;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lDWhau9ouoiuycMRKoP6fih0FqpLZmaYNH0fMjbNcwo=;
        b=l+Rn0qzzfZnr+ky9Eotddo4W0kdbhxOMqHjIjWyQLqaCEVxAmHOsRcaEaz0F6vNqu0
         yfM14GTFxBTNBobVDsR6KCK7zl5w915CxGlW3aSmMcfcuakYGDwP3EhOAEnf/4EqsM3K
         1DrybCqBPzQ0cziUKtFkq2nSctX0VzkevrIO7XGRzT5sP6hqV43anik0syd6EKOGyZMU
         IepDic9hK+rWMqebENkFOJ2eUqa66WAQO2uyopAVrwdgmRLmYgimYs1o7JvJPt5k71g7
         5LNDLIoNXFCUQOuZj0irxjNQVDuTkzPjpNQsDe4WAt+h9vzwbaexmoKL18MBrRZEWJbe
         GXgQ==
X-Gm-Message-State: APuU4Z+7o0JRvzXLnmDy6yAPSO+QvCYvNrk3egW7Ohdh7I43yqNg+CiX
	b2y9LutEUGD9jcWcWL6Jrg+36e9qM0vtUUC5H0UJQ0d/VslpUVPLI8/+MP5a
X-Gm-Gg: AYBFou2eTM6xL44CgtP19bHj2xZZdqOGWi/cRFxeMXcIelUIF/pu7CFGQZz2ucjmvgf
	BWTz1jCz6sROGlV2mesI1w3xk+XYHS0c6U7kdDQ02x9qpRpZzsPAvBQgNHEYIUeZztcrdwuEhVy
	olAtArWz3dZhCtaxJym7q9XLtOn8A9fH/i9yGjuEG+88yAR7XWMVvIi1NHd8oaEvuXc26MpHmoR
	wsmw1Rxvn3232M43bndIYaxs7MCX/bfWw8yDyc4N0CdeZMcp4xfXUSq/LVebWQjzEiF9juMmL7Y
	73Lzos31BUdYJJm7Ln5ntpSi73XyGp6Paqgn6m/rxwi4iX/UiE036wdv6VEyEAQb79jDxZWDy2M
	iMXGMgij5b6hFUwDd1/wYj0MuS3gw1ORP8nrbbzTzx4Ae1V9OcpPl6B6n11D7sFaGU94t3xfqm2
	1paoOuqW7p2JksOqByW1zQW/SV4ky16X8bbQiZbNG6CQFDvEu+Hdiub2lnJVC6x23Uxb5C0JR/n
	Q8mgq5kresNn1B5Af+qR4hN6UsngknS5CVT/8xa9c217RUmAlPTEGSE48Ls4lnSaQO6+qh8vRnv
	a9Olbs2UPDWBQrAff870AG8kqbwNJDOp1LqIzp0=
X-Received: by 2002:ac8:6f13:0:b0:55d:99e:822f with SMTP id d75a77b69052e-55d099e83c8mr16784861cf.46.1794671568827;
        Sat, 14 Nov 2026 07:52:48 -0800 (PST)
Received: from github.com ([20.57.38.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0533d7dsm43117671cf.8.2026.11.14.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 07:52:48 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794663678.git.tanggeliang@kylinos.cn>
References: <cover.1794663678.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v27 0/8] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <197667a0-a994-1349-9d06-7cd897ae6754@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 15:52:47 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/43603887983

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7919d2e41d=
50
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1211367


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
