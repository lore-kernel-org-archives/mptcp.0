Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B08288A
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329880; cv=none; b=PzwElNbvywVYfBIFJ0cqZHe5yMfjfyLILsdut5DRvXt0j1XOksWTinEe8xDCQslhYCO/qF8Z+5f1gma5eQ3Ycd2tlhmwO8hX/0M1VmTKkoIUp299n3MILi0NpfJnbmUNdjigo0w5Zg7l6m++f4JN+1j7Ezc76m/TyUxFYQCzoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329880; c=relaxed/simple;
	bh=i1KNSzbovpyLjoHTdjxW2Iw+Uu0Ys1SpFF3/L0Chsio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bY5ZycsYfTtFYMSoSyOIlFaYDXtPt5zgBos7R71gzLGwF1EaS6enCj4qtHYbNyslITqj2nX9a2BiJExHnbCH4TL1ZHiiwCO8wC3/FpQ+1G6gkfbD5KkvA1vum06/5V0Bk2tZv5U4P3DLBv1v11wGf8BSwsXP6VKit5O3WJ1yzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmxCHtxR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmxCHtxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740D8C433F1;
	Wed,  7 Feb 2024 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329880;
	bh=i1KNSzbovpyLjoHTdjxW2Iw+Uu0Ys1SpFF3/L0Chsio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RmxCHtxRZbNPuPFCSvpfersTPjHG67zxONHtaEQcLIQAGUGZm/DAibSNzLT4ic6hd
	 ZaVXoTERm7vZSxMnXjL0x2HBt1Ec6h3l2SQJ0enCVV/y4ayb3uNGW7KcrDwWdvCag3
	 AAWljYky7u5Jo3vMw7aFe4P5Ad5XP7qCPoiR6oXD656K5rLHAuFT8B0GZaFJ5vwh/B
	 eXwSooov6kdiK0TCkL2YofH7RIihhvnS2fMnJVPt5KOQE04y74bOgnozCd4ROV7xdX
	 azD8iQ5iSK1pZ5NLhWl7wbMLfZzYHekV4V3Uox6/jcZN3LdpnKy0iVnSu3lbS09G8F
	 Lj4IzU7yBQrgw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 07 Feb 2024 19:17:51 +0100
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: diag: fix bash warnings
 on older kernels
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
References: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org>
In-Reply-To: <20240207-selftests-mptcp-fix-5-15-v1-0-005b0cdb135a@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=i1KNSzbovpyLjoHTdjxW2Iw+Uu0Ys1SpFF3/L0Chsio=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw8lURfZ/PjrL6mHJz7N1X4lMG9V8rWOkPQF7M
 VmKgJ8FShWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcPJVAAKCRD2t4JPQmmg
 c9gWEAC+OmRB4MHzCX6tzQdT9FUlMXq93R2xq2l/sZMz8w33FR9gGjdwS22GAsdE/zU2XOy/XwB
 ZUbT68NqYgqk1qg4bKW93S0IBQeoRETHDr2EFHzfRnzfGVhIGG4atv43ncswdJH3UVxdiorF0Rf
 sktSJsbF28/njpLGOPHxxSD3knR7H4Bl2NWTLR+8uabPpgJ+lqCzJDNyNp07y8oMUJo/bgNiOnL
 nr46ifxqPfxKkHNN0Zg/mVtd6PbNNwzbKU2Lqiy7FNds4XrYrJZ81SOt/+a09rzMfkxqAB4Js4X
 t4B4HbvDiqvat+pXIU78MZ8srEakyScqNFzZaPBpUcce3MXIN2biepqrU1lKRsa7XqoTrf4xBV4
 RPUyGrVA9u+GLzQKSxLqDPLGeJGbWfmEaj18P7CDtUXaDvVkNFYBni+CEZJrWZCk6k1/1y/oWJH
 lM2e92tCP26LH4pV2m5F3rhMmeXRXFjR/w4Qhtqi6D+sW6X9DRKqqiNU62C+wCqM6+pzTHb5p/l
 t2bLMx/g6enJmp9eugmRZYib6yJxDzPkb7W8iGtpWCWBPQv300inVv/x3xuMyEPzVUTi3ZzQ6at
 l55PwjYtYRfoh9fGxELCkuBplTXCC6lwrvJ6h327LgjxoAurbQDNTBLRv9M/I1DLc9ShHX8sNNX
 iyhYzbtso1lZSPg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the 'Fixes' commit mentioned below, the command that is executed
in __chk_nr() helper can return nothing if the feature is not supported.
This is the case when the MPTCP CURRESTAB counter is not supported.

To avoid this warning ...

  ./diag.sh: line 65: [: !=: unary operator expected

... we just need to surround '$nr' with double quotes, to support an
empty string when the feature is not supported.

Fixes: 81ab772819da ("selftests: mptcp: diag: check CURRESTAB counters")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 04fcb8a077c9..e0615c6ffb8d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -62,8 +62,8 @@ __chk_nr()
 	nr=$(eval $command)
 
 	printf "%-50s" "$msg"
-	if [ $nr != $expected ]; then
-		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
+	if [ "$nr" != "$expected" ]; then
+		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			echo "[ skip ] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else

-- 
2.43.0

