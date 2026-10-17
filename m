Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7A47F3C7
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241205; cv=none; b=iumlkOdHY8H+RJrXDzUbXYrh5BGOZxcQgA1viyNELSvZIzHEkUhRUjv6SlFQIgwLkp1KVDRHogdCP/nf+a0JhzI5UFau3XY17HmftBO3CnHxA//LseTBbrX6TorlZu78THrCTLVp0xbXa6zuVtGBICnM919roXfv9w+7bxDxsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241205; c=relaxed/simple;
	bh=+GjVNuZ40ZBG7BVDlcel55l6onc9avfrCeR0eBUMbl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xehfz0TQRgHn2YzhrescB5GUiDYMT8p1EZLpCiQhIGR5CjkWRNADsS8QvZZ6jVnYgjHFpKAxOB4PXv+hRgW+8JCryiSI5jYCm3rTH86gEPWD3D7Mt77ywbe8jLJEduT5DdZ2lEptyOjbchJbIc1asaYVPd+kQCvMWS6erZMxAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUzEWizT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUzEWizT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43DDDC2BCF5
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792241205;
	bh=+GjVNuZ40ZBG7BVDlcel55l6onc9avfrCeR0eBUMbl0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dUzEWizTbrhlJL+0LrBLICu7EPN8DUKorV/aZVemRU+q831h8YVPPUD+TJgRn+waF
	 v19Wdnzi8oDDc1WsSrGsO4nfcS/7Tao7XOiIlCn3QY4Rk24QjZkjw2ocg3PJvMNzW1
	 DbkMpDxSaIuFOQFONcx5iFxNsGG/JS9yIY96FEhgWLPrtrSzHfHtx/5JMkaCX8zTVo
	 NT6GT4EaYhUJil9KN6TUfHYLHxPuqasyQCK1Cs4NXWFsrmNFdyPDH6HxSVAttWlzME
	 PWUIL1IheN8sKpECn2XYZFpw0a1oA6yLzHZNubczb0Va6tzwdJPNz0LsKohZ4vn1ea
	 KH1J7GrlIxjFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C1DCCF2C7
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 12:46:45 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Sat, 17 Oct 2026 05:46:42 -0700
Subject: [PATCH mptcp-net] mptcp: push pending data after a sendmsg copy
 fault
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-fix-mptcp-issue-640-v1-1-50a7bace7d43@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kBiQyxeRbpoxtFOoTFkYimId
 2+sy8d//22gnIUV+maDzB9RWWIFe2mAno84M8pYGVrTemtsh5N88Z0KJRTVldE7g+S6QObmwnj
 1UJ8pc9X+1QFOOXKB+znpGl5M5ajCvv8Adh4uCoIAAAA=
X-Change-ID: 20261017-fix-mptcp-issue-640-c47bc084bd36
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792241204; l=1554;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=BZQcEIK5odqd77DaV+ORXYQi6bbhxS0Ut7pU2pUkSKc=;
 b=oP9E23Yodx6pUoAr1SMzz0UTCMaPLOW2RbNUoes/eMQ4Kg4hXbeANUEUg6nv1ANnCjY/PI7Nk
 Gm7boeGsBwwA+0y1QRIjRDexW3ODk5wcxgmE9zsDIbzssoHClN+Ci0l
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

mptcp_sendmsg() copies into the msk write queue first, then
__mptcp_push_pending() on the success path. tcp_sendmsg_locked()
does the opposite: its do_error path jumps to out, and out
calls tcp_push() when copied > 0.

A later iovec fault (copy_from_iter / -EFAULT) after a successful
iteration therefore returns the partial byte count but leaves the
already-queued dfrag on rtx_queue. No subflow packet is sent, no
retransmission timer is armed, and DATA_FIN stays blocked on
first_pending.

Push in do_error when copied is already non-zero. Do not move
the push to out: copied is a size_t, and sk_stream_error()
stores a negative errno there.

Fixes: 69800e516e96 ("mptcp: propagate fastclose error")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/640
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 05c38564e8fd..f72e0e3d2619 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2129,8 +2129,10 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	return copied;
 
 do_error:
-	if (copied)
+	if (copied) {
+		__mptcp_push_pending(sk, msg->msg_flags);
 		goto out;
+	}
 
 	copied = sk_stream_error(sk, msg->msg_flags, ret);
 	goto out;

---
base-commit: a22035be824449c4921ec406f6383089016a628c
change-id: 20261017-fix-mptcp-issue-640-c47bc084bd36

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


