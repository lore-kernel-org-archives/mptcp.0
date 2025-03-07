Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F625771
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347441; cv=none; b=oG+9Jnhc42o8TPY/G2BfG/d0UB6x923ZysRPJ8/0Jp0VBcNAAhRHZ9yamDfYum688k70dLj3LBgX9ZSLv2ZLCU3la/UPOdM9lKw9ctSkgiw0biDmEptcEmZjABXVd6NN6mspboCjeOGiA4I8GOPkhUNer3Zc74j9N4wP+XjPpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347441; c=relaxed/simple;
	bh=hqW7ItUM/XSfB36ILy7bSow0nePwi9oZ4mxqFS0CFfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REXCHOT0AyorjCFDqHYB7nqIQhe5s+0czg8yVVE60b27iuKzblmctLIlAY7e0YxJdSuALOQKOrEgI21RN3PsnF5BJaAlJ0X8w+ZeVZ8YqAw0+Bw1AVt5bHpcZ5i86aK/Dr5YdylD5pzAzFwKrVYTRx/jgh3k1ZkWpmi6nLgF6OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujaa/Sgr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujaa/Sgr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B77C4CEE5;
	Fri,  7 Mar 2025 11:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347439;
	bh=hqW7ItUM/XSfB36ILy7bSow0nePwi9oZ4mxqFS0CFfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujaa/SgrSmPeI0PTbr4GAiDcyYgvKOjEAXyynOg6DRcB55nKCzJC2jcmNULMa5ocX
	 hyBeWMx4SA2JyQjFre9YDaQBKjRrkCkM6paM/kEJQGp58FcTESo9bgjx6Oe7cspJn8
	 A6oAp6S7fOZljY4XIPzzQhd1Hb2PTe92BS3vLNBiEPzEBoLLJASe0Agh0RcveQYyZF
	 ZT/0bU6URJKHu1pcCz+/wJSpIYMGrbCFzbVaI/bc7zEIhAn1SOOlYtmOhH3yP3nCBY
	 S4e8fmXKpVAEU9HIqb9C3/nbiMsI+E0hCOB8GTMtNRAVOVJv6quayncaHyDU1MZmLC
	 hfWuDHvVIk7DQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 11/11] mptcp: drop subflow contexts in mptcp_sched_data
Date: Fri,  7 Mar 2025 19:36:52 +0800
Message-ID: <54a6a158b655f9e19588a1460867316f6d0cef64.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_subflow_sched bpf_iter is added now, it's better to use the
helper bpf_for_each(mptcp_subflow_sched) to traverse all subflows on the
conn_list of an MPTCP socket and then call kfunc to modify the fields of
each subflow in the WIP MPTCP BPF packet scheduler examples, instead of
converting them to a fixed array. With this helper, we can get rid of
this subflow array "contexts" and the size of it "subflows" in struct
mptcp_sched_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bd3d1b3654dd..0083af204000 100644
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
 	struct task_struct *bpf_iter_task;
 };
 
-- 
2.43.0

