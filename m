Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79340363C79
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 01:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993289; cv=none; b=tuErn80J9d77qgXoTeaGTyOkJFncBj2WsQqA2McRaubJipbM8Geg9KtcaEhXNjTfNjIjosFhbplfkHMoQKZ3sVi1o+eQwCvw8tff9dI1YxjQ7pTHbjEk3Svkcmsscj4hxSQD2wkQYN1nJiiTHMHMt73jxY3G9qQxjSERijcp78M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993289; c=relaxed/simple;
	bh=gXWmEM4LFpuxOAMuCUM6NaMQDK0W28QcsZPP0A7MkB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQSrmxCdJ6ZJ7pK3PqjLRcA/a8x9ah+wRzcgXmU6aWcCEAkz1nu+VQH+2ul6ySkvPJbX8g2gKdDqKSRISxC8zQDUoOuAT0e5qVIbHakr/IVjjdmVolyd0n5WqOjWjNRdl+86uGZ7z7MwzoHVJyKot6m2mn67eB3Y3BSK4nFoD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK2MZflw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK2MZflw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E161F000E9;
	Tue, 14 Jul 2026 01:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993288;
	bh=BV7dLguDmKvmHGtOUgdSiWteNsUaNM1pfyH4C0rn6ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jK2MZflwi6QY3BQvbxKEDka69wOlfWOHEPLdCKjMisdd9VdO/HvttQj73aSrVk9eV
	 UBXF0SAFZ4/sPBebcI6b2WR/xyGy5eXUyE0Lu7NeQwGxKkQ3ucXd9RsrBFMZPQp3jo
	 BZmNH11V0N7DIHGLsNJbzQwT4dBwSzuVZcZxHj+JckH5OV2FJdK/pzN2u0ou4rBu6m
	 k2TO33BRPT1LQmsupz+QWguoT78YIrnWXB5yAKG9CX2Obn8YrirO1RyCpUYZWAIqGP
	 h/oxzj4QAO4IbffzVVS/3qtmSF5ag30bguGZEti3VMwEDuDX+ixXUwO+zTB1mcv+xj
	 kioX3+Jwb3hFg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 6/7] selftests: mptcp: connect: cover zerocopy mode
Date: Tue, 14 Jul 2026 09:41:01 +0800
Message-ID: <2573c94033852afd00fb7a4b5adf47cd99be636d.1783992745.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783992745.git.tanggeliang@kylinos.cn>
References: <cover.1783992745.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a new test script mptcp_connect_zerocopy.sh to run the mptcp_connect
selftest with the zerocopy I/O mode. This ensures the MSG_ZEROCOPY path
is exercised in the regular test suite.

The script follows the same pattern as the existing mmap, sendfile, and
splice test wrappers, invoking mptcp_connect.sh with the -m zerocopy
option.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile                  | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..9e47ecfe58e2 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS := \
 	mptcp_connect_mmap.sh \
 	mptcp_connect_sendfile.sh \
 	mptcp_connect_splice.sh \
+	mptcp_connect_zerocopy.sh \
 	mptcp_join.sh \
 	mptcp_sockopt.sh \
 	pm_netlink.sh \
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh
new file mode 100755
index 000000000000..0220d29ad68e
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m zerocopy "${@}"
-- 
2.53.0

