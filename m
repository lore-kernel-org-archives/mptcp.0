Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4413AA38
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157160; cv=none; b=FLtfOWFhdyDF4oK8ZNI8n4hqdV46sGqNUENVCW+gcd2K5+CEB3CXIRArFMYPZiIF487SW6vp0ydkcPJGwvI6UHCnrK+vli/O0B01LCJQ0Dph1i3c7fKFN68s/vAr6F8iPPvMsOVVCevl0C1iqyXjwLF3uoMK6f6o6NFhSsJmGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157160; c=relaxed/simple;
	bh=uhAM2fpJLIUWjiXCtbWvVgvwvbT7z6XZn4ZHWMdpioo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX97jeFOOxP3K7UskAlByJf0QqAqQTfCDGd55wp3be1seE53gFP/viFxxMsJsmLbKrGndyb81hEw0ux2Vp+btZ9mPFod/W1U43ZV+mBp6Md1mlfGgjnnPi1bDyRuUkxME/sV6zqrFVa6I4vxNJMX6DY0rTLyrA/OL/hhMnwMHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX/opddV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX/opddV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C92C4CECD;
	Thu, 21 Nov 2024 02:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157159;
	bh=uhAM2fpJLIUWjiXCtbWvVgvwvbT7z6XZn4ZHWMdpioo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gX/opddV9dKLT12BJAbbr6TFMXu+e53sQ6RWVa9SC/f0Fslaf3H9ioh1WsNvDXgaF
	 OT54l9ofE8Gn49HzTmlPNzHcQB+xgRlPVsAHuKYHyMyydhOUzFAlwzZIe0ADyweAot
	 0jq62lsGC2yWcOTQ6sHGHT8acc2v/uMIJR95dpRkwWPFsCJv528ikMFn85NiUfK2M/
	 DIQIXN1jE/uiaYYdCGmpPXpm+PRUR8+jbNbwwokZ2i5dEBHvvv80a1DOW+IUSQ2kPy
	 xJPKNAKg4XOoBpoHLB0LGjHzmDE3hEpWEVdnzGpaQE22SPRfsWECsXd3MotHJQD+f4
	 qVvYM4tX23d7g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: baohua@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/8] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Thu, 21 Nov 2024 10:45:41 +0800
Message-ID: <e57ac76105430bab4bbc5ac4f62c77e883dd7f29.1732153672.git.tanggeliang@kylinos.cn>
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

Split get_subflow() interface into two: get_send() and get_retrans().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..36bf9adffb2c 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,18 +16,32 @@ void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
 {
 }
 
-SEC("struct_ops")
-int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
-	     struct mptcp_sched_data *data)
+static int bpf_first_get_subflow(struct mptcp_sock *msk,
+				 struct mptcp_sched_data *data)
 {
 	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
 	return 0;
 }
 
-SEC(".struct_ops")
+SEC("struct_ops")
+int BPF_PROG(bpf_first_get_send, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
+{
+	return bpf_first_get_subflow(msk, data);
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_first_get_retrans, struct mptcp_sock *msk,
+	     struct mptcp_sched_data *data)
+{
+	return bpf_first_get_subflow(msk, data);
+}
+
+SEC(".struct_ops.link")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
-	.get_subflow	= (void *)bpf_first_get_subflow,
+	.get_send	= (void *)bpf_first_get_send,
+	.get_retrans	= (void *)bpf_first_get_retrans,
 	.name		= "bpf_first",
 };
-- 
2.43.0

