Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842614A33
	for <mptcp@lists.linux.dev>; Sun,  9 Nov 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762725709; cv=none; b=E1sMb5Rq0YKMQi/3ynGCfQ1fq0E357jcrNOhykd+xPcZXyQqYUFC+yCbNdhYU/Ue+2cJwb38jYymLohpUng3I9O9qPuSRcxqKkzsdgK2a+OhpZ0wKGmgIfhHhj+moVSuzSj06yhp0hM/QNW/3NhbYzw+Tu3pXv0hl5DBmyuF13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762725709; c=relaxed/simple;
	bh=EiqBIceD4FnUwGpjEC+fXWzQcqSKy2z5cz6kQMkUZtQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IbwU1Gn+9YFeYNcQR9BOwpDoBaCXKTMyQXUdtyU4J35TJGUE7XIR+K4KPAFVU+zJ3G1nwtRf+jrWFal3s8QFqqAuESPzoFX3M0TxDoBen/TePw2C2sxzvH5cVOGDCaPAMOSSw01gguC+mK54IX90CrtCCBiSIIGt+PYTDtPNsAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltTs3tHY; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltTs3tHY"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-9486248f01bso95852039f.0
        for <mptcp@lists.linux.dev>; Sun, 09 Nov 2025 14:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762725706; x=1763330506; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+WYbqx3gkDOBQWGWmrvDVrOCmxILj5235Ryc23OgqI=;
        b=ltTs3tHYwXTikdk1oPpDvs45+Ey2eGF2kZm5YiGGlC5xZfN8WXaKIF1bZg97cuwqEH
         0qAPvyREfBE5/k7ChSb+KYtYqaKij267LyUixCR3fsVGgzOBwXbQ0iS2hvyjecAe/heo
         nG/1NKUMlbtRPRcqtvswhGlw7/Zc6S2GNfMJc7wHpsW9kjjjaFJ89Ia5taeG0mFwc0CW
         FX18svHRaU9BockIsyOARGlN119VvqjK/zCdUpajY8QR0bAicUF24E1kUCbkglPkiYNQ
         3Fil0wsncA+pqyxLOIjwL4STT/b0K+orUtO9K6F6bY+lCD72VNvQNcNGv+aNbYmwT8kC
         ZG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762725706; x=1763330506;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+WYbqx3gkDOBQWGWmrvDVrOCmxILj5235Ryc23OgqI=;
        b=cqOzT9HALYXhicU5HSVT+V3FtkCDZjBeOGVVkWElRtuiC1MkGNhODKJTlzhaW/AGCU
         d0Ev2sszs5EDHf+gngaVcaophqceL1qNd0YWf6+Dci+cEAFU0SWrHU+k0rarXP0gPyzf
         FJEau9+QnKqCqcrbBVUwv0EBzqM69ADycZ8lJaXXtvAn/a529cWlyTXPzbaNgjO6Nc/L
         oe6/UQAzmjuGymOwProVbB74tZAXnTDdf/8InlKwtxKGxoyJayyVxZznR1QV036V2OyZ
         ySS1DeaMv1lzb7ukpkiB39G8K5//Gscen5wO90d1h0HuRsLPjN1gnczzc0316+poXVGW
         3ySg==
X-Gm-Message-State: AOJu0YyI9s6t/girX2XOZ3hMScuXJ7bNDDEGZQft/6Bk4GOF8YPlfWzq
	3r6A22IHNkfXENFIQcHHlYbIG0u/GLQ6EpYCtHCeMRXdv+Rl9aA3C+o=
X-Gm-Gg: ASbGncv8jv95f6B6AVSaT6hKp0na6ry7wV6SRhNScj30TVB+75HF9sHlAg4J8VkUGLT
	AXV3N4HhneDINNKpo4pd+BMbTG2GREmbJuHN3dK7wgjuF9AO73kR9+rn+1VFoCdZ0wDCXEevAPN
	9N59Y0/aBPhvOiUq9oNkogxgJeDZzo/RiBlJdfUKH2Y039+dnqUouCpuVBgTIaXbnNmvEcBpZjN
	FoLv9wzoxOEcDZKPnGrU5AXT12pIujQh+Uz2d0/BU9wWcgn6MxT3z0qTHmYTX107A10D8IFwpAE
	ho8JiS8BPWHcaImetT9ztaUDyZBAH2a6DQJtkC9Iwv0Hgo6cBnWvnGBwZrcbF1qSpDzfUeJMLoN
	axbGDDVyfgdn+s0L4MrFZJ+GzybVKt2z6KZdq1NVDRIq6FX/r9QcE9WQZBPO+ubZgkXODIklsUN
	qJBkD5IigM0BGqJprgelwN6GLv
X-Google-Smtp-Source: AGHT+IEx6bSjiiBt0eRFuhEzi+dNlvGX09tXFimH4AZ9Z8kI/1DvC3LIz9bwY9rhpE/OwrOn7mL5uA==
X-Received: by 2002:a05:6602:3f8f:b0:948:9d92:9eaa with SMTP id ca18e2360f4ac-9489d92a194mr451907639f.11.1762725705630;
        Sun, 09 Nov 2025 14:01:45 -0800 (PST)
Received: from [127.0.0.1] ([172.212.163.17])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b746991ac4sm4290444173.64.2025.11.09.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 14:01:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
References:
 <ed5c5ea1de503f6dc8a514b5eb4c9d16c431646f.1762696333.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_mptcp-next=5D_Squash-t?=
 =?UTF-8?Q?o=3A_=22mptcp=3A_leverage_the_backlog_fo?=
 =?UTF-8?Q?r_RX_packet_processing=22?=
Message-ID: <5e792591-2c67-3d9d-65d9-cbf8bf3ad96e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Nov 2025 22:01:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/192143=
27116

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d100023cce38
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1021300


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
