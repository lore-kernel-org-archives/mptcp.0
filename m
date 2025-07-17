Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE42F509
	for <mptcp@lists.linux.dev>; Thu, 17 Jul 2025 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716283; cv=none; b=HyQgs7j7Z99bUFSxUaj9OO/TswXUFgXOz1bpbqkiF6wlUL68KFJbL/ap4aVYk3BIcFnYseq7F5EdBHPylh7ta2Uok4xNsfy+2XBtyjE7T2rM/Gyeb7jmpVz5X4B77ah9CM+ziLvLvXEA7sf3Ah03Rpe5it2JlwP+D6UkcDbiyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716283; c=relaxed/simple;
	bh=VACcF3IqbT0KbR4SH3lYZ4CVra4Oy286Mm9koaJteek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKi45cwepl4hI96Kqqsb/H86Bg96oi6MDs5yne5KVh/wsnagMSs9iOJs0xcV0BnTJe2Tw1IRSVw3GgLlFqHPpi+eervTpOeiOAaA9Cryj0QWIdRcNbhsPwlY9ZPqtKQ4XhiiRrC3bJsdbgXcb51Zby6AWmuVWezL4hddf+oKJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9ji5GPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9ji5GPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053FAC4CEE7;
	Thu, 17 Jul 2025 01:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752716283;
	bh=VACcF3IqbT0KbR4SH3lYZ4CVra4Oy286Mm9koaJteek=;
	h=From:To:Cc:Subject:Date:From;
	b=l9ji5GPn0nw6srFaI0pHnJZ1dkGURmriFmeujb8xWM/ObHoz7/3OzF0bk4K6mtq1c
	 cnDZ4Zee8EJlyAxYlJpkcA7lkKI/vlfP1xoforVz+mvbDnp7DQgT9yEcWsb+rIsV0C
	 JeHr0tyufUn5dpl43j7zqAQPqCNF7mydRXcgtRppcC644MO2OdEPn8B8gD0sKPbN49
	 KSr/hoZShuaSDRraNSnzvGMlCRlpw0SMY6THbEvWYS4cX3p+QufelEBhYzi95CHDZF
	 Rqd4j0n9IzqdHSVGxf83Rv1R/Yqv5M3tsfp5+D9kNfy6WRiKqPCano8xGAmfn8MIHz
	 bfzHDXhLP3HKQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: connect: cover splice mode"
Date: Thu, 17 Jul 2025 09:37:58 +0800
Message-ID: <066b5d2e87f454a33d4fdf01b76ee64ae4002436.1752716264.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update subtest name.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
index 77fe240ecf8c..241254a966c9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
-- 
2.48.1

