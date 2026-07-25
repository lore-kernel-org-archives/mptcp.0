Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F612459DD
	for <mptcp@lists.linux.dev>; Sat, 25 Jul 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985251; cv=none; b=IsYrXThuUktU/2Trx3xI+BSw5lDE21/us11dADgR9PAYZN33qQgtJ5vfMUmCVUtA57/qYdrTjJJjqG1qvulvZ2QMZoDtp08UW6TcGKPjmHEcirEJ5ffkBf0k6bhcZr+hBOgJ9TW93xDrelZGja298cWGsRjuanFlM8yBOK6YwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985251; c=relaxed/simple;
	bh=h19MppLedVsX1Ds15hz0Pe+O4tVFqGLXYICSVC30XbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv72JfWkkAVSVYOYM+fd1Pcj8bu/lQB9DZwoUuJd32jlwP7ieehqIO1sUH2VfnkMQ+1KxzuB5i+euaapfz6FdJkVuy/4tOabanDTs6M9pToA5Pv+He3Aw6fcKLxGt5kDfk4TMe2tq8P0/HHvJKpbBAJYWKjk9krmRXDkn4Yr/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXWn1em3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXWn1em3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EA61F00A3A;
	Sat, 25 Jul 2026 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784985250;
	bh=jyhh3FSG7/pumiagk/fTo7BJPLJDBvO3Xz7ejsM7DrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bXWn1em3bD32QAeQegTrKQvEkexuQVtHSFI9EEzPsoh9YvYERg/QC7ed9FrBzsS8B
	 6TBAZrtK5LJwlQTL+1aWWsbZDwhkLUqPyQUraDqFNAdqUea2vkpUd1MBS9yz6e9jSY
	 AjRsphaS/GiimmPhljL80PGx7fPb6nxLeIHZscg8jDnfp7oG0yjvPwNfUZK2FbgdNE
	 KXSATpJCekQxsI2B4i09NP79WXVub7KtsRaED7DnUewsyTyq3xTXa+LGrmIxVq6TwJ
	 s+Ux0gWPrgeWuNIiEZkMJ+1POORSaFa2kwr+JiB9n++xwadBOHanr5Hb9KkEmxkX+7
	 J6HscJ5lAvQzQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/6] mptcp: copy the subflow's rcv_tos to the msk on accept
Date: Sat, 25 Jul 2026 21:13:38 +0800
Message-ID: <8ea981071171105d5688a5c4a182a9c1f25624eb.1784985085.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784985085.git.tanggeliang@kylinos.cn>
References: <cover.1784985085.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The server-side master socket never inherited the tos seen in the
peer's SYN. mptcp_sk_clone_init() now copies ssk->rcv_tos onto nsk
so inet->rcv_tos on the accepted msk reflects the peer's tos byte
(matching plain TCP).

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 954e20bb27de..178cd8de990b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3699,6 +3699,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 #endif
 		mptcp_copy_ip_options(nsk, sk);
 
+	inet_sk(nsk)->rcv_tos = inet_sk(ssk)->rcv_tos;
+
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	WRITE_ONCE(msk->token, subflow_req->token);
-- 
2.53.0

