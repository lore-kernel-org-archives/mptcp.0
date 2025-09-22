Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF62F5461
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579851; cv=none; b=XJKskuLpLlBgkRYNC9nNXKAXJJ/vUcwZ9PNcJFZvWgsYVnlwltXVJZ6uKZcch/uwccdvVgAo2A/kzRJsE0b0EqCxwWNJhf+X6Zb/mIiYfGl1AKQ/Mz6XCunWQZHWPM4i6Ags0+qVap6O4gtd97ZG/gZInFW2USVfdgFhbmVf5ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579851; c=relaxed/simple;
	bh=Y8yJHpii9RXE/FJyTzW3nCREeNSe2DRb5iXhHumwCXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reowC1neq3nrHwUtG8IIVO8g00ZxNkcoTjaRZ3vyIFrFDqdIBITeLYPsPaVBtebmjAQT688FjWekEQL030oezbgHXpg/8Ecu96wJEj0a9iT3nrxrb5b8eqyapZr7LiSH5Lh2Pl2MoL1KFePsIN1Qw939kI3A6CMcAlvK7jLFHng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxyZzRcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxyZzRcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD40C4CEF7;
	Mon, 22 Sep 2025 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758579850;
	bh=Y8yJHpii9RXE/FJyTzW3nCREeNSe2DRb5iXhHumwCXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DxyZzRcSko4XrldNWcWsTF0VFvrNwXro/mbRpsvNWYkNSZNgD1mhhW+ITaJIEgbBV
	 SngxhTfkp9MLI1I7QA8eM2hY7JkSmDo8ew89DsehY/LjudQRNTPNbvIpe5yZ+Gg0rR
	 fUXK7+BcHu7781RrBoTFmrdF8KbDx/6G1dy28dyDozQzzSkUybNoWjyjOUZQdbQAeL
	 R3jFIVqniYQn7PNaE6+ZEySkaoZtCgGoDav7bIvNd9iJVYPyPi7fIrw5kGw0R4aBpI
	 b3QMl+1BxpydsHRNavGkBGZHmnRG85O+SJoNpOeUT66V9eFaWybcCMFevv9dreKBZU
	 sihMDM9VwoP9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Sep 2025 00:23:55 +0200
Subject: [PATCH mptcp-next 4/6] Squash to "mptcp: pm: in-kernel: usable
 client side with C-flag"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-pm-kern-endp-add_addr-new-v1-4-60e3a8968f45@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
In-Reply-To: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Y8yJHpii9RXE/FJyTzW3nCREeNSe2DRb5iXhHumwCXM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIunmleI7Pn6OGMObmBOU0PBPXnPNdZKzit/+IW7o0Wf
 5iX7Sje01HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARj2mMDOtWBS+ZckuymMVn
 4Z2yyLdxd5a5xG7cwSBhL7ZuNnv2HgeG/wXsbLte/3n7hXG3sMcqTf/lqW8tJ73yNY9cu/j54RX
 2x3gA
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
index 7be454196a41f625100a6e0d6cbf1ee360dff553..fbd0a4ade8469ee75d99083bf640ad91a6fb714e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -429,9 +429,13 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
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

