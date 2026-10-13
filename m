Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707A3E3DAB
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874620; cv=none; b=bg8dBivBeevkMwWzPbnpCo34U0kYtPgZ2qwIuGbe9au62W3ziKnMwnCuYsG9eiuB6f5yAu+jBun/mWPxsmoKt62bRwtvOKoc1QaKAIJYUME3ZzNQxJj9X6ay70jK5qh4daXqZgelTVaClSqsFRhEpYan8lDSBfk2C9IM7WcG0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874620; c=relaxed/simple;
	bh=IFmpeGLlzH1arne5y9/HHPfDxlUiT7CtRs+bs3W/6EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQee6TN5D8npdRPgIgpklOqcT54cjXIuE03E7VbhVpTBrxKfGMLU0/HUT5l622oOnhVbzeQyfL8xsjq+txzx/ngi9WUX5jhS7/LIk0dmSZ4PQuowWJtG9xDMlGxU9CAROdqJcYjakaaEdBOkyaWB5REEX1PBr1lBgQICcSVbuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8zt1hwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8zt1hwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7154C1F00893;
	Tue, 13 Oct 2026 06:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791874618;
	bh=I110+WjKet/+uDCX6s9L3jDfyDjwyposa2fxzfVsfGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8zt1hwamHGU0A3yV34dHjLEs23YaBbmSwdbdiwX+RtGb0CB/BtWgB0Gro4aNaGQ2
	 EXpz2gKTnyLmpS2OpCQ0p45mpBXw5KSwXy1taXrgVR7m34LHkM4It7MVhgk3pvBLrK
	 XPZ3ED8bERMH2EyuCLOeM9THWFmwtoVcE61wRDokBeX4FJesZM/Ff470yKelN8ejdn
	 7j9bvSsOb/itoX0X5H+10etJfZd0EbWBN6jAIGADeWK0lXwF0C/ao9v2vKNi6kxang
	 nPEC216XlbXjP6FuDaJ4LRBT1hM079NCL3/77sKLEkTSI9cY31MqmbBS9YRpI2w7UE
	 rITa7wh8iBV9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH mptcp-next 1/2] mptcp: add msk_is_mptcp() helper
Date: Tue, 13 Oct 2026 14:56:46 +0800
Message-ID: <1b21558a40905ae312d2ac987de4db0a04db3c02.1791873760.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791873760.git.tanggeliang@kylinos.cn>
References: <cover.1791873760.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Introduce msk_is_mptcp() to check whether a socket is an MPTCP socket
(IPPROTO_MPTCP on SOCK_STREAM), modeled after sk_is_tcp(). Unlike
sk_is_mptcp() which tests a subflow socket, this helper takes an
MPTCP parent socket directly.

The naming follows the convention of rsk_is_mptcp() to distinguish it
from sk_is_mptcp(). This helper will be used in net/core/sock_map.c
alongside sk_is_tcp() to add MPTCP support for BPF sockmap, and in
other places where MPTCP parent socket type checking is needed.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 30f0e8ba88a8..8943d9f2b48b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -150,6 +150,13 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return tcp_rsk(req)->is_mptcp && tcp_rsk(req)->drop_req;
 }
 
+static inline bool msk_is_mptcp(const struct sock *sk)
+{
+	return sk_is_inet(sk) &&
+	       sk->sk_type == SOCK_STREAM &&
+	       sk->sk_protocol == IPPROTO_MPTCP;
+}
+
 void mptcp_space(const struct sock *ssk, int *space, int *full_space);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
@@ -261,6 +268,11 @@ static inline bool rsk_drop_req(const struct request_sock *req)
 	return false;
 }
 
+static inline bool msk_is_mptcp(const struct sock *sk)
+{
+	return false;
+}
+
 static inline bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 				     unsigned int *size,
 				     struct mptcp_out_options *opts)
-- 
2.55.0

