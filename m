Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD7231832
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005996; cv=none; b=pCvng66PJn8WflBcvnebFLgnfI/gpzCo41K6NhBNs0IhWyuoseOsEhYoopahmVk2oyRQivkiXMmJxdZHG/JPOQuXxyvsljlmtO8tcJmerE7KJZ0BUVqLlQf9HMN1hhWrWB+YkqUrc8l26eRqrMijrHz6uMcdKoZ6bs86XKp/cNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005996; c=relaxed/simple;
	bh=DEz0P9GssJ3vBU1q+8lqEbv/bQF4f/eGaiKLVs8Mnro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4JGkhMAipBzPd9uOyEsbsYrXFbNZFU/iEGEjwrv0QuGmGuoMnxoxGEMV1u+Csidp96lRAu0rtfCaptAjQiqM4eIsvrV7e+tf0yAEr6BSWNH7XYTHS5+GkiB5rBAuItEXa9BaYS9ZdW8xcAxLGl4pzqpwlVj8QL4vUw1IiHexro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9lU6yBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9lU6yBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938391F00A3E;
	Thu,  6 Aug 2026 08:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786005995;
	bh=k4bj4mpDpGWsqGh6Nevo5xHgWGWvKG0+OM9F+yiqC3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=m9lU6yBzvjAYXNZAl01LAXuTOaQC/Y6tw8F93a41pyMkOocVw6qEaJsQbMVs1uTRm
	 Zb+S7tZ5Of6kP88GwGv0CKfKO4Tuam+0569z2XlOnbZD+4f3iPEzNzDDPGEahnoU3u
	 P9ePD43bi4yKWNRpfw91LvG2c1e3+aaD6Un7bAuRjTUUXQwEiFhniFENhBj7wH+4bl
	 Mkr1VXtkCy/MlIrxQNZPnx0e1f4aBPghCKwfCW4UkHCNIUfyolsZ0cy/lHU12ha2Hh
	 On9mpZdzk4/sugJsanVdZbDdWLOoGaDhQRiQzx8lznJtxwia/CGvYOR6vficl9bheE
	 iDhGIB/X5fuKw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 06 Aug 2026 10:46:21 +0200
Subject: [PATCH mptcp-net v2 4/6] mptcp: pm: userspace: don't dump initial
 ID0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mptcp-pm-userspace-id0-case-v2-4-fea1808e1c57@kernel.org>
References: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
In-Reply-To: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DEz0P9GssJ3vBU1q+8lqEbv/bQF4f/eGaiKLVs8Mnro=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKPB93/97EeDAh68mCXR9O5LQp5Ultd9+6pEl8ht+mL
 8xcaw8zdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkbiojw+6lfhtig55deNXZ
 9q79SHGn4xfBxpR9k3jvrWB1+6J/nZ3hD99bm4aaebP52d+V+NUF/CrcoDYh7lSbvqB1pPHeQq0
 9rAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the first patch of this series, the initial ID0 address is present
in the local addr list when the connection has been created. Not to
change the previous behaviour, but also to have a similar behaviour than
what is done with the in-kernel PM, the initial ID0 address is not
dumped with the rest.

If the address is removed, then re-added later with a new subflow, it
can be dumped.

Fixes: 34e74a5cf3b7 ("mptcp: implement mptcp_userspace_pm_dump_addr")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 359ad5acd836..f6c5069e963a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -626,7 +626,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_userspace_pm_addr(msk, entry) {
-		if (test_bit(entry->addr.id, bitmap->map))
+		/* Ignore default ID0 & already sent */
+		if ((entry->addr.id == 0 && entry->flags == 0) ||
+		    test_bit(entry->addr.id, bitmap->map))
 			continue;
 
 		if (mptcp_pm_genl_fill_addr(msg, cb, entry) < 0)

-- 
2.53.0

