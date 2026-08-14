Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93445322A1C
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732324; cv=none; b=k1i2fNldkkWT1SbMSVCx0UuQmWYp9FdGonVhgcT5PrFfwbKWMzfehb3iG76Q1zwlp4ZmLGf6bMv5ct/XWa6ig+gdjFy0xh0bM4EwU8aZTOOd/txMEdB9BRujIaJ7LuVf2ExckFCei7lXvcq9Bcja0c7HbG+dIAhkrLashf1eJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732324; c=relaxed/simple;
	bh=JKSi61PYq6btF0W61cpn1wOtOhT9dBCpQWrKPKd0TnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfh7KPeMSMW/5++Nl6nSkInK0VATATjpsDpqenL/qGV5jy3Cs1FD2Rwygsc8fxjOM9b7uxY4ApI3O3zGvUvFNcNWDTT+tgEVAcpkWW6mwNH7FUv//4mECIQqRF8wojF3VeverZuJAIAG/QpQ1CBuP0A3Oy/y1hqeVjv7MhWQ1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtSOv5Xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtSOv5Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985281F00A3A;
	Fri, 14 Aug 2026 18:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732323;
	bh=SQzSHeEXcc2QMbJDhMOy02q3kXDY70jUfQSwMClm+L8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GtSOv5XcdGUyZQ03gKJuawbYjBwrc71NaQNSkaTRIVvZ9F/GsOCSX/SzIwDwtqhHA
	 LA7DrmAZeUP0QQIMqtjdGOzoGqSMar34e7fd3nK/IMYXjrvqJFKADBA3lyfaYzKIH9
	 mwbZjdnhOsnhUpaHJob1c7D89/boPCchaPc9LTF7lkDIMautI7U0J4o8GXpUN0sl4K
	 7BgK1WYCQkVDCPT7aYsUQJSrsP3ldVmmYgYfofzPoc8geWS9I0WL5UU7H909umSHg1
	 BkYPIUSxFIQjV8GhzIZRtXpRScO11hkZpFnq7ET3VgoAbXA2gNHFHdOiS4bmBdZVUE
	 N/Flru9c4jc7Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Aug 2026 20:31:54 +0200
Subject: [PATCH mptcp-next RFC 1/3] mptcp: no longer fully_established
 after a fallback
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mptcp-reset-mpj-early-v1-1-3ca3260f9474@kernel.org>
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
In-Reply-To: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JKSi61PYq6btF0W61cpn1wOtOhT9dBCpQWrKPKd0TnE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLq4+VidzcwM82sDZ35lGXmbTce/s1TlgrFKe4Rf++x4
 oPBvLLqjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkcDmBkmNAr5/Dt0Hn17tI/
 hTHZJgU1DbXlM6ZzRT7Ze1xm24FLmYwMZz52zp2c9u3Q5kUaoUwHd73TPHM84xrLgQ5/AdFzOz6
 k8gAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a fallback is done, the MPTCP_FALLBACK_DONE bit is set, which is
protected by the fallback lock. That's good, but while at it, the msk
fully established state can also be reset, to easily prevent some
operations.

This is just an optimisation to bail early in some situations: with the
PM, or when receiving an MP_JOIN. This is not a protection that requires
locks to avoid races: the fallback lock and other variables are there
for that.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2762d74f29d..a3982e4ed553 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -94,6 +94,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 		return false;
 	}
 
+	WRITE_ONCE(msk->fully_established, false);
 	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	__MPTCP_INC_STATS(net, fb_mib);

-- 
2.53.0

