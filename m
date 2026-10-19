Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436129;
	b=RCvzN/EJUT0RI5dCCjoQsw6PHNPrCX2kM/2BTj5U8roGMy7KAqPS7W1qfmt3XIZ9n8xw
	 310Jbvtrh3+j/efTlYi2E1lLgWQtRSTb6UQO+LP3eJ6+3QtIrH55URiSf3WTcvj46MDxx
	 8yzFvrFR8Qzia1JdPeRZKtxte4L4DQCd2vyHl0M4MLPNfnz6WI/1k/hmHsi8gd5FLh0ki
	 1CvqjsTIrTcDQsZb0sEJ8+El/auzNTztU4CVPgZbjzbOTQnSQOOI55J3OOlEemFbRMAaR
	 ak56iHphkW6YqTr1IGCqsoCyRSy2NRzBVcHb42ki58xOIj0lPJFwM321EC7HDKU+PnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZEweP7BYkV2D440QMYL7zCYkBEnbEpQlbvsJVJB9o90=;
	b=gnUkIhVxSSG1SBCuKfZhXLp2pjLxdlYBntcVA1LYQ6Zts28ll1nNZxI0BXEHTeTwyJwx
	 xQzT6tdSMjdE5QRLOvxUVjntK1VItADuAuRdyZwHoEQgOcH3bawseBcFlivvRBfpQq8Mm
	 wWmHDv0Pjkn0ff8T2WBHEc9/a9uUwKEt52Vv5tOK+SWz77+CBdyY/07gYtBV9hotpeX4r
	 4zavbrVd12NgGaoEB6VWfGNAkRjm6OH6P1I/nKnImaIhb8jR7CIz/eflnsFL97PEFz/wY
	 PGmkM8LC50c/L9vv0UQvDU0Z0xVs5KPedhXUOlvDIGf2V0e4n5qQMUmfwNQDZinGAyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=atpKtqC4;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B248606A31B
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B248606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=atpKtqC4
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-157fe9d771bso1160274c88.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436129; x=1793040929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZEweP7BYkV2D440QMYL7zCYkBEnbEpQlbvsJVJB9o90=;
        b=atpKtqC4fK8Medyr3azwmOg+PX3kCBlCAa3ZC8wBQTldBAd8dBWgJ54hqwl+TxdimW
         ezNhoWZe7mKv9g3FxP3GGwnm7mS+YwuDQkfszjC1GlfwIxqxVsWk1fxHj4pRDyU0T6JT
         awzMkc+CfkRyS4CuO/c8Zt2YaRVBkj5ar3WJ1waJxvDXKaMAjyGxF+WjQF/Bcpk34uGw
         zEcvu71XRSz42dFYUkwUP1rQcyFYkau38WOHJNfpP/gvv9CxjYxSkxxhXqJXxjDIjEY7
         IS90b8V62ho4CexjOZ+H3qOK/cwHzd6bm6GXCSAvFf55hAMBUojHpzkv+apSa95O92C7
         4P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436129; x=1793040929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZEweP7BYkV2D440QMYL7zCYkBEnbEpQlbvsJVJB9o90=;
        b=CCmGsyBnexhNT8/MYHOTpOcdko2jKtgGk7NhLhevhz9wSg6RkXQnICURDyEwSwHDrE
         +RLowyohs5MkR0qUMpU/6N+ju4+V/kEQS+ncmB2sZJPreqKkkKhS72wpWXiffBXtMKM/
         QLB4ypbD09PEkAGCaj9a6sjh6E+pnyid8+x0cTKfeB5bPqBeqQ5KX/CRDw3nyxb4rjPk
         XCIHjuKZSOV+4W93VGDZCrWOHPPT6n8qqyU26KSFoRveSYw4XEy6kBUeETGbwjYSkiZU
         k2VVo7kIW11xRqkk4swTLwEQr8rfZFVosK7B6Tx7c3rP/9SlViriHPScreGuRkY+fB8C
         qIeQ==
X-Gm-Message-State: AFq9FYI351cI5/8zfUaAd6vbxYM3FyaqQpA18UHrg0iceRzaysUy/jwk
	kKbvb4QoBaKXQ9rfb+MBAfDkF8Bv4wyrB80JKXDHKNPiLiFH5a8G+LnH
X-Gm-Gg: AYBFou3QAZWCHjtQkQOtTnc69NeNilrO0+dznRxU+BnG+iksmNT5wR4GVgI9LL4AzZL
	DhZzzonY03p0bEewaKxmn9OzXKG8Z9hVVmT42iiJclH2jIObl6p7o5GiQbmHunydq54JhYoGXgE
	Ybt2ck7kqQ4MAVTkBBYxDxxDhNOsu9ichve6Mqg3sTm6RhXppBvmE4/10tQSZElB/Z/+V1lp85G
	fBasMJNqJyR2yM9hv2Bk45nRMNU5GPzHW++uX/JvDfnYoQKYQGPFbap1qk6pIqAtLhuCVUlapdr
	euWd7cWlPHIDdygOtNZeoVSlWSH2wuz7hiVOLxH5CCADnMHpkgryUWkVp6+6h+JpCwjXtcETZ8C
	um+Sznh/nzJmNDCcGI1P57/WUnPjn4NTSxpvCz52Kp+5ABGVKel8j6Fc/ypJAJz2PFcHBJPcKJb
	IUGjP5dII9NYVz0db7Hmuqt2aKzIQNQqJu/+0omVZ1L6xeCOmNH4gu3d8nd3jJb6yt0d8gGZsZW
	Ushx9s=
X-Received: by 2002:a05:701b:464a:b0:14c:8461:b3ef with SMTP id a92af1059eb24-18513e7c64dmr10752587c88.24.1792436128558;
        Mon, 19 Oct 2026 11:55:28 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm32106011c88.22.2026.10.19.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:55:28 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-next v6 4/6] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Mon, 19 Oct 2026 18:55:23 +0000
Message-ID: <20261019185523.458799-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAG0Mgm9TunYCsiSyp=Se=uQmq_kzXO=M5DF6wdVtsh591NwENQ@mail.gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com> <20261018041748.1655711-5-anilkaushikwireless@gmail.com> <20261019172646.212143-1-w453y.me@gmail.com> <CAG0Mgm9TunYCsiSyp=Se=uQmq_kzXO=M5DF6wdVtsh591NwENQ@mail.gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anil,

Documenting it sounds good to me.

I'll do the probing from the PM as a separate series on top of yours.
I'll send an RFC first to see what Matthieu thinks of the approach, and
Cc you on it. Would be glad to work on it together.

Thanks,
Abdul Wasey
