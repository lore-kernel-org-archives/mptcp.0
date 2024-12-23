Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BA1514CC
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942626; cv=none; b=oDHEt1yJFxnmRUmjlqVhXFsxZb9IMkwWTQdRGaB8WDtFFLuLp4uejPz9MOVV6KZMlTiqwubru2gRqJUxtWaq+jecBP7GmE8LSCCL3l1HXL5HmjGKAOJB4afAl5kzhUwOBFQi1wHpC1YzW9or7QDT+zaq9oI1wnUOaVbRZgfSWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942626; c=relaxed/simple;
	bh=MnplbIa5aZflN54kg3ewAWhVKcNBCX6oRBVowXEqfZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4JboEcwUh/bTQJqFl8gTCH4zf8w1U6ICVlUh4TPO3gva9fNHT8BdOrAtVu2OmuAdHEK0pDUKyN68bgRCG/54biNcd3mzUDQTeodKmVqApP6Rqbzvg5B4+X+QJY0a3PGeCmIQXNFKRYS1hOAqYPLHSHilonzMk++XpqtmC1X8Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxOpJawo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxOpJawo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A17C4AF0B;
	Mon, 23 Dec 2024 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942626;
	bh=MnplbIa5aZflN54kg3ewAWhVKcNBCX6oRBVowXEqfZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxOpJawoQos68atz0Y/Gi15LhU9QT715dDCvmZJxQjOrDUzijglnbKzRnIZbZ6fOj
	 R9gQWy8SvKxoGxrTljVUeb88wtxbmpK5LsWx6VM0NBFLRNUK3vM1TlyPm7zlUKekeC
	 y/6Qi31Q5/Wk9pF8zJwlJUstJ2mwR+KTOQRHZbNfkKfAypc8ZpTONRZltZVPkHwXdM
	 i2bqA2aGWy2GSpfpSPQclmmIsMLoMIPo5Vi7nG9kHgm23mbJNnz3TmZeFyNN1qzu3Y
	 TbXpp5ub468u1urSdx1Lkr2fOHFBf9lQh3rsepjBhIhpgnbK5IKLI6051OYfrWDZkN
	 8ESHN/VFtz11A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/9] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Mon, 23 Dec 2024 16:30:08 +0800
Message-ID: <abe1b5ea6fd9e6913979cdbf6c249115d894f340.1734942318.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Please update the subject to

        bpf: Add mptcp packet scheduler struct_ops

Split get_subflow interface into two.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 923895322b2c..8d4865177037 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -156,7 +156,13 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 	return 0;
 }
 
-static int __bpf_mptcp_sched_get_subflow(struct mptcp_sock *msk,
+static int __bpf_mptcp_sched_get_send(struct mptcp_sock *msk,
+				      struct mptcp_sched_data *data)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_sched_get_retrans(struct mptcp_sock *msk,
 					 struct mptcp_sched_data *data)
 {
 	return 0;
@@ -171,7 +177,8 @@ static void __bpf_mptcp_sched_release(struct mptcp_sock *msk)
 }
 
 static struct mptcp_sched_ops __bpf_mptcp_sched_ops = {
-	.get_subflow	= __bpf_mptcp_sched_get_subflow,
+	.get_send	= __bpf_mptcp_sched_get_send,
+	.get_retrans	= __bpf_mptcp_sched_get_retrans,
 	.init		= __bpf_mptcp_sched_init,
 	.release	= __bpf_mptcp_sched_release,
 };
-- 
2.45.2

