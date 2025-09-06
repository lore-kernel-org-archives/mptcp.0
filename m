Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA91367
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168458; cv=none; b=BKEiDkmmU48u/gLtsJXH2TBmgiVwBVRh0x5WbLg/eBnkpeCz8inpDOt9Pwb+EO5lfKqm16yboa6Hn9+NUPLRdrnQNqVAwuJQ6UT8DtJMdaT4KLeQ9kR10Wxsfqq7mNKepgOjp/BbouJuJrf3yqFY81Jo/umNiTSCHPsYQ0gJcAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168458; c=relaxed/simple;
	bh=MVQtWHz+K0vX1k9e4a8kJB1ru4ueC2ceKvHslBk1V08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FBWRPBUjxNMMQOB6DwmKbBbkjvWffF0JPQgJyCOw+ptwo+t+dYqTaCSnTdPre3DQwTT8xLV9FpBHu6WXgYo1AcH7ZkYIUG127a8TEo2yKEVsg/w4t6dG8ntU8xrd/FicpBwtbtQbSwUq5j+c8QbligXYVnVq4domAYx9yU5QYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCRKl6AX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCRKl6AX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF10C4CEE7;
	Sat,  6 Sep 2025 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757168457;
	bh=MVQtWHz+K0vX1k9e4a8kJB1ru4ueC2ceKvHslBk1V08=;
	h=From:Date:Subject:To:Cc:From;
	b=KCRKl6AXG4jSCvXgfZPqQl23E40Lko/IsZb32G8l3+LfLhii0vFHBT9iUWC2yjk1+
	 7L5eZtkDbchdb8hRgddwATJp0fO9sCbOlSVU8WvQmv3LS7y47aHoEcSum4SHdUNyIB
	 lR98mVPZm0xlv0Pztz2TnihnL640hkcP35SK5G2m+sfgYDLWJb3MlJohZs4KxHWjaH
	 HZO/Hbo2sUq78pi+dtivh1fKN0e0CSCE2XhdfKUjBbFJ8/mAoEY0DtY247vXQ2P+xK
	 wDzIDoeD/bTuI2wR6CWXSEX/ilm8z3Xw9st0jUmNJUlnZEELsF5gMWdq+sZ3flQ5qf
	 DCQhiJz9GcE7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 06 Sep 2025 16:13:08 +0200
Subject: [PATCH mptcp-next] mptcp: remove unused returned value
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-check_data_fin_ret-v1-1-2c8100bc20eb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHNBvGgC/x3M0QqEIBBA0V+JeU6YZHPdfiVCRMcaljVRWYLo3
 5Mez8O9JxTKTAWm7oRMfy68x4ah78BtNq4k2DeDRDniB5VwG7mv8bZaEziaTFUoL/VreKPWaKG
 FKVPg45nO8EvVJRHpqLBc1w3a6NodcAAAAA==
X-Change-ID: 20250906-check_data_fin_ret-6d284170880a
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MVQtWHz+K0vX1k9e4a8kJB1ru4ueC2ceKvHslBk1V08=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2OHv4rT2jaihiqvq27LpV1Qfn36zTNvqfO1sTpcr7J
 SHxatO0jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlcd2Fk+OGTt37ri8e77tdE
 +LeuC/wTfLHuZ0sZQ95+p4sCuza9j2b4Zzt1sUXYcbvLv69VB/716rjBUcTyIfOAiUbyXrWw6ZP
 0GAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When working on a fix modifying mptcp_check_data_fin(), I noticed the
returned value was no longer used.

It looks like it was used for 3 days, between commit 7ed90803a213
("mptcp: send explicit ack on delayed ack_seq incr") and commit
ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").

This returned value can be safely removed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1c26acf6c4145896ecbb5c7f7004121c66a20649..f3dda47ad1d70b5c6a326c17dbe6d244c5638ca2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -530,11 +530,10 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 	}
 }
 
-static bool mptcp_check_data_fin(struct sock *sk)
+static void mptcp_check_data_fin(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	u64 rcv_data_fin_seq;
-	bool ret = false;
 
 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
@@ -572,12 +571,10 @@ static bool mptcp_check_data_fin(struct sock *sk)
 			break;
 		}
 
-		ret = true;
 		if (!__mptcp_check_fallback(msk))
 			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
-	return ret;
 }
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)

---
base-commit: e9091ee333eb716a0933dcb08617228dcd3d3623
change-id: 20250906-check_data_fin_ret-6d284170880a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

