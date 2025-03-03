Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21A13C9D4
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740975937; cv=none; b=ndL3fDywehVixbQiRWeMqWUiHaSsqgAAQmHLlUAoCbHVi1+wS4aKOOkSChNJCM4IAcZBA622FDD0l5eY5gUw3EbJe5jfHXjCsiGzsukv5HZWdNTh8dcS8GA4T9J2NyV6+S/4CeBv2PiYf38xTvxYZD/u8laWifTNVVZU/inHpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740975937; c=relaxed/simple;
	bh=Fpy6DZ2IIMNqs5cfmZUBl4kKmiCfyONoQFns2U58FG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lITwWuLx9q8CUUhs+YVfhSh047DMr0MwmHWWWWZtiqh9FMkOyfW25Fce0rf2F8OysmPOZEO7dwITMbUrlGxINUA0nhaObdZGluF5/D7lnyAExmDynYWnTw3Ruv9SLaxH22omV5hqDytjL/PUBueWVMp23NqIy3Wcod1owKfUJR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3Wa2xfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3Wa2xfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B3BC4CEE4;
	Mon,  3 Mar 2025 04:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740975936;
	bh=Fpy6DZ2IIMNqs5cfmZUBl4kKmiCfyONoQFns2U58FG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3Wa2xfJ1PuRX37vz8Bip+3mOWfZNNj75m/g8Qp52iRJxpnoIfamov1qVFOQjZwpy
	 7E0o4DNtSQbzjow5ZymMmbLr6V2zWvN5E9OX5tYrHIkTyI1FAIDyKd9E+moEJTn7bN
	 nqYXYkR2Dc02hlYe6znbIQFXkxWSse7A3s/xRDdKPilRaf9WF449iTZrMcEg2Mm/7e
	 J2KHjAs/wrFJU4glS5gvvO6mmOwCh9b9K8lgNcx78zJISkfoBryuVAhv9iXlXKf63R
	 76BkCChhlkm+wQMsOcRkSMNxcLpXGraGf1WpbZoau7nNEKOzm4MUk6fBR6A9e4ZN0J
	 NPZ+Dn1s9iTWg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 09/11] mptcp: sysctl: drop get_pm_type helper
Date: Mon,  3 Mar 2025 12:22:57 +0800
Message-ID: <b48dfaf2c07180cca758f4012f7310441701d9ac.1740975633.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740975633.git.tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_get_pm_type() is unused now, it's replaced by the
new one mptcp_get_path_manager(). So drop it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c     | 5 -----
 net/mptcp/protocol.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 643472eb11b2..fd797f071886 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -79,11 +79,6 @@ unsigned int mptcp_close_timeout(const struct sock *sk)
 	return mptcp_get_pernet(sock_net(sk))->close_timeout;
 }
 
-int mptcp_get_pm_type(const struct net *net)
-{
-	return mptcp_get_pernet(net)->pm_type;
-}
-
 const char *mptcp_get_path_manager(const struct net *net)
 {
 	return mptcp_get_pernet(net)->path_manager;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 56eeee1cbccc..3579c31650fa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -693,7 +693,6 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
-int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
 
-- 
2.43.0

