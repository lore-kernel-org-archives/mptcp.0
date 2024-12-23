Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7C19004D
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942632; cv=none; b=c2iSzTlVLdtNwGvLdmWN+6raROtuUH6duWMagE2P9KxSsifa4qvacv9048hPyMI53QeEnW6L7GJnW9p0/zeasjlIKdhgcfdkUkQmaJXxuRnRlVSKW7zw4uzZxTNn7XtKJ1LzZTR0Nf+qOmb37A0JFtn+7nZBnQ8qVefe0YNr320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942632; c=relaxed/simple;
	bh=UqTcQ1PZTKUdJs+cKK9dUBBLPnxmp1B9FxeWgk3TETc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTcbfAqd4ZZ6/r2Rx7gbQC/bR9PNvVMUWji/Zf8rT9AcPdx+LEc0UJgzl6x4WUK+MvKEuOtuYkQ9nvIa/PsBoSLeTjBmBLmLjLPtjNKOrZ9GAHIcJfcNIFGH0VxhoPoCYwGSey+EJ2S2d3SgRdK8Hsst/OB3qRwNBzY4b8uIELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+3xx2Fb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+3xx2Fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF9CC4CED3;
	Mon, 23 Dec 2024 08:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942631;
	bh=UqTcQ1PZTKUdJs+cKK9dUBBLPnxmp1B9FxeWgk3TETc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+3xx2FbljtkpfMg44l3zFHaJMnQDkUbFc1+0frBhAH/3PsYmkYNeso/q7NizPuon
	 esi2w/aoVMHpJ55ySqnE8JW0haI2FYsrTU9hTO+Wzyc6drkXfYW4vvIjqrmKo95oCu
	 QLEhJ4uNGmN/0aibiQnE7oeJ9RpzOhxzThkK1Mf2DZ6uxQKPVicbObtm9yNGZdaWrp
	 yuFjyK5E2hGWS3LhX1O8ehwvesjZJBwo/eUh6QEIBmWHeEYpllUUsiiijTQVRqBlEN
	 IXu/kelvLvO5U98zn5YSKqYiLE3DQk9ucVUUCqQ+09PGrMrkd154ir0nwxsczu2X7o
	 fsSYyzvUyMteA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 5/9] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Mon, 23 Dec 2024 16:30:11 +0800
Message-ID: <d8dd8cca8a5751ab88f9b539bf20439d3fc7788e.1734942318.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use new interface get_send() instead of get_subflow().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 638ea6aa63b7..405e96c116d5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -31,7 +31,7 @@ void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
 }
 
 SEC("struct_ops")
-int BPF_PROG(bpf_rr_get_subflow, struct mptcp_sock *msk,
+int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow;
@@ -73,6 +73,6 @@ SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
-	.get_subflow	= (void *)bpf_rr_get_subflow,
+	.get_send	= (void *)bpf_rr_get_send,
 	.name		= "bpf_rr",
 };
-- 
2.45.2

