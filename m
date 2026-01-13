Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD030E0D2
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293797; cv=none; b=YF1UkcC5oPzRIDBGUxxnoesYzDFUsKadvohye8VVSEGQZ80sP5pOtQrUX3qtmZ2F7rad1QWkf0/UUSAmwJZX/vwEq/9rN9mbldPOKt+kHnO9cOgX44VEqWl25+NX9JVhwGEBV/0q+u5x9izC2MGwisuuoLLaYCrPHtf7gWX5+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293797; c=relaxed/simple;
	bh=yIzCQgAPQ7Y2haQw9bh+WSTXy6LrEaV4wYo7buD2D1A=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VWzAt9eV1FuzdaSkPAO0UW8LKrHmME1oC8t9a516oATY34YsQA7tW4I/8E0cS1c4AxY0TVpacr2FtN11/hrI6i8p5lg1fQZM/c2YvL9OM9t1VEoyUsnKgQVedQckUhXW9aNxZ72iZL7QU4OO7khaSiBsVeThGg/mms4Sit8W5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AT9V2qOz; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT9V2qOz"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8888a1c50e8so91270706d6.0
        for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 00:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768293795; x=1768898595; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0BbEmNiTa8XH581stqH6jbUX8OEcTWRUBi19yK1TU8=;
        b=AT9V2qOzrRpK1GWeNfaXOpeyB/ty4Yu8UZpPJedspKe1ux67nQead6ogruCgxzQw3X
         Iupm1dsPenvhNFwRyY+XQG4pDO/ehA2ViblJ2wuPyHE4/XNyQHeOHg7BycPYhpslfKzu
         +Hr6tlcU7u60u9oD5fTPm02drmttBUA88LWB9sZThKMASW7pZZ0ateisBLulOlEvaNcU
         mqmlDeD9xtwqJV0rr4ud5CYDkx1fBH+EEtxSd/xzkFg/e0F2uJqmVnlA7cjnOmaGeS15
         4EqpUdU4yNS08I8nAdAOZYMy+HSJGQnB4Bz+NeTB5577SI3FWrY9p3vfv9lAdpGH//J/
         5+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293795; x=1768898595;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0BbEmNiTa8XH581stqH6jbUX8OEcTWRUBi19yK1TU8=;
        b=kJCm00cCxWMUnot56WNNH3jZTyjztFOsEAY2dViFbsRMoS/E6oZO+5UCLE6Y42AtSU
         NCT7A5QJ/+PjZAzxOBtg8O1fTK8IPJorLM345u+RKwOLOvvfQf+4DpZW3Pd53lvF0oRn
         nJ2iYkTMAo9TeJheVahBE95dq83vcxhrsFAg8ts4iut0D5rZ180V4PCAK6BQCjJUt6Da
         je6UtAIXGH4kz8iHYmR4wx1NWz46pyTCDcvjK9GMy/xDW7z9GP1xWc4dcNeCfFoSJw5D
         keQmXnjnxjmkAdEdh2VZoyh+9eUFd4oV/qdoI/J//l0TNktcx2IvaGnjAmLOf97QmU3L
         7Y2w==
X-Gm-Message-State: AOJu0YzdcIvaYVW8YBI9qyrYqHZxz6WiMTkGfltPNljlCDUYnNp9wKoK
	OTw1qJKNuZBqNydbDRd2J72HpOmjcsitsW5SC4hfBbiUv6JyQ7rDZsH1JdQmprw=
X-Gm-Gg: AY/fxX48wgO3yo6ZYiSytzRW7sZRkuQfcD7AJo927CGE+LUWUG7hseloBuFQ1Vbx0F5
	vV5MJErozLeMCYMuNADAPzJcKnE5SJIkIvYIW1hVy3NwctCRGdCBXGeSzvdYxJEREqsMTwPh8ay
	bRlhvJ/EzsrO2fbvzH9OsAv9b4/GqOTyGkNDmU4YPG7bLA1YjrZjXDzZQKpy25eogTfw7dI1Dy6
	DD5rWphVoYH+/Gu1qMzvbdMo/ksjCl+g3Zjm8juzvKV4p0L4HkCgXrPscPoMmr+oISNuU3CxMK7
	vtp4mPl9V2Eeo3GUtz/rIN98/Hmd03fvSoumtPQ8XO05Er25N7+Pyg/YVcvEuIMpm6y6AFopKFW
	OD17YFLF4gl8IYk3Sz5ZyeKjihGX09ygMJvf8VoGlc1kikkpoftHya3DmGouGMnVYK23+QQKzvY
	HeQqTphAXjW4rQ+KQdTG2Zlvc2
X-Google-Smtp-Source: AGHT+IG49KhNf1eIZHM1gKWkYQnpmtBpmAx1j2zEF44+lRu4j1q2MerVQ7F85w4N4IKYyxqqC3Xz9Q==
X-Received: by 2002:a05:6214:212f:b0:890:6330:97bf with SMTP id 6a1803df08f44-890842770e7mr281548106d6.60.1768293795186;
        Tue, 13 Jan 2026 00:43:15 -0800 (PST)
Received: from [127.0.0.1] ([135.232.225.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm147755216d6.18.2026.01.13.00.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:43:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <24196096819a0557b38926fd53ef1b9121465b11.1768291283.git.tanggeliang@kylinos.cn>
References:
 <24196096819a0557b38926fd53ef1b9121465b11.1768291283.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BRFC_mptcp-next_v2=5D_Squash_to_?=
 =?UTF-8?Q?=22tls=3A_add_ops_in_tls=5Fcontext=22?=
Message-ID: <fbbd941c-72bc-11b4-7922-22693af970ea@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 08:43:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/20949913531

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/76=
1f4fddebf4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1041619

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
