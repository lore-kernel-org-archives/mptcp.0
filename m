Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693183CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391885; cv=none; b=qvU6TQAiQdBJ88CQb29ho+IUyH5HP4dv5AkQA7uWb/9vFjHmezPQGr9LYw+RAMa3Kjx+XUIYYF7kc0UpbP+ABFpN/3Gz5fSm8HeUMACHYjuVwx0g6RtkzTRN2cGthYzTiuEsHhg49EJBYzBWcRY2Uhg+tKYGqn717sMVRQN5AmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391885; c=relaxed/simple;
	bh=oSnmMLYCpUNY0er7kFjeah3ZncChkhJj3qmtgH+CoJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mttUn6v1tUwF2VrVfXf1aDlNfuA6kBIMY7q/Jjf2+lahm5e/rPp8LBRqzqcax5nI8I3t6UFe4BKzzJZYirRdS6D4syanZwAjeHm8G1p/HpcVZ1BYHgxVX+eJW5j3wjC5Wzu63NmNmpmNEqZH27RYOZLzmkIy8EAgLr/ADJlYgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmKfYCbK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmKfYCbK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FA1C4AF0A;
	Fri, 19 Jul 2024 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391885;
	bh=oSnmMLYCpUNY0er7kFjeah3ZncChkhJj3qmtgH+CoJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mmKfYCbK0TAhHB4rQgWTP98v8+h8N2tGAgxXulkZsFTtD3xYrskv7XgvZv66V2jqg
	 1QH0A8zYJ2r+p0Yy0ECj5VrS2BE9LzHCkToUgzxax3zlQzjyhclw8cipvncABzO7Oy
	 5v+sxs6pFZGLH/FiEmtdH18wYRNJH6iNGjCTez9BT1Mfx6fnr5+Jbx4sfK6o+fL+Rx
	 OkQoZz4SRJxp5hsneWB/WpUVhOLAOyIVaDWc1Br6E+oZDWx5965hqUnQFV9eZHr8ej
	 Svrb+2QNTvRElDsJJc+ioq9FZuFJTnZplp44/d2JEfNx1c7oPPnnze54UXFnKIjW4K
	 92xZVbvAsF4Qg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:21 +0200
Subject: [PATCH mptcp-net v3 10/20] mptcp: pm: re-using ID of unused
 removed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-10-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oSnmMLYCpUNY0er7kFjeah3ZncChkhJj3qmtgH+CoJ4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsAN8CLPBwNbU23zwczKQq7Z+GbB9JX5blZv
 z6efm8fBGWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 czYdD/kBlTtMm/qSGipWha7cETfcdDmckMkOQaGfLLlCVzL0eFQW9iELsgEz5roVTGzReHane5T
 PTZpYTuhMdDcoVIdNVdugmMD2jeoHwohf6WBMxqzbjFoAO911p7671h4MpbB6cQp5rTweEcqKgI
 +xF5AlWh74kNGvyzR5a2yhxMqITGBz6rOa1RSK1Pfn2HrQfW1d9Y7ghz2TPBs3JfDbLP56ucjMF
 +bDOWnDno16amP1yA0iC0PCJv7x/8RZyEd9vIphtLnP2XB2DcFRebRRPw2zL7XcAV8GwKcQr1Z1
 fF4TxNX+y9nmrfgEpWQ5UH7x2PapPwCsUkO8GaloAumDrZui/cYPbhSKcQ0s1UknXd16zfDRqBF
 m5nEw2omQEiwmUQsAxcTOc3GXjjxlF9t2s5gNjsUSbkCzNV3dNDsk8MYGEjAULJWdsi8++zcJKo
 yTy6Du0Kmrj93A9Z3BxOW10zCix+VQdvpXk69QGUXBLgqQSRmeHI128A1qcd8LMqPWHjt1bAyuD
 vXWsSRw2UAzDLYULjX9+KQK6xZLl+J0ZxqBfEE5T4pIxD1nhiyrcQ/bZjGnNy+3djBmULW029eN
 7kWSFDIrsouqjytItdrMBeavTgpW6AeuwfcTocNz1VxT43LKpemmkWrx07a1IBsWnTiaIJC5jwz
 2Rku8Omy2qDzF9A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflow is attached to the 'subflow' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the 'subflow' endpoint if
no subflow is attached to it.

While at it, the local_addr_used counter is decremented if the ID was
marked as being used to reflect the reality, but also to allow adding
new endpoints after that.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v3:
   - Add new line before 'if (remove_subflow) {' block. (Geliang)
---
 net/mptcp/pm_netlink.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d44d318dce03..bdbf27fe89e0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1454,8 +1454,17 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
-		if (remove_subflow)
+
+		if (remove_subflow) {
 			mptcp_pm_remove_subflow(msk, &list);
+		} else if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			/* If the subflow has been used, but now closed */
+			spin_lock_bh(&msk->pm.lock);
+			if (!__test_and_set_bit(entry->addr.id, msk->pm.id_avail_bitmap))
+				msk->pm.local_addr_used--;
+			spin_unlock_bh(&msk->pm.lock);
+		}
+
 		release_sock(sk);
 
 next:

-- 
2.45.2

