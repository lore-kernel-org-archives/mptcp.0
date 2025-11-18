Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88319ABD8
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438513; cv=none; b=fViEt/6DPouDleMNd9oZR+OQq/E5s4SBE8ymWkCqjVvwQIQMlWidz1hygkGs0beanWJlnKWWEXT6w0/02hX2DrfGsADuDsMM2fFHfaCazvK0y48MYwczkm+RK6eNyc4agYG8MvVwfSxWL1BACtKlj3HUpAqynbukp3mZEDmy8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438513; c=relaxed/simple;
	bh=J86OKn5xH0aCyfgFj2LrEaddfYLxe76BkBFI2DuoDYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvCXjMWoP5A/ilsOOxSdefAHNY7oXI/yJv3xy4WZuYjHmvAU9h5A8Q9BgazTuLH+tvha0XKkhutU0uN/4hw7DRoMKyjuRTZewwwqBMa6JZ9f5jEp2Kkq6ej067Ba1YiRU3ghg+nQH4LhwlNZMzcxRKB5LMe8ht9PXhyGqF0xaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnzYfTrD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnzYfTrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFCBC4CEF1;
	Tue, 18 Nov 2025 04:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438512;
	bh=J86OKn5xH0aCyfgFj2LrEaddfYLxe76BkBFI2DuoDYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnzYfTrDxXEHk65LqAYU2Au2zbSytjuPYSi+TT2j2u77aYPJ8H/bkA2epJ10zTJQ8
	 rgV3J3tOVuV6lXjsSAbnPlXvNtCZgL0oegUyViIY4GWPlxDaEbS46fCb8WTRb/IRpa
	 9SwQ0ZcDaDmAqP//nhA8iA1OeqTKI9py0to+Pmt7vARhrqQjnSOtCMaJ+Bou59yysZ
	 XAfQQisbXIJ6X6yt1bB46kS+4rgnTA0pxkcvLVD0fSGSjEKdr2fhgKtCktWKsJu8Rd
	 y8PRtRODxqgRl+u4cBiieZ9LM93xk4LU9FR3zePj3KJt7sFjWxQfiEU1JCU7gFyP4T
	 kHXXeYmrVsjXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 02/10] selftests: mptcp: sockopt: skip mptcp getsockopt for tcp tests
Date: Tue, 18 Nov 2025 12:01:23 +0800
Message-ID: <f4f9813261da9b8d68f936f61d273af6c6610dbf.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763438045.git.tanggeliang@kylinos.cn>
References: <cover.1763438045.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Skip mptcp getsockopt checks during tcp tests since MPTCP socket options
are not available for them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index e4752f848f08..59c07eda12cd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -384,7 +384,7 @@ static void do_getsockopt_mptcp_info(struct so_state *s, int fd, size_t w)
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &i, &olen);
 
 	if (ret < 0)
-		die_perror("getsockopt MPTCP_INFO");
+		return;
 
 	s->pkt_stats_avail = olen >= sizeof(i);
 
@@ -415,7 +415,7 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 
 		ret = getsockopt(fd, SOL_MPTCP, MPTCP_TCPINFO, &ti, &olen);
 		if (ret < 0)
-			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
+			return;
 
 		assert(olen <= sizeof(ti));
 		assert(ti.d.size_kernel > 0);
@@ -470,7 +470,7 @@ static void do_getsockopt_subflow_addrs(struct so_state *s, int fd)
 
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &addrs, &olen);
 	if (ret < 0)
-		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
+		return;
 
 	assert(olen <= sizeof(addrs));
 	assert(addrs.d.size_kernel > 0);
@@ -540,13 +540,8 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 	olen = data_size;
 
 	ret = getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, &mfi, &olen);
-	if (ret < 0) {
-		if (errno == EOPNOTSUPP) {
-			perror("MPTCP_FULL_INFO test skipped");
-			return;
-		}
-		xerror("getsockopt MPTCP_FULL_INFO");
-	}
+	if (ret < 0)
+		return;
 
 	assert(olen <= data_size);
 	assert(mfi.size_tcpinfo_kernel > 0);
@@ -650,7 +645,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (eof)
 		total += 1; /* sequence advances due to FIN */
 
-	assert(s.mptcpi_rcv_delta == (uint64_t)total);
+	if (s.mptcpi_rcv_delta)
+		assert(s.mptcpi_rcv_delta == (uint64_t)total);
 	close(fd);
 }
 
@@ -685,7 +681,8 @@ static void process_one_client(int fd, int pipefd)
 		xerror("expected EOF, got %lu", ret3);
 
 	do_getsockopts(&s, fd, ret, ret2);
-	if (s.mptcpi_rcv_delta != (uint64_t)ret + 1)
+	if (s.mptcpi_rcv_delta &&
+	    s.mptcpi_rcv_delta != (uint64_t)ret + 1)
 		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId64,
 		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
 
-- 
2.51.0

