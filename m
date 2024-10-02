Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BBD197A99
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910937; cv=none; b=KCzIx5ZMPU1KB+U22mG/zfD/UEYsjTxrRfnWOBzQswzQvyV3gsikn+PKUomF7kCRpkHJOtwIzfi5sIdlqk941ZXlIeyhmgjxrtF/RFO2CPwB5iDBrKOx6YAu2tETZIdbbPfwJnl5NkY9qahcZ/D5rhWrKMc4g8ee1RzJlEdLPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910937; c=relaxed/simple;
	bh=Nh4SIc+qVsoQFnlf0pfJ4QGDWAl6ijmaUO0Br25BAaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klgw9dj9BkmuslLY4On2p+wDbUVWJjpkl9xklWICqvpSTCU6OCOQENuJpDpmLpfL0C60HObYZlUdsYCeoG21OnY9JtWgFLT+1ZJxfaWvebKLG8gzDi24E77dsx1jBHvnGJtfxb/RN6xbGuWmXWMsKOZmrZx6BjVagQ4CtuiaLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdmLurRs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdmLurRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1999C4CEC2;
	Wed,  2 Oct 2024 23:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727910935;
	bh=Nh4SIc+qVsoQFnlf0pfJ4QGDWAl6ijmaUO0Br25BAaE=;
	h=From:To:Cc:Subject:Date:From;
	b=QdmLurRsM4qOB1ygNaUelxQRdbpLjV4EtCtLEgrCK0mrk4QTR277L8Goz7BCUL4lM
	 o5sYyOpeFZ4yCV6vFFdikWQEtw1EXEhoIQZjMafh70JZP9RwyXnAUP45S/CeDSEudm
	 u/wyD8w1EiOlS5uu9yUJlEggcUyVOAB3tXS7QuTk+XYMRyGz8LNCkr6nfunO4bWraQ
	 t+pUY2HiOqLigbL4uk0Xxq7Gk2gUVginSkBy1BJSQfF8KfdpKiVubZPAQQEoyBPmT6
	 2N6QZJsemfCEcsv+XI4ehp2q6p/fuyJTRn7bOpWAJ16CdjhVgzUCzOpytNDuVVPzy6
	 YRztcxlFX/2Ow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "mptcp: add mptcp_userspace_pm_get_sock helper"
Date: Thu,  3 Oct 2024 07:15:31 +0800
Message-ID: <de75c66cb4e185d54604dfbe8d77c7574ea549e7.1727910916.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop useless "goto out".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 79531c949cc5..a514f00ddbb6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -188,7 +188,6 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		sock_put((struct sock *)msk);
 		msk = NULL;
-		goto out;
 	}
 
 out:
-- 
2.43.0

