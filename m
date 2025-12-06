Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAE28A701
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024487; cv=none; b=dLxij2XmqSTle3tnofSPIPOG/aWQY5viuObSRTKvQwS/O04EX2O8cHf3N71pFcFUu6q8Moc4/SM77JY2l95mD6DOlKDbNlWISEpWKxcM7s3jAthMxzxGE2jlF1jTLoQ9oz42y8ilmabJPoCKYDZsn5EkFEB/Xro276+aSSTVSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024487; c=relaxed/simple;
	bh=p2KvbtiTsaF0tbGHLxMEAf7azAZn+3yJxa9Mv7tTwNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Le9FabYCnaHC76BRwALixmq5ZD+6QjTSvORvpW1y3ovlWwnIHRqRyBi7IgAU/XEtZO0KnLUtawFqh9HxfPWN4Tvvg7AHyrAkb0/i/HKag4LBTPKYlAwx2tuaU5RMoDDkjnICV6gbKxuixjChYIxzCcnvVtfkiaF8RBMlOtXiq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWqZVXjV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWqZVXjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10559C4CEF5;
	Sat,  6 Dec 2025 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765024485;
	bh=p2KvbtiTsaF0tbGHLxMEAf7azAZn+3yJxa9Mv7tTwNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWqZVXjVmePBsLX/0ir2fd9TOHFkoRd5MoMpzUMBpIpqVuTojvU9pybsAm/w0w+Vi
	 OKwtHl/F244Mrqej6QG6wZgxiD6ZJRcq6QbdrMynbyXyzRIZUwvHMORgNDilUcLrJf
	 SmtVQv1NbMd9q4XxafNxH3rdFu7I4Wq2GA3pkiWeugu0jSOnfSl/z3GEtlomKkMkrJ
	 HPRwdzyfqumFGltJ6fARfuL3JM+RkTXAApz3hwRlE9SA3cZToH+Wl7WiYhSrSiED5F
	 RWwxX3M1FbbYEojG4wSlCSy4/lR0fvsgS6hmFGzNpg62F+7JpFt8gIS00bMOKvk1SI
	 UjGS3x4D39zVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v15 6/6] selftests: mptcp: connect: cover splice mode
Date: Sat,  6 Dec 2025 20:33:56 +0800
Message-ID: <63e9be57d99b01908f4fc77d2aa4aa9bd9d4c868.1765023923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765023923.git.tanggeliang@kylinos.cn>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The "splice" alternate mode for mptcp_connect.sh/.c is available now,
this patch adds mptcp_connect_splice.sh to test it in the MPTCP CI by
default.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile                | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 15d144a25d82..30d9022119fa 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS := \
 	mptcp_connect_checksum.sh \
 	mptcp_connect_mmap.sh \
 	mptcp_connect_sendfile.sh \
+	mptcp_connect_splice.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
 	pm_netlink.sh \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
new file mode 100755
index 000000000000..241254a966c9
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
-- 
2.51.0

