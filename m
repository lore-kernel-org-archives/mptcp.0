Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEF1EB5C2
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438005; cv=none; b=B81h/FyTjfz5bkGAyNJm1v/vbY5vr6sZS++94cn1+gPnGB6eQZtMjoxEPvOGH99FQXXSfZvn6pWdSMcmM2/Wzgvxqd4AxX3ydRiN/q9NpDzHE+857Xg46LIPDJP7Scjz3jd63Mck05kG3J7buAechIRUvrv92ZD08i8pX5x3b+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438005; c=relaxed/simple;
	bh=UG0CRXzNwszajqgpTvN9x/gr894ZfJfvrQ09IKi/byg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JhtYZewOlwcN6vbt9uOqxjXaSg2oBe+IzdtzEGgd23caNh1H8Fdo6R2xJTg2vifKGNFa2OktRf6Y1EmKkl8NzJ6iPctU+tZBtyGeVZLw2MajEQqJQbSLBuccLTMBhjdgZ4hqL3TaXs814w5RizQI+d9VypMiyZycAfNzd6tv6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmQJXJpF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmQJXJpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24BAC2BCB6;
	Tue, 18 Nov 2025 03:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438004;
	bh=UG0CRXzNwszajqgpTvN9x/gr894ZfJfvrQ09IKi/byg=;
	h=From:To:Cc:Subject:Date:From;
	b=tmQJXJpFbh2OSG75bcYoWBl3rfk0bMK/bxMA6mPUWzUO30quCvGWp+uX4E+mjC7F+
	 Zohh0F+H+YDNgLfxGjQCo5Ofc+8HegGH1BoZCNFkcLNGqy503QmgLfhDR9lD0K+nQx
	 4iOSb9ZheMpOu7i517u9ORwM6E27Us/2J3bSGxJtXuXVT33giMT0/4RYS9MblZz3R4
	 IwZJL36r6fhC9CjpV7lLuFv3vQbtXY4Jn411caDmt+v6YaFR80WpXKGPEpEbgcAyM8
	 Ucuq+bNL4DUw3ujw0KySNf4UVXeDFaK/4z4BYF9Mu1BZDqSZ+7sK2n+JkPqUmEdfXv
	 RDQBGsJanrVmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "mptcp: implement .read_sock"
Date: Tue, 18 Nov 2025 11:53:18 +0800
Message-ID: <3bb22c78b078988462e13e72aa6fd9a29b07a8a0.1763437914.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Squash to "[v13,2/8] mptcp: implement .read_sock".

Add sock_owned_by_me().

Based-on: <cover.1761198660.git.geliang@kernel.org>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c64494b15a40..873c1a93b777 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4304,6 +4304,8 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
+	sock_owned_by_me(sk);
+
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
-- 
2.51.0

