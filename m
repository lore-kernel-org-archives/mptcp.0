Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9672DE6E3
	for <mptcp@lists.linux.dev>; Thu,  3 Jul 2025 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532435; cv=none; b=tgEKBP8ZJpQmmwMpPIjOcFe3UCsHUIQvRCISiqImkdpNwYIZEWhaQ1FuNM3MrqxDoEmGsGKMOa1Q+XuK0WdgEbbBNtq2icyJrKwzs8yJQN9Mc8HJNecPK0QgMXYmEytLaov/3KIWCvnhUMQCEeUTFUsvYknTqi0LB/jZR+275SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532435; c=relaxed/simple;
	bh=1enmgdSSUlUjwUhztEkvtHTwIT6oCu9inFEp5Y97fLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pilJjRD7fgfNAS52njy/1ykKvhleaJMRHM5X3lQnWu1lBHS/Gw0lV68U6ZS+7XCyDU9RmCs8ZD6yfwiKzvDmbbRNBuahIaaK2HubPa1HDLuKwV0XeZBJm3NT6JmEnK0GTF/4IhnKqqv/XbXL912di9hGnB9/K0sEQVtuHmifHnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfbrMVWV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfbrMVWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C93C4CEEB;
	Thu,  3 Jul 2025 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751532435;
	bh=1enmgdSSUlUjwUhztEkvtHTwIT6oCu9inFEp5Y97fLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfbrMVWVNLkGXOYHumIqhyIRl51OCxRXVBOn+Kgac/ueARwGFav+EUo8lqvpjgPPL
	 NkcdhvYrWK+5/M23dsSOp7DxJvz0fz6ZMCxx5pCdnauZj4hjEegSCrf1zfPxQQY4pU
	 7xamuTMp/if0Cx3UJOhGizyGf+BwJBmeMc/K5gwcgEBgJZWq2cePpQ1qeqvvvRcFVm
	 sm87wRqWkp3JHdYwPZjw0jH6KNYIrFEi46s80rSEMumuLZkjtS9QbhsNP75gWcXJqO
	 hP7uaJCeanv7H7xqO7dEWmUzWJAMnT1eHhfNmNrtIehB4UtDxVXP4bNcMwB6TB/5nJ
	 CTOecLZItWrdg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: implement .read_sock"
Date: Thu,  3 Jul 2025 16:47:06 +0800
Message-ID: <973d9da345cda80ed088d25c7c537df20a170adb.1751532205.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751532205.git.tanggeliang@kylinos.cn>
References: <cover.1751532205.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

No need to init copied to zero.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 068ec724e081..924b4d5bd1af 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3997,7 +3997,7 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	struct scm_timestamping_internal tss;
 	int flags = 0, cmsg_flags = 0;
 	size_t len = sk->sk_rcvbuf;
-	int copied = 0;
+	int copied;
 
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
-- 
2.48.1

