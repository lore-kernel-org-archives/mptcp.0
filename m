Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7657188CC9
	for <mptcp@lists.linux.dev>; Fri, 13 Dec 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075587; cv=none; b=NRbWIraVFWo2k28zQig/g81Gmy1GllHf4+mJ0ahJNndI5mLzj0sM8tjQYOo5FLRgMTmu1rlILY72WXRXKO1cQBrgdQigyapq1kgRgCLEG0Y4s2b8pv2yYwJYy0WrQU6nxZSaW+OzhkKlujSAX4Mp4HmujXBsaaS1Tlh/l4Ftac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075587; c=relaxed/simple;
	bh=hOTuMP8IGsBovDgdFwl6cBT1Rc0oLt0t52sJKc9z+g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUmbyt/A/YsJ2TeXGBUmxINJS+iyr8N7dimJlYli1F0zN/WMo1NZ62/Q+iRQXdgYvR0r9lNIi9Kuf95cfXL3viaUOzUQTG5bcC0abRUetWINaZsgcMS4Mw1YrB/ixKHDegWo1rzOwK34FEi7jH9QyJO0suel5+fpgdqUSdU8Jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfbwBBTH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfbwBBTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23698C4CED0;
	Fri, 13 Dec 2024 07:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734075587;
	bh=hOTuMP8IGsBovDgdFwl6cBT1Rc0oLt0t52sJKc9z+g4=;
	h=From:To:Cc:Subject:Date:From;
	b=bfbwBBTHL3bm7PRnY2Ds0RtnXEmvCv5JZhwdptzck4jMnZ0dl+BdmN5W7DN3W66Fv
	 pVgRZg3FIcylm7hQsdvc+FN03IHNHKPKVLc7o01zNudoaEIU78wYR/sKI5oUQR67z8
	 hRr33JwCto5qp37tR05xiA7aQ9c23rJILjpHRJ0jZu69Y0Hi5KvcohVlrv2+RgGA1a
	 T2ldexutE7jqS++AaehM2uxXNfw7v4Y/cMS6gFBhIpGADFiJp1cYrOf1QbGVr6YeQB
	 48Nf711Aem9EYyq3fT9Vjg3X4ApOL7ehYMEjcBpvZgX9yCe6K8V3EM5ecOkcrpJ2Zv
	 GKMCycnQcDjuw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_send_info_to_ssk"
Date: Fri, 13 Dec 2024 15:39:42 +0800
Message-ID: <4846d6ea9b3112075b93e964d3b2970fc245d55a.1734075511.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix alignments.

Based-on: <cover.1733800334.git.tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0d7a5846bd77..18106ecc9cee 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6015,7 +6015,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
-	FN(mptcp_send_info_to_ssk, 212, ##ctx)			\
+	FN(mptcp_send_info_to_ssk, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0d7a5846bd77..18106ecc9cee 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6015,7 +6015,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
-	FN(mptcp_send_info_to_ssk, 212, ##ctx)			\
+	FN(mptcp_send_info_to_ssk, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.45.2

