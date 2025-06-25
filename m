Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F70929E0E7
	for <mptcp@lists.linux.dev>; Wed, 25 Jun 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845977; cv=none; b=JzsiKbxInlB7FHFcPDSeB9yJwIqkH17Mi0/705x2DoF+v4/l+LoCkOTlJQxGTnXvrVk1WvXgxDV2rABheF16GxHp1hzKeuNYnXW7mG1QQYt/dqDp/EzreRzV/5C/0dBPx+FxIp1TkJm9gJ0vbhJUwJLR2k2+TOGEu996/YKkqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845977; c=relaxed/simple;
	bh=wk3t8QEt4p9vzkrFwkkcTvfaJsxOptNg5eZrYJ4bUCY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=c13Hoog+QH6azEiVuNJotj/+ijUakbeKF8B+n2YlYPmBtDqq+7W0sBHVqmEGah3QDS5RxXGekulC/Budr815D8WSMxqlBeXBuJzrkowFgVZgziaVsjJHIJTvFnucH9cZd4aY0crUDfKQpscW/UNy+zvPE4DeIH+IXBvvePJQHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXU1aAjg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXU1aAjg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d6ade159so47726575e9.1
        for <mptcp@lists.linux.dev>; Wed, 25 Jun 2025 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845974; x=1751450774; darn=lists.linux.dev;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wk3t8QEt4p9vzkrFwkkcTvfaJsxOptNg5eZrYJ4bUCY=;
        b=jXU1aAjgU+YP0f3O4/yOUisKkI8ETJMopZB+yUZZ2/DNPwZc8BJtk16K6TYHSjdqqV
         2lV0OIFzsMNaYB5pQDwofSpdBNJWrTauo355/ZgSboL82KfRWzAAywatt9aLtBE0Fd4V
         lJO7mfuNOikuogguR+Ykd2YSiCTolKK4fzuPU2n9nQ8as6Ccx61as7bcJWD1/KIaBYga
         QmjIUhzstuy1iIGWUE6AU1Ey1YiHX0fX5s0D9QlA37tGnfebdGMj3k2F4MfcwYZtuWwX
         X/h9KYH4dY0HWm/I4IGpIACpjfJ5ha6Q2CfJ2v7ASANtUVG6meZP76RLi+iNrK45jFA+
         9b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845974; x=1751450774;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk3t8QEt4p9vzkrFwkkcTvfaJsxOptNg5eZrYJ4bUCY=;
        b=tIYO5K7TNH/GeOZw3qzA/S3LdzibK+kkdwHtlEKDDsQ7RXzmC9ry4TtoOA9zf//MTM
         hPlPQ6CFlPvDOaADuRjrCG+p4I2V7OZjszFUN6sPKBWtwu8rMFXtAx8mR0BvBZzDLrc8
         cyRH/AvFUid3MmfbBfYuHMJec5rbvXDCsDGNo06CX8LzZ5eDKNYGK8FVSF4I/KDPIc/2
         zbvlb0KYMn/tcwEKjmQOcVCNC/5hLYxqBQdhoYwVpPM5aBrrICVwoMX+nAYxTnDx/kSw
         sBHrIRWbeE+pvlJDd86a6aGgU3puIAzJCNt5pxWdn47QJrhiivn9U6SzdbugEr9xeHuF
         LPrg==
X-Forwarded-Encrypted: i=1; AJvYcCU3NsDBtwXKPSkGnPKt9lPcyaRtr44TNwJSeGuVyMwFKEAxVz6OGMMgIJTm0gjSuVnGRxWZvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaqpSdoG/ta5lJ6K+1k3bfsbWhWYZvwGoVhOvuMQY4/omkYp90
	VckbfdLQJamrCxdobAlUAU5dyBw+a3LZsr79Surzo7ejaCKhwRTqmLJXOOxSoTFP
X-Gm-Gg: ASbGncv7X6mk4nCO+wLWONPhi1LsrUVnnq3qk7dpuAsRCRkNrFqa4IJXAfwHCsjhIaD
	l4A6pyKb/6cwAlGy1yAiMaIR1KEzXnAOu366xX+Q7CwPRdhryq6dm5rghwZfYGn5rXEE+MKiwCq
	fxeis2Uc55qD5UQdZhiJy7wgSXf1dpiqrCtCZbxRTyL1DqleeKqaMdo5tW2UW7tZH+Ot1WhdSSi
	1Lprd1jeWgAPSAVjvLdNKvczlx3M40q5B4prq969GfEj6PQnNpEFaK4nzJTdic5ivWkTiiKHuqZ
	ET6lColN+iOdmI11UH+Vruflv9aULI7YOCwoa8kCKwnLzVTKMQqMCT+dhHSEnYIDYzNX+DYm1CQ
	=
X-Google-Smtp-Source: AGHT+IFL+9Q0FSZHRbnhY1d0EucQKPMCMeEbxo0kwWMc+Uv9TtpQMADBWHr43oA9ACVi6QZvHEKZkw==
X-Received: by 2002:a05:600c:8283:b0:442:e03b:589d with SMTP id 5b1f17b1804b1-45381b132f7mr21175595e9.24.1750845973913;
        Wed, 25 Jun 2025 03:06:13 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f67c4sm4231818f8f.62.2025.06.25.03.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:13 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  matttbe@kernel.org,  martineau@kernel.org,  geliang@kernel.org,
  dcaratti@redhat.com,  mptcp@lists.linux.dev
Subject: Re: [PATCH net 07/10] netlink: specs: mptcp: replace underscores
 with dashes in names
In-Reply-To: <20250624211002.3475021-8-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:53:31 +0100
Message-ID: <m2y0tgb10k.fsf@gmail.com>
References: <20250624211002.3475021-1-kuba@kernel.org>
	<20250624211002.3475021-8-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're trying to add a strict regexp for the name format in the spec.
> Underscores will not be allowed, dashes should be used instead.
> This makes no difference to C (codegen, if used, replaces special
> chars in names) but it gives more uniform naming in Python.
>
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
