Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1340133FE
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846940; cv=none; b=JUghRAgKXkbrMiAA9KIK7jBlI2rrgXC6KQ5kSRSxCiO8wF7Aj9KSPQIIT08QwksYIPMV0OKRfimYhPLdgYRtdgNNDVIHzOga/Bkn2wUH+Z8i94zm6+mOnoPXgxLMXV1yxnRcPnKiB3EgTUQ0sDu66JZ7AMBIOBpWYCoydqciCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846940; c=relaxed/simple;
	bh=oRPddNFGFo6Z+dCpJXlJ8VLO4VG3VnIN7OuGV5N+jBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEv2iy4AfHSH/jM6o1KvlOjxk8ERHetn1Gm4TD8qbilR1zexWByrFj/4v+fVwDXVpX5jT3CSxRn9Jq84s4uUrlF1PXPEqBVRSEokNj/JL+Wc0jsdHbg6f8ofhfTmJ54/2V5+SzEqrhmvg37HNppQHZ2wBeedQqBS5A6impHab0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdzaviYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdzaviYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB3AC4CEC6;
	Mon,  9 Sep 2024 01:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725846939;
	bh=oRPddNFGFo6Z+dCpJXlJ8VLO4VG3VnIN7OuGV5N+jBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdzaviYCy/UnsBM908vVsoXmPyz9XCcw5GYpLixSTLm/94UxmwV2YiOzGiBxfUJG4
	 wboTnbYOnWU9BXNtIM1crVGyYOzK+fPA3tXcbrHHce0EN/9UxIf+QzFOftZ2juCCID
	 /zHX9SHKbQIjiEidXR26M3dmwzT8VmodNnc+X8uU1Pnlt0H6b0EsSVWERNt/Geowo+
	 nDF3MSNOf0Mmt8963N/5JXbVKLvJth7kcVAWr6AVouGPqvMkinek/ov/HJhcEjHn6i
	 KRS6uxA+814hWRoNFrQVB3UQlYr6DTveH1SmEzSNKym6sIWlQ7dAWJNtRX0BRttd8W
	 IagVbtk7Kc9kw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/4] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Mon,  9 Sep 2024 09:55:29 +0800
Message-ID: <5a985e7bb55e2d82e3205d22358fc6732c98ba64.1725846806.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725846806.git.tanggeliang@kylinos.cn>
References: <cover.1725846806.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_subflow_set_scheduled() is used to update the scheduled
flags of a subflow. BPF schedulers are not allowed to directly modify
this flags. So the write access permission for this flag shouldn't be
allow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9672a70c24b0..6414824402e6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -60,9 +60,6 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 		}
 	} else if (t == mptcp_subflow_type) {
 		switch (off) {
-		case offsetof(struct mptcp_subflow_context, scheduled):
-			end = offsetofend(struct mptcp_subflow_context, scheduled);
-			break;
 		case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 			end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 			break;
-- 
2.43.0

