Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC046E01C;
	Wed, 12 Aug 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546568; cv=none; b=AWx7jBXwmkqGmHAVwk1H2tibNLOHRumzBylLpi3p0MH4HUbMgAMFvomadxEXLtMTNmgOw0afUvs81k+Von4zBLOt/gsf+4+w9slxHV5ExlAchUPmHPZGur8Cop44G67V+xW5w5RgvHDBJ9OqpcXz6941SGhiY1o2//BF7i7Kruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546568; c=relaxed/simple;
	bh=XwU0bkqFK5u0JeeJ9QM6jzdx9FHXDApFemobL+2NHNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1QcnX9WiaChW1wFMKkPMiDjpL1btyUEAIlWcYyd79Mb84JYiiVtODS8Odluup+EYwN/CekSqhrLaMQ1GGKluDVK1KjAb5umK9sT4rII6xOtMRXTdHshRHuJT/uYv0haCM2AoDYdGS1TF34SLfewoqTN3YoHllfi4InekBickcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf4PkM9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf4PkM9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110D51F00A3E;
	Wed, 12 Aug 2026 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546560;
	bh=WXZl5udg7ZJph842UCypS8VHhdJZk88YovBys9phKz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nf4PkM9jHkD9ExE872jRVQkceON+pZYOx9IJDLu119Iybwt4DFe4MXulseLJZZix0
	 SKsdP29LV7ty5z4KVlcSb8wL1yKL6mBvUIa5ihcHDggSuph0ZrH7ACBB/WjRZdPbiq
	 O0BzUe/OOiieGqe8Yd+ERTAfzi7stpg4YmCr51ckhv5J56fgZwt9jXq36cL11X1BVk
	 TVNaDCPw8Dlkqh1gy9o+x0uNX5z0SBoExkv7mjr8XOdkJpwhon0thK/m4trtI40Af+
	 1OFiiM86RbJAV1JyUufYwJWiqpuH7r2ec+Yo7nD3CwZhrIgqNPc4vpw3P/Oam5mjCJ
	 /1jiEXto6j0Bw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:36 +0200
Subject: [PATCH net-next 01/11] mptcp: pm: add WARN_ON_ONCE guards on
 extra_subflows underflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-1-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Tao Cui <cuitao@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7Sm0kvtxa0BRbbyBX9OkWC3GS3dAAOG3vCPCiXLOlWA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOovdEq95iMwt77dc6ss6s/5E2JU51aUzth9wOH7lq
 XfKsRspHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOROsLI8O2u8rlf36YqVR1h
 vMO39fO8dnXu3pkF/96oxehHLrJm+8/wP0731q1i669lnea+PFqr7Q6o+V3v3/flrJlRebnZeq5
 YDgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Tao Cui <cuitao@kylinos.cn>

extra_subflows is a u8 counter that can underflow if a decrement races
with or precedes an increment. While the recently fixed userspace PM
subflow creation path eliminated the primary cause, add defensive
WARN_ON_ONCE guards at both decrement sites to catch any remaining edge
cases rather than silently wrapping to 255.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 3 ++-
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d1f73c3e39fa..8b68868255c5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -670,7 +670,8 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 	if (mptcp_pm_is_userspace(msk)) {
 		if (update_subflows) {
 			spin_lock_bh(&pm->lock);
-			pm->extra_subflows--;
+			if (!WARN_ON_ONCE(pm->extra_subflows == 0))
+				pm->extra_subflows--;
 			spin_unlock_bh(&pm->lock);
 		}
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b3af3462bdd1..20627e12c113 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1254,7 +1254,8 @@ u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
 {
-	if (--msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk))
+	if (!WARN_ON_ONCE(msk->pm.extra_subflows == 0) &&
+	    --msk->pm.extra_subflows < mptcp_pm_get_limit_extra_subflows(msk))
 		WRITE_ONCE(msk->pm.accept_subflow, true);
 }
 

-- 
2.53.0

