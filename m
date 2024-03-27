Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813B31A76
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530130; cv=none; b=CEghZPno2bwKwDKO1j5V/ftK3S9glZjkiZ5fZeLksiGYABS5+TOAklsVUWUzztSaghmj0silFWaCgUObnY4gjBYq7gxSwe1So6dO1AM6kG1uhXA1WQedcvz89FfCZS8XiAjZK94eKm0NQvLn6D71NXu20sbZDRu2uM+gQ/VdWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530130; c=relaxed/simple;
	bh=5rB12x6TrqgkX/N9c+/aNQiVysuTLr977o0FUaF0e/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/AGO4082BR3ybV1wZWys61kdrvlm5py9MK2rUx7hDXg5hsMVwEBVokxmKOkXmtDVXRYNVq47UTRqMRhcNcMDjUnOnXX+Yt3eZqAJEqeoYlPjOZB7gmDezySVWXOHI3K2ndib/sYCXAVAVlfiDPFxTSh7lNcg5C3HGinTtJjM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eik26j+p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eik26j+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFACAC433F1;
	Wed, 27 Mar 2024 09:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530130;
	bh=5rB12x6TrqgkX/N9c+/aNQiVysuTLr977o0FUaF0e/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eik26j+pBp8Lj0jO/6y7QmR2roVGPWid40l4PZ7vS86LfV3OOmX4cDLd02AaBYMNE
	 mhcDr92Xd02Bwdy0B37kQF8CERfkPrGHBLaa1+50usTJSJZ6HFz42uCVtVJz+70720
	 Kn1D5xAbGy6H77OU2vPaimzJRBQnXDwSZUHW506/34o9fQ2tvzlq3EYV8uYL4hijuB
	 YjZ/3AUfCf+nOXto+2YK5Dxf7cw6CjSRRRGHIN9sbTARL5odCIa5zwZwAiYGTuVy3s
	 6YwPNZFtnNATg/fLyn/EkRQ2pg9TwM+5VYLI7ET5kNZ7vD1xWRLXZKx1bGp/crd/K7
	 nPHfTLirR6fNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 06/11] Squash to "selftests/bpf: Add bpf scheduler test" - add send_data_and_verify
Date: Wed, 27 Mar 2024 17:01:44 +0800
Message-Id: <d5a68e54838b0e4d4534fd3b881f56ce10cbaa55.1711529752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711529752.git.tanggeliang@kylinos.cn>
References: <cover.1711529752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add send_data_and_verify helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 ++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 64c5f6404784..f86ae0be0167 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -534,23 +534,41 @@ static int has_bytes_sent(char *dst)
 	return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
 }
 
-static void test_default(void)
+static void send_data_and_verify(char *msg, int has_bytes_sent_addr_2)
 {
 	int server_fd, client_fd;
-	struct nstoken *nstoken;
 
-	nstoken = sched_init("subflow", "default");
-	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
-		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	if (!ASSERT_NEQ(server_fd, -1, "start_mptcp_server"))
+		return;
+
 	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_NEQ(client_fd, -1, "connect_to_fd")) {
+		close(server_fd);
+		return;
+	}
 
-	send_data(server_fd, client_fd, "default");
-	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
-	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
+	send_data(server_fd, client_fd, msg);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "Should have bytes_sent on addr_1");
+	if (has_bytes_sent_addr_2)
+		ASSERT_OK(has_bytes_sent(ADDR_2), "Should have bytes_sent on addr_2");
+	else
+		ASSERT_GT(has_bytes_sent(ADDR_2), 0, "Shouldn't have bytes_sent on addr_2");
 
 	close(client_fd);
 	close(server_fd);
+}
+
+static void test_default(void)
+{
+	struct nstoken *nstoken;
+
+	nstoken = sched_init("subflow", "default");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
+		goto fail;
+
+	send_data_and_verify("default", 1);
+
 fail:
 	cleanup_netns(nstoken);
 }
-- 
2.40.1

