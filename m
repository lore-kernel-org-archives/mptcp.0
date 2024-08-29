Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5F4A18
	for <mptcp@lists.linux.dev>; Thu, 29 Aug 2024 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900019; cv=none; b=LmfCrKLRSsc0zp0C9ibDoNP65w+sM2CTduFJrIUtaagpxeDAee5WPuJo8F7ko5t2jidgozncBV0LswFXzpdldkJ1fBAALhz+pvgItDqug6Cfor+j17XoNh7w0rPk2CS2ZHnDNCrr8K4NHTvVvDD6bGXql/CYXepkNPm4t3vUEoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900019; c=relaxed/simple;
	bh=abbMMrsnV9iOCkJDaqd1YaLB2b9n27wZYAQnKdmDj5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jrq9NJi2nX9fSu0A6Tjz+Jzf0qVXmG3fkusTXCMV9uTZyFngBzH8Jm93C/izW1gpJqNxBwSQxkmnlEPd6vUrGrT+3mboNFFEmMvgVt4b75uUjiRwl9l3ahuqer5EYSV1b8auoQyKxFcxQhIvVxfCoJqA/28bn43fnYGZONxY1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lupBOaTx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lupBOaTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B6CC4CEC2;
	Thu, 29 Aug 2024 02:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724900019;
	bh=abbMMrsnV9iOCkJDaqd1YaLB2b9n27wZYAQnKdmDj5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lupBOaTxHkSvEPLhBPDas8ei5m5cCDPomDx8K4VCcHjfmwXZkuPGGbFXeBv2aNaRv
	 1BBoOe4TBORduokPzwDL/iTDi1oeSHbXSDqWoIudv4ePhoPDugR/yFwa6H+41aNSms
	 UA+m5Fm+TXb797iR3d4mtF7A8d8XEsLh6GbPDm6+HGUflBmbuhlKS3rs3EA1KM70lf
	 A5kHOmsKxm1hq04u+R28hFK5MuE7YChnkXuRdVLHIDkjuNwpLbXB4H9KoleIdOsO8s
	 VIxeG4p4tqSaNC1XsWl0Cg7T1hH81v5bu8bCRcvCeqwMvqXOwkcZhJXGG8DZ8QmGnA
	 4g47BoHEtkDTA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 3/3] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Thu, 29 Aug 2024 10:53:27 +0800
Message-ID: <65ec8ea19326bf8beb73055f3be063a3a94d2e2f.1724899785.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724899785.git.tanggeliang@kylinos.cn>
References: <cover.1724899785.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now ss_search() are only used by bpf_sched tests. It will be dropped
in next step.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 85883515c67b..9b4d054462ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -480,9 +480,15 @@ static struct nstoken *sched_init(char *flags, char *sched)
 	return NULL;
 }
 
+static int ss_search(char *src, char *dst, char *port, char *keyword)
+{
+	return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d | grep -q '%s'",
+			  NS_TEST, src, dst, port, PORT_1, keyword);
+}
+
 static int has_bytes_sent(char *dst)
 {
-	return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
+	return ss_search(ADDR_1, dst, "sport", "bytes_sent:");
 }
 
 static void send_data_and_verify(char *sched, bool addr1, bool addr2)
-- 
2.43.0

