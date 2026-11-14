Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660138;
	b=zWmiAm+6X/cOOUudRJlEMcad3xy8t0z9hNqYRK0KvBGcSLimzIcB6yRhUxWiiJIl3L39
	 4O0tGhDVFnABIciqEPlqKp6a8T4wIgyjh2BWbaSFZKmfPahTLwfp3ubaoeWvA3cAFyQZI
	 TwYja4EXofbJElD4hdEkVheEll0GwrlJqp2gceXFMlRxFfJaRmNiegcYQVCTlyRFlrXaE
	 1mleWFD36olJc0U3XhuiBmEjSwxCOooHanGAleQty5UKbZKKTVYzY0x94tiM+sMQ/5yFP
	 GypLD6rb4D56/RADsv9UmiEJBxgzvGQeW1szIBdH7IwUkBuWPQYwxj8gwJIdyhvAWHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=C4WPmCztPH+KoFhzb/uCAJwlkmrIRFMhr6hpJOKutGM=;
	b=T/rwsOdsqKTv8qi5NXohCnwUbLml4vQWx2jYrFP3ZMRkizAMe+3KnPLv6EdddBywJ/yg
	 jRuKixt0WG40OxPaBuvBjLnv51QXHOcEaAp3TcbRpaTRK5ckiSev78ElIueGoRhXHkFYH
	 +Uibht/CpTMBh4+suQ4F7KUI2x89ygeFALKwLmXcZIPSVlAuePWo/mu3aIVZmP81ri2c8
	 a+NfG7eAIVubmB7lqE6MwMKaLKef6zK1fkT/tomBuV3tzZMjwE4JYzqsCNynsxiD1giAx
	 tkI0OHFEqLww6/1Yu+u0mvMz2OKpggHeY53oMRjbU2pVVLn/38UPfneIYwu04OuDXmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHV5258C;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A746606A331
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 12:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A746606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GHV5258C
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1408980c88.1
        for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794660137; x=1795264937; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C4WPmCztPH+KoFhzb/uCAJwlkmrIRFMhr6hpJOKutGM=;
        b=GHV5258CL6KT7X5l7CHHHxfyJSuDt6fIrC5+ka6oDQzYzrCpWZw9YuEcMrpawXNCmZ
         rVabOvli+/GyFoMRdh7vQSpPChrnexHJqFOnPK8E59UTOPb6bfq+7ky3xi7dtLovoaQY
         T/5H+VzdJt7CiI5gqALnN6gTfoW8xNDWBfHqJneEeMk4/uXrGHfVBkKF2RdemZghVyzA
         GSCIz5HTWWsoj06SC3hMo2bUdww1/csa+5CYJSQQ2MSndAT+1iEaBplHoFv+kNRbFOti
         rK193JrFzUStVnKtZwJkELgSdhEXqeBj0jLMpZUQAaDVbxmOJk89FqVDqqhzyNLgPLcc
         yZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660137; x=1795264937;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4WPmCztPH+KoFhzb/uCAJwlkmrIRFMhr6hpJOKutGM=;
        b=rGfHajYbMH4KEJ6hMzxppOPlvhHECi5dpV6XbJnLcLcVvmFHDujqfbeUTUCJ12/OQo
         4gHWNGF1TFb9rLa9v+iunPSLL+6yWemkM4G1B77Qu6put0lL2XoWFgvuGWcNcGqJJf1D
         Gt5QDF5Bi74bjDCGRr/9Y9r2sHx5DlfiIbxrzQTsM9h5L8BwwqvEdu6d/F3DXfM3OfJV
         TKVDsEq8TAKN81FIaW0HKLpm1b7dVQeUCpXT5Tz7eHrNYl/2oCairx2cq2uloZsdO6OA
         WI/61udOz97eD1CoLUW5WgYIU4qdYh3dRV81oup2eR979/BTP3TU7yLwoPlx09Tk1NNO
         hI1Q==
