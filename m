Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF142A165
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505013; cv=none; b=e8+PMrQGX5mrjPWlueot2WRWd1XFRdB3sscuRWWLxHeubNHg0OVYy/fYih1a2jqr1VH90MMOY+JIQxN7BN0p7Ojo4PuVV46s0iH35iLHDCXEJo+V+eJ1GAvkFm/EJe+Ori8KLMGVkOpUVjkpTEQH78XtX4kfM4zE3itKCoOa+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505013; c=relaxed/simple;
	bh=TxywdlczJNNYW5Yuyz8Jn9+pnQu7T2G2mfXN9ISwZYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iz9XcAALVR4SDnsWV4Y3qBjwbscnoWCihfmG/JFuEP6ZokDwqOb1H+i82N1LseGtRlRNp0kb0v4e6TJz7nvBmoSUraf/tdnSuRemdAYvwvGbibCyJcM0hsQZ2E1idt30wB9ZCWzBGF72JjQhA7AUXxem0ShBeYRGClMW9E97/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni/FhOk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni/FhOk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ED91F00A3D;
	Fri, 31 Jul 2026 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505009;
	bh=a4AlyqJAyOiO5TpCS+oh4/m3B0UurQMtrFxmYkoG1C8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ni/FhOk/QBEsyWU09nPUTArQcOLU8bWWCr6KI1hSQFJnGD8W3Ol6+zOwVTKyRaXzt
	 PMh2/M89LREmzrvSw/3V+o/jOwkATKobBzkVl3Mr4ij2BVud9sDAbts4YS++dNeD4i
	 4mdQRqSHGa+ndl88qgjzJ6gb35+ectnsrj7hMEl15wr4mF44Kcu6iwCHENZrv1GEdk
	 R+Bd9V83Z8va9+h0Z7bWEVxXQkOYIZ4Q8OGpLmQeqzLBiaRf9Fc1ySOChQ2+/WrMQJ
	 TERO8TPPFGWCVEv2OtvK8y7aWBNVsknWeVaxbr56Amu54SNFEfPQGVH1UGRNGc+Xbo
	 q+2yde5PXeh1g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 15:35:36 +0200
Subject: [PATCH mptcp-net 2/4] Squash to "mptcp: reclaim forward-allocated
 memory on RX path errors"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-mptcp-squash-fix-7-2rc6-v1-2-cfe460beb666@kernel.org>
References: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
In-Reply-To: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TxywdlczJNNYW5Yuyz8Jn9+pnQu7T2G2mfXN9ISwZYM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJylry9zhe/62MjdxtzU3RMmeiSm/7/I8WT30TfT9tva
 18hxrGho5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKCyxj+R7cJq97S8VvN7HI8
 530Ez8VLd7Y3OSyK7GrzDSr2ZrPWZvgflTSDleFJxTdtpnX3Ju16qOjxUfb4t/wwNi4Rhj1bt03
 mAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Follow the same style as in most places in MPTCP. This was the
previously enforced style for netdev.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 90dc894cb976..3dee08862027 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -149,8 +149,7 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 {
-	/*
-	 * The skb forward memory was already transferred to sk by
+	/* The skb forward memory was already transferred to sk by
 	 * mptcp_borrow_fwdmem(), even before setting the destructor.
 	 */
 	if (!skb->destructor)

-- 
2.53.0

