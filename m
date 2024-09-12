Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE1190063
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133169; cv=none; b=bnnuaZuUi6oja4Y3dCgF+LtgB7bd9T/93QfQWdgvm+ywYZE/0MSBF4o9L8SEJ9IYhejR8nN03gr2rmT//ZYPkCXzpKMpP2P3O/y0OhGvP9gkUxIJuNjmnzc+xtwPSr6nSWmd4d02oTzx+/vspzgYrks8G9qb7MMMd48QT/j8PyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133169; c=relaxed/simple;
	bh=p/u08phHhlqhN6T2xbBOiHaa1aRmGqAr6bqCvczOld0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru3EgWlfwgGqycffhT1AO172isi3hHQcC9xmCsig5tL543sZ8nTBFduV4CUN3GtmlTL0LM2nl98BcnuR7jmdeRCBbRgGpvgoXqZcn2D5fClwGqIbG6ZTNXVtKhC+EiRXy7rKMSzoqyfs0gWdTyqiiFgV7HYwhERSdEAzODY+jqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tawOhe/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tawOhe/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0227CC4CEC3;
	Thu, 12 Sep 2024 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726133169;
	bh=p/u08phHhlqhN6T2xbBOiHaa1aRmGqAr6bqCvczOld0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tawOhe/ok6z2texgmxzEtqWEebDGnetPD5m4ffXUiD/38b8zIerxR0WU3kbL91O83
	 Yvi1oFn7MA4bn9+tZD2iNSi/5jAXN4O9X5KTenHpr3ErSuXCq1jmnjoZhz6QBQ0T4L
	 GZHXzJ1bZy2J4dEfY8CCUqlL95kzGfoujb+g5+k2j3P6KfSHPB3lBzU02t7P97TEAZ
	 v6pyMFrvHzQaPpnyzvtoZcHC76qA0f15K8nM/AUV/WGgPbehxDcuCzDIjTseTX5XD7
	 WHAzpQ03cAe6MCXexHBvB4g4BQY+QtWRGu7oDRT4donYtfA2GpatvYEO4BlxA/kiMg
	 t4CNDhW7jXjIg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 4/5] Squash to "mptcp: add sched_data helpers"
Date: Thu, 12 Sep 2024 17:25:54 +0800
Message-ID: <bd30ca59034889631e7451df9da7b564494a9b20.1726132802.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726132802.git.tanggeliang@kylinos.cn>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_ctx_by_pos declaration, since
"-Wmissing-declarations" is ignored in __bpf_kfunc_start_defs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c3942416fa3a..d864c8ccf316 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -722,8 +722,6 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
 bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

