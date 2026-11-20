Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161972;
	b=yYOdVME30HGgQlLnkvrBcplTDaNiT4Qgd69xjfApJOH3j6NdGOlypgQPtFtZwg3Wdu+Z
	 w3qgJuEWjJu5M5Whws7hBahXr2KoM76rqZr+eQkMBlLwG9LZWhJkR+OaB8KZJiNLk4nHk
	 hm2L746Gt/cHwGqpXSR/I3vkH+C8KSIZpWPgJrbX8makl1HDqt9v3I+VExLc9BMiGk7yR
	 RSdpWX9QtdQ3WJTaLeysfZN5fgcntpV9RCbEUtOH6XqB42SUPoCZBuCLPRlzPBsmHcuo1
	 uH6jApakg9o5WGoL0rC/2VHyN6OQAwko3s0KJApIpqIr4bT/MRV5shI4S8363/CnAcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VsLypriGHYKlhMV5iYD5eFrEKHOuZT3YxctC/v+kE4I=;
	b=CNCuiQUgvfGTqxa/P2HywJ3RKDHolc+ZncP5O15N7zUC7ewECNFUutKFzAlGDHZPtfKc
	 1XomSbr8h3KB7zn7U60frdgndl2N2kkmFdh8LS8TxgKNswXO3zuhNJ4gUsByqStsOcRhl
	 OC499gVWFVrAr+pxSwWUHNfY8A+sVFQIGAs2APkNRS/vX9dijWZoCvQkXQkN/TpGcZ62n
	 xPA4kGgu0cqs7UCDuGwfSVvIyKBSSNmEZdW+3x1+ZHUZLVPZzH7uK2yCUFys2IXHAUyZz
	 uxAz8hhTIJHm9PxdkYhwYVhkqgK/wEUxiZtx9wdsPRM5PD12u/RXWyKnFIcIArmuIug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xqQlTPgf;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C1606A326
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 08:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xqQlTPgf
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb684859cbso385316a12.1
        for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 00:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795161971; x=1795766771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VsLypriGHYKlhMV5iYD5eFrEKHOuZT3YxctC/v+kE4I=;
        b=xqQlTPgf6YFDMPtpc45PxelOpaTdQETZJTiS8XZ+cxrMT3uEEnQ9sh5gxNRfks+fHG
         EQQUEqZLIpMcZ3Em1jkeEPa4KWq1GjZnruSuZZL0K1IOkVpLAOov1JzmUsC1LqskGfr7
         ZkJvZONhW21KpFFQlRVKGsPgcgVEWa9lt48JLMmJB+xAwY4Allkl2CjuuXmPqR59tEim
         n4E2TbamBwjU8XjtAzr826IcuLUmDnZCRuwBF+jWH/puqJXQIoY2ooA6wV7f9CNphA1N
         T78rAfXVg/NYcYuGCALeFBNu24En9k+dGeT872zvK/S4eJ8LD3hEETvLwJJDG9JWGsrO
         cL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795161971; x=1795766771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VsLypriGHYKlhMV5iYD5eFrEKHOuZT3YxctC/v+kE4I=;
        b=1OL27UICztLJiyeZ/00C1bmmDo2Mswvt4XQ2wYVgAVOm47QO7cQs7eA36uezi2szpU
         lPKiwTKHmLSbDbStOeWBvUfX5Pj51debaR4zv2ft11IXiic4u0MmICrlpoI9GxUBixOB
         JvVIvbTjWjjzUKzabUz0yjaV1MjU8DQyqfL/Bk5I5KqQWsB7AM21WrxQa/q+/jPNni4o
         zYOjELUJJjYXYrPQpmfIwWLDbcKAZxsaNj9CX86uRn5Y58DyVQhJjcczRfhJiiVu7ZEt
         lFOg1qS1xXKiSRhpC7JZF1nScqZyp65TyjJjkoNfIYNJfiFX5G43J2XAF5mfbBbHsMuN
         n8gw==
