Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80A13C8FF
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223236; cv=none; b=FHXnb/R0PhIK5r7lszA5cLH3KRGAcUHWQe2W54c1E5VKmLRw43Hxnye6x89fxTJooJNNGQ4bRzWxz9X1S7MG9Kpi4cvaTMfcjNEV+FMYc1z1DQy10HVp59yxn1APuABo+XZmJOy4BPF6h0lIQfHgNKFSojXrW1BSMBcHeO/TcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223236; c=relaxed/simple;
	bh=MKeEbNJ2SSlUm5DXfBt++2CPWkZY8+DwVbNw96a1kFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8JSSuxYi1473JPQK5FeqE1PEqszZgvcHWbV59dXYuV7efCp24wS8RsFZUcSnfyKB2wfoEX17FJ0x7RM1vs5NP4zlrn3bphZmTlGCzPsj3pqkzAhUDr403WQcb48S86tqhyMhAkdCIW82nzTwO2l7q+G6f8Z9rttSQQmGM1uSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgz4NouA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgz4NouA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8C2C4CEF8;
	Sun,  3 Aug 2025 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754223236;
	bh=MKeEbNJ2SSlUm5DXfBt++2CPWkZY8+DwVbNw96a1kFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hgz4NouAoDZFYr2uCTWxnEDX3qGyqk49X6EgyzLj87TivIyM7mvaNi5KqALY53zT6
	 5wUoN6fPTAr0UUI/sr4L6AFIII4jwmivXizh143lsrhdlo87foOnCu4Rqmj6X5kNir
	 9sLRfhSaCttv2NTxpXxD4A4soMEBFVvZcnslHXKNFpH+VH6b5nl+Ll/wbyji+Z7A7T
	 ughc6PK0U8c36F00sAYqaQ0pCV8P0wwm7BZdHh247vygAivwue4Q5d3dSf9CMZjZ4R
	 bsgdO+7MGHrQrh9gCt3EirAWzIAp06txTce5GPFQbJwFN+cqTShpfcmvYGnKI4CeZ1
	 38cEb31PQf9nA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 03 Aug 2025 14:13:43 +0200
Subject: [PATCH mptcp-net 1/2] selftests: mptcp: connect: fix C23 extension
 warning
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250803-sft-mptcp-warn-gcc-v1-1-6d87808721ea@kernel.org>
References: <20250803-sft-mptcp-warn-gcc-v1-0-6d87808721ea@kernel.org>
In-Reply-To: <20250803-sft-mptcp-warn-gcc-v1-0-6d87808721ea@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MKeEbNJ2SSlUm5DXfBt++2CPWkZY8+DwVbNw96a1kFw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL6gxq8pjOyBWyq/jH33DbjFXXrn1fnb248ukbjlOsMv
 Qwbl6MPOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACayxpeR4dQChkOitovf/ddt
 KHhy+5dba8+/2HMvApSt74ZcusF2qYCRoetfeuRVjk2eh/5xsRgzluieelS4qWFr/bdzN7ovJkc
 uYQUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

GCC was complaining about the new label:

  mptcp_connect.c:187:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    187 |         int err = getaddrinfo(node, service, hints, res);
        |         ^

Simply declare 'err' before the label to avoid this warning.

Fixes: a862771d1aa4 ("selftests: mptcp: use IPPROTO_MPTCP for getaddrinfo")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index ac1349c4b9e5404c95935eb38b08a15d774eb1d9..4f07ac9fa207cb08a934582b98d688d0b9512f97 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -183,9 +183,10 @@ static void xgetaddrinfo(const char *node, const char *service,
 			 struct addrinfo *hints,
 			 struct addrinfo **res)
 {
-again:
-	int err = getaddrinfo(node, service, hints, res);
+	int err;
 
+again:
+	err = getaddrinfo(node, service, hints, res);
 	if (err) {
 		const char *errstr;
 

-- 
2.50.0

