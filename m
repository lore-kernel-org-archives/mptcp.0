Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9954E36F9
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408552; cv=none; b=VRYdw0u9fUUyTuGqtuMCgQn70we/Kq/wBED18Wqt5Ln7iWPpmpXngvPj5SlS6NC4A9B+QgqLeadnkL+fLMftRuzlaNZLCgr4nUsuaYAw+NQc11QHIigL6GNld03UpfTbl2nHSpkZmFmve9yAOpO/rEWYxoF+a36XIVju4UPUx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408552; c=relaxed/simple;
	bh=oHCnAsvL8UPQUkf8HIgtRHdHU83LOyilj1RaGvr4dnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VNQuXLbEZ2NL810LeHrDKNBzmxDZZYkU9SfMPk7+Dziyf4BIVUWCudPl3Kk1m01hNcj9e0Zqodq/rjWdfZTqQxiNDzHDsiIP+uq6np+Hx9h7HINP96tShpGjn2+JBgO9zLShiHml57p2YafQyxOCWOem3HnFXbu3OHMppOoTj+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8LgVgUG; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8LgVgUG"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5751240eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792408549; x=1793013349; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1rNKhg7wsxoFyd3ycK+p9wlTbGB7D0GBZ0I8jEotlmY=;
        b=O8LgVgUGwCG1N0QvzVa+pSq2CnqQLB24bGVwekBtYWRpdVM5XYJ8No1SfjAKixyUDW
         G35uLn0thZXBRNQsfAxTkY5FU4JxtIUtSk3bvY52FNDcxaRUfTsEXT5roXSLyG1byS2L
         w1Oe13lA4Sr0eOO1A9XttEqZ8k6nTqrZIROcNaVXoVlEWRhVTPdHvw8sqSftZrJedORk
         l8124EFPwLs4RcMAumxsrWtOVaLGcDtXYlO295LImjg57J+7+rpkvTYaE3YW2RsgnFXx
         GD/R7wb5kvi0n9z+JTS1aL7cgjozuPB0jokvvlPoPTVlG3PwRogGli9adleuOx4bMD6T
         9Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408549; x=1793013349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rNKhg7wsxoFyd3ycK+p9wlTbGB7D0GBZ0I8jEotlmY=;
        b=o1+WzW0ZUYgutLir6Er3MPNcAVjTLix2aEg3aVudcOYXEBryEIXYyRQwIt20h2YH4Z
         ohYi1prWFpHc3HBoLtBz/Dc28hXGFhy8utcwKHcvG3Y4IHQ9Z62X+PCAFeJlgybWAPwP
         L8JIsi/gytFFrXlzbtajvHuOdpIDklqK0ZhGBa1Ip8ipAYDSUBJIEZkBFKwfd4x+rNsE
         2JT3CK5BX+rDhYRe1YETVjHH9mdQUSKGuDlIron8e2O7p1M+2W8Xv0noFDuvE22FuLq4
         nHSU+s8cDNILI6lVH9eyDfxW++XVY5WLw9Dmrx0tvFKKXeWxN+o08WY975cLdfG7tBtC
         YqZw==
X-Gm-Message-State: AFq9FYIOAzLxpwpuvmhlqAHcxFy6Wud3QLpZrSkQHnh/sfXDsszl/3mI
	VTRLoIa9iJrSPuPSY6XerQ2jaF81P52FtzXDxQbRRP2PcDPt2NM9/YkH
X-Gm-Gg: AYBFou1YI/7UZ1DTN3g47QT6LZ3Upyu2S2FUhNF4+QnsbqQk3qc2ABwiM92m0lGjKYo
	sMtB0mm3KYk9pnvrHh6yAIGjziWYsv1X9vvaLARCNYRZ36/CJoPehVNDOtbZuPq/1sDXiVJ+SHq
	Cm5GR6TZlriHa2eYMJBiMySkBxxTWlkmm8WRtp7PqQNLdQfpmpUdoLLX2pU4Jl5xh0mzkwYF1OK
	oCcOLlewjMppYGVdl7gIEFs1gxnazwfQ/emwFUhIT+xqvnto7OBMffTJ10Q3xZdU4FR/etjxUkg
	RgjwvXkuUbgFIYOIL1Px+PvckZwH88B61bMI0voeCzEcjNKea697xtpZR0t0cnBL7+YhaNUJsOl
	fNbrmnXnBd1tJxEiXGfNP42dKRo9pYn+fQUFBZeJS3YL+oY+A34Sygfa6lfwhf86ofIb27WE6hq
	grW8k+1WKyX9tMFAHy/RNlLBr17K2ni5tW9bNkWbeRXZeWP+rTzWb6/fFcwwitUzpF+bqkqyujO
	nRgko4A6yGzG0yy6w==
X-Received: by 2002:a05:693c:88c9:20b0:351:7444:8bfd with SMTP id 5a478bee46e88-361a2e2fe01mr10666792eec.39.1792408549090;
        Mon, 19 Oct 2026 04:15:49 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ab80f9sm51054961eec.12.2026.10.19.04.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:15:48 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: stable@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 11:15:41 +0000
Message-ID: <20261019111541.2063142-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 6.12.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
fallback when OoO is present") put the out-of-order queue check
in __mptcp_finish_join() instead of __mptcp_try_fallback().

So the fix itself is missing, as fallback still happens with OoO data
queued. Worse, the passive side now refuses every MP_JOIN while its
OoO queue is not empty, which is the normal state of a connection
already sending data over more than one subflow. The joining subflow
is reset, so such a connection can't add a new path, and a path that
comes back after an outage can't rejoin while data is in flight.

Move the check to __mptcp_try_fallback(), as upstream does.

Tested on 6.12.113 in netns: 6 connections (5 uploading) over two paths,
then a third endpoint added mid-transfer. Without this patch only the
idle connection gets a subflow on the new path and the other 5 joins
are reset. With it, all 6 join. Same result in 3 of 3 runs each.

Fixes: aab400cf8e35 ("mptcp: do not fallback when OoO is present")
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/protocol.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da774b1a..00997357 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -74,6 +74,13 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 	if (__mptcp_check_fallback(msk))
 		return true;
 
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);
@@ -943,13 +950,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
-	/* The caller possibly is not holding the msk socket lock, but
-	 * in the fallback case only the current subflow is touching
-	 * the OoO queue.
-	 */
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		return false;
-
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
-- 
2.43.0

