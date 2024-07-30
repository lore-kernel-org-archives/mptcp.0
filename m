Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B475218FDA2
	for <mptcp@lists.linux.dev>; Tue, 30 Jul 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327878; cv=none; b=gposWteX+Cs6jxSRRF8pisIQAm7fmop/siS7ibP6q7NSqs25PNy2lr4AJMgdK1bXAFn7xpEsyD0QLOfg8nd4mU26Paq+5iK3pOQZvIxpvz4Cl617URD3r5bZAx9TBxudnfnjRA9xrsa6UXLhDEHyhDvtivqWaSRDAVE2JYAr7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327878; c=relaxed/simple;
	bh=0AI8R8DXSsg/JspP8y2A4EBxMjx/5vI2RErm0C8sy/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elYzufCZncVrq7X2D0sVWtZCqqOv1QrDYio0fluou/F/9RAKU6zz0ZzCD5sXWBsvVlVeZXguIP5DVZWgEVQ6dtCigovzqd9Hbmy/T4umCpJXqZHDftmTQVJQBkP7ZxhYrWR84RQBH9SKp8cztcEFYBTFji9FUFSRLfJcRNTzdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJGUjs3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJGUjs3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D809C32782;
	Tue, 30 Jul 2024 08:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722327878;
	bh=0AI8R8DXSsg/JspP8y2A4EBxMjx/5vI2RErm0C8sy/k=;
	h=From:To:Cc:Subject:Date:From;
	b=TJGUjs3PujeoAz+bGNaLJv2u5x9Sg+BtvzzNnb4OtkEW3WFPmDvJZUyZ38lyWg3Su
	 +HcBib89hPjCn8wvBu719KOl3g8XuALLSxOl3BRfKh9qv22R4yD3Z7zt/aTQvOw6fN
	 VrFw3szU95IBFvPZ4m6C4cvin4R1WaeAhBIxn6kxhjqzh2Hng+HKLTaFrydu82AW6U
	 OD3iNdy99K744jUAqG9chxyt72K3lbFOT3/b0JJArQEOMhItmYRnY702GklQJ8XbxG
	 xAJ3EA1iQDoAN23tyQf0O5TfjiPlhKd7XY3+QN5wFO7BMqKe0wsYV2a9kl7AVGc/IL
	 0cjYo5K9Bj7FQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow subtest" - set limits
Date: Tue, 30 Jul 2024 16:24:32 +0800
Message-ID: <9dafce3091d30a8446897813d2a9d302625c09d0.1722327628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Need to set limits before adding endpoints.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 00f63f3f19f4..ffc2cfacabee 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -357,9 +357,12 @@ static int endpoint_init(char *flags)
 	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
 	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
 	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
-	/* It would be better to use  "ip -net %s mptcp endpoint add %s %s",
+	/* It would be better to use
+	 *	ip -net %s mptcp limits set add_addr_accepted 8 subflows 8
+	 *	ip -net %s mptcp endpoint add %s %s
 	 * but the BPF CI is using an old version of IPRoute (5.5.0).
 	 */
+	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl limits 8 8", NS_TEST);
 	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
 
 	return 0;
-- 
2.43.0

