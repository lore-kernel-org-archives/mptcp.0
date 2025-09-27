Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72F2DF148
	for <mptcp@lists.linux.dev>; Sat, 27 Sep 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976309; cv=none; b=spsLXeVqLk51yp+CJvzT0hEtsMloxLJq5BmwsfGIU7FwsDo14TV8QC6V8bkdZQiAWtRWI5AHN5IFiXBcX9OtJpEtI1NKXAZ6Dl6ZHRm57DztdOf9n16zxubXDN2EB80KEveSQwD4tOlpzFWp0aOUZLzQ7p5TBPoFt8/ivwxTcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976309; c=relaxed/simple;
	bh=02n7mNF6TsqQNQQZi6d0zEfSQ70oYonJabggGH6P9PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tj2hirUfQF02oLoxllZfb38BiBrlYn9QY8AcMNnCWIpfwP04ig8MkN7++wmgJiVg3/1yVhqitORAZuqZEqzyU7Bz2+Jodse5FsIsx07Aabk/HhQGMHPv9DRNDitQjowUW2SuzKuXN55GQWGkklG46X5fQeZuZSTbxWcZArZlVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSNlh3en; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSNlh3en"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B55CC4CEE7;
	Sat, 27 Sep 2025 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758976309;
	bh=02n7mNF6TsqQNQQZi6d0zEfSQ70oYonJabggGH6P9PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OSNlh3enPGZszFkSAjP9D6uAVnX2F8cnj5djfznyTWNgi/w0a70H27X8Zyn900T+8
	 jI10YjxSdylHHh+D6wxG0SSeU8pFKtSBtu7QXo1XJ4O/suXRtL/h/jgwLeMI+lBxzl
	 O3a3PvTdijLfiUlKzrsRO/iDORLd1NMdcd5JzoliPOiTvXyAwKP6bQ6bUff84OYzCm
	 ksIj/6LavGsQSkLYbKN+GytWbAs+t/oEUovRhxbZ+fc5NLuGtuBk9QfdOO1ipbIOMU
	 a5hEyo9jr3DindXFKZHNGuZzHZSWeShxk/exBOBuR2qhlHwfrFi4YCC26NT9XWQ6PJ
	 kGpJLLEcaKayQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v12 8/8] selftests: mptcp: connect: cover splice mode
Date: Sat, 27 Sep 2025 20:30:25 +0800
Message-ID: <92d58c5b01d53f1a02ab39a2c50094fd36d58e7a.1758975929.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758975929.git.tanggeliang@kylinos.cn>
References: <cover.1758975929.git.tanggeliang@kylinos.cn>
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
index 4c7e51336ab2..1bc74b271a0a 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,6 +5,7 @@ top_srcdir = ../../../../..
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
+	      mptcp_connect_splice.sh \
 	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
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
2.43.0

