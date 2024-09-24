Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F591155C94
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170135; cv=none; b=fIQOVQ2jM98PMoq0qtoF9G9+ziycbkEglZx7BEP+HmVuxtVcKaH7GdIog45I5O5yolwZGFVlA9FYi99P2q94nwwFWPFYMgsbtMjlkDcb3mFkwwiE53tAwtvJbVdj13gt9QutslhheOtIbNFMhy9xCiR5MkAZILivXxg10EutI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170135; c=relaxed/simple;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhWU2BXN9OpGX9gAUTNxN2TS9VqnlgrIyVKtIXCjZfs4cYOaQDuqvayuSSykXmOTcigB+QFDt5eUeltFhvZMDMNpfCuUwTmCQdkabMjiJqrG8IwjULqJ7T/a3bdpfrJw7yy5H/UxDHbvEtDph6SVNGL7SIHICODcdHoUH8zDKPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnvqH1MX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnvqH1MX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46297C4CEC5;
	Tue, 24 Sep 2024 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170135;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnvqH1MX54fJebrkyIwl1WbSLxEErZ1WFTHxcOryw269p/rn4WjIOGZm5IHR7ZSE1
	 zSfIKfAQ/tzGhB+tougHpWbDRyVskJBzESoGj8D1YCY4peUtEsC69CqmPW9+VZ2sxt
	 DI67OqSi72VJJmnBmaH6CuY7SbQ/jlfsOMD0YQSm2Ei9Z26AkgN4hWsznyD1v7HygK
	 mVFGcAAEf0YUxEXIhPsNNw9ne75ySkItWJtzqB3mIqtdEJZnmdzQ6+wQoWTsHtTp1W
	 X6nhApZLueJl8LCrTlvB/X4wMr5TGqQpS1e6ad4XtOHlkg3RxdkhRKLKQIdC1rb5rM
	 cvxi/hF8d8XIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 8/8] mptcp: drop subflow contexts in mptcp_sched_data
Date: Tue, 24 Sep 2024 17:28:36 +0800
Message-ID: <7de75b35ee8e2159cce7a3259a047eea21f398b2.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727169534.git.tanggeliang@kylinos.cn>
References: <cover.1727169534.git.tanggeliang@kylinos.cn>
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
"contexts" and the size of it "subflows" in struct mptcp_sched_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..84d67947a517 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -104,8 +104,6 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-- 
2.43.0

