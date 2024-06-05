Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C30153BC7
	for <mptcp@lists.linux.dev>; Wed,  5 Jun 2024 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619908; cv=none; b=a6NzZcqNnKSJ2S1jsDvA1aQrE8oRKKLzh7GAkIcPQyH+kf4aJVLxINrRIaZRcsuL2CmcOcy1102ijjwsRQOTTiiaAaK+uaDJAkhWQR6awNM+qZRdBy4FgO7LAOZC3gmm8civU9g9rOv2BUO5CUFSBLyVhyDVLNeHWcW9vnGQFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619908; c=relaxed/simple;
	bh=6zRBCcQ+kf1pahOspWBiNH0ox+W5ph3vhYWQgH+VqSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEvwk3gFf6ty10qRWb2O1KV0hzVNEkxQ2cvIEGvWonjGguxgs/TNaeH9LT1IPfXy2cnB/0d9cy/RH7tLBGuJBR3ZZ+eQaNoNhKfUGA0ZkcKs5ttDvklm/J9v8Mor4NJgGPAYX3l3rW2uDIOFW1sKhQnIsKtq5tSSO8j07lBP/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPSS/rrV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPSS/rrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C16C32781;
	Wed,  5 Jun 2024 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717619908;
	bh=6zRBCcQ+kf1pahOspWBiNH0ox+W5ph3vhYWQgH+VqSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FPSS/rrVeIteymY/RoCgAvHF42s78Oc2dVnNrDRBWDEM4m6uRlVxQQ5RLEnhAOHVg
	 z6RbT2W+BibaIEE+MuhSH7grLpbsi0F/t/z2GHDLGoY4G4mYFGWbf3caITv0QYfFwu
	 M0do8wjtNI22ND5i9ATi35fpJpd7P6f2B5KH+6HtWle/T13xnOWLxlqAKS61XJfr/q
	 Ie0eSxjEDKw9Mch9YZVH+LhdRMIUe6bmsSn0YLhuUa6IX0474AwqMH7mANtU8m8zR8
	 Bi+f+q3xqJjASkXxG2tNtmvOg0q88nIloeqp744EMz4OnyjzMU1/8Rz1hAbCi+CG2z
	 PsXJE0uRl65lw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 22:38:14 +0200
Subject: [PATCH mptcp-iproute 3/4] mptcp: warn if 'signal' and 'subflow'
 flags are set
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-mptcp-user-feedback-v1-3-d2dc3b399643@kernel.org>
References: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
In-Reply-To: <20240605-mptcp-user-feedback-v1-0-d2dc3b399643@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6zRBCcQ+kf1pahOspWBiNH0ox+W5ph3vhYWQgH+VqSc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYMy9ymnHWPcsgyhcQ1MEOTzC6gBE9pqN1OWiE
 cEthXMAl6mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmDMvQAKCRD2t4JPQmmg
 c347EACd6zGGIleZlQhX6LVGtns88NtrzcDIRslPAHOALr6kazUCGzs9DO83YqmTsBzleNEvTU5
 qQjLBauDCGGMW0eo1wh19pfNfhVol+9OG+M3TwvXpgwCAll8FO4FBE8QmFCxnzYyaJAXwamDNQA
 gO64tEQncYd/8smMaRFs0OfncAT5UYZLCLVkusGGX3A1AedHiiHU0bnS5o6RrOZPqowAw3/QXu8
 UXAmLvj7O8UxmIR7VL/n6vPL+Mj7FE45IBUxokDGKsDdENHSHIam7mFuRm1PsnFsxvOqPl7whlQ
 iFAX9tZ0LptWda2us3l8dSNZNhnlsfobi1y7obNVblghid7VLlClaMA58frhGRQsAP3IzwcMW6K
 1KmjixFidGIwdMqwA+vuUxmiYw9TmBMrYd0mVB9YROT3jXZ84A0eAx50Nh1J3R32gzJpzE5jEB6
 SupWMRaLwLHyvxTu83gqeuJS2+Y3mnD7PwQlfyquOlItL+0bY2LAMxqBlueacrCjS+2j+A2Fh8s
 tovyuj/13zV7H7QqAVKQVNBIZl8duj4IYTtP5AUh1gNzVGvY7dSgwv43Tj2n5nXtZqvPBW++MPL
 HiKHceDojf/GSyA2YzKL6Lstgtsh+/yI1UOUUshfNd4+wMic6Ae8KU51PNFxIr3LYsoGM6x9G1Z
 lYM/nO21AhTpRcg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Setting both the 'signal' and 'subflow' flags is very likely a mistake
from the user, and would bring unexpected behaviours as mentioned in
some bug reports on the MPTCP project.

It is then important to guide the users by printing a warning on stderr.
Users can ignore this message if they have an atypical environment where
the initiator of a connection might accept the creation of additional
subflows from the other peer.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 9847f95b..0f09cf75 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -179,6 +179,15 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
 	if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 		invarg("flags must have signal when using port", "port");
 
+	if (adding && (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
+	              (flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+		fprintf(stderr,
+		    "Warning: Setting both the 'signal' and 'subflow' flags is usually a mistake:\n"
+		    "         'signal' is used to announce additional addresses, typically for the\n"
+		    "         server side, while 'subflow' is used to create new paths, typically\n"
+		    "         for the client side. It is not typical to both initiate, and accept\n"
+		    "         new connections with the same peer. Continuing as requested.\n");
+
 	if (setting && id_set && port)
 		invarg("port can't be used with id", "port");
 

-- 
2.43.0

