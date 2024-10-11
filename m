Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAE804
	for <mptcp@lists.linux.dev>; Fri, 11 Oct 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638867; cv=none; b=Jl7prsf7O8rSceQQHuNdUQ5mpexxT6IyWw/o1w//uhnzMIAhRnZxNnXHmE1yZfUUeUOOSdwFPiVrONbRykj3vt8EKDlboEr2f9Qbm6z7wgywU+BT3BLAPcbqS238BLWRqLzS9+uWs0ES3pJl7P0+/XDHYzlGEq1LHKsuxkgZ9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638867; c=relaxed/simple;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad7Z5agCM0mnPgQjFf7uwjqtW433YRJaOzeXgxO/olwDUkK+Oe4611ABr2OAedK9b4u5mIUUZd7rdgqEWzrZbpkL2X6SZ1Uu6hfaoTrkG90D7IpzgmSLYSCb0Rw/flqUGvf7JgqAJKdUIk9NIZcf0aAO6Y0uoaaPxodo6Ffg9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umX+85QU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umX+85QU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D465BC4CEC3;
	Fri, 11 Oct 2024 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638867;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umX+85QUxec6rRDkPcWITBLBE1pZQFteeuHIhrFFx/5wF9pmOK0XQmZgTbzUh3Rlh
	 vgzAuTpHrkO6Y/0iJftAt0QyaNISJIk7WgqvkZjd6X4AotwhotOQ1P6YBkH9Y4w6rE
	 ck81v0giqF9Z8cIYf9yDVbL3MPu2vb5OmPEfqhiwGSz8UNAfnemYS/uKO+woFiBBX8
	 cdBoge7hvdvsuyvX/NXbx6gpKmzn9g4oWW8nSf5o1NFw+5tzJq0mtjfjmq+5/c8qsP
	 6IqsWxYoIl+lwSd5Fe5WQ5yLoZ6KKRmDertA3YMTTIfPB4lQ+mEJD5gWHIvPpKZ5gW
	 48G/QIBFg9r9Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 10/11] mptcp: drop subflow contexts in mptcp_sched_data
Date: Fri, 11 Oct 2024 17:27:22 +0800
Message-ID: <6542c05c6e5f2d18b9a4845900b716a075bdbcbe.1728638310.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728638310.git.tanggeliang@kylinos.cn>
References: <cover.1728638310.git.tanggeliang@kylinos.cn>
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

