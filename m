Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C78462
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181886; cv=none; b=jh5G/9/h8xDFz2lz/7uYCzwgBhZCkfXCzxesshRwsy0c///izUc8K8vbZkgcNOb8/VVuKgKuSNGFHIlQQpjnBcnwctw+qxESsyaxy6oQGaq2aUh8rLmtTi9h1CSmzG+nq3gDYOS6xZFQAwJTPLr/tU4tkTyGSgAo8c3t87HGeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181886; c=relaxed/simple;
	bh=ATsuF4obbflErMUuDj0V1hDDZSOEjOmOnDC//M7VLjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hOBSGgNVQTbHmzJzwXLij11hM0AuH9dmIm1kq9ciIzvniIspNwqkPXKTRAYO9wYlBjA0ia+kYwW4uhumUylu1Slr9e4H5YmAMEMqZR2CXROCQgszGRksHd49KIF+KmyhzxK3Q/QjMisCBiPRrZJ4tTSEjIKHNzvNciofWB+qLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCprx91c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCprx91c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530CBC4CEF8;
	Wed, 26 Nov 2025 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764181885;
	bh=ATsuF4obbflErMUuDj0V1hDDZSOEjOmOnDC//M7VLjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lCprx91cVWsQqPfIk4jjpPhIG5tDmZPpvWjaW+rGept9USb3gw23aYVt/Uabn/Oft
	 t305v4/YiBq9ADH3itsXPtZCpFG8iblqpDVQ+Iq6iUi37eSWgxHhbmSwVMsqhMBLO7
	 fTux5/AH2s16Mf0/g7wsul5/MD6o6HhmMcLA4XvXqnPufPskymAfJwtQ1LM6vIC3sy
	 KYx5a95BK0uwgwu2q6ufgJYitjUeklRIW5RArxjYXYbKJtJQyzCAn3T53fzbNr1fP4
	 iSqBw536PclLlGWb0l6dBrb2mxdL1sqo5wLwW36i88AEGSayqlUQiZ4RF1l9bCFrNn
	 e2zEeiWKKxKfQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 26 Nov 2025 19:31:11 +0100
Subject: [PATCH mptcp-net 3/3] mptcp: pm: align endpoint flags size with
 the NL specs
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-3-d2e4c2ebce0c@kernel.org>
References: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
In-Reply-To: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ATsuF4obbflErMUuDj0V1hDDZSOEjOmOnDC//M7VLjI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLV3atiA+KmRi8usmos617yaEuI5JINR583f3l0MWIL3
 +bp+fv0OkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYyv4fhn70OR1j32sAo9Z6L
 to8L05jXRvzi5F6h/eagmdXO6q47xxgZTr3aWWy6QriE6W9D2esdmy3WftNwWOx7QivNM6x9/u6
 9rAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The MPTCP Netlink specs describe the 'flags' as a u32 type. Internally,
a u8 type was used.

Using a u8 is currently fine, because only the 5 first bits are used.
But there is also no reason not to be aligns with the specs, and
to stick to a u8. Especially because there is a whole of 3 bytes after
in both mptcp_pm_local and mptcp_pm_addr_entry structures.

Also, setting it to a u32 will allow future flags, just in case.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
This is for mptcp-next, and it explains why setting flags between the
8th to the 31st bit in the previous patch didn't have any effect.
---
 net/mptcp/protocol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 199f28f3dd5e..d98c0cfa5889 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -247,14 +247,14 @@ struct mptcp_pm_data {
 
 struct mptcp_pm_local {
 	struct mptcp_addr_info	addr;
-	u8			flags;
+	u32			flags;
 	int			ifindex;
 };
 
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
-	u8			flags;
+	u32			flags;
 	int			ifindex;
 	struct socket		*lsk;
 };

-- 
2.51.0

