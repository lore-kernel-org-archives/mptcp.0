Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDA1E511
	for <mptcp@lists.linux.dev>; Sat, 12 Oct 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740566; cv=none; b=lns94j02e04NHXM5oSgwQ7Xp2tud1o/90/fe8ZIQLnLe0fcF4lbL6r50v5MU+HlfWZFWBYV2gW+8nKdNonih3orMQBrwY+2ewFeEKtGu3TXu0r1kIfjoiRt6liXkQSRqY6EC1cjwuaCeYQynGkfedh5cZdqCNLz+mvTrdxIWSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740566; c=relaxed/simple;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/pThD5+xm2PTG/MUw62RkZBvlHUBKPm6vAYqsp6J3P9DVHHn5SZdqaRoDG0bfDNk+rpkk3w1Oo/b1aZiB3rGV9C5FhZDuJ2ZQsw29eZtWiernMwQQaRj7i2v5WkZYagNEkyyNWTR8BfzMSii7p+xC15YYcEfE+I6PyXEbqZflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou8y3aGm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou8y3aGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A3CC4CEC6;
	Sat, 12 Oct 2024 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740566;
	bh=hN3agyD3X5i/gzavJ94nZKXl6iKgXdKHAjxn48A3d+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ou8y3aGmD3O009eO+udB0+2uYqnUBrzGlkU58f/pP9qiCBNci+LpkwIproM428Xr8
	 O2AHYKJqdRN9xxarGvDG20zkFJmdts84re0QPJDxoNq/yqCqxjM++/RZ/sMRegDhOn
	 YSORFCyiTD/43iFIEYFMwdXJkjm+1ncZ3uzfhMh0/epybidZJ343RSeEH8c/yRN0XN
	 gBPReh6Iap4tBYYvaT/lmpKe+khbu9lmcnAOAjT0ALxTfDT0zAtiOfgP+lMuBHUAPs
	 zcuRqoeXUF8WSzEQYqEy/DpimaJOcbsB9XD/pEneVIODwFzkkCXCt+EgU5ICyOmEsQ
	 QIHhAoQL+9rmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 10/11] mptcp: drop subflow contexts in mptcp_sched_data
Date: Sat, 12 Oct 2024 21:42:15 +0800
Message-ID: <b61927f327328bf76ac3404a319cfaeb9384d486.1728738220.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728738219.git.tanggeliang@kylinos.cn>
References: <cover.1728738219.git.tanggeliang@kylinos.cn>
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

