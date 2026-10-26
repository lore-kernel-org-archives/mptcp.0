Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793025859;
	b=kMCXehY86EyCb+lN2OPqttlne0bddNPWdNZM6ii7z4Lvohyo8/+MFa2HB0b3ISqwvsxn
	 h0KY8fBxbk9BorqvzqKIFXjpSOdcGGIBP9SHS8JmUGHaczVhF8319fokPGB5YoxPBGAPW
	 YqJXHvinI6iXPeAw3MYPkMaya0rKZjIO76Usn/0RFOsCx8F8Pt7iar7GZ8DhArhkcWd6U
	 bL28VsuoOlxesp3NMLkNtP+ZKfHJLU9qtbSK26aARgl2LRbFZQaXPQTVjn+iW6/loXr0j
	 5Wb/edJPfNviRnOWNYimd/MW0+4ZjniiXk6+lY0XqvfWw10usYnBKT8rw681opWKsxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PmLN4KMI9/ckNOzHWJ+qP7gBBd55w1zodrkYmeyXAOM=;
	b=DUP0TUlRIMkUfTxpRBQUEU1CeKqWSO1I2hZwAiTEKNbImWouVrfWg0WG1lmvvUXv5chA
	 Y8owxdvfxu7IfDAPpHrUkf1cjWjhFOQ9cUDiXjBV9EkC27QeRgkFPVX6lQt66HhPjSFjX
	 O1UFjB0ai5JrTXGy4cv/iYJ3R/DMIDiB6kQKdJ2lbn0yCFFgSOZzVNIpZKYSFY1oc7DkE
	 cUThrCrB6T61izAgffOxnpbie57s+NstjYvJOUGx6iafYUXLSo+FHHX1rqcTC9uW1JVr5
	 ckS8mB6Gu7GuqTwWjEG0rbXQ+bMlUjrv88RPLUKzLnwouN1x1mGX38axxZEZZQGWU9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExvjL9dW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F3606A31D
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 14:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B06F3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ExvjL9dW
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b05bf699easo27610697b3.2
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793025858; cv=none;
        d=google.com; s=arc-20260327;
        b=JpDJ/XjmdcrA9AvM1nqA6Dv63DIHjXtRBYZ1n8dhEcRVpFX/xLJtms5RAsdsGVcMCn
         6nwQ0c/H494mBooBoWs899uDVxnWrl7ND+9A8nCI+ovB0cRQ/Gc2caLNpARO6rEfke+X
         EUHM+naC/cBb2r8wkN23aeZTdeO8AfSYWRFe/kaXQ/p93rCS+9VykyNnvDQmqm6zepIu
         kG/RIjxGEhEviyuLcpLg08L6X+FeQDuqqlPMlcl979spt2IzcdlOl0q/TzyDGCN1jkhm
         2TZU/H8n+orJEM05rk82+7v22Uy2re0t3QyeNAHPbbqLhnruIkg05/RI0eOLsEVoWKzN
         oQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PmLN4KMI9/ckNOzHWJ+qP7gBBd55w1zodrkYmeyXAOM=;
        fh=q5gD6ZDzYt+hJQGJq2cPo3itwA3E5pRd7k8eID4pnuM=;
        b=QYepvnHbLFCy1Oj/fLV0rtKTZd77y0ML4z9lALY4zI+pJ8wAJd7Fyj/ZuErokhOP16
         YEbAVcaskyhRx0EHSsXBVoDSqpTbdgIe2XNMBD9l0Z5hvQ5H7fyN8QdGpDc78rblHb+Y
         5cy0HPdXd9wGnkAwwzx3NoNbpoWDgi7qKPbOqI/CjNJtX+9iS2K2+IBwCWKnLfTPDeKD
         g9VOqgg9PZEVlQCfiXT9HskvEKXCEBH7x0lZtIn2MBJaepKXpnH85QVuRc7Ct48E/gz9
         3aW5D9pu4ISEryyPpwkPyTfT3kCDHW4wg1iqMDdi/YgTvDtz+zxvQEBAhisS0iyyPCOt
         DmhQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793025858; x=1793630658; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PmLN4KMI9/ckNOzHWJ+qP7gBBd55w1zodrkYmeyXAOM=;
        b=ExvjL9dW0F4XeuwiHrqD9BvfAdVjPXAuQetdklymySBvqFTowNcV32xCnFipogD/6U
         Y9/Jg2GotRNEgrrVzWDK22cr2N0RIiH/g8dBpn3aX0uJXHlW/ke1FPSDW8hkwLv5qZXQ
         sN/uZlzZXgntsvPths83G1EFzThYqSUMSPx5A1jn1OUEpyJXFwOiwx0OQQf5Zs1u7J5/
         SdlbjNXLG4LbCU/7oblo+QI+JYcIR8fLWF8pHExo9P2uFBt++Q8w8HdfJ7Ts3bHx7sXb
         6kYfUlLzzlfGqlARpPsW8nOdK5rtywkAJ19CM9cYqkpPGeLLBuG8Evxd/BoR0GrnobD0
         3nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793025858; x=1793630658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmLN4KMI9/ckNOzHWJ+qP7gBBd55w1zodrkYmeyXAOM=;
        b=Ux9ywB4cVWedymOvFg73PeMsWVVKTrsA3ooz5j3EZpYZSpAAPb+ERXb+Dhd2Ze4X9Y
         MfkIpmCCoL59t/kIzt7HuqQFBxkv3+m2DxlXcRoUDiwvQ7OekhKNlNYVzacKtzdsurld
         QwmJX6kq07VigHR7HZdew9FFVUz46Fd6RlVkkdGnfvIFLwrwwCoOVEePPUdb5v43XgCR
         S+jE/TZRxbOZc8XGBX1rJ5UUVE4K5DrXGNYjk56qs89XQZqsZ2KxeOFqPhj+548MJ2pw
         BfJveZ2BQnPtZ9TKsAzp8DAL0STuw1FZMV9kYfwxKz7bM72wykG40YJxOfIsKMjsmaN0
         MPjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwGtvdOfkQcvumL1FXiK4Xu8swZr7sXfc6fcYC9cvlb/G8KqmdAmVpw+S3tXVUdg06PcGZ8Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLMjkv44uyrWXBn1H/X15NSni3qb0v5i9px7n1nRYk5Caar8loE
	2JC420Fdidj8U3JS6YCSVHw9WzVppP8Lgh4qq2F+q5/AEsyiEnEyRrP89JVgBz4u+HWmOk3k2Ol
	Nj1ZwganzpJWwmFSDi97WHSabetnGLF0=
