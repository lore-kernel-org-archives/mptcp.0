Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223C22094
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364492; cv=none; b=G1UychgEtw6X762/fWd6s5Me9uFbHnBwH20QMYCfkJcvb7mf762NoNp5kmR4s7myloSaX0Bbu/IbJ1jZ2iu0TgXcI+iirJzhchbUtzO5nKD5J8SGVUuGauuu1k3VFtKNgt2j7P+ME2/IFNwTXGOMgJPEeT7SrpG/UiMYhujFhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364492; c=relaxed/simple;
	bh=vRJe9071SZylths98m+u2D5ZwwNLkyOBCYTvSfaUUa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XB/+3KeF6u40W7elnm/kh4RumH9Uwcsk4CWJpDHohSXMuu1LwPkOIXyywAx1GPvKFakg9PQxahMe2U0attg6O0lJWcdyby52Y35eMxFrLAtvNDI4SI+s7DLrSmzIRD01aD4bwsqNwXYvAfjQIR1bgeKtdGJVNIoddKxAa/AQi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGPhTq9+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGPhTq9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA2CC4CEEE;
	Wed, 19 Mar 2025 06:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742364491;
	bh=vRJe9071SZylths98m+u2D5ZwwNLkyOBCYTvSfaUUa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGPhTq9+u4Azf2xvBQjxIgrVMaKC93IxjRhOQ4y5gZaEkYv07hUAliHM+FfVkF7nC
	 JidH0a8nKYm98mOZrDLDa5osEs8YCWTVJ2EiEkxUj64ARR5Tj8wxIHWYy5N1D5x2ps
	 G6m2rSbLYcwa26K8WO812wQJTJRpCLEpagKr4n+T/ckgt+/4KKfTUZqnNp2fhkjCeP
	 4CGlFaAYw+vqgAqiJSYijOW+noUivlPel6hE3fYdXGLNXiXGxbCZhmEXVeWNhQq/lf
	 4WWOKfKjvZyC7Kb9LDMEQU7wF0WOtFQLhK05LMy2BrdL7gbnBGp4PnZ56i+o7L/fC0
	 06FReC9aASaNw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Cong Liu <liucong2@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/1] selftests: mptcp: close fd_in before returning in main_loop
Date: Wed, 19 Mar 2025 14:08:04 +0800
Message-ID: <e8193c72e8d1442a0feeb142b0b161b425ce7882.1742364129.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742364129.git.tanggeliang@kylinos.cn>
References: <cover.1742364129.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The file descriptor 'fd_in' is opened when cfg_input is configured, but
not closed in main_loop(), this patch fixes it.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Co-developed-by: Cong Liu <liucong2@kylinos.cn>
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 893dc36b12f6..c83a8b47bbdf 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1299,7 +1299,7 @@ int main_loop(void)
 
 	ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (cfg_truncate > 0) {
 		shutdown(fd, SHUT_WR);
@@ -1320,7 +1320,10 @@ int main_loop(void)
 		close(fd);
 	}
 
-	return 0;
+out:
+	if (cfg_input)
+		close(fd_in);
+	return ret;
 }
 
 int parse_proto(const char *proto)
-- 
2.43.0

