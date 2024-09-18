Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D444A1D
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647933; cv=none; b=uccTTHrC1U5nPcBgHgkZEMF94p2ZbRzEdQKcXTZgk6oF1efsvMqKfkt6jrQiOvuihQlyH/Z33mq9zyaNShg8Ht3Y3JwSKJ/iJKhfGmDFhR0c341IbL5zf7JDdR8N4h4qZCPbYsbX18JkRqwvoC7s77qh2APnrlSOohTdp1W91Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647933; c=relaxed/simple;
	bh=8eAH8GdWYHEniV9aWy6BqxIJ30yhNPjm4jN4t5U4nNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8dk9XjjBuwM8tsF9+LKbrZAd9kzqSRv/pxgAhSqO/tqWPQn6IxvxDAO26bOevpISuXQkCS6ZEgjOA4Q9nJq0I2U7Wnhfsq+M1XXkvBdKIb/sdB2skenmb3uoJByqlGkk4q/rukscfxCEWr9/IHI6ejoCvpCsvqhGISv8FSIpp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqCUFzyB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqCUFzyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959F6C4CECF;
	Wed, 18 Sep 2024 08:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647932;
	bh=8eAH8GdWYHEniV9aWy6BqxIJ30yhNPjm4jN4t5U4nNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqCUFzyB1kL+kwnMQ5nMaEidgTCZSLq25GUdo/KZjI3mCb9HOPnDW1bS2YzHr6X9k
	 rBZRY1KvUpTNrVxPReLM7I2V0IxFrID4YVBCLw1W8PrpsZbfJHeseVI8yaRKPFy+uV
	 BcCXxtfWcDJIvjcfD3h6u9JjtWDobg8OHpbyG0L4jtLTdK0krIxcZuuwfHVuBNxN8j
	 tj0bNMDrhDuyrr1AX/TMweX9uQs23MSuaZ7DU7NGRu9szAROUKFr+VM/yRb2LSWx+b
	 FtvpaQON/bUHRV4Hm80w5EaUJiAb2RFCsam5zNrk3Qczyd90YG3OiZgLdUPbip/ZEU
	 DXFi84QV8Ne/A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/6] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Wed, 18 Sep 2024 16:25:16 +0800
Message-ID: <f0b6cb2675bbd3c756005e445cff9e8c6272b05a.1726647599.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726647599.git.tanggeliang@kylinos.cn>
References: <cover.1726647599.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update endpoint_init() in sched_init().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f4715b1692df..04146184e45a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -492,7 +492,7 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
 		return NULL;
 
-	if (endpoint_init("subflow") < 0)
+	if (endpoint_init("subflow", 2) < 0)
 		goto fail;
 
 	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
-- 
2.43.0

