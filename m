Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A08223DFD
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872502; cv=none; b=ba5U7nvdcCnvlr8fkdHb97w3q/brv9GAGoIESoA30W0gP34U+gV199mClbG2Bf4QmLk7TEzECP7S2Sn2/pUg1HoY56w7tIIAAiGCARt7SJytj5L0lmnBeIUvQL0EiPr3SRT5ICr4cTjnucFSRYGmVbq6yyfB7LVX/JnIAOGe6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872502; c=relaxed/simple;
	bh=dpkBHUYN4Vg7h4pvAnDxvc5Wg0hOujhjmAO2Gdt4dNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqUaVsacCSLYSjOwM3EGx1MR7C61cACtyBg8tpcbZq4rscnKAFzWjXuxNgWJ8vjuj+eyMVv9w4okzF8p3k5ETk4vhNWL5k9ccsk8eStnjpd+gDS914FRShj1FZhhmdTLk0U7P7KOpAlDL+9NDsdChm6GWs6GdMjeLnTe+87BLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCNLmUHm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCNLmUHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA33C4CEF1;
	Wed,  3 Sep 2025 04:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756872501;
	bh=dpkBHUYN4Vg7h4pvAnDxvc5Wg0hOujhjmAO2Gdt4dNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCNLmUHmS6fr5uaKqXMnImsB+uHkq0Hd94eFClFFFVz/TYpJm6LY/PP5lVifojVBx
	 pBXdzenmH5Z8Tr+U1bYqw3EeGU0u8zpujpCUKpJYuNs2nCgni1pNMmJY233BLiaJkL
	 nQThBan0g8MCpb/sp5bIiu8DQXsD1AzTeeBJ1Q3F7W54hiMhJpSNtYPJ5jYekQL+mf
	 JOven61q6WzoDj9LjD25OycvuJcbaQerk6sZBkX+0SJdXSO5HeUGtgkL65B7st+PUC
	 giVqzYI8oMpuVzHgeHf+uXYH/pJZcbi7rCe7ihZzhg2nDHyJj5oPuW/hwd1Naj6TVh
	 EOoWzTsUNvIag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v2 2/3] selftests: mptcp: close IPC descriptor on server side
Date: Wed,  3 Sep 2025 12:08:06 +0800
Message-ID: <64f5ec5170dd363b19af13fd127a77baa8288104.1756872050.git.geliang@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756872050.git.geliang@kernel.org>
References: <cover.1756872050.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The client-side function 'connect_one_server()' correctly closes the IPC
descriptor (a pipe or UNIX socket) after use. However, the server-side
functions 'process_one_client()' in both 'mptcp_sockopt.c' and 'mptcp_inq.c'
were missing the corresponding 'close()' call for their IPC descriptors.

This omission could lead to resource leaks (file descriptors) in the test
server processes over time.

This patch adds the missing 'close(pipefd)' and 'close(unixfd)' calls in the
server-side code, ensuring symmetric and correct resource cleanup.

Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test cases")
Fixes: b51880568f20 ("selftests: mptcp: add inq test case")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 1 +
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 40f2a1b24763..6a282ec21fd7 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -462,6 +462,7 @@ static void process_one_client(int fd, int unixfd)
 	get_tcp_inq(&msg, &tcp_inq);
 	assert(tcp_inq == 1);
 
+	close(unixfd);
 	close(fd);
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b44b6c9b0550..b616af36c16f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -685,6 +685,7 @@ static void process_one_client(int fd, int pipefd)
 			       s.last_sample.mptcpi_bytes_acked - ret2);
 	}
 
+	close(pipefd);
 	close(fd);
 }
 
-- 
2.48.1