X-Gm-Gg: AYBFou0QUl+VaSC/nBZirWRhJHgXEETOWTl6NeeVwBdOttytpTr35krpwhjcvQD8PSp
	AkudWaWf0CbecmVvJXADDCPPzsY+SQ5rsE3QiNyoIX1+nTvjko5Fy1hoiSMag3lQCvfPMy/dqR0
	TweMYQfzj2uo86rErY2+umqwt+nV6SX7qendJ4I4wMlEgdHG2oRWTQJopB8iMJxx3hXqo7Hv7XI
	qXGL8jO+K7Pmf/aoxHmFE+Vo+ryhAYYv99roFF5VXPyU5RoTMGNixMYKnbhqDDkjMNb0YYcrk/K
	x+5eE2FfyZmLAOgampVuZjYqbhSVyhUfrXoTu7r2pIrmq/ZZSZmdKZVVINc4P2MWcJ4Y4qqrEKF
	+sn2Z6sONHCS5D6bApi+a7Ir19Y918twC3bF2MG0=
X-Received: by 2002:a05:690c:e3ce:b0:8a8:8945:c423 with SMTP id
 00721157ae682-8b166c5d5ebmr46729927b3.56.1793025857715; Mon, 26 Oct 2026
 07:44:17 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <pm-mptcp-objects-candidate-0066-v3-73df72b7a543d4cada0e@gmail.com>
 <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
In-Reply-To: <CAL4WiiqEHwZRhSRXqFOtF3OYsX_v3519Ey8AEknbaZKFNogeJA@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 26 Oct 2026 22:44:06 +0800
X-Gm-Features: AclHuK963cbP9FFGoa6Gs50d3hUXJxO6-lmlfnE174He_utWipWjNu9DcJLD_EM
Message-ID: <CAFRLqsU2QHD2Ta2aL_qSVr9nVFrn6mXV_nZ987+oqHUbCa7ZSw@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: protect listener backlog reads in diagnostics
To: Eric Dumazet <edumazet@kernel.org>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, geliang@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Eric Dumazet <edumazet@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=B8=80 20:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Adding these stack traces without symbols is not really nice.
>
> Time to use scripts/decode_stacktrace.sh

Sorry about that, v2 carries the report decoded with
scripts/decode_stacktrace.sh and trimmed to the relevant frames.

> msk->first is a TCP socket: TCP listeners have SOCK_RCU_FREE, and
> tcp_prot / tcpv6_prot use SLAB_TYPESAFE_BY_RCU. Reading two integers
> under rcu_read_lock() is safe, and stale values are fine for diag.

Thanks for the suggestions.

Best regards,
Cen Zhang
