Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF723987D
	for <mptcp@lists.linux.dev>; Sat, 29 Mar 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743265590; cv=none; b=NZ2OMQ7Z/F4jW8xAA45+ZDxDK+rQ8gyRrqj5eK7TzZHttV5ZQIMcuR01/Nt39l5wRXxT8TkjPv+eoe0Rx2J4u1TK4D8XHzIIZ/u36AcbMHU1xCOkkVcAKaw6H2PlKJ17OHpQRykbmY7/Qfy3n4RlREXv7KGIYOSEVDChzNnYxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743265590; c=relaxed/simple;
	bh=Hgx3dp8lBqd439Pi5SzxBD/40UAHe+cPmNaCfU9dsMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wdyano3oFB08M54llxeGt+36L7lqwh59KfY70MZxrgBjKLqwjSG862cIgBhHK/VsYUclcMopp01qceIH/cJcjpHUjaPwr5Ih+/LyKq64HQP5Os0YXvc++u8HskCrzFP3zRmtZHYODLrY3skLPs5GO8svKCwrbyfsOTTKJycr27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMMreG6D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMMreG6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0EFC4CEE9;
	Sat, 29 Mar 2025 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743265589;
	bh=Hgx3dp8lBqd439Pi5SzxBD/40UAHe+cPmNaCfU9dsMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dMMreG6DwiigaGN412Z9uQkmIljU7+3jz5jm0NQz5GYH4/iaEyFR8PhW69HE0GV0Q
	 d3AqIM41ZnP0osV8hMQLaIzI/QsLa8rWLg7UAOwZL4tM5vI/AGH+Oz6z2VwcTFPHeQ
	 9cHLC35XkNzrDf8eb7w0E1VERkMp5vjxad5+vjjTuNG2ERu/uEZ5PPBxhGdTfBzAWg
	 n9+0kfi9NvHHhl7n3t9Kn8MAHEN9FIJYL7whCYDGVqlpY6BJnWzx1uLEdo8dF3h44b
	 oyYPVAAnpou+0vToL77HTBzg9ZcFZJWUo+5OUUM+DkIbZs+XNbFu1bTwlUkQzDt78Q
	 t6qaxkuIq1Ggg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Mar 2025 17:26:14 +0100
Subject: [PATCH mptcp-next 1/5] mptcp: only inc MPJoinAckHMacFailure for
 HMAC failures
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-mptcp-mpj-reject-v1-1-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
In-Reply-To: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Hgx3dp8lBqd439Pi5SzxBD/40UAHe+cPmNaCfU9dsMA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn6B8zjWhJ8IJmfanDfgcasiUOtS3GqzY+biAbL
 MA9EKdyfcaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+gfMwAKCRD2t4JPQmmg
 cxFOD/4vAwDvpmqKxcVSwgvNYwrt0OopjB3nlcMeU5u3IxIXbkfxnhpM0907hNhYIGXjZkLm3wi
 25KL4jyQgNU191uFVvJr1Ds3hxZAHD508ClCOPK6DbrCIpiQVt1qfr3dAWfiwZogDxejUGOqqG8
 pvyBo1kkcOXUkXjgKfr/I5U/BtBSYd0zpqrizw7eHbu1epW4S22zAlpzCEWxQXbP/OnYd9oRLfC
 wRRqnD/iYTeIG6K41b9aLEvVB8dWpmrGqVW2iGEJL/gLLwXyK6YQ3pvZZNouGzuGQGsczoTGI8/
 iQ3ss4T7kLF3JNzoKkcx+XzXi7I2txt7oiDHimxKXDs9qN0YmNytVk7brZlegqyfgA6sOr52nU3
 ruv0zO21N+nQgRFqIrfXrpUpIMq/rIp3Pn/9owZrO0xdwVQ37biWYHQxtzpyfZGQIgWJ28X4Dad
 HK6+2qF3d3dffzrYSrx5IRL+rqeN3sTBPDqnWVNNZ4WKIaPeAjj6ZpwuqAIjZR8aQg2Id91zmsi
 mUkEGhXgMNbp5EuR93tXsrzpctAxw2bJDtY3IFPis8Vgimusmddi5nY8QMX5Q8tntf86908FD5q
 1hcPfiuQQG+Q3meuimKYKEbSgozkvkTLZ9ANIDRwWVQDspjMRPfuo6CKKqSjpmw6JUvReyHXSIm
 wHievl4M3xE7AzQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, during a debugging session using local MPTCP connections, I
noticed MPJoinAckHMacFailure was not zero on the server side. The
counter was in fact incremented when the PM rejected new subflows,
because the 'subflow' limit was reached.

The fix is easy, simply dissociating the two cases: only the HMAC
validation check should increase MPTCP_MIB_JOINACKMAC counter.

Fixes: 4cf8b7e48a09 ("subflow: introduce and use mptcp_can_accept_new_subflow()")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: this is a fix for mptcp-net
---
 net/mptcp/subflow.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 409bd415ef1d190d5599658d01323ad8c8a9be93..24c2de1891bdf31dfe04ef2077113563aad0e666 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -899,13 +899,17 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (!subflow_hmac_valid(req, &mp_opt) ||
-			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+			if (!subflow_hmac_valid(req, &mp_opt)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;
 			}
 
+			if (!mptcp_can_accept_new_subflow(owner)) {
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;

-- 
2.48.1

