Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748A19D8A4
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982154; cv=none; b=XgMzhfO2paS9GfnNnPs8KWlQJpGfLmqyzoQP3nO68ha2Q5uat2sQVhNueNPnfkK/iiJHDQZIhEX6A6KIIZzvLE3cyDaMVqqaojQGq23wbKZA48pQJiCPYZVIKrnu9yVm0FwmOllCEbkt+uHwT4DE52C32cSLaSm2SsAiTlu5SzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982154; c=relaxed/simple;
	bh=dSqOq1rhZXZ70FuYPLU37hP7P9WuMdY2KzMeg5K5qJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCgWQdlKwQPKAv8cPqWs9U96X+qXsCwaMU4z+EsNaLTWAVHdYN1BsC8cgI4U+PV+xzZ9FYomk59J0DnxqCVV9VL/XclobvVoDeDVjak1pRkDlNtxzz9F7t3s+cpsAM4MogutmQKGCMhzR7BdmqA547ACUYKow2/8Fm2nraiPmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgOGzsWm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgOGzsWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EB6C4CEC3;
	Tue, 10 Sep 2024 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725982153;
	bh=dSqOq1rhZXZ70FuYPLU37hP7P9WuMdY2KzMeg5K5qJE=;
	h=From:To:Cc:Subject:Date:From;
	b=lgOGzsWmPzQvl1xLc/AadHHd3OLS42nR+TPKoCbZk3BP3mW/WXORIpo16F/OuKtzc
	 CJzrjJtJOxAxgPNg0Nq8Wys/YPSeo5qQfvWs+AGoKWB4pDpkzvWWmOGE103AStuJlp
	 lWzVxCTpnhRNqmvrRP3OekrQex/vjY/mh0cDcAo9bqgTlqsYVGnoVXe1r7jLIM5r92
	 MOpDEySJyghHRRe5VcGElhB4lAnM62UVj18mHFsX4dHluk3Wyvhu+e9XTmMAUkhIV8
	 7NCKfhgkBvzJjL+FKek42YhOpcIs71R8DX1pNJe38s47gdjdO5gUFLVIFeePViE9pa
	 8ybYGB4GA456g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Tue, 10 Sep 2024 17:29:08 +0200
Message-ID: <20240910152907.2538-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=matttbe@kernel.org; h=from:subject; bh=dSqOq1rhZXZ70FuYPLU37hP7P9WuMdY2KzMeg5K5qJE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4GXDiPitMfbry4PGLIBJgsxBihPuje75d0e0U 6lArH6AZ7uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuBlwwAKCRD2t4JPQmmg c+ICEACO1XQObyJ0dntjKMrS92rhXyCL6Dv/WR1n93EbciNyTNxcVCvsctqPmk/FkOepoMDg732 gE8LnO19c5FIbHoumQAeNaCd3CdBIg40YNACWAigqwumtbB9jyDxI90SwGs/2la7jsbuCNBEyl5 FdKeNpoZCzIqMTWVscErQ9Jgxo/PEEtUowhXukL3MaYtrsTWjge4qfVbP8m27tvMMTvbdpeHawi Tn8XseqVKauppjztBRh1LTI8/q7SG3udnmw3TIutTtBmGT9hkjTiiGZvpTtWm/lAmj4M3VghxqD rUBAE4KqnwIJ6c1EAhqbDZsUegI/umFhXaQvPkhy0hVsLeta3AOaZnAlEElx11JIrHI8nBAlvS5 bHoYiXPtH2FrghnHd31pFLkT73p8aU23l2ew2yVfw47xYvBPPJ+G7lyJDbEEUQUBEmHBrByQc/1 GS4jr+aW/l0X3812NGSyjHS1rz77PAE6UW9EbBwUNtLft6BGIC1dMMHpLIrCVmXC6rn7ID5m6Z5 bNg2o9yvf4IxHYqHjGSAiJ/aAsE2O8FpZCroZHaC4p9Ahp8HIyXTbsIsrqBXO+ZE0BLfTBaTCjx JXoD1HKXzeFc1AItL/LnxlNR7OS+kwlX3qvFLVEj6UWrqioOsryG2eeO3Mc32FQFs8FfiXfpWjC gtkDhy+j0ZdB4kw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Fix sleep() usage: sleep() takes an integer, not a float/double.

  tools/testing/selftests/bpf/prog_tests/mptcp.c:373:9: error: implicit conversion from 'double' to 'unsigned int' changes value from 0.1 to 0 [-Werror,-Wliteral-conversion]
    373 |                 sleep(0.1);
        |                 ~~~~~ ^~~

Use usleep() instead.

Link: https://github.com/kernel-patches/bpf/actions/runs/10794529238/job/29939101033
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c30f032edaca..c76a0d8c8f93 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,6 +5,7 @@
 #include <linux/const.h>
 #include <netinet/in.h>
 #include <test_progs.h>
+#include <unistd.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
@@ -370,7 +371,7 @@ static void wait_for_new_subflows(int fd)
 		if (!err && subflows > 0)
 			break;
 
-		sleep(0.1);
+		usleep(100000); /* 0.1s */
 	}
 }
 
-- 
2.45.2

