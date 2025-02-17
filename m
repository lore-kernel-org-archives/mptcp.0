Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833DE19ABC2
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781481; cv=none; b=gxyBk1KEC3Xw7jpANzwTXZlCZpfuJk4EfvGR3lFQzV/PBNFDbsW9fSkAWfqiVgTt01rKQjZ+t8gJu7eHUDbsZiRJnlT8+kZarlCbvySn7nPB8mafZAYGUaoKONhfKUms9XuRdWVuscf34F4yqDy7AWOGKEu7s8xzS3xtAypIteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781481; c=relaxed/simple;
	bh=tD8mQGd814n0mULatxAyMzelWfFxFcQJl0e5tNaXbpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJEtq+kVuJciYYRRmQrlPVetoG0X1Z6gfPJsdi3uAYATquqP8B5MS4jC3POP4qYHw2UYBZpmNJnuhztyVRTAWEBLqdttWENLkbvXl/oNa0/6cg/XPmKOmaAhWsrrjxvot3EDcGgflkedaAF3DyFQ/RKJ4jOK+3qkKPURGGIYZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzp9XvbI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzp9XvbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADC6C4CED1;
	Mon, 17 Feb 2025 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739781480;
	bh=tD8mQGd814n0mULatxAyMzelWfFxFcQJl0e5tNaXbpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nzp9XvbI/4OOcBHNqFoDeW5GfCCZl0iXNiYVT6FbNT8cp70CHrPTfQvm53IsiUEQ2
	 FuVrPHMCPS9tcaPD/44STugs0UnLHC4dBreWaoD/6AUSURjJRX3DMjHP0j0tsVvNAO
	 tngFXJ6DTaLoeFtUUJdp3g76OyLqspZiLHNfeE98n+hOp7lJ6TVFvv8sqxeoNP5Uea
	 IUs3Ixe+dSCPiobA+ps8BgouJjYG2o1ddo/cTiDiXz2uZUINHUzesMifdYJf8o66yi
	 htnx+XaaIA7NLbSMo2WtWpyviuRG0Un4zXSFLfaKs6FyvmrwIWQ9iB8t5sT72Nayph
	 /ty8MyIFI69+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 17 Feb 2025 09:37:42 +0100
Subject: [PATCH mptcp-net 2/3] mptcp: only fallback due to inf mapping if
 allowed
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mptcp-dss-drop-mpj-v1-2-d671d6b9a153@kernel.org>
References: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
In-Reply-To: <20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2986; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tD8mQGd814n0mULatxAyMzelWfFxFcQJl0e5tNaXbpQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnsvVk8TGPcy1dXIzGXSUKUYV9013x+MU6ffgNb
 sj1A0jVS4KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7L1ZAAKCRD2t4JPQmmg
 cwHzEAC5ydMIyazZ5IsM795E+WAeS2UIpSfsRMfDy16pTJ8JAI7W5jnUSPwpeh0NR0eaTK9L4F3
 5l+oKVo/fcPam5G2DHebR+HXrVkAPxVSRXMSGiRKd2yna6cZFB5a+XxUwQHpRRHPxJBYjx38N94
 kN+btobtUy0hXF3jfpYnk+H1eHNxZ2/jzelf28P+ETmI2JWoGf9ZKnh9WiUQdoNIdzcdjqdD1fA
 vWjwyl5mSmdFKiG67OFqkrjBs7+b+YPm/6hKm2UTqcTwAdzs0OZ7R3E7SmtjTNMVEpw+6v+J20e
 v5lfbLD8mr1T1hR2RviygykhBO5W5+EWVrLL1tCax1PwPoJNmL9t8P7lrF2dHOwYelFzzZ4SBrk
 9VHW4agP2HZyGdLGOlz0e0tj9UQ+FWjBCxCSzgE1Su8lA0Y82A7ZbpSOSAoC5mC1Fe25JX2LW2R
 aW4ukHtcz4BGGqB4NedCHYdFDwVIIfuoR8vDt9HFKa5J1nluDDBEWovkx81uLudR7OCArsvOTMu
 M0w9MLEkJu9IsFxY65Z+8lISmwNHXuKJX5SAFid6djLGxBxb5ygbLF2U6L0PtBmJto5kuHRWweA
 3AiGVvdvjkxIRujRSp5yY7B9m0pnH3KQTGh3DtOof1N7U+Ghr00wFvspevWuOLuDpCeBsbkj8f0
 yweSAfDuz+PW73Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Any fallback should happen only if allowed, so only if this variable is
set: msk->allow_infinite_fallback. This boolean will be set to false
once MPTCP-specific operations acting on the whole MPTCP connection vs
the initial path have been done, e.g. a second path has been created, or
an MPTCP re-injection -- yes, possible even with a single subflow.

In other words, the !msk->allow_infinite_fallback condition should be
placed first. If it is no longer possible to do a fallback, there should
not be any bypass, e.g. when receiving an infinite mapping.

Now, regarding the conditions to do a fallback, the RFC mentions [1]
that if the checksum is used, a fallback is only possible when "it is
known that all unacknowledged data in flight is contiguous (which will
usually be the case with a single subflow)". In other words, if the
checksum is used, a fallback is possible when the other peer sent an
infinite mapping indicating the flow has been altered.

Note that the issue is present since a merge commit, where both
subflow_can_fallback() and the previous extra condition with
'subflow->map_data_len' got introduced.

Fixes: d7e6f5836038 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.7-11 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6ec03580ccec12fb50fc3aacf3d22413647b32b5..a8ad16db1ecd08ef7155a38161555253e4c72399 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1298,16 +1298,20 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
+static bool subflow_can_fallback(struct mptcp_subflow_context *subflow,
+				 enum mapping_status status)
 {
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 
-	if (subflow->mp_join)
+	/* If not allowed (additional paths, MPTCP reinjections): no fallback */
+	if (!READ_ONCE(msk->allow_infinite_fallback))
 		return false;
-	else if (READ_ONCE(msk->csum_enabled))
+
+	/* More strict with csum: fallback in 2 cases: inf map or never valid */
+	if (status != MAPPING_INFINITE && READ_ONCE(msk->csum_enabled))
 		return !subflow->valid_csum_seen;
-	else
-		return READ_ONCE(msk->allow_infinite_fallback);
+
+	return true;
 }
 
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
@@ -1406,7 +1410,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!subflow_can_fallback(subflow) && status != MAPPING_INFINITE) {
+		if (!subflow_can_fallback(subflow, status)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */

-- 
2.47.1

