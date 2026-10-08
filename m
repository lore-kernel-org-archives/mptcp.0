Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F03A6B9D
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453993; cv=none; b=YZECQr9Tr7iaU6NBygEfKUqSwbtiq5fjK3gG+HIEla1Sed4Ukj5fzuPBrcHag2KaKWVQoQwk+CqhrQJmHmirxIMPtc262pBTwpFLVuSB1xd2D6OUYtl05B6g0NFakcZHSB8msgkqOC9e++ttQbsSKmrnk4X4HXl87s9cqUuM9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453993; c=relaxed/simple;
	bh=JWj1nuzQ35N6wDOjwCmlhSw/qBTHjvsrFfWUXl3xZZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCofWgrefJ5X73+0lDrBzvLfpHJaDXfWCWVcO/J+fCCfhPD5v3D3cFa/s5bNV5xDOpdFiO1U1bIf1FFRp1iF5LuVy9Iz6bMV8qbDn214TYImnxladvM+i7r41hJ7LIMVNZOGzqZC7G1erxlRDDRFVn6ONVJ/y+15VD6EDM2wR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9WOsC2R; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9WOsC2R"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1438d9363fbso1892680c88.0
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453992; x=1792058792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eCf6grt46A4djzAcjuzxJT4IZiodM5ZCyPT424FBF2c=;
        b=a9WOsC2Rbfs4hPrEHcDbfUCL12u3N0/ydbzpZvrXEtsSuCIgC4jLv9L6BU8p5zp1Ou
         YxQihBjg3tyKToD8YHWIXPNbxLVMN979eoPlWkkZnU8LaU1eKTM3f5+2i9JRJOYeUNsW
         wbVCW3QcplvGt+MqCGKCgGENRMYX+taEOHy3IaWoiunvH8XcDlnX1/dWDaTgHMT5WRMm
         5F7oZqfnHV2/chbK0vNmcgyqNUcoT9esDP49aiJTMytrFOfwGcvNdprc8dFzUph437aV
         3DFn2BcaXPczMRVjc5W2vnwQqtTrXxWCgnoHL4l3mdbQOAzUzAAkc1ERS5SloZL5NxWS
         b7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453992; x=1792058792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eCf6grt46A4djzAcjuzxJT4IZiodM5ZCyPT424FBF2c=;
        b=VXsMhDRZ0S1+bZ1UVvMJ66vyIK+QMjAegx5fqlXxVcYJtUBXjzGUvIDNMq+dIVW4b8
         XfJ9luTzKbWhWrgbIFj4X2e7kbN1JCvTxBKmvNpvfLSUbYVNvri9M9y30/UXcpdau0My
         prmGkq5qSJuvr0V/nVIe5wjd1RNrL1JYEI0x3EbFit46nUbxvBSlkmUfOkjvRKE8e91n
         DhNZCiZFmD7kxh/NJEChvB3b2PyQ1Jn1kPukEmOmoMuPbdVVR3M6aTIwjGpBJ0Ek/N6z
         eeDbGSnpAMiqrY7z0KCMnCWmgNTmmHkF+QhGCRg9Awp7TS+ED7s90C3uhsn9AL04sE/2
         HpPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1ssOk0r8KN7H0SKjFS1aVC/xqdZHXh0FMd6jHrJtlsP3oSmO00zgbHRCJQAkip95pY0IOcQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lS7TdrzU7qVrPaNAvNhEISK0+EZX7aWhVP3bcWqiQoaZdnV4M6
	6d/mc/F6HOw8I9GNfQV/xKSLnXCQ7itM/gWgaatCWBIfwIQutB/q0SX0
X-Gm-Gg: AYBFou1nJQHRmxf2nWLC9HQQ6DYvtskIJdy4Dtjp+KEiqxxmzClHVRrFUcUd55QWvn1
	dklU285+i0GPHSHKWz157VPpgtdKicxVDs8VQaEXNWf5jTmRZY3FzaBmmDZRxkxc9wnsvoMO16H
	PfoxT11B93l11EeiXvsM/ouyi6qCok3kVQP5AzVMcnLl5zz3/jSq1e4GZCyB3wobhOSEMrReLsq
	zWd3cjlgWOqe4kc0gPfcYQFk70Uvn2eO8OX1IEfMIifC7Wli42JAY0pGPsFQgeUMZJn24L/aXfM
	V6+9FtA3gjAZjMcEab6st1dHnW2+8RMMNntG746WYYK9KX9kyy9bPAO0SX1Di6ItId02/Y3HP7u
	51ME9GqH+aGXDzP3HmVofj8PGKHigVkTVVUGuBSnc8Hpm7qppjF8ktBkTGaDSCrLYKT09NCEMdf
	hRoakkOK2z6jd839OZoeoVQu7NvD+L+EmIy2PnJGdOrDrM9dcQ4z0nXEATe/I/sNXPQbZ9k2uKo
	RUQo0+os7XrJVqgmZw=
X-Received: by 2002:a05:701b:4584:b0:155:4a09:a228 with SMTP id a92af1059eb24-1659f86d47emr2222835c88.8.1791453991594;
        Thu, 08 Oct 2026 03:06:31 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1616980c3b7sm12992588c88.16.2026.10.08.03.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:06:31 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: Petar Sakic <petar.sakic@ink.fish>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 15:35:20 +0530
Message-Id: <20261008100520.104205-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com>
References: <CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petar, Matthieu, Mat,

Thanks for the feedback and confirmation!

Indeed, since the bug predates e00b63056fb4 and exists back to when server-side
Fast Open was originally introduced, the appropriate Fixes tag would be:

Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")

During our testing with simulated network latency in namespaces, we also found
that when the 3rd ACK arrives:
1. check_fully_established() marks subflow->fully_established = true.
2. But within tcp_ack(), the underlying TCP state is still TCP_SYN_RECV until
   tcp_rcv_state_process() sets it to TCP_ESTABLISHED.
3. Therefore, invoking the push in subflow_state_change() ensures the subflow
   is recognized as active by __tcp_can_send() and immediately flushes the
   queued write buffer.

I can send a [PATCH net v2] with the updated Fixes tag once maintainers review.

Thanks,
T S Rameshkumar
