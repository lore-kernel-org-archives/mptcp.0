Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794644537;
	b=3PCo/oS67+b+VspuMyZpMu4VazdkOT04WUcP7y1FW8JdZCQtO9lbec+aukKkyDAR5HB7
	 fd9SGV/rWrca3Gb70VDLd4V8w/u+neqQkjdKAHZ61n1tNfqmOwp82AdoRc25+YA3bcp5t
	 DHpc+eD1U/fczaq4bumklU8k7Vv+QfyGl9vy8EeupHgvWBtYm9yMcvOA3xlW43BZeL2gi
	 qm1c6Nabq/sxY3uLHYAGK9f8sswRb7G2bNWYFUaour+DJ6WMZ8XF9r50icUMwVzBsr5g3
	 LGlOAwbfQcP4tFYxaAbzrRbM0D+jgCRWjiMRvUDneNWTiA6NMauzNCQVKlhL5zL2Dog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794644537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Tfs9s4KINOXHCd+tSmfq6jFMNmE+uM0ebKd1llZq3aw=;
	b=sVzrfDcmghZ2I2ZhyqL5TRiCQ5fVaakQpSjGkU56MKOGrtX/odcXLB0BlIlS6mEC0KuA
	 IoEppHl8rCPyYH3CjR8TG6jsub4dd3HIaBB+kvusa2/kk9Q1J0Bi8fSlXrZrvQUWCH2U6
	 I5z02HrZHiyIFEHfBxsDebuUrRnlv2zsV3Caz8zRSMPxt9uMi663HpZ92e5foB1LoY+4n
	 4sBJqZapnNWLdsorR8u2Odeu+0yAdVFYwMRs7fPk3n6RQX2HCR0+jAwdrO/eRjrHegy+B
	 y9fCmOk4kZ9uDzJ17eCVqHoHXIT9KGQFs9sYQV0oXM1k2DveH+cIqUbTb7c/V4gIZQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpRH1Jq3;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76D606A323
	for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 08:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF76D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpRH1Jq3
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a3c08d6928so2395038c88.0
        for <mptcp@lists.linux.dev>; Sat, 14 Nov 2026 00:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794644536; x=1795249336; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tfs9s4KINOXHCd+tSmfq6jFMNmE+uM0ebKd1llZq3aw=;
        b=YpRH1Jq357osfRD1odXTPBvP+qdX3YIowqRuLLaSw+q7iu2R6vV9MfQmf26ogCvvS1
         jwwDDgmKcigBeS1HdlkBPxDczJqJyLWNbdiyhT4IzKRG2026FDlM0nh7EXJ+cBuXNW87
         W5UdxtDtkaQn26xIqaQ3HXeupXkzhHJIyx3UTPla4ElVxgWfz8a3BzcVGMSCQzLq3kC4
         O38Vgj/pqgCDlkJ4A6I0iDMv/4N2UIQ9cJj2OTbp5TF/9DdMnSRFtRQWafoRW33nnnKy
         KTHk5JRsX1nOmE5NabTYmQWSERtzGKelZAuvSnLBUQtsbDH2gUz5VgtyR1nr6gtaEGlF
         +i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794644536; x=1795249336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tfs9s4KINOXHCd+tSmfq6jFMNmE+uM0ebKd1llZq3aw=;
        b=MrCY6KZ6cB7cTCsF2WwxOIzvr82x37AWa3Uj3dsHx6YDfnEC6WB2dUhcQiK4yALlCj
         6a9LyFx3oNeUufgflpOs7PAvR1rDMcNbnMgQIck+W9/CsfZS30rIwC/Yu7aS4of0Okxi
         2m+fcbaUY7BOL77zqUSbgxyBMEuLx/ythtJCtFec3s2eBToFzRuHuJ+mRX1kbURFXwnQ
         ZJ+VJFtF+oV9X1dluFMzQQLfPI+K6Bp3uhlMaZ42J/UICozBjC+oeIPHZexpmgaGM7s6
         GM5tVv73oNs9uUq051B6DwTFKuG2Es12PEUWZkoMxapK8hfWoCCGzSEjsLkbeIXFJKpK
         Sd/Q==
X-Gm-Message-State: APuU4Z9fzNSxJWxvnbSzF7tL9LSXvDwom7isvf+bHIRyspLYEMThMgRr
	Esw/7vDLKj8v4odWIULpahSmUyoU779A442eL6Ts4u4MnYSpG1ihCtqykcBOOA==
X-Gm-Gg: AYBFou35gw9pO7Ud5KaPpHeGCwGumMWxZffaweyVF4Lar2c9xfhmDCkB4ErXgZ+wK8I
	xjRthU34dhlGwy4FF+/mSiWclc6u7z+5wiRNQHv0P+Z6oQ8XylfKT2UoarnuelYDWrPexlKCVNn
	34PxbLx5oNFVAvAH0snAcsZlGGqiJVALR8H495ZQ6smH4Kj+RhwMA+CqHwuYBp2xpJqlu1yuhYr
	I7NDeXGYC2CX3vxXOt6io66/rssEOp1PVx5BJqd/rlrJlDLB9ERNiofyevTgXKtQ/H4jvqzxC+I
	KTCeMsESAYln4QfGBoM6qPT3eCSvtnE65Kasa+AauwB1UAV+nYJ0YlpmMgrBWPVnJjW8S+D4WZe
	3JaJO8M2LXYi8Ws9oaw0d6WyS4yEtXdy4GIldtyur7dU8IK0Jb5y16InUFbDWSKC6qdStsECGxg
	YgBMs/l55yQnBAwufuvyKK3PHv9Xf58SVOFS5a0JZ5LATmQwmXfrtTtX8E6ReQJ7hpJTXMBM30a
	gg81w6OyB3KZD/j9yncT54tZatMB5t03rWunPGbE9oYKpnL6Dr2CcAkCkMesFwoUeYCw93WEc7a
	u6fYhEUHynckdEJ3b/S54d6X2mBu8+9P3muMfql2uezQEce5P5HtvyrubQ==
X-Received: by 2002:a05:693c:41c7:20b0:36f:2e77:93e2 with SMTP id 5a478bee46e88-379681c6815mr4735704eec.28.1794644535629;
        Sat, 14 Nov 2026 00:22:15 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm14684645eec.9.2026.11.14.00.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:22:15 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>
Subject: Re: [PATCH mptcp-net v8 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Sat, 14 Nov 2026 08:22:09 +0000
Message-ID: <20261114082210.3439645-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024111842.1069878-1-w453y.me@gmail.com>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
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

Hi Matthieu,

On Sat, 24 Oct 2026 11:18:40 +0000, Abdul Wasey wrote:
> With fullmesh endpoints, removing and re-adding the endpoint used by the
> initial subflow never creates a new subflow from it: the closed initial
> subflow stays in the conn_list, and makes the PM think the remote ID 0
> is already used, or picks its reset remote address. If the initial
> subflow was the only one, no address is left for the remote ID 0 at all.
>
> Patch 1 fixes that, patch 2 adds tests for it.

A gentle ping on this one, in case it got lost. The MPTCP CI and both
Sashiko reviews of v8 were clean.

I saw patches 21 and 22 of your misc fixes series touch the same part of
pm_kernel.c and the same "delete and re-add" test. I checked that they
and this series apply on today's export-net, in either order, without
conflicts.

If something in it should change, I can send a v9.

Thanks,
Abdul Wasey
