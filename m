Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78C34A79D;
	Sun, 13 Sep 2026 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295425; cv=none; b=fz/HSkgBNU0wa5UjtcVRQyRlmYwmUvl38QU8yvg/5b/bp/7vknav3C6KeDqk4zxFiAfr87EDEJ+fwghCelovlIBNCPBjJA6b44E91chWZI8chq4Ep0YMjaIEyrH40pUAHFuQvxm4fR/AmWCnU+8aTkefZJxeBYe7PtMxru7MNFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295425; c=relaxed/simple;
	bh=ngCDj8Emz3p32EELUtISMOwDZrHYeIZwMySzMY+65J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BJj/mto/Ktlq89LY6c15/RN9yTPr2fpq8PXUelmP/2+UWkVQ3hhlY9udlDzXCIw89MdxJkOwzggGYF/pfuHw40wQC1VpbU2vdCouyUPE9peVEAAT4LCgEYxiC8W6NLVsllj8pfqqSbglJN3SgJcTt63W/nfisYy+eLOsMl+CxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj/94uDh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj/94uDh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7494CC2BCC7;
	Sun, 13 Sep 2026 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789295424;
	bh=ngCDj8Emz3p32EELUtISMOwDZrHYeIZwMySzMY+65J4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qj/94uDh5MMmNZHdT5ndhFtT9gGUmofzZeqyAwYWAabRyNpJbh+3VXeYroEVIyr/L
	 eK63bu89IzoYAfzqDgfzuRDEze8SaiS1IKAvWONtkGsqRuYuOrJPkL8JKfM6PM3Oeq
	 HnpSvl3bgndDt8752AGa2OJKIuy8EYGjZEG80/fhXRjiGTR3L68MSC2913b+t0GUQM
	 NmCmQjz03xwe5/5Rt+kA8XHb/nLfdZ/FKJwdS603BG62mhGEl7vi4q/YWxQa0H5iHE
	 k6tn2ptUz4ecPXj/3ECw36GQoYbioYBrLd2EDzVac36sTCcy1MWY+nQoSCR8KJNdrH
	 0G+sVWQ1+XHUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E120C88E56;
	Sun, 13 Sep 2026 10:30:24 +0000 (UTC)
From: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>
Date: Sun, 13 Sep 2026 10:30:05 +0000
Subject: [PATCH net] mptcp: return sk_wait_data() errors from recvmsg()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-b4-send-mptcp-recv-error-v1-1-4eaa3684a8b8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC17pmoC/yWMwQ6CMBAFf4Xs2U0KqAF/xXCQ5VXXxNJsKyEh/
 LtVjzPJzEYJpkh0qTYyLJp0DgXqQ0XyuIU7WKfC1Ljm7Pq65fHICWHiV8wS2SALw2w2hne+6zu
 4kwiVPBq8rr/1lQIyDX+Z3uMTkr9T2vcPxYYZLIEAAAA=
X-Change-ID: 20260913-b4-send-mptcp-recv-error-ef0f898e05cc
To: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789295423; l=1552;
 i=markdamirkan@gmail.com; s=pscsi-20260818; h=from:subject:message-id;
 bh=nFns6QPwNtc6ZlWxL0DfCPRqrLoyi61MO8NmnrCReZ0=;
 b=zUnCB4O2oj2YTonWyuK6Qcw/TnT5pXlznkPJPKBbwLfP6dmUgoy5JYhplV6fjLQ/c/NfTunoJ
 yPRzcwrZ8Q8A6ln++W+b0owuF5pCAcU12geosagpf0liSbGaRVjlZH4
X-Developer-Key: i=markdamirkan@gmail.com; a=ed25519;
 pk=/wb49ibt4gZFDncmhFQBYtjPvzT1tfJtvK4Mqt1P2Wc=
X-Endpoint-Received: by B4 Relay for markdamirkan@gmail.com/pscsi-20260818
 with auth_id=961
X-Original-From: Mark Amirkan <markdamirkan@gmail.com>
Reply-To: markdamirkan@gmail.com

From: Mark Amirkan <markdamirkan@gmail.com>

Commit 581302298524 ("mptcp: error out earlier on disconnect") made
mptcp_recvmsg() stop when sk_wait_data() returns an error.  The error is
stored in err, but the function then jumps to a path which returns
copied.  When no data was copied, recvmsg() therefore returns zero and
reports a false EOF.

Store the result in copied, which is the value returned by the function.
This also keeps the usual partial-read result when data was copied before
the error.

A recvmsg() blocked in one thread reproduces the issue when another
thread disconnects the same MPTCP socket with connect(AF_UNSPEC).
Before this change recvmsg() returns zero; afterwards it returns -EPIPE.

Fixes: 581302298524 ("mptcp: error out earlier on disconnect")
Cc: stable@vger.kernel.org
Assisted-by: Symbolic
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0098e28309..8dc25ef154 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2459,7 +2459,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		mptcp_cleanup_rbuf(msk, copied);
 		err = sk_wait_data(sk, &timeo, last);
 		if (err < 0) {
-			err = copied ? : err;
+			copied = copied ? : err;
 			goto out_err;
 		}
 	}

---
base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
change-id: 20260913-b4-send-mptcp-recv-error-ef0f898e05cc

Best regards,
--  
Mark Amirkan <markdamirkan@gmail.com>


