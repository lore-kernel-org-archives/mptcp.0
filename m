Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062843D561
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948372; cv=none; b=lcv9xu6flsAXe+QsqyFN3B56JChhRphwtS+acaknlgBkytrCCmY2PL5kNINnp/UqMJuFv1W/CzvBaiR0RU6pCUamft2fYR6Vwg/raEXk8ujWAcZOYq6hrofK9BiM4ZQnKUlo+hXbWo5nKaWniJVvI/ApUwpOc5lSf7jIfdRa1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948372; c=relaxed/simple;
	bh=KJy1oD0rz8jZN/MiejM4nt6kCv65wYS5whGAj7X00Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=As3iw53aUC3WSzcBoOCv/iJ/zK8buTSTtKxEKS2twIwgAE1s98m5ia+TPoIAposyt7q+pHB2Ld+2Y2SW1YjWJRKifgAsdJ80Su/3AFZmgIiOjwK60U/Sl/XdbCfqTaWoViIGfPExmXDLBzRwqmqPXBAaERzF527eIwI3Aail4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaCVtajN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaCVtajN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19092C4CED3;
	Mon, 23 Dec 2024 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948371;
	bh=KJy1oD0rz8jZN/MiejM4nt6kCv65wYS5whGAj7X00Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaCVtajN3vqqhPBAOACJZ3VvwRrvKkZa3H91+ko5TMRphO4JqQM+t5wvWODHxgVLn
	 gq/EEyTzspOQe1XpLd015umQmtcuvWTF0hB9exEO1y9qR7J7RQr2cFki4SkEb6s8E8
	 z9k+eaGG6HGOmjFZGZK6WlX2CUIIGMkIDDdIIiJ0hhbWGhcqwu7zf+vaGkweU+6fQ9
	 73pG0xbR/wdiMTg8S5hx8XlzjuYlY0eB7ikvWJ6VwLu8GZQ0S3t1Cpz6zjgo6Gsxrt
	 MNFVCsuDA981BbnBtEfA05XfNV2HN41Yz48cmZcKYZYCBLGiwFz+UhiJPczKHRJrV7
	 hBzZ1KHQVdYXQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 04/10] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Mon, 23 Dec 2024 18:05:46 +0800
Message-ID: <f132a1597e4ad525b403028258493384c3a251a2.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
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

Drop struct mptcp_sched_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 57c4606a26ab..ea8098c6add9 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -178,14 +178,12 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 	return 0;
 }
 
-static int __bpf_mptcp_sched_get_send(struct mptcp_sock *msk,
-				      struct mptcp_sched_data *data)
+static int __bpf_mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	return 0;
 }
 
-static int __bpf_mptcp_sched_get_retrans(struct mptcp_sock *msk,
-					 struct mptcp_sched_data *data)
+static int __bpf_mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	return 0;
 }
-- 
2.45.2

