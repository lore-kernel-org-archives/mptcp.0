Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316129;
	b=u7uNiL47kvPcaadYyJCStQQRVZ6a2noo1GvPcFgXZGyWHniR1fsFCJ9q3caLEXz+iNgl
	 M9AXgnhv0D/wPv5YRvF1ao0v6avVbrQ63WKLjEz7sUkQrohEI9i4vfPEW324GAhQUf2Vv
	 UzOid123jZLSTHxHq5oicJuqLdUZffk82tDV4BjK/vHOW+3xPxBuEs3OBqnH0qfhLPKQk
	 WCu/GEVQl/2g9tX7m64bWBjN3glggOJFoOLoSaxeEqii/LihFx2Az5JUqXRVT6bs47Dsz
	 QEw7WlDofFJmDVjjeVVozspWNgJzfOc+fchQRUEZxDWd2cvDb33wTPTrhyNqtjGYQaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316129;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=d9rzxjAXPfp1tdr9gzSVkzo++QkPoqY+umqoBiCBDpM=;
	b=b4RWEgPVmmLVZxtA8Cwfv+WTyFrvFkhpgnYW6zHj4fVSJmPiqQ9ZTIfg00dbDlPYGDA0
	 DWhdcb/At6nHuOCll1ulqyTL5sRzdILG0v8ZlWdpeCyZRKlfWEdSIs1V0Af0qSnVuQYpj
	 ib97EtCfuJkOM3qVRkrGBI4yxP+WBUEYsIrCIs9+44WEujKt3bUyx2kyMgoAZBNOZJhc0
	 QiuhCV1j1pPqdzd0aT5xPxu0NMVi9q8eVsDFvkNZyp6RB3Zw+G1djJneh3TtijX5kzloK
	 gMf4h7s05c5lJN4stnXxzpmHoi4XwRFjwe5ZnEhYAGwm6LdKWXZ/x+0RsAD7FDB/w7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+BwGV4l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC6606A31D
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+BwGV4l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43101F01816;
	Thu, 29 Oct 2026 23:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793316128;
	bh=d9rzxjAXPfp1tdr9gzSVkzo++QkPoqY+umqoBiCBDpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i+BwGV4lz4dDYCgQLGKjRJOd9XzUcd6htambkLQb5sh01RnP+AiURmvq9FLBS97+i
	 dACGlmKMTzjdjIxnX1C//kAE6XiWkClHtIwMmzVfdwTinOpbOBhx2q35WAeHknOAhh
	 ywEkBk+8N6i3mNWvpdcUS4xBDiEEGH8RIk0gfC7+/VR1WZTLhQK/amv5RMJU46rKxP
	 LhquuZpxtgRbaV8zxjCw8TSgpnU++OfQ40FMq/nY6vF9mnd5qdGnEKgmJGOMRBnKhZ
	 nbiZGDt5onehJCyghgvyi0nGSX/CoPVA2voK0zWbmZxPBvg9wohvzinZ0VaiRWyIXE
	 Et9KKAe2inS5g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Oct 2026 00:21:39 +0100
Subject: [PATCH mptcp-next v2 1/5] mptcp: no longer fully_established after
 a fallback
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-mptcp-reset-mpj-early-v2-1-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, Gang Yan <gang.yan@linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1031; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+GAlv3nBw2U9OsHeNKBTJNjV/0upUjO60WCDq1yrLVw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeX5VoUlyVEN7SOU1em9XURv7rtOwFz+4kbn12LGaH8
 Y2TO3a/7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIjQLD/7zs5Vum1Js51F3z
 3JJS/VnLnKF9Prf//g32PdHOj9Q4jjL8j85tP398g2DlRLvZs9gX+T02OBJ98NjUwo8X4p8lsW5
 fzQwA
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
index 02a4f479d9d8..f11393e51757 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -94,6 +94,7 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 		return false;
 	}
 
+	WRITE_ONCE(msk->fully_established, false);
 	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	clear_bit(MPTCP_RTX_ENABLED, &msk->flags);

-- 
2.55.0

