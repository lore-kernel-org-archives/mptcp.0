Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7A1DED52
	for <mptcp@lists.linux.dev>; Thu, 29 May 2025 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491759; cv=none; b=I5hNxJjw3LvQuhPNTWZ5t5xy8V9t/mJVgRY86HH625AUCHC1VtafEtiJvbxW1KlhjqClEsd6w7B0++6T/YufYhDtnlFj9aox51aGkJGqUQ7B6opJnECy1bHDuKUwhbtOHvyKp/AQ+t8y/T38GaJVb/0fWz2G3+f2fH1mTbABm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491759; c=relaxed/simple;
	bh=zbPqWnL/aONW6MTgvQVjaEKHdEhgP05v11xrTpWF1yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p28p31lS8S2IpQxKH8IAz39jqU/e4jrAzkRO25FfabLDqBEiFEFFfQhfdbPvIrXUj7C0gEjzEa6/uClRPEUplBr0JuwrCuloZlV2ePGXsW2oZnTDWX6R4KJizrFIDKGPZ4p5qK06wZuQIHqB02WDBJkqNMbhbpv5FKopMgYFhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbuL62Rg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbuL62Rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A25C4CEEB;
	Thu, 29 May 2025 04:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748491758;
	bh=zbPqWnL/aONW6MTgvQVjaEKHdEhgP05v11xrTpWF1yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbuL62RgqoNDBsWLd9u8m8lTB13jd36eyt9uskqaIktEPA6ShRrB+WxzmyqjcESnP
	 wT/LHUsrMHmWq/uNi6i8Ib1+B12WlVhvaRQd7yH9zI6dS9VOciFWVRPDaNjrYGMTgm
	 F0o5UdzHz4CWRIuBdadlwfw37P+iwz1qGl6PYGas/6vrLEsSaqtJBC6Y1/AZOqyrBj
	 +nOxYJ2yKxCZDoTcY6cYKY61M1i6w5ru7MticnvMXUDoSbX+QxOBKhl78dAISfazlg
	 rIRb5ISnc3wWqBW5IWliB0opK+QGEgD31mO78HyP+7ISrK104JRLCBnGjLFxX7axYH
	 gBC2NZ2ESp3fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/3] DO-NOT-MERGE: selftests/bpf: Increase total_bytes of bpf sched tests
Date: Thu, 29 May 2025 12:09:06 +0800
Message-ID: <7d761d89ba5ffa5693c221d62ba448c194a54818.1748484770.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748484770.git.tanggeliang@kylinos.cn>
References: <cover.1748484770.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Increase total_bytes to make #487 easier to reproduce, to verify that the
previous two patches can indeed fix #487. This patch is only for testing,
please do not merge it, it will make mptcp bpf sched testing particularly
time-consuming.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 5402d42335c3..0b40a9a07b5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -56,7 +56,7 @@
 #endif
 #define MPTCP_SCHED_NAME_MAX	16
 
-static const unsigned int total_bytes = 10 * 1024 * 1024;
+static const unsigned int total_bytes = 100 * 1024 * 1024;
 static int duration;
 
 struct __mptcp_info {
-- 
2.43.0

