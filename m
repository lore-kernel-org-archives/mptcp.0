Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024D1A2398
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781482; cv=none; b=bcJKJQlwh47aIIrl7JQcCkdi82kONygP88l+wKFrLdZGO+YHJUydRN1S3PhVcXiCdJA1O1zwTK7rVWFI+Ulriiyvm0QIuyDmPvSLuuYj9jTtgq2RGn0Y51qlDkUc3aLzXbzLpuMbWGpOMtiLzmjSNuxZ7uLLXY0+ZsPxiQi59f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781482; c=relaxed/simple;
	bh=jTQZdhnD4SDNeCdoABo6+2QrCmcs9b2jVmYynAo2Rew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OnnyUxiE2jL2ZolPYuVip7PM2ewzXxVVQDySLhYV94RBEEz2ulkrsPTrkUg7NULC/fbL0CsEFOsQKQ03Vpt7uka1ytALv+U5qAAo6AuIqjsSum4xY1mBeZao7E0jLYDmZlOXemu+lewhCGf2OyJys1VBAPhg4H+BdTSfocKmk0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NikmajNk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NikmajNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A337C4CEE8;
	Mon, 17 Feb 2025 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739781482;
	bh=jTQZdhnD4SDNeCdoABo6+2QrCmcs9b2jVmYynAo2Rew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NikmajNkOWNUQsquqqJFPJNXoJ2UN/Zsy5jiDHkN5Wuyzfw2468vOZezYacGnU33k
	 XDtQLVb6ooULiKt/hCiITuxtRbugczQbpIo2JgPhMjUdExKmyob1eFDzb99H/o8Tvl
	 1RjPNLpnNys+zfvBK2pNO6j1a2N7eBlLv9z/LOe8OHxthUzRG5RCOjpfX/8diswUw6
	 P1V/LW2G4gla70O9ZPn6KBU/0z3EAI2tq9L9hrclCr6+E89mSzKMktlZ0Dr/M0X+to
	 /nb3vRet0NxiwIeb16jNGg8o/vW2vIVieBx4v+3Gmxe8UsxHpJ1TSk+OR+i3hjkN1y
	 gK4BbEcADI1Hg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 17 Feb 2025 09:37:43 +0100
Subject: [PATCH mptcp-net 3/3] mptcp: safety check before fallback
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mptcp-dss-drop-mpj-v1-3-d671d6b9a153@kernel.org>
References: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
In-Reply-To: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jTQZdhnD4SDNeCdoABo6+2QrCmcs9b2jVmYynAo2Rew=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnsvVkmbT3kiqs4Vj/gOZLZUE86/2raP785fruK
 nD2Kumy+N6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7L1ZAAKCRD2t4JPQmmg
 c/wmEACvw7aCMTCUgN9en/W2dnNrDRJ+TeHDiNfbD85nKcPlK/JO7huIsccEs6Uy1BEg0r546gD
 Zj1hbFKa8CqkSL9MLghnW2/qJWx2nicJheEVjMSYFmaN4Ihp8PVIv8tovV3jXHeJwYPBSP3WtAK
 +SgPmgzNA371wqc989nAMn15e/Z2D4yvu5AKXm/Q0S2OEmQPHSFBg4orKlZxpwdE9TiCpKbJeHB
 RexRvqB6CvyDO87Hiw6K6KKORGKMQdue6Qj/RL9/riPzW2CB2q37BBTxrvavd8lO9oZLkF9iPfq
 7Nhuc/M06+7D2wziT98D3stxZtRVCbcgRwvKe8VV9Dlb0p0SYCoM5jXur6nJemp9Sd+sup7MJxI
 HAL7jAaRAGKDSRD5aUicmMc9hBOP2e3h9l7eZav7sxaOjzK5mUcCB2IKBgvFG+ogWTGpXHxhN4D
 8yrPq51TG7TN+hxkux/6H8hi+fAZEkW46b17m5hhnpvKSSDP/K7MEf6JXl4CNAHl3dcMFR/T3Zc
 ZAue18ro0odwugiAUnzmV5or8ld6aL1ypiDV6kBH5XBON0dP3MStmEBL1ksFT7D6g3Y/hizDglU
 thdjxCxPy4WyelH9J450nSaMGYVa7KETdeBeKFWl4HgI5cX+fOCcfQGV9QHDRlMfQpKfUZI+dQC
 ZiGEDS2QAPeXTnQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, some fallback have been initiated, while the connection was
not supposed to fallback.

Add a safety check with a warning to detect when an wrong attempt to
fallback is being done. This should help detecting any future issues
quicker.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - I guess this patch could be sent to -net as well.
 - We could also squash this in one of the previous commit, but because
   the two are needed to avoid the warning, maybe better with a
   dedicated commit?
---
 net/mptcp/protocol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bac5c925a72f6637e33ada9869984c5902bd6a43..3d72ca1553227cb41ba8c205f42d1f01cc264a7e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1198,6 +1198,8 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
 		return;
 	}
+	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
+		return;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 

-- 
2.47.1

