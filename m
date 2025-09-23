Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8122ACEB
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619989; cv=none; b=PLzhUSFD6vC30ZE482pElDimA60tIDwxpEPRr8RWzeQl2AH6GR37hiYPcrfOOPw9JWV1eySiXde2X80AB3AMwV4FqvdUpLu4/rfT+rsCJTcAb1JAkJSN+7f9/LSyDnFXavRujTW0bdlFGx9G7s6iUBeFBOW24A9468fcm6kHV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619989; c=relaxed/simple;
	bh=2/0PjhEFbIJRwQxqp5w/H2uKVwclF8Nq+lpJHWw53ZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVs33v/URgPr151c+N03rJMl2ZdkTViCudnPaUeac+pF6Dm3sd1s4QV2LNkU2x9CNapwsWKZCAwPVxjlD02hAJd6+POxz/7H0HW9yLaZqv1jtbuKbvTpRAeOvrJ2A2v+RsZFrUm8YIL2fB+6iiwtpdNCZJcL41j7728MHi4u2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd9hV/8X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd9hV/8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5CBC116C6;
	Tue, 23 Sep 2025 09:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758619988;
	bh=2/0PjhEFbIJRwQxqp5w/H2uKVwclF8Nq+lpJHWw53ZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gd9hV/8Xn//5mmo/MVijjPnOXPPmIKwDem78wHRISJ+yvNmevCTSZatQRheIfoiLe
	 7gJIP9MefkMZhATlqhAuIvAGvtU4aZfqXOQv0V87FmFwS3VJZWiYxGmVWc+CBh5d7e
	 d8M6uyU3TwX85922pet2pD9bB4haE99p0Vv/4sbJ8wchZy7jCRZ1dwY/jOOS7Dzbhx
	 dR1p4VRVocKFbw5xHzQRMcN4oIZ/vPpHFg9ApRB3lrBu5oEH/BwRdm9+FXsYBNXfsO
	 uQRIwvP8s5/jYXDZGhigyaXoVcDcL7F8+Sow9pIrmLn3pmLXZGrNjR1qTvosvxC63Y
	 eStfbKDYrY6Zg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Sep 2025 11:32:50 +0200
Subject: [PATCH mptcp-next v2 4/6] Squash to "mptcp: pm: in-kernel: usable
 client side with C-flag"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-pm-kern-endp-add_addr-new-v2-4-ee5369dad569@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
In-Reply-To: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2/0PjhEFbIJRwQxqp5w/H2uKVwclF8Nq+lpJHWw53ZE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIuZfrO9Nz7/f4m44v7n229nMLI+NpLp/jTkjTBxbcY9
 t/edLpTqqOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiWzoY/grHPLy+Y2XMqf0a
 OTdji9/bhf/1M3vh+s3Z5OobuS1VVjcZ/mnKP8k1D7JdoOVo92iyxoVLl3aKz7yRbuF1aN3jw4I
 OcSwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this special case (fullmesh + subflow + c-flag), local_addr_used
should be incremented for new subflows not involving local ID0.

Similar to what is done when receiving an ADD_ADR in the non-fullmesh
case, or in the subflow only case.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index aaaa684d86239fbfa4e237590fc274fa9b7b0347..116d62ed86f78b0242a33a67f77ff875ba00ae30 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -431,9 +431,13 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 		local->flags = entry->flags;
 		local->ifindex = entry->ifindex;
 
-		if (c_flag_case && (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		if (c_flag_case && (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
 			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 
+			if (local->addr.id != msk->mpc_endpoint_id)
+				msk->pm.local_addr_used++;
+		}
+
 		/* Special case for ID0: set the correct ID */
 		if (local->addr.id == msk->mpc_endpoint_id)
 			local->addr.id = 0;

-- 
2.51.0