X-Forwarded-Encrypted: i=1; AL+hErEhhle+TSz1Pcvm8ImFXxWj4kZOfF6TFjhZ8xki/vxvqRE02SM40W/jME/uFkcdt4Q3R17avQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/20OX2uvv9talWkR/ybzPgSPU+24WM6ORgHMEnZ9R+vCwMrQcN
	sn7v4HGg0aJnfCdT+bVlVDAFYNEH+DTG8UXy48CjRNvKM/9kZqRvG6bw
X-Gm-Gg: AYBFou1l07a60vL/9QU2wNM8xaMFSuxxsr6fIFtNo/3ZAtKhpi9DMNJuobxYGQ4L4LG
	8tm4R6EC+DlBt4hUlKOVTOff1T4vzBXCLljMBGfOsadCoqRpg8vP3BIuv2zpFm8vb4ZN3TGOBPf
	RDLPj1HR7wXKBUa2yh+Qx9ePscAEZHjnImV/M78qF9oB5KozXcbW3/G2pVdd5zRdKH/hJQY6LBS
	/iPlSgxF76qmMhdpRw3bZM/7iyoad5TBFFpo73nXZiwfbC17xaoHhpvVfdWxdfweOrCl8qXqHyT
	DSk+pOE0R3hHAC9kOhlornJ+S+svZ5KJ1DH5M2O+DRrisN+EN4mTWuG37Ko9nc2ZuPuMVujDxe4
	Eeg3GrqJtv7zF6q/6EVAQcFU4YmuAGb+XSUeIHSmEdNLba2mt9K43hVlkcC9Nx6A2xrvFC73jhf
	tcsMMfLtBIJNveVcGy7gF+QEPN04eHGpu025OVlPjpZFZRUJ/hHdS1IJtkMm44aG+oOlads4v66
	mgG2bGDvphqPNq+wwpy2tW6p4vUgzwKV2xHjmcSYRtFaSpXPZ5SKVEyQHFiXdy7vXTtJhu6rlX8
	zQhz7iVGnEZqX/SASN/FXvEBPIA6d0XJASNDIJM1fqL51R0gyZ5lt90Xr9nnlxF6SoA=
X-Received: by 2002:a05:701b:4294:10b0:1b3:b3d5:566f with SMTP id a92af1059eb24-1b5030990dbmr5086025c88.11.1794660137166;
        Sat, 14 Nov 2026 04:42:17 -0800 (PST)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm16550060c88.14.2026.11.14.04.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Nov 2026 04:42:16 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH net 1/2] tcp: avoid wrapping Fast Open blackhole timeout
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <avVX-3s3AYwtxQe7@google.com>
Date: Sat, 14 Nov 2026 20:41:59 +0800
Cc: Yingjie Wang <x-professor@outlook.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "edumazet@kernel.org" <edumazet@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>,
 "matttbe@kernel.org" <matttbe@kernel.org>,
 "martineau@kernel.org" <martineau@kernel.org>,
 "geliang@kernel.org" <geliang@kernel.org>,
 "ycheng@google.com" <ycheng@google.com>,
 "weiwan@google.com" <weiwan@google.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <EE7A0514-C23D-43C0-9C38-CF15CFCF8AEF@gmail.com>
References: <cover.1794325665.git.x-professor@outlook.com>
 <340d9f1f96e235642e8b47b5e7c836a18de8dd56.1794325665.git.x-professor@outlook.com>
 <avVX-3s3AYwtxQe7@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

On Thu, 12 Nov 2026 06:15:12 +0000, Kuniyuki Iwashima wrote:
> No one wants to configure 80 days blackhole timeout.
>
> Please apply a sane limit in proc_tfo_blackhole_detect_timeout().

When picking the limit, note that the product wraps long before 80 days.
With HZ=1000 and the maximum multiplier of 64, 64 * timeout * HZ exceeds
UINT_MAX once the timeout reaches 67109 seconds, about 18.6 hours. A
limit of one day would still wrap.

On 32-bit, time_before() also needs the interval to stay below 2^31
jiffies, so the current expression is only safe up to INT_MAX / HZ / 64
seconds, which is 33554 seconds (about 9.3 hours) with HZ=1000. So
either the limit is derived from that, or the u64 computation with a
clamp has to stay.

The same applies to net.mptcp.blackhole_timeout in patch 2, which uses
the same expression.

Thanks,
Yongjian
