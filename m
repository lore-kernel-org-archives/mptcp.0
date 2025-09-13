Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806203596D
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723959; cv=none; b=XXkgx4PRKgRM5zsIagToMH2JPScFheEEPMlcXiOCK3UWg9P2tkEOq7qhStnWUC5I+GSRz8cpbArNkzSP0vlKXoifQ4AL/eZIV2ISOEQp/6KN2wrhomtFlavSECh+EoGWGtec9Y8A1DYN1Oh/uJTThcJ72/Hn5PQfsE+I1LtospY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723959; c=relaxed/simple;
	bh=W1TrNXyK3baNrw+Eky2FBKNJsJGOe6HbIPXU5mFXflU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDVTFDPoabUN8pgMkWgcgK6qUVdVdUD5eOe14C7hMUF/CBv9NkImoOGCykH1CB97dmgd1oKzweOEW4gS0DXdBCCwcJSxYneJB86cWIJlUcl5jyYRsATvVPwidlKMiZvhd5LolKXy9nbKpVSoRK60IXkqEs2i/0rAmOhTOb1I9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKeoikBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKeoikBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A340AC4CEF1;
	Sat, 13 Sep 2025 00:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723958;
	bh=W1TrNXyK3baNrw+Eky2FBKNJsJGOe6HbIPXU5mFXflU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKeoikBOIPvaclXZc7N2DjegMkYqOFI6OMs5cYjmHMkUHnm0ZS/6GuFBqE3Yzc6N8
	 zz5ZYBoyhiU2vzfbHxVKiWmk29prOkbFV1GPmxvQI+yL7Pm3cb2sHGx9JR2yg2D1wh
	 zurHaes257qadQdoiawWuTtyxNMuR0FOjZU6yE07IJnpjsNtHAmTYCC1BSosUXTO5Y
	 xZHFNHChk+oB1QlU5/louD4k8i9dQUBOM8NwnoHrVVqdMBuU39RNuMc9T1XnOtdclb
	 xiJdd1SDChsxtmNFOuF9+2MqLlTtTF5BuR010FpoqsEH9qMsq/UTDndG1P88aNmlIB
	 3ZXIe775djafA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v11 8/8] selftests: mptcp: connect: cover splice mode
Date: Sat, 13 Sep 2025 08:37:27 +0800
Message-ID: <e33b18b0f24b325bf13c1334d232dccbea2ce876.1757723270.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757723270.git.tanggeliang@kylinos.cn>
References: <cover.1757723270.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/net/mptcp/Makefile                | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 4c7e51336ab2..83c1602fb6bd 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ top_srcdir = ../../../../..
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_splice.sh mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
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
2.48.1

