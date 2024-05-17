Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99A158D91
	for <mptcp@lists.linux.dev>; Fri, 17 May 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967670; cv=none; b=uK24jNOmKHCTbRP0CaV1OfDZW04jxKGTkBHNIC4dwvu/TSjKMQGLeUdlHKEDjPeFxhThrKzZxNb5RJuCCO5HDxr/h2fkfUUFcg2ftGVIbYjzxlefLFYKHpH+ZPsYW5MXgv9AB+/UGvnOSOLZc/Lt6dknCL4lS8ZLBhBCQU50SI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967670; c=relaxed/simple;
	bh=02UgC2SUUTf3R605TKQzX2uuRJeAOCEdWBzn15mij3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATbvJaFhA1ToU773m4Xck5kKnK3sm2NINObSIjOdEfPO6y4SARdoS39YsD2+nNcpVy1v+0U3vsARx7vwMNuMaWXV/I9/nkrvQnjMawlLyLJtvsRoBQdhmbvCFrGjcHt8bic2KG6UyHn7n646r2JXmJO0t+usyiSQXnvkmGlsYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4fVzLe+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4fVzLe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6578EC32781;
	Fri, 17 May 2024 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715967670;
	bh=02UgC2SUUTf3R605TKQzX2uuRJeAOCEdWBzn15mij3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b4fVzLe+cNZLaor/QZLwwhTE2ZSkt0Ld3SYRfA2d46pIAdSgYTzg6wvXTi7wnnwBk
	 eustfX7dxnqaaVdRiUF/Z0CWg/v+mFEqRM7NKioF+P5VFnX91l3LrD/W48GEPqqieM
	 LRRpg5WU2cQExBc4rDpQ0yoeaWSvP24rg/SUu6NggYwSiyqgDxZlQUNxRHrkE6weBX
	 MkJGefrp6/mcJD7/+aUbP5Vsuei1ONBCYZQHxm/x+adUjjeDVQnLOzlC0CmudKCsms
	 6qL2ms8k9onb/+E4ek3jWLThWmfaWTFhcJFdE2oc1V/lKmWk7FRKo9czoaSOqgemm2
	 uzrxNpZ34kh1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 May 2024 19:40:44 +0200
Subject: [PATCH mptcp-next 1/3] doc: mptcp: add missing
 'available_schedulers' entry
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mptcp-doc-v1-1-fc1ef063584e@kernel.org>
References: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
In-Reply-To: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=02UgC2SUUTf3R605TKQzX2uuRJeAOCEdWBzn15mij3s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmR5az0pC17Sygq3x2ci/s3pn9t3GX3dzNKASpd
 G5Bkv+iWGGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkeWswAKCRD2t4JPQmmg
 cyqWD/4+GQ43YUKk+Vry1iZa/HUe2KGzfiIV2JjDCye3tzmnfareG/gFt1sW5HqPn2O8iAWBJR5
 TWzxC+6x6y1KZhehBgefAb6gw4vX7crQrxAf6O13DCFMtGfwzUxFRRLPTsb/zqdgpTpLfX6N2Mv
 i9sv5m3yVnuoiL9igmb7W38kq6+91bccB/76GGyebc2j8E93tQS4uXJW8k5DyOHdnNrriZD1yr2
 aUpMTU6cVgLfaDUQ/fzMiyi1EzQERK0DOqiXAiR/+LOM7M+qz6VrE2cQV5U2METSEnxDzZkx88v
 5swqOpQnldAm6O65yNyGqjqG/3AGTYyej5wbfzBrcqrPK1f8F56hv93e6ZB4whbnbDkv547aPgs
 8l4uQV2CJYUAXltzvwfFstgmtB/uP0Q5Rtu67netOwhMAkPCtNhstE/QBId9fGBiOcPGop9WikD
 ZRh7AoYYSjHSmEr2bV/R4mVBSiHQn01ZvUUSMy39iw8CQT2ECXmIO0akjk+9h1p7oumUktBYMbf
 n8UnSTmhpnlqhjVj8/IXFRxiOWt/6rFn36JZX0nYt+bHXPjjBzWlELOpPN1S/FQGePOrkMm1v/n
 frKyYaCiVU67YoRs5so5uPUqbfRocD6DSjg4CzeXwzjgHtOZExiSe7Jk86FJrMggONs+p7/lU4J
 th1ebdGCRZ3Mc8Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This sysctl knob has been added recently, but the documentation has not
been updated.

This knob is used to show the available schedulers choices that are
registered, similar to 'net.ipv4.tcp_available_congestion_control'.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 69975ce25a02..102a45e7bfa8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -93,3 +93,7 @@ scheduler - STRING
 	sysctl.
 
 	Default: "default"
+
+available_schedulers - STRING
+	Shows the available schedulers choices that are registered. More packet
+	schedulers may be available, but not loaded.

-- 
2.43.0

