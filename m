Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1518E342
	for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143500; cv=none; b=hM1J9JB4k3XXkW4ag7k0gPBpjifwXM1lAXTOVQaqI/vgK7en6q9we8R370AT7sXgM5d4du2IcuhZX+TYMBjS7k2rmOzoRd7HYRiW8L4PdX8ZwDRj97FZptzp2jGjynqoqfzP5nYXTVuZtg53eXXL05iVxEw4F8eL9YqqgQH+5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143500; c=relaxed/simple;
	bh=Y8gLDlQdXkw/XDhbSfupO6GYhPrD8v4wKdgU79NrRos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1zJEkxnloIPb0E1fdnT2Y7wJmb2C7tctxwCMZlgkN3Pdv7c8GQ3JoDnNJYuy4r1GS2zSrAYei01MDseD7LzqtjUJftBZI/GTxgc/oyNOspczag5XFX1LTuVlR+mRbZ2XlVhqmpH1P3T658vvvcS+wTfoH+DYi1goOCHK0JWicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2IDlvJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2IDlvJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B76C4AF0B;
	Tue, 20 Aug 2024 08:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143500;
	bh=Y8gLDlQdXkw/XDhbSfupO6GYhPrD8v4wKdgU79NrRos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2IDlvJeDw4d4wbJBJ14umrFRCWwUwgV65RKMNjMQD/mtU3Thsi0YSp/J/Y/yKmBn
	 XxZv6PPeT01zNJcvbWbyvHQT2J6mtAjqoV63dnUSWfyhX0E55+vvs8vvn3Ua4B7fvv
	 Ah2Qf2DES3NV3Ln6ucd5bUInG3zteUKthnzqW2ZQXqXsx7TjmcnNt1KhVL0rG6i9Ng
	 ohWev9f7Xh3uad1JL9y8/jWN1K8V/aIR1Xlwsjh9aqcRT9wWp/s4FaBExKkIEPIztZ
	 BBX4sB45yLSJV2396TO/H0NyTzdTTzqvg5tXvCu/FFuncHpDeH0nZ2UiBvC6D9oAHA
	 u6iZNUPtU210A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "selftests/bpf: Add mptcp subflow subtest"
Date: Tue, 20 Aug 2024 16:44:53 +0800
Message-ID: <1c6d49faee85ac8e046b79c3aa060a1170d4d54d.1724142917.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724142917.git.tanggeliang@kylinos.cn>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Close client_fd as Martin suggested.

Please update my email address of this patch squashed to as:

  From: Geliang Tang <tanggeliang@kylinos.cn>

since BPF CI complained about it:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Geliang Tang <geliang@kernel.org>' != 'Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>'

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 9d4e3c1d4e7b..69fdcb28249d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -383,7 +383,7 @@ static void run_subflow(char *new)
 {
 	int server_fd, client_fd, err;
 	char cc[TCP_CA_NAME_MAX];
-	socklen_t len = sizeof(cc);
+	socklen_t len;
 
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
@@ -393,9 +393,12 @@ static void run_subflow(char *new)
 	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
 		goto fail;
 
+	len = sizeof(cc);
 	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
-	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
+	if (!ASSERT_OK(err, "getsockopt(server_fd, TCP_CONGESTION)")) {
+		close(client_fd);
 		goto fail;
+	}
 
 	send_byte(client_fd);
 
-- 
2.43.0

