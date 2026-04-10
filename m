Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028430FC36
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831536; cv=none; b=n/6lTkDlSYIr9efCSRaJGBGyn28yVPBzR7wprqXfNRa2rBLUDG/8sXXa18e8+PNaBTGH6OCxXfkCIFM+OKDAQxCq7cp8fhSGJO/VVegpSaCCTDg+lKUDC/q1Dq3l8n/c4Puru5swj4VtszD1JtnR2caTFZ+5qOHPEoCJw/fn0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831536; c=relaxed/simple;
	bh=rg2sXC1Art2i0kFN50i563//GrJ1M15JsZXb3hbhYjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sNqPYjIjvp8tFWUBZ+rxZu9rPA5eiwcPNEM4Ispb6xWxcZsYeqRXddifdqWlWK0Lec1PGS0BbWQRpLRf+/dMwZEYfH0ku6natyFlqA5SLynHRThFVZ78LqrurpCPI6T+Th+OPP/f0NpGvndrbQn82LAdL7ticqZyOLpgjEO2GkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrYH49FQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrYH49FQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A998BC2BC87;
	Fri, 10 Apr 2026 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831536;
	bh=rg2sXC1Art2i0kFN50i563//GrJ1M15JsZXb3hbhYjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QrYH49FQDOFXdTy/o3O/6YkCsz3BaJqT2gJ32MH6X/V2KhVGVPfNumv9JF68ZMZUy
	 wxrzKNbSVrkq1ut/nyb7YroXB1W/F3LEjW5o5+W7yCTWDeSuWQFmpCyN/G2sugfOhW
	 vkkmU/pmHbL3JH3EnyjynabCklkvPzAyiqmAnOXM667wLYYEMNu3K8MilP/ZaNo/Bq
	 ygl3jpmb3deV3p0LQ8XzgOd/uYqN1zNmVDhmgJqQz4FGqojmvTSnzZ8G17eH4r6psS
	 XsKJxbhRbLnvobZi6gQhtjO5AorqkOPyODgEC9/SXHNADKWU5sg+alaMULuPC6Ls3R
	 TOiK1p+aIqPdA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:50 +0200
Subject: [PATCH mptcp-next v2 12/17] mptcp: pm: in-kernel: increase
 endpoints limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-12-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rg2sXC1Art2i0kFN50i563//GrJ1M15JsZXb3hbhYjU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvcj6S/Oz9fNevU/unvg1TOXNArPJ2W5npysx2Q+dT8
 m0innxPOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZidprhr5RK80TLdfZ5b9Jb
 N6h7z/fZ8FR0VvfGXwJBwkdfJXOUfmVkuPFOSczEyulbQuamyK0Byj9ncq49tvPosx8PhApW9R5
 awgQA
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

