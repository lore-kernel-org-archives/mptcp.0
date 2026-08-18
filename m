Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4061147044A
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075743; cv=none; b=TF/v3YRkZzkMc4uZrSxpAA1bT0G6RnVvIqW2o9EgrWf6iQJQCEzGF6R/vll+LN4w1eB3qx2xJAbb9bhw284cJrdrTaebyxeR1p6uo3tKueCPJ/bmYffKGcczSvSgUeawkQHsnU9m77zf+UKRYbB0aAJiAB+cyWE8hXtC4+bO8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075743; c=relaxed/simple;
	bh=jFVWyC23oRSPwjt5CH4mJx4/5+6S7fiTDq5lmc6pUoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9VZ3WOqjbfApJsAUYhNM4OVteP0cOrGGamPnM6QVuOqi/RW2gt1jQF66TQn1rVvoNeeFHmFipGYVqwPCYpuDk6LwcePi+gcHTaGG2gHwQDGRQwQ/ATCrNsYWPhFJdJbtCGgH1HzmIDkbwf6rwhcGed4+gKWy1CvBPEjVI0x98Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxUbna84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxUbna84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B0C1F00A3A;
	Tue, 18 Aug 2026 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787075741;
	bh=GqbZpwn/1Jgx+RxeQVocy/9tRDSihrFf9oZt9UaXogM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GxUbna84G/1VK61l2xflSfBeuFLtBgCDtnYW1CqJaND3DzHKR8qcnxrWc9QeR0fgI
	 /4wUv5rvzoGMTkClWHK6QxEf9uw6f0i3G0OF/YrZh3HRjhyyxUoV2oVqoA131uKtdD
	 zL/4ytV6LrkT1ZspIh6pL2Me++ZfEvZfh5EfEgl6kWGl70mb6XItvgVESZ0VyVP1lP
	 gaKO2GHvUvSX780dT0xcP3cAc6B8GI/i5Ep9kT8e6Q0iC2x+g7pmwx+1ifKJ2G6Jzm
	 FNcyETOTCDBoA5W3pYsbVXZ7cdpii7Iv4kevSP4DBNBywEwgFFrzmNXYbl1yFS+Pdu
	 9rm35pnIdqPmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Aug 2026 19:55:25 +0200
Subject: [PATCH mptcp-net 1/3] mptcp: syncookies: remember the request
 backup flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-mptcp-cook-reqb-v1-1-052dea9a7f20@kernel.org>
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
In-Reply-To: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jFVWyC23oRSPwjt5CH4mJx4/5+6S7fiTDq5lmc6pUoQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJa5sw6fmbOGYOcBIuGtDlq8guXPjuZNKfjnLLhjy3ve
 jbOVWFV7ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI1WZGhv/K/Cm/dtgwGrUz
 J3see3Hr7JMj2nqcWfce7udR2iNRwsbwT9dfX+WST03MoRU/Uj8WKG55IhSZX/Ncfqspz6IPV15
 mMQAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of using an uninitialised bit when copying the info in
subflow_ulp_clone().

To fix this, no need to extend the join_entry structure: backup is
coming from struct mptcp_subflow_request_sock, only one bit. Do the same
here by using one bit for both.

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in use")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Sashiko: yes, thmac is also copied in ulp_clone and not init in
mptcp_token_join_cookie_init_state, see the next patch.
---
 net/mptcp/syncookies.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index b5cac5701122..9474706641c1 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -26,7 +26,8 @@ struct join_entry {
 	u32 local_nonce;
 	u8 join_id;
 	u8 local_id;
-	u8 backup;
+	u8 backup:1,
+	   request_bkup:1;
 	u8 valid;
 };
 
@@ -63,6 +64,7 @@ static void mptcp_join_store_state(struct join_entry *entry,
 	entry->remote_nonce = subflow_req->remote_nonce;
 	entry->local_nonce = subflow_req->local_nonce;
 	entry->backup = subflow_req->backup;
+	entry->request_bkup = subflow_req->request_bkup;
 	entry->join_id = subflow_req->remote_id;
 	entry->local_id = subflow_req->local_id;
 	entry->valid = 1;
@@ -117,6 +119,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->remote_nonce = e->remote_nonce;
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
+	subflow_req->request_bkup = e->request_bkup;
 	subflow_req->remote_id = e->join_id;
 	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;

-- 
2.53.0

