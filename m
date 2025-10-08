Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13E16F288
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932017; cv=none; b=qKu5wpQC/glrUIPbDPkfqZW7pQqz5LSu1MoZSiI8gf07wzyfSmgKv71LCv5TBl9vUVeRkITCRZWrUWUB8Kn1bUOGcb5S5Pk9pWpi2irE63GTrjkRGMEcmF06eEkgfttl2KOIVmBvoVQtDg719KaYNLOQh9twWOP49zcdmLfps6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932017; c=relaxed/simple;
	bh=fq9OolGGmsel86BAhF5n0MmVu/U4DAXphDJwxa8Ih4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLgnHf9bkw9eIVRJVYAWl4cNRkDykji0QhLzLJcfps/ROEAxV5C3kmFDdI51Cgkp459nd+Jq3f95tQJxgfWq2eDkVqMbxdxn6miSCqxexUe8IWTAKE7FBtbD1xUnTj/a1qhWeSkxloKYHIJMTLI/BMA4ukX8pAwU5oKC+LRju+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj0lrf2L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj0lrf2L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F8AC4CEF4;
	Wed,  8 Oct 2025 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932016;
	bh=fq9OolGGmsel86BAhF5n0MmVu/U4DAXphDJwxa8Ih4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qj0lrf2LeWMhGlKpnWwyfQJKeHtpldnYCcO1aKIujLtLgpTwJtWz/ODrxYb21XV0n
	 nN357GVUvbe4nDt4/kvouTuPbAOFitFSXzqa8D7DM77z+wOKKrRtSqOFyvJoyXfm0d
	 9GnzrrIssWgePjIwm40zzgYQETaUYGznT/jentiURWYa/BLDimgzo1zdFS5M4m4WjK
	 Qh6wGStox3xz8kWrZOXwIAoVIZ0V5lcFVD4wWaDyKdaLxY1ZiAfqUBE+mwTxqPHwWy
	 nqCkZYGZdRPD+DcJj7AzlV1tER2hU0al4IP+7iJRglvyUGsXj0ShuurCNQoc3T2HXX
	 F5J7wsmRDrVBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Oct 2025 15:59:55 +0200
Subject: [PATCH mptcp-net 1/7] mptcp: pm: in-kernel: C-flag: handle late
 ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-c-flag-add-addr-delay-v1-1-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fq9OolGGmsel86BAhF5n0MmVu/U4DAXphDJwxa8Ih4E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKe5aXb7Zv/5fL6oCSXva9jnn1ji7fJ55VMmx5+7Mrzh
 Tw9D+f/7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIB2tGhjVz2jkutH5NjDrT
 wBVn1/BRofSQ7NqGZ2lm9Re3tj5TjWJkeKegfv/d/LU2L5iq7nDFzckPUG7dz9yZqrUmVKWToWA
 WEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The special C-flag case expects the ADD_ADDR to be received when
switching to 'fully-established'. But for various reasons, the ADD_ADDR
could be sent after the "4th ACK", and the special case doesn't work.

On NIPA, the new test validating this special case for the C-flag failed
a few times, e.g.

  102 default limits, server deny join id 0
        syn rx                 [FAIL] got 0 JOIN[s] syn rx expected 2

  Server ns stats
  (...)
  MPTcpExtAddAddrTx  1
  MPTcpExtEchoAdd    1

  Client ns stats
  (...)
  MPTcpExtAddAddr    1
  MPTcpExtEchoAddTx  1

        synack rx              [FAIL] got 0 JOIN[s] synack rx expected 2
        ack rx                 [FAIL] got 0 JOIN[s] ack rx expected 2
        join Rx                [FAIL] see above
        syn tx                 [FAIL] got 0 JOIN[s] syn tx expected 2
        join Tx                [FAIL] see above

I had a suspicion about what the issue could be: the ADD_ADDR might have
been received after the switch to the 'fully-established' state. The
issue was not easy to reproduce. The packet capture shown that the
ADD_ADDR can indeed be sent with a delay, and the client would not try
to establish subflows to it as expected.

A simple fix is not to mark the endpoints as 'used' in the C-flag case,
when looking at creating subflows to the remote initial IP address and
port. In this case, there is no need to try.

Note: newly added fullmesh endpoints will still continue to be used as
expected, thanks to the conditions behind mptcp_pm_add_addr_c_flag_case.

Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with C-flag")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index da431da16ae0..df2bc36593d0 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -370,6 +370,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 subflow:
+	/* No need to try establishing subflows to remote id0 if not allowed */
+	if (mptcp_pm_add_addr_c_flag_case(msk))
+		goto exit;
+
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < endp_subflow_max &&
 	       msk->pm.extra_subflows < limit_extra_subflows) {
@@ -401,6 +405,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			__mptcp_subflow_connect(sk, &local, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
+
+exit:
 	mptcp_pm_nl_check_work_pending(msk);
 }
 

-- 
2.51.0

