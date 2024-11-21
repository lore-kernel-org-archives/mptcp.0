Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6270811
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157170; cv=none; b=SCbTUksgtglABKnVybJ7L/ppDlcL2geABp90boxYXzCW8WPR7CZndHV3JwI+YSsPva7cMNGix/+CJ3YwyF6BoNAp8dEU6Oib+wu93ouf8rVPPPPzyxCnTFqkxEU2ZmZ0j6A18SV3uTKY/GCbqoPrUfCcsz7GIOTj7a5C4grVEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157170; c=relaxed/simple;
	bh=A1iLh4aSCA8bGIG5PLWjdNZCaBIqRTbyK6HDgi5vfNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0o43oKGvGLdP/bkH6G1JSK/yqZ8J33oQ1qCQWBG5P5r4cvWjmhUbvVyNwoCgMQU0L3WEJqrwiVmYkF318ieDwCNhIUeHz6OYd93M6P1kfYZIak7gCLtKndRaimJmQi3PZmVrmo4BgWjJUN9ETZS/z7gMhhUltZZWPulUH4BQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EORtkCod; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EORtkCod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DBAC4CECD;
	Thu, 21 Nov 2024 02:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157170;
	bh=A1iLh4aSCA8bGIG5PLWjdNZCaBIqRTbyK6HDgi5vfNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EORtkCodBzaiFD1OKUdUqhdYziAqNg/tPGyHFrAY/hMMGNJyqnKQg8lFPZ8TpAnaQ
	 bl5HhB4BVu1cZZEfLhnM5nv38aoATrkrDhNKW/8i2Mr8QKCOEt7AOr3gB9rXCXsGaY
	 UL9UpswgQ/CYOn6NA4/rgYx2MCh9fdwWdat7pa4wAByzraWQMdH9FEexZzVUMVFcjO
	 VGeRQcr4d2X0/V4oJX4tx0vXv5+q4ALJVKJYV4NGVlA8cT89eclRxgB8ZQf6m4jRhj
	 daIE7LPahLPMD+E4ZOlXTYTIhi9SELp/iYUeKiDZ46YifD0bDuFFVgv81HvqzC7oD6
	 Y4GOliUWnLTDQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: baohua@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 7/8] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Thu, 21 Nov 2024 10:45:46 +0800
Message-ID: <c5e53dd0a8ad0f88cc58fe42976fec9aa469a3d7.1732153672.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732153672.git.tanggeliang@kylinos.cn>
References: <cover.1732153672.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Set KF_SLEEPABLE flag for mptcp_pm_subflow_chk_stale.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index ab1de189ba4b..a6cf4d1a48a9 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -329,7 +329,7 @@ BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
-BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.43.0

