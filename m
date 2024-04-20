Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255972941F
	for <mptcp@lists.linux.dev>; Sat, 20 Apr 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612260; cv=none; b=oTzCvMxs7pnxROjZe9CNiKeEj2PEiSIX8ItWR66+KdtPVyrTvjTPzN5ke46juSpYu06HPzRZ4bMBfyhs6NWZm5WbMo8lN8F9uapL5eT6TF09Ur6vTuGaFYJ00pnkCRAdNe9q4pIEskusb/0uoEjThBvJMeFqFImfowuxiQ+4EmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612260; c=relaxed/simple;
	bh=mm0SV7jv7LnoqtM5Nj8uFJPAcLgnJ4o4z+CfE7BKVTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5NnKyWaHmq1751eNep1z0Bveobhf7pwnys7UAGgZuGWixYO0WySmY6RkZZSsKaZZTFmha/ecR4NFRiolbN919Sa+gXVcX0/8aYD46yVKN2ds4ia/fJSMOYzrh3sJukqZyFanE7kfNN4eiwUodDFeYgoaDlgAnM75/si/Anwu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs1dpXvN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs1dpXvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B8BC113CC;
	Sat, 20 Apr 2024 11:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713612260;
	bh=mm0SV7jv7LnoqtM5Nj8uFJPAcLgnJ4o4z+CfE7BKVTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gs1dpXvN3M97od9tj0G8ZG/6uNnVCrmn6usCzMkSbBDI8hQND8oYBZYKHW92S7cKW
	 lSIwb8dL1+nFxpYiEq1T7o+wxlSKup/KXzrIJEodEHF8YVpdVA6bqyLaFnz1GPbt8f
	 a4jSo3AE6rA5G5J+9wjb1YIdpbN+DCAv2u7Nc5nCIhEyXRXxwbDA/eHCHvixVPVcSJ
	 uKUTV+0ZFZjZ0SbEapJKbgchDUUSvwQG/dK4NhbUjcY3RViKSK1R47M6s0rPAB76zc
	 GQJFmr6Uk7KHeTmURY5kGW6U5Ax1JTWnwgZIBkRU6HKb4wH6EAllPlHFb1f2wrYCIV
	 nVLW7ZvzUTVwA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 3/4] selftests/bpf: Handle SIGINT when creating netns
Date: Sat, 20 Apr 2024 19:23:28 +0800
Message-Id: <52828eced92baaed52e180c5975f96620255e9c0.1713612119.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713612119.git.tanggeliang@kylinos.cn>
References: <cover.1713612119.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

It's necessary to delete netns during the MPTCP bpf tests interrupt,
otherwise the next tests run will fail due to unable to create netns.

This patch adds a new SIGINT handle sig_int, and deletes NS_TEST in it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 0b0da4556d91..307d4b360350 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -79,11 +79,18 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static void sig_int(int sig)
+{
+	signal(sig, SIG_IGN);
+	SYS_NOFAIL("ip netns del %s", NS_TEST);
+}
+
 static struct nstoken *create_netns(void)
 {
 	SYS(fail, "ip netns add %s", NS_TEST);
 	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
 
+	signal(SIGINT, sig_int);
 	return open_netns(NS_TEST);
 fail:
 	return NULL;
-- 
2.40.1

