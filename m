Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8B35AC29
	for <mptcp@lists.linux.dev>; Tue,  7 Apr 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574889; cv=pass; b=YSjRMCPKW4Oc3mJuChYwCtl8WIJNAbCWKD33OScOwHsH/rNAzMb3E1x2FC0+5c4A5cVmf+9GF2cjZW3PzY3euo2ifKPTgYjYedT+dUupFqnvFTa8ekUWRmL/69la1ClKaTTgBZgzHxgHZuGtlGqhDFdMbl1vz24MpGZ/1EB54CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574889; c=relaxed/simple;
	bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZVkS6punH46FUfKcYkfiQQKTJPB3Fv4VaaWyfsrmWVVcB1VcAbc2NPAbixUewB8GSguQy4s8GlxqPhzuXH2Y/36Ja2dJ/O9/84AVWkq9QfrHEaOg8nJ2qEf5qBpFgec5FCCGoR32U1V9WCdClGMzqd7hUGWu+3PW+mzkXZO0lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffe7k94i; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffe7k94i"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-950bcf4df06so1454226241.2
        for <mptcp@lists.linux.dev>; Tue, 07 Apr 2026 08:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775574887; cv=none;
        d=google.com; s=arc-20240605;
        b=XTPQCufeCRFud+5FzFgoL/WDJGvzcC4YgeSvzSGpvXRRXyigmRotQdcH92mCu32Xd5
         31gOvuQ77aTOQrNBF/2n/PU8GOZPQKkz4g/0CW/57keWYFEH1Dof0xt0nu1g2otbDlq/
         WaXbF4adH4CLKKB2JzA1p4nw6Xv7MTELpyXLPvZLKSLWcWZw3JCFsrYNJ4fn9Jc/y5Py
         qy8wtar6wA+n7ucDmDI+eSuED3jJhwGkl0wITFsp9arr8jZZSMrBnYn2rVSVh+Uyj1pr
         13MjfcrPv2+qytI+FAqt6+BkPZtcCyPWSe+Lzsjy/Zk/Xvdm0bPgtcjJMQznzkldmZ7d
         cc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        fh=XlesQS3Hhx00SYHnT/4QA3KITImy+beBoLLI2RKxiLQ=;
        b=auPDg1tt6M6gzt8Z7Rvu5jrAeZODTG7qv9bv9Co7e6Kq7A9ZSCx1z8uviUgOVKqH3b
         zDpcMKml0Qy6WUVbic+4GGjENQ+Aw3pftC5F3E4ZfVrL3gvVboL6jx3+bhdeTiKOFzju
         QJWu3nCP+vdNtBGgQjZOezv+tIPNeCLQHMkAmQwadzJAyW8rTp07C8e1HkOJGO8oocRa
         7lCEmjzrrbGvzOY03vemDBsHMEH6ZWbobpVUhynO9PPYy58+TehG+mHDIIw8LpoigR65
         f9Hn4HFby45SDNiIlHCUxJlSNaFGx4/ieBZSviesODhVoQ8hX92Emjh3V5Ki3jB3d2Sm
         P1YA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775574887; x=1776179687; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        b=ffe7k94i3ktHPh4YRSmMvXfiC/hmDvLCJahq5HmEfwgjN8IEHBQ9EAnhiLXeMsNDcl
         2Rr1ggLFwArS9rzRNGqkPFMr3cw3MzIGPw0r76cavlR4tn7ODcusXsfN1Kq9r3gsCBj0
         2/EUrOxaLiXSbUpJt/pSRnCWh/tIGYYY+zR76jam7aWNDW+8Aj3pV8i4euDyRMng4HMI
         d7M/aHE2DPEx3JMI/0LTHsQIsYZcC+9hbv8Z6G4O+WeUwQK0OsEkm174RRhAqUnR9NL/
         EoRzwjPrghqoIzKRnlBkmuyCSfRbsLnt6plW31WKb1CHEIBFQLcFzM/YQlI+uIrM0PB7
         pUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574887; x=1776179687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        b=WOYFkzdxqtaeBpEi2X5nQv0EWtycsnslzb+YKiHvW9Xxy+Htw1z+WuGzi/kgoMex2H
         pt3Wen5T5ooz7RU+j8fc55lyJ4Zt9HjrZB03DqjDXsowB/kk51TcTgcUzUIHKnwJZjuO
         u14SyAVDBHLnKNSEL/6atwXAZKyzqc7Zw0Y9lTl717ZBq0cEGmXQpVb6JTyOltCddgcC
         3c4/Ax7vXF8ykaNThEMc7yDxSIRdpOrtTzP/z4quX5vVojX5j1xJPe/GXoBX19xuugQc
         QD8SAaTFAojekOaLzMBWiM4jHgp2IbVJqrImEXyIf2xZ9x+XELUgtCz95rmytoTrH5nB
         +oxg==
X-Forwarded-Encrypted: i=1; AJvYcCU2qeK08gV2PRt52j0fd1txzMWsbAHFFRzV/6U1xOamKNS4YMcaxJLqrmDi3qd2vja1Fg+/Wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzX+R5bmAcpRn17MlpPzCa/F5prtTlRKR1R+mGn6GxzLtn6rxs
	VbwqzItXR2sapyWVbE2G8EkFDosNawEP5dlqCZH0TDBJmHbBxNmEuiTcA0AbacA4btesSATUpvO
	I4CxyIOXX3TlQDyUSlqck5bZr1Ve1o+ZtWI3sXKJ7
X-Gm-Gg: AeBDietghMEtH3xMil5BiaACT1YjgZr54ubXohH1DLCzCOnmGy1jTCQCPB1vt7zUPg+
	/a+uR+Ot6ELsSIDvlbEZqwVXuvtb+Q6a++yTz7AtmumO56Bqt8eggUmsnsZbcPsN5G0IUkd89R+
	CIaX7eZZtUlWf8f6zv7L2iSVfCjfJ12i0zPQuHZkksHWUg87CUEANg+cHkUAZwGOG2k79hwPyms
	E5Gwl9WQ1JSfEwIqsy4hDUf6sKYLIriL2xi0If+sJJ/C/2s8HaRhhJcO/9ErdFNtuj8lw0LD4wp
	jGdE8/KUODSoLtxmsw==
X-Received: by 2002:a05:6102:8555:20b0:607:97a9:e3e9 with SMTP id
 ada2fe7eead31-60797a9e882mr169043137.23.1775574886413; Tue, 07 Apr 2026
 08:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260407150758.5889-1-devnexen@gmail.com>
In-Reply-To: <20260407150758.5889-1-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 08:14:35 -0700
X-Gm-Features: AQROBzDVHNhmKDoXWfA937vlS7i5gl0nT_gzqkVTXTlHZU7d9eadHvamrDIvMqU
Message-ID: <CANn89iLweeu08XgFL345k1NVx56=u6RV_GqnfG2ArvLjUwktrA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 8:08=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 (netdevsim) and __le64
> (ceph) fields where a direct assignment would trigger
> sparse endianness warnings.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
