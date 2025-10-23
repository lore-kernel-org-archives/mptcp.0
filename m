Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EEA239E97
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199037; cv=none; b=btZcSauh4Og9Z4DWIibNJlal8K2PS+pgcJ7OVNBZX+5bVmBaqc+V062l0yfIS+ADUFLB4A1iRFDiy5/ws3IuUOCvLOlNkb1zMJUj+SiAovGmEyVche6Y8vyzePGwWC67/euOMJVr4DmO15vm1kSvZLE9k9STuIy/PrV6PRXxmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199037; c=relaxed/simple;
	bh=44gKlRmMR6ajeBEiC1QjEWJ6xMmcm6YCUrHn5I5+ad4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMhTtfWvANec9GZ6DAMIlG1XKA/fyHSDIkxoFf1SgaH9P37jKCQWIH9GM0sgHkrk9fCqYyezTeuwkOR/T92cqA1+MqHWPO5GsHGIf/4aFT2vXUHpA2H+YXL/qcpxwiLAz0IBNacjJOcn+ZQql7ciSgp1ltYM6rUMKhFV+T8QWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXQd8v5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXQd8v5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4ACC4CEFB;
	Thu, 23 Oct 2025 05:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761199037;
	bh=44gKlRmMR6ajeBEiC1QjEWJ6xMmcm6YCUrHn5I5+ad4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXQd8v5mzT8uWxFfkwjZ/NZmW0nWGPWcLHylXQeqJAPV2htjIgnzqE/HCsR9I+j9A
	 /v5093v2nQ8tyTefh6VHfn3ZQCUrwiJuXWN7Zoa0tZ/c2VHzCP0ywh+G2UjK/sCuu4
	 Ry07KEllDK5EXqEVfMtL7Fc327lxlI4Yv8/qamULsHTK7MQGvH8X0UNEKtcFml6lsr
	 4b8JHy60+8ehafBeKR5IwUUCyKGtL50bPugquC96DNmhCayfFHG9p0OAHdCHf0fD0J
	 OdHMa7txKtF+zPnbqj2z1f0iRfKaodLdvsQokfnUq2xh1xRu58FS2w/iwFvLOvua+b
	 c2pBVl4ZuaURw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v13 8/8] selftests: mptcp: connect: cover splice mode
Date: Thu, 23 Oct 2025 13:56:51 +0800
Message-ID: <c0d8c8efe9bbbe477b4c97b344cbe7cdfa371661.1761198660.git.geliang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761198660.git.geliang@kernel.org>
References: <cover.1761198660.git.geliang@kernel.org>
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
2.43.0

