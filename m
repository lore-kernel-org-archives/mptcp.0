Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F30215F60
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737787; cv=none; b=Ko0x2fj/gdvFT8bs7+y8eA8b4SLN9QVqoKfBzXWxnripaiT8i14RtAr00UteOtcyacE2u9tZfFYNbcp0HbkFvxBwioo4tsvRrGTMe1CYSlseUwZGiBuafcQcfpup+x8ewTbeuRsDy0Gj8ILJhUiWW+/m2qGw/bNeKq2PQ0smVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737787; c=relaxed/simple;
	bh=PuHzt2847OjwQRCWTngW5c85m+cVxG/nquJ+I01eQNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxAZVgfgMl6W68n2PqT8AtQPhSwJ5iKE763t3veh81lrnQwM7SY94SIeiNPrmQR1sI4ZmiJo+i8fLywOcyV0I21kd+XCxVxwHahuOs5xYmAfbCUvCfDxJ88s4C1y6VJzs35JKqe/h1g2QYTBK2e5r0Q6nqrAn31iEU6uonX+MYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHHGlEe2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHHGlEe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06323C4CEDE;
	Mon,  9 Dec 2024 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737787;
	bh=PuHzt2847OjwQRCWTngW5c85m+cVxG/nquJ+I01eQNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHHGlEe21FI1m3ACKg2W2ijDXZdEVK7FyUvjecbRZzvwA2L3Dk8rOk6+0CkOpLw63
	 3SO0m5GQcp4u14hOg1Jut6MK6jEUofcR+t43sr+cZC1KF4ijN8nDQgVpkTEplSZxzR
	 lU6xcIv+Df8ZWWZNes4CjX39TmuXOomQOMlnmXQTF1yB6TpoC8wi5M5Owm2wUmNZoc
	 FNX4hlAFmQClMrxWEE1C8Bq7i/5XfD+7bFfnvfyXSlHkKPXoC7oyoW0TsWecP8GVYw
	 q80lIadPrQkE1vOtlh28y7lBY6KBSl1S/XRDYzNbMKyupS+sGRZjD5W0TJQSRa3H/a
	 tkMeH0aFVh94g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 8/9] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Mon,  9 Dec 2024 17:49:24 +0800
Message-ID: <1a55c3255f814aa2df35ae7f2e5c5a8b7d9926a6.1733737459.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733737459.git.tanggeliang@kylinos.cn>
References: <cover.1733737459.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove bpf_mptcp_subflow_ctx_by_pos from BPF kfunc set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 8a9c7a91dd7a..025b2af33f28 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -330,7 +330,6 @@ static const struct btf_kfunc_id_set bpf_mptcp_common_kfunc_set = {
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-- 
2.45.2

