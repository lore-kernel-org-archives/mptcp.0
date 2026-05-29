Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8336A36A
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024940; cv=none; b=XUalLDDF1FkLUiuDAZCwXHZPjdLlDviQJCOqskP7ZqTegl5MFLBAyAI0lmPFXB/05OYxMaEh/XOlFPpCHgh3d2472b+zug1VC4Ivtf17xi5XTGP9k8u2qH4/yx9AbOHGq3tjLiTKeq3CDeLYzNM762rvqMvfsLCWbFgiL9DCRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024940; c=relaxed/simple;
	bh=YWlAulkQZABrXxcDww3dS+p57II8NsDMK5QfB5/sBeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKn+gHqnWNfY1bczva4lG0L5F/vcHZs6xOre3CaWPtcLJHJUK5wn/C/JofZjSzh1mE7K4CKa7FmLKzdQofdwSu/Xe5Rhcto4eUdW7c6HKMafDiOrs2Z81wkm9aQZN5vviQURHNwUqLhRkJXsZ6mHR0bbjCfaQc4+pi3oNjNurLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUVZdWP5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUVZdWP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45E21F00A3C;
	Fri, 29 May 2026 03:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024938;
	bh=p7NsbMyuxlMZKFD/C68T+zFAFT9JsiDfSLo+E4UheuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BUVZdWP5CfjvdJDVLWaYRUGYEZ8/d7FSuFT5Rm5qlc4oXPDZwjlcAmDaFEDABoAhO
	 vQR0wFWnNNAUxcsmZb4Ld5/46rGJLms+W9KxTj0cXs4vvC0czVqWR8ByLOWL74fNzU
	 Xfk/lDo341QI0nTTb3rAZzXx6fNYp6AayhgAKswjvxvd+644cKMtY5JZwhiFQVbtv+
	 ZQQRv5dzqlrr/pdseWeQGItiMz0sVv5mqBcFG4ET2u//kCUxfMgIHvH14s53Koe7/e
	 CADXW6M8CEk+InF4aXPLzuI7dX68IfunqdCeiRaPK29Yc0WVIGa+lWgRedhPxW1WTp
	 FlpanSZnkvtJw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:52 +1000
Subject: [PATCH mptcp-next v4 14/15] mptcp: pm: make
 mptcp_pm_add_addr_send_ack static
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-14-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YWlAulkQZABrXxcDww3dS+p57II8NsDMK5QfB5/sBeU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZXeiuhWePv3JxgVQssmj2zhoeZSTmq0o/z9
 GH1vaQcp1OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVwAKCRD2t4JPQmmg
 c0JXD/0V/K61TsA2Sgxo6AdpkJH7tKfgD37tpW8Jswdu9f3d0WdkJhHBUU0LpIKwucMq5DbmxXC
 nDF839sYSbY09wp2PoNV8a0GBDWJcwqcVeSH+n+TeCZdA83+7Vb60Xqy1zmz2aUhpi7YeKb9Vxl
 Lm/uF8jSMGEto5okCKEpfUtH5JbvhYjod34Lj4eT+o6wj6gbcgpErwFBD6jLbIRRrOBABS+ij9U
 KiJ7IL4EhluWTbWLbnBP+tDu7b0HrjOMRhsLScL12EkbnzeCP1tGbNUyWvsZzJe8MJjSiCvQV4j
 nHclJNrZ4Bs43U9qV3fDXDgq0nAg+JJEPNESoT9aIKwBoyRDVTkNE+5YNVaKp4VlCe7XJJuYoMF
 tsDnOXIEXlsoSCMWrdPwH3RmWoxaShX/9+qvqMvMehQFXiZQniPW3SWHHuvIgtdc2/pM/989x1Z
 W+P8P/d2Jqrf5HiYdSVhKrTxN9j3HsLQk+1CBvvCSv9lwGDeMooRTjIOyLVSgtG4GXRatzL4uqu
 2rwAHGdCgIseNya4FjiwXyQtLrkAKG5qtqYmGTLfn5JZpLwiPMxnPsRKU3LIrQrlUzAzYKLMztz
 6kjP70eNwWE33GTEb6ZP9l69vgeIRlpOW6QOX53+RuAdrgWdrDBFJuLH4zKB+6GoJgufYfpPHAK
 gKU/Hg0+2Rxtgdg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Only used in pm.c.

Note that the signature is added above: it is easier than moving the
code around, because this helper depends on mptcp_pm_schedule_work which
is declared below.

While at it, explicitly mark it as to be called while pm->lock is held.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c       | 4 +++-
 net/mptcp/protocol.h | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6c0468f1609b..a781e21d74f3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,6 +226,7 @@ static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
 	return false;
 }
 
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 static void
 mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
 				  const struct mptcp_rm_list *rm_list)
@@ -744,7 +745,8 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 	spin_unlock_bh(&pm->lock);
 }
 
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
+/* To be called while pm->lock is held */
+static void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
 {
 	if (!mptcp_pm_should_add_signal(msk))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 27a0354a1ebd..71bb522483ef 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1117,7 +1117,6 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 				const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_send_ack(struct mptcp_sock *msk,
 		       struct mptcp_subflow_context *subflow,
 		       bool prio, bool backup);

-- 
2.53.0

