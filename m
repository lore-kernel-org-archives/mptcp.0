Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E56440A19
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075743; cv=none; b=BZguBCjwTumqFSCuF4DzH0kEguo0eN5r6ZtiTdKGarGa73Ker5JkerjjREwEqFwso1ktCLmvTI/1gzXTUZGMlcb/RF81rZHcYSJfL9j0mLBpdsGy/aNRlxukpeJJLipsdf5gT6gL6NcUd43gMFaSy7d0XuQbREAF7qJ8kMh99rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075743; c=relaxed/simple;
	bh=ZdV/PUgYUQ48rhd44h0OLQLKEe1C0FwAPgygZZPkS9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ut+BkhjUt2wMTnYb2LQDYPgmSspt2EcgBjIbrj6Y4W1s/d5O0riSRkFpG5tdVO0l5y0QMQXZjrmFMibhOGDiOzEeYlcB3kwMxyminVTz0zelfQ32QXcSTfBmsSd3l9h1oiNmK+DXwtrgEi2Qgj1ZpF5kCqAiP522NAj3ur3EhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+hYIYar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+hYIYar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C13A1F000E9;
	Tue, 18 Aug 2026 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787075742;
	bh=2rPuI4YsIP+CfdMx79w18+wJWTYDh+dwEX6Pys3NYss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W+hYIYarYMHQy6lzYOavw9M5f9nX4DIHZ8TZuAy6g3kb/00QGwCg3uGCcvLiHcVVD
	 FWIsz2WDCRAuWZKDKvCE07PsZEGAguh1LhPGSCi+7PKGwmaQGbi71TO0VQv2PMEm73
	 Twi0ttuDbS/S9ZlFEwcquKvpqW7ZfKru11k+jKL2sYAaFsnd25LODUYoG/KVgMVBnu
	 O1nXF1sHRH5RSAiH8UACJQJ/6uN1nGGqCWWvSApFqjCWbKwRyTmVoYI/at7pvwpM4p
	 P+RVfcAFnEqdhdIhlwry770NpGK8Qrehq+Z/L4rdiJ2tCSmwsL8+U7hbG7SWNCrGzs
	 oXeTLtfqC9mbw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Aug 2026 19:55:26 +0200
Subject: [PATCH mptcp-net 2/3] mptcp: subflow: no need to copy thmac during
 ulp_clone
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-mptcp-cook-reqb-v1-2-052dea9a7f20@kernel.org>
References: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
In-Reply-To: <20260818-mptcp-cook-reqb-v1-0-052dea9a7f20@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZdV/PUgYUQ48rhd44h0OLQLKEe1C0FwAPgygZZPkS9Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJa5syuF1VsWMlx2CT1xJ3HnH8a/CJkXk9I+6BbacA26
 4bivqaajlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkcUGVk2Pt58vf+Z28d7/Ys
 W6TxtSLrrGjEuUUGjpap1bZzOx3PpzD8r8rrSnH/kjrNvG7ut97dH18Z/mUIU9PXWsB/ln35wdN
 9HAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'thmac' is not used after that point.

Indeed, subflow_ulp_clone() is called when the request on the passive
side is over, so when the truncated HMAC is no longer needed.

Note that in case of SYN cookies, thmac will not be initialised. So
better to remove it to avoid a warning for reading uninitialised data.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d..01db7edce18a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -2084,7 +2084,6 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->request_bkup = subflow_req->request_bkup;
 		WRITE_ONCE(new_ctx->remote_id, subflow_req->remote_id);
 		new_ctx->token = subflow_req->token;
-		new_ctx->thmac = subflow_req->thmac;
 
 		/* the subflow req id is valid, fetched via subflow_check_req()
 		 * and subflow_token_join_request()

-- 
2.53.0

