Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35487224CF
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023795; cv=none; b=ad+ELfFRZ//swFcWIsy3jVGFHQU/KFgr9TfD5EEUM0MoHe+hWkDzOD0qzZUfqN0g3/orxbL8h+XU/PAsy85c5SK5fLxjy+7s5Arsm5jvrQQyE9x3uq/3x5MWA03jB8xl7lxlik+ISXhlvzInC9hGnh0Zq2OB5r05Bewy3P9vhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023795; c=relaxed/simple;
	bh=Zb+32JUdCvzFr6YS3HVWxtO3o2fz5/zgF4mbGXoaSRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsiraJBY4RD0MNMMwPdGKty/pU2REbf7g/Yn1kc/4/CCFEkzo2R3Up5j8kE8y1vnQV80GdHhy9w2jwN7tnVZvpJLBTjMinLaOwlnvN35/6QvY1VrAh61dcnJhoAyb9Sd4rk3c+Sk/LO6H6fJZhkLlHVHU6KFkw4qOCl9kjv0Z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s59e5XGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s59e5XGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C619C4CEC3;
	Wed, 11 Sep 2024 03:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726023794;
	bh=Zb+32JUdCvzFr6YS3HVWxtO3o2fz5/zgF4mbGXoaSRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s59e5XGNestBf1gSD4f7bvSqzlIugOvQISy93oPqCO5S3Rz0ksi+XwK674TouSP00
	 3qCSejjZFy44n2fhTFVC0vv3U7ohPBZvSKjcmDsQlLM6Za08sIMfEFhsWBxXnICYMm
	 3OgVKZsZI4bIYZf0otpnWNh6ZdC4lPcdwkQSA0/oMCpJNrQXH6u+WHynMjab/cfx7w
	 y8ToKwDYQsJX/3gA3DkBtLb8YlcvXHLTHK8H0U+pu0zGPWVBVWd1PLecbPJzGubHXq
	 91VwRXLsUfZOagK6dAPDHdHKq1zQwEEbGAV+e1KexfyO1vygnlKFRC1U+U9ESIZ0rY
	 6QxT8X0CR28Eg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/5] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Wed, 11 Sep 2024 11:02:59 +0800
Message-ID: <d43bb458e1cac93d13202ad86b54de926c1fa3ae.1726023577.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726023577.git.tanggeliang@kylinos.cn>
References: <cover.1726023577.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop mptcp_subflow_active declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index eb21119aa8f7..dcab196867fe 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -16,7 +16,6 @@ struct bpf_subflow_send_info {
 	__u64 linger_time;
 };
 
-extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_set_timeout(struct sock *sk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool tcp_stream_memory_free(const struct sock *sk, int wake) __ksym;
-- 
2.43.0

