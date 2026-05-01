Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BB3EF658
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654904; cv=none; b=u1cCArvDS53/0+fEsKQvIi1QK9wuLEHSiQ0Yte2bBdxfdw2bTWVg9ytiGZivXYVRGgU3uUlarMmbW5z6hViFz5Svig1xSqKJAAk7HvSX3FgY5gNm8Jh/Q/HEZvMgy1oRJfwbn5f1wEkj6Zt+zfOEhsK0asJoO8mVPuFtvQ2OFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654904; c=relaxed/simple;
	bh=064idbmQIFqz04QrVYQYZzDXbFXPCliJXULxXIEQVro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWlBiIflk+v7YBycTzLehMk/+VNx32ZwBbqiE3vvD12pS9VyHCaE2iH1ylo/iBwGGaigqsuoqg/syoQbFlbPlSqW9nDiQxjoqOY3p8G/7IQsvgUa5PICUDwkyrh8sA1kSGSj7rEnc2dGYIzF3nWporxugfJkc7udMfWWooIH5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqoNZjYW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqoNZjYW"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so18546761fa.1
        for <mptcp@lists.linux.dev>; Fri, 01 May 2026 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777654900; x=1778259700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=064idbmQIFqz04QrVYQYZzDXbFXPCliJXULxXIEQVro=;
        b=cqoNZjYW5XisnweGvJWiqIueEDtA34lLm+IviNYDRDDdLuoAyqvAaFRKCr+mFy8oZ6
         0NCMXAJzD1n/DOKifGcflxsSF2CBMDt1x05I6SLBGRdjR7VUY7oQCgS5fOGIkOA8ArTK
         5gEXCjwvpUCT7KEAK5HW44/qOLqN8R0fbUWr1DYKXkDolpLiGLnIIEc3oq/pjjIm3LXh
         S71mzpg0aoae9MoUGM3mQ8/EhtsDXBMh644dnrXfa+Znj3p2JAXwus2n371e94s4Ld/g
         WaxkE3LBEUI2RDLUrNOGN4YMrZ9SrwhlG3k6RZ1dUMdU0F1HbzRJ4xpGdYpZLL22N7e+
         Pj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654900; x=1778259700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=064idbmQIFqz04QrVYQYZzDXbFXPCliJXULxXIEQVro=;
        b=o6rxS//fzsevK/0UdcPLkr57ndKXF0N1z5LeH7iFpiB1BBF6yQCGzIR+fjcuCoSv/J
         tTjwdoizM1QA141Y4BY3Oqz0A+PlE/tWDGUyWOsEsLeep3lj4GKcL5nwoKG40SURTmhf
         tgDnVxh8q52WobEIlWjcSAPN8LJ+WG3XjZGYY5UzYqhWhxbcCbeqhQM9cINo40QLErNl
         Lh3JdVqne+SIHLqvL7XlPbgDFWbTTfI4S1dbfL9QV9x43KlyHrlYmonIgB5ym2N9wJVS
         Jl8Vx2SRqvsmBUSoV7jBltVuJVe4U1Fand+wkt/emR1yQaTBjXuZIk+kJEP3AQdsg1Ll
         1T2A==
X-Forwarded-Encrypted: i=1; AFNElJ9NR6wZqjr3GtG/DfTSCuNGNF8KkzDbpT1yPdiAoU/DejcqujsxMDNtCUACYGMXQLiQqZRA0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEPVsWKRrxJns/o/IT/OT0N9R2E98TqxPBQj9/v2MJ8IYjtGPb
	fewtFa2Gv2vSCsCPObXclkKNe8sV8YZlYDcJ1KgyPYYNjr0+qfoE6X3h
X-Gm-Gg: AeBDieu/ENG/ZCPaXje3b09j93n6wUS121gpG6WbLfGv57r0i299ZVZw0WKcZ8hHp3X
	rm7be1e9zTIZ6V8LGxaeLcdOBudTUdVRjFgZVgL6Dt4Vqh0UXvGqMA7NvyOwc1zDWXQ3FBeJ+YX
	j47wYHyAUy9LEoCSHDptAWlHhebjjlvjHMRKlqs+IVZcnEbNhFtrp4t9iakBThjc/WFbHDNAZlx
	OzVXZ4Ttt0qh8yHkOKkdc8LE3YCEqG1nwjV+vi1yqOhtgwkfVz6iimCUIuA+/Ca2njf/XhiwnEd
	7wGQXnxFgvwpzgBahRDb5TekVfto31q++avYPGCbx/SR6mm7ffPa1FKkwca2EzOZ1y0HQR9Fxpe
	ShVA4WEiWgjy9Ftj2KpPa7phB2+KVpHx57UdJSh68UYp5FtFhX3pXJl47Yb35OV/yDN3lmfz1Nq
	oG7wdInSuCezCEGzIb8LwsGzpzzyupN+CHJ+TWxHXAKMDfhkghh6oV24PjxOHDUQVagAP3bKA=
X-Received: by 2002:a05:6512:3d94:b0:5a4:1904:711c with SMTP id 2adb3069b0e04-5a8522e3765mr3276021e87.29.1777654899294;
        Fri, 01 May 2026 10:01:39 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c2330easm632749e87.37.2026.05.01.10.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:01:38 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: matttbe@kernel.org
Cc: martineau@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	fw@strlen.de
Subject: Re: [PATCH] selftests: mptcp: add test for IPv6 subflow SLAB placement
Date: Fri,  1 May 2026 20:01:36 +0300
Message-ID: <20260501-reply-mptcp-v6-initcall@vebohr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <44e564f8-d059-407b-8f5e-a149dd76dea3@kernel.org>
References: <20260501151454.211598-1-vebohr@gmail.com> <44e564f8-d059-407b-8f5e-a149dd76dea3@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for the review (and for cc'ing Florian - same mistake twice, noted).

You're right on both. The 755 thing is on me, and i'm convinced the
standalone script is too much for what's essentially a one-time init
ordering issue - the fix commit is the safety net here.

Withdrawing the patch.

One question if you don't mind: if something similar came up again and
a test *was* warranted, which existing script would be the natural
home? mptcp_join.sh seemed closest since it exercises the accept path,
but i'm not sure if checking /proc/slabinfo fits there or if there's a
better mechanism for that kind of thing.

Vastargazing
