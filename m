Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D138171E4F
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853566; cv=none; b=HTtZJqe9BkQXeVjFL6mKnYUfS2mjrE7+ftmiBdJlqJXhrI5MLiua54HQTG2YFoxWBydfYbjox5tfAR1kPBmulmwwe42gx7DxlHHy3D4AxmQE51GlA3uxLWX4jewGpDcQahKrXlpAIfN1C6akzbCiw3AwC0fAlRVHmBQIOG49LnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853566; c=relaxed/simple;
	bh=NMfSo/BWgyFRZXBAlo7PBd8RIfso8UCUT7cUYKAlSY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeSR8K7XajGVfe5OaNCsVVjl89hLsfhbHX8D5M6cUKunv4hGWAO7qas+PKGx+SNAywCioK1gb0lpJtwZg/p5SAJ55N64DAoslWf8MnRy9NzT+lwu1nZvsC5inaNKgMX6dhRmzCH+ElY6qhJ6Vtwy3KJ7NXwjbfkRk4YLCnU+p0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pypNZvTy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pypNZvTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7175EC4CEC9;
	Mon,  9 Sep 2024 03:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853565;
	bh=NMfSo/BWgyFRZXBAlo7PBd8RIfso8UCUT7cUYKAlSY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pypNZvTydM+L7mf5jkNBrL2bsFvMGlogBzyVfvc4sWVpqopOs0PFynIFKe/HHxsOP
	 8mn17SCffMuuBzH2Co5txdunoJ5HjI8XgPmUCGAnzIS/+ve7coCV3COJ7rSEvjUzmC
	 KIdSejkWnHJT9y/IzMxBHwudrSb2Ogd3D676D4YYPv3TigANjKG64Hzacme4liErhb
	 B1JFWmRE710pY3a+/vsok6uzPV4UiGUZYdmjh1bcp4ST8+j21+17tm4WYaJ+fmNBQE
	 LUd98P0XfUFcqmnqejKjoQRd+CTcSp3pe6ekW0i91bTJmEPB6unOaWWQxM6aK6W3sW
	 36OSBM4R/XpZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] mptcp: implement mptcp_pm_connection_closed
Date: Mon,  9 Sep 2024 11:45:56 +0800
Message-ID: <c073a099d8e00c3183d2e4a15adfcde4fffd7fb1.1725853370.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725853370.git.tanggeliang@kylinos.cn>
References: <cover.1725853370.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The MPTCP path manager event handler mptcp_pm_connection_closed interface
is added in the commit "mptcp: Add path manager interface", but it was an
empty function from then on. It makes sense to invoke mptcp_event with
the MPTCP_EVENT_CLOSED event type in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 3 +++
 net/mptcp/protocol.c | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 620264c75dc2..16c336c51940 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -154,6 +154,9 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
 	pr_debug("msk=%p\n", msk);
+
+	if (msk->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ef59e17d03a..a12149d8f718 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3121,8 +3121,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d\n", sk, sk->sk_state);
-	if (msk->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
+	mptcp_pm_connection_closed(msk);
 
 	if (sk->sk_state == TCP_CLOSE) {
 		__mptcp_destroy_sock(sk);
@@ -3188,8 +3187,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_stop_rtx_timer(sk);
 	mptcp_stop_tout_timer(sk);
 
-	if (msk->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
+	mptcp_pm_connection_closed(msk);
 
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
-- 
2.43.0

