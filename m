Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8FC20A5C3
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150535; cv=none; b=WsF6UbJZt/ED860iDzf4xdjySt5B+pipSSfcafcx2k2FKUwyj899DlvA0sy7pjYJ2OcI6DB7lGJcNGuWQMdDQ6fDyl4udzY19JURNuZCONmp9ypcSsnaPSStwx8NXRdYRLlrgiSu8LzDEEMRPjAImhovPRnZZuYQ4+3XE9yx9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150535; c=relaxed/simple;
	bh=gVnmfG/Jk809zxkJ47HI01joKTtxC0QiYVLumcmsEhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evd0z+xeA5umIAIEREoyQfShUK5B2kmGrUmvNNMDsdmGPjw4MEcuObpTrGWFLox7MsP7vAfCXXreMageVj57QABYGnY9Ibk9ZF3vjMqqqSrY436bF4f5J8raMEO6t1dicTHPtjCHIy7sQgemMaQcFrQ3N6wM/tR6cwqgXp1wAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKYHtvCU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKYHtvCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309D9C4CEE7;
	Fri, 21 Feb 2025 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740150534;
	bh=gVnmfG/Jk809zxkJ47HI01joKTtxC0QiYVLumcmsEhA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WKYHtvCURe84P+jcHxKCUHuNrofokMitopvJ9xJ+FwsuUnRjS5X1tAGVFn1pesv3J
	 AgEu9wlyEdnfN9AmPXdSphAPP6rd4kFTOeIt4bIncOYKGQHCQ/fN1m4ei8KT90r4ui
	 WQXAAFxBDFPkM3pzwRYTKcBxaflr3cpUjd5zMfN6ngc2fBRK5O6vMl5TCS+I2TzHNP
	 5M2iRZFq9jwqVbxMyJZIi9wSvI++EFi6uuFkEKHU87yDE6Lf/60htIe6i+A5HexGnU
	 lq5Cdpc9iiMPmQlxHDNFxRQffaZrCcY9LhkpRW+wDVDjdNLLJLwcl/9nG4mwgeieIE
	 HQt3OxKTHUAPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 21 Feb 2025 16:08:45 +0100
Subject: [PATCH mptcp-next 2/2] Squash to "mptcp: add sched_data helpers"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-mptcp-sched-data-ptr-v1-2-dbaec476fa6b@kernel.org>
References: <20250221-mptcp-sched-data-ptr-v1-0-dbaec476fa6b@kernel.org>
In-Reply-To: <20250221-mptcp-sched-data-ptr-v1-0-dbaec476fa6b@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gVnmfG/Jk809zxkJ47HI01joKTtxC0QiYVLumcmsEhA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnuJcDUyF7hoBpqnADCOYHpHUzwVm2gjBbFog/t
 FXx7SrZSUKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7iXAwAKCRD2t4JPQmmg
 c1+qD/4lu1HH8tW2XjAp16GtWgUnu1CWsKGtct5gXzeOepUwZdIwX2RqPSz9n5MaocQAEeBNmdb
 o9/6Xqubq2Ag0BSxP4kUrc0DqP0q8+aYB5aNqBb/NUL6RQCjRgYTedhBzF4TvwkKTqzEGBPR5XC
 D0QKD8tiOVto9I6Gr+y0T0JfBXZRJ5fpTXByWO+2lmuqA9zMAQvaHl0TLGuoqeyXry3E6YhYncY
 jf729utTyqfHs2B8VHGIJTsA6SoXwSdRz0qtR8vRYyOzYZesRwWZ5HGlyuvFSCZJVDaoykc+TB1
 A8FkHHd4prV5+wCDZCspNJQ/u7jFolr7VaLi0Hf+cVZm0aFALJP7zZT0tjg2sPva5rZ60ANJ+s3
 FIitWohd44hS4D+MsW/+SbQ4DkRZa6dt0hFaIBZWV+Mt3Q1NxQMs8Ys4rDUYJXM2nOLvhnBGWjB
 oazJeotCuKQZN7eBpcZ9we8KPtbOqMbHpi7DRaTtsjdbAbTaVOFReJWECn6/pq25Kjff9Pc8u37
 FPnkR7oQN9MxWZtt+aLF72EG1yA8lCGBZijJVq0w4JjhLJelPPMlM4HeSh0jPLV/4ZuyLOmb2eT
 So39E9r+72RzkmIaavaoj/jehhk/DDld4GeOllctzvI5YhyV4pFPn1zD+f0uMT4JaKOOhhyZiz9
 zI4jP4MuZLEmP/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

"mptcp: add sched_data helpers" can be removed when "use bpf_iter in bpf
schedulers" series will be applied.

Same for the mptcp_sched_data structure.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sched.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c8e08f6c300d37584d3d89a01022b5677aa8b6bb..37d86aadaeaa523568a82ffb22254d1fb34a3d2d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -177,7 +177,7 @@ static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data *data = NULL;
+	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -198,15 +198,15 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_send(msk, data);
-	mptcp_sched_data_set_contexts(msk, data);
-	return msk->sched->get_send(msk, data);
+		return mptcp_sched_default_get_send(msk, &data);
+	mptcp_sched_data_set_contexts(msk, &data);
+	return msk->sched->get_send(msk, &data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data *data = NULL;
+	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -220,10 +220,10 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_retrans(msk, data);
+		return mptcp_sched_default_get_retrans(msk, &data);
 
-	mptcp_sched_data_set_contexts(msk, data);
+	mptcp_sched_data_set_contexts(msk, &data);
 	if (msk->sched->get_retrans)
-		return msk->sched->get_retrans(msk, data);
-	return msk->sched->get_send(msk, data);
+		return msk->sched->get_retrans(msk, &data);
+	return msk->sched->get_send(msk, &data);
 }

-- 
2.47.1

