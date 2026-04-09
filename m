Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9D34104E
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767941; cv=none; b=RTLkF2rLUqpdRWt9HnX9ffrC3vJZ06Lb409heVhdNNI5+fpYdrNU7dPY1hzg/+fbOl4VniXW38o5fUk3Nmfu9u4Rac8dP8upJ/tkbPo2wOtz3KS2iv+dp+ymHTmuRS9etjk2HyY8aexNlGd4QLZjF6MTvkX8kZRDqtUW23STq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767941; c=relaxed/simple;
	bh=rg2sXC1Art2i0kFN50i563//GrJ1M15JsZXb3hbhYjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoazlRDA7EKxGaHHe8upr3gveiKPzBcZFi3B3MpWjn3zGKx/vlbTCLTdJwrdWjIbxRRzlldm8+tFexjVnooE3kVKmfLNZzBnGTFZeFYLgegOEuxFyHk5O3V/erRDDD7pAgO/3xl/GaqKkTjPVDdS/zmQoEtkxz16w+ZkDDGsd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFywFGaR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFywFGaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74196C19424;
	Thu,  9 Apr 2026 20:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767940;
	bh=rg2sXC1Art2i0kFN50i563//GrJ1M15JsZXb3hbhYjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UFywFGaR5gYYPeZEJHqUDxtj2Iour9FjMD2C6/PIJ2hNHn4S/aSV6siRYXrgCkH6R
	 t5K5wUuJAszEMXksER9y/6cXp45bSZLjuEeuIHFe3KiGtifpQjkaNnr2ZO00lpXJ+2
	 XAgwVfOILfH38yYf36Ewivd2JTNCBZv/0sv1Rw1PlMGmW6e6n4lcZLxxtDGzRgq9Qo
	 c5JG7Nl1i0Q43UJvmtvcKQ3P4gDvv7MsVvCkEYQ8WVjpyMme73cT933LJ1/aQPNNQ3
	 XQOmVy2XowGnRNouH3b0IJNCF04SO15gmI5nfnJqnuE75Y98EllfRjnuItMxgV3IaH
	 63rhYEq/bHkqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:51 +0200
Subject: [PATCH mptcp-next 11/16] mptcp: pm: in-kernel: increase endpoints
 limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-11-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rg2sXC1Art2i0kFN50i563//GrJ1M15JsZXb3hbhYjU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCJaLrJ+f7P3KJMj6oY30it0rVXma0ypbLwUFxcuVT
 5yw9eaqjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImolTMyXFy+ta2j/xTrvzql
 1unbSupFbEVUolL0knZJ/Tv0LGIODyPDbV52/ie1h1b48fHv2PKy/c9OvQqW63c/F+oWn/rgfm4
 BCwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The endpoints are managed in a list which was limited to 8 entries.

This limit can be too small in some cases: by having the same limit as
the number of subflows, it might not allow creating all expected
subflows when having a mix of v4 and v6 addresses that can all use MPTCP
on v4/v6 only networks.

While increasing the limit above the new subflows one, why not using the
technical limit: 254. Indeed, the endpoint will each have an ID that
will be used on the wire, limited to u8, and the ID 0 is reserved to the
initial subflow.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 685bf2b9f9c2..ee92a9a127c3 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -743,7 +743,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	 */
 	if (pernet->next_id == MPTCP_PM_MAX_ADDR_ID)
 		pernet->next_id = 1;
-	if (pernet->endpoints >= MPTCP_PM_ADDR_MAX) {
+	if (pernet->endpoints == MPTCP_PM_MAX_ADDR_ID) {
 		ret = -ERANGE;
 		goto out;
 	}

-- 
2.53.0

