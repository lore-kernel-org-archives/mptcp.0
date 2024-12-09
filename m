Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924121661B
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737776; cv=none; b=pwfshHT7w3drt7CAxTh9d1azQndchV0qcdfRErfikhGjcORsWoBDWOCqzSCV2vyEvR+tUzff17qZ24G5G2hGsRyaua21KIDA25Wo4gBVB2KJjOADDCzz+oPVWvPdao1BvfKxx6IAGunaY2VpezSJ+eMcMakOFIGQ0l/pJMWAGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737776; c=relaxed/simple;
	bh=Ae5ZluSOvGKGy4++0Dz1LYKoAm6vXOPxH/8pQHBeTqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nONWI2S87oNwDue/+nhEDUIMbEMpojtZecI3Rwn0vZ5FNOWgn6HJoBnSW84OBUPTe8hnzOfl1DV+etEsJ5sIfTlKVb7WUM6flnj5OnXkZ7uYLOIlV0d8cJ2MuVwHWa2/7xr1mPKltgx2Tv+dHFM9pCgakMkKyJK/ZvevpYJZLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af+qgvkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af+qgvkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C22C4CED1;
	Mon,  9 Dec 2024 09:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733737776;
	bh=Ae5ZluSOvGKGy4++0Dz1LYKoAm6vXOPxH/8pQHBeTqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=af+qgvkZ3uUfodOq/JOjMGmLUhiJOhq1sqojvsQ2sVswmTpyBLFswVV7gFP+Vrf8X
	 8CuPmN1K90+L9KqDoRU1ylLeWFyVqz4ukNYZ3zDPo04idw0G+0kfQvuu34v1w3eEsk
	 z5CxnMMw9byGfcornA7HxAMA++G0WiK4YoWEruxb9AsX43euFPNC1eRsDGjXdAJWt5
	 wXPJ3eD7lNlq9KfDFYIzKiZkweaQezM9jnBqZCyl3u3vhfUxWuaTld07ywmLmU7B60
	 LhQ3gzT806dm1y7/cu3vkyPctJfZgAsj2MtFSt7sGbaHV8Zi+qoMXgOdMnEphCraqj
	 LPuscxddg8oLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 2/9] Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
Date: Mon,  9 Dec 2024 17:49:18 +0800
Message-ID: <8de3f8f27d3e59da5c9cafcf908562d020966127.1733737459.git.tanggeliang@kylinos.cn>
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

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 296f0318d843..70c3a69d4a47 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -20,26 +20,16 @@ SEC("struct_ops")
 int BPF_PROG(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	int nr = -1;
-
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		struct mptcp_subflow_context *subflow;
-
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
+	struct mptcp_subflow_context *subflow;
 
+	bpf_for_each(mptcp_subflow, subflow, msk) {
 		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup) ||
 		    !BPF_CORE_READ_BITFIELD_PROBED(subflow, request_bkup)) {
-			nr = i;
+			mptcp_subflow_set_scheduled(subflow, true);
 			break;
 		}
 	}
 
-	if (nr != -1) {
-		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, nr), true);
-		return -1;
-	}
 	return 0;
 }
 
-- 
2.45.2

