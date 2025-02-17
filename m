Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A8101FF
	for <mptcp@lists.linux.dev>; Mon, 17 Feb 2025 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788896; cv=none; b=ny4HUoqxFrgdP5KPCFSMGHJYxTOdKBVddSQcn3zhXsK+jwDr5hTIpwizxiNg5B9unw4qnRFOq+Gnj/MFt5PlDFhEudQfUJrfmJrD2+FVais2Z7nvVzgzbt7yJalrS7CXmEXNLt22mqdBuUVeY5Oz58j22aSyPosaakUmDlXBZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788896; c=relaxed/simple;
	bh=QH8lswTyWVWhcaVom/XLC2qNwS0O3SXO+M66ZfsxXTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNCT1Y4+WkXa44+sV9YMdZIpeATF6Ub8HJZwxp6d/T3Qk6GWxyZZYwqBOXLXXY7aVUKCqnYef+oe5PZM8PoqmQ2NkYfarB/SQpvfLOBIpFEhAZWSySpj+GH4tP6euzxWFDKxbZEFpyuVCRNqXEnqdq9ZykJFpTyp4rTthfDj/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw38xLUB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw38xLUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DD6C4CEE2;
	Mon, 17 Feb 2025 10:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739788895;
	bh=QH8lswTyWVWhcaVom/XLC2qNwS0O3SXO+M66ZfsxXTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qw38xLUBDRsTx7mg3IP+0lGf3nX+aB12zCPSthjclkeXI5zwp9sdjc1PzRkf1IHIi
	 sExUBXPRDOI/xRj0Tp0b3e66lTvpItMTwxaL9uAt4QLkZq/42BmwSCPQ8d+fr2q7+7
	 1CqN5y4JJgidWUSx2UK10hqm8z2z79v2F9Y4xsmit6jc29hS2OYq6TLR6xjWTFKIyh
	 cX+V3G7KEPmm+cJ7cy5woeEZnHmBpDkG6eQWWic1gqyLSyHMbzhwjuL0TU2CeuruBg
	 lytJmaE4iDjiQ5U0P0bkqAHF5Ui5HuKRYPXlM3vpuKdyAAEwdH4DtNN/NlgcU4oP33
	 oKrMJOLjzTYOg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 8/8] mptcp: drop subflow contexts in mptcp_sched_data
Date: Mon, 17 Feb 2025 18:41:18 +0800
Message-ID: <c5c2a3787d92bb5679ca9d256a8f15fff66c5cdd.1739788598.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739788598.git.tanggeliang@kylinos.cn>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_subflow bpf_iter is added now, it's better to use the helper
bpf_for_each(mptcp_subflow) to traverse all subflows on the conn_list of
an MPTCP socket and then call kfunc to modify the fields of each subflow
in the WIP MPTCP BPF packet scheduler examples, instead of converting them
to a fixed array. With this helper, we can get rid of this subflow array
"contexts" and the size of it "subflows" in struct mptcp_sched_data. And
keep struct mptcp_sched_data for future use.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 2c85ca92bb1c..df87114deb1c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,11 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SCHED_MAX		128
 #define MPTCP_SCHED_BUF_MAX	(MPTCP_SCHED_NAME_MAX * MPTCP_SCHED_MAX)
 
-#define MPTCP_SUBFLOWS_MAX	8
-
 struct mptcp_sched_data {
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-- 
2.43.0