X-Forwarded-Encrypted: i=1; AL+hErGO6QA279dbIyzcFC3nY5w0sw2yAkK/ipnpCyT8mbp5cX5LSsnTWMgeJfa/pEg69pbbTYbXVw==@lists.linux.dev
X-Gm-Message-State: APuU4Z89XaSpI467+3o9sUbSNJlfKR4FU3dBZ5q6gHYdnjL8eUf8V2+P
	WJakI2ADRiwMMbJ9GtuVZl5eGojY9a8S0Ppn2D0J5+P/DjgTAgZEl3Wv
X-Gm-Gg: AZFdTZcBKHSgP1CkkVcGy3kjVc+LvUehf7rEWtt6OPn79UaIXKgz2OAT3MiBdM0FvMW
	Hu58ldOxEku2Rrv3439Yjq7CyaZtK1kTxCrRW7Rq1udGAc/FyhySMYT8Mo7LRN9hXeB2sqaIxRe
	4NOtzw+9AOJJIksl33+X6weZVFvIQWy7nhrWTnueK3Az+f0M9p7dgL0YR8BggC34UhT4pWe3EIf
	SqZwUbKOxV8qVSRnb7eWr5CgrXYRKAMqMXZJ8gtEPgyYk5iwBELXwoBNeHyE+A24N+weSc89gDF
	PM0PrAzLosA8kv13e0hW45AYcUwfn+e3+cSRJH4F9wfsOMbKab6Ob0TF1o7yuhXYre9/gm61eHW
	qIDXMM7wjtEtbWxifRwcAkmOCpsT5ul82l5rggvrBsJanT8J89R2DrY5NHlwuNk2frhsBcPiI/G
	BqgzGa1S+TXryCuf4cQHENhoDfbvsBTwBOTGrobFGu9lA1HPMz2MNdsRdaTQzO6XYb1qd9YgJcT
	UZSBAhvIjoPTzGQ4XRc0HTK6kMKdaYr/ZM8tfdBIjWWhEjj7C1dZg1+KWqqaajl9LGlh5PH6FId
	bGtHsasH3L9JkJwcrr0nqHEms0rPA0OXeT+H8PjlbPzb9g==
X-Received: by 2002:a17:90b:2fd0:b0:3ac:a521:95c with SMTP id 98e67ed59e1d1-3b41cb235aemr2207271a91.58.1795161971489;
        Fri, 20 Nov 2026 00:06:11 -0800 (PST)
Received: from revrse.tailec2828.ts.net ([166.111.83.77])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-cde6d0285c3sm948556a12.20.2026.11.20.00.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:06:11 -0800 (PST)
From: Lin Lei <llleigoing@gmail.com>
To: matttbe@kernel.org
Cc: edumazet@kernel.org,
	llleigoing@outlook.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Subject: Re: [PATCH net 3/3] mptcp: exclude MSG_PEEK from receive buffer autotuning
Date: Fri, 20 Nov 2026 08:05:58 +0000
Message-ID: <20261120080558.2866468-1-llleigoing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cab39a1c-056f-488f-b217-194af2056db2@kernel.org>
References: <cab39a1c-056f-488f-b217-194af2056db2@kernel.org>
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

Hi Matthieu and Eric,

> It looks good to me too, please send a v2 with the Signed-off-by:

Thanks for the reviews. I sent the fix as a standalone v2 with my
corrected sign-off and both of your Reviewed-by tags:

https://lore.kernel.org/all/20261120075459.2862977-1-llleigoing@gmail.com/

> @Lei: could you open a PR on this separate repository with a new test,
> please?

Thanks for the script, Matthieu. I used it as the basis for the test
and opened the PR here:

https://github.com/multipath-tcp/packetdrill/pull/214

I ran the test three times each on IPv4, IPv6 and IPv4-mapped IPv6.
Before the fix, SO_RCVBUF grew from 8192 to 50237 bytes in all nine
runs. With the fix, it stayed at 8192 bytes in all nine.

Thanks,
Lin
