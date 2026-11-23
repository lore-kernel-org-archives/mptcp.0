Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422009;
	b=sdQhMvaLoC8JddzLHdYFHp3J2yxMD+rRPEfeWZl+Coo1bfCRxJO5ligm4jCYN1LUNg4j
	 Nx3nWGMzekqxgEhBrOSqPuhOj/zFylOwFOiooX+hawl+XsOKmFH2gRF7WRd1yfDlTXHBO
	 VxVBUeSvI7Db3H1CaMIewjoc7v/h9KXy9irerf/Ect4Qs4b08osqQmrhgG8qBK21UuBpX
	 WN3Zqlo5EIt97lilONLySaF3597k8D+5VvBGnA/cATxEp6xom0Z8t/Sh8jZsLLAzFkKaE
	 8TudhadIHgZm3RRjgGzSNRnb6eh74KqZqoYSjZ0edREiovnxfCi1w4jhfFbeUy/Re8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422009;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LLBeeZz5CEeAN6PHCVcSZWIb/bLDca4LEe5dPKpuzw8=;
	b=Ygu46Fd29scZmHfe5idHsOitKE1ThHIdUbRrK0ngO1Z06BrPi499KiZ0e7BhKE8QsgII
	 2svsJTDaCvdc76WDwg9VXnHrLb465gxBIylWauok8IgIZBy5zcwI1pUjm1k8BvkqLS88+
	 ODRhG7Lmcx/JibTkdx/M08HUiiv+lus3dDkXiQ2Oat2OcYlOPpuI1uSU/UO1ZI79vNZfs
	 R+nuTQwj+kKMFVvTTikT4rCa8AWrQsYwLGXSUwfP3zmEQmDCHg1xzpedKw07UedsQq6u0
	 WR0vFesuZrZOwU6rkRcMGsJ24JUlBUIPoluEuPZEitzJUHkXJ/yCWGHJDNckabB8Dgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULdifIzF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05F606A32C
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULdifIzF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1DB1F000EF
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795422008;
	bh=LLBeeZz5CEeAN6PHCVcSZWIb/bLDca4LEe5dPKpuzw8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ULdifIzFsXqxIQfnW+NLdq/VdbXNCgFfYm5bLTgSAxC61W25yTFfP1Z7P39qGf1In
	 7gLyc9UhORRNA63EFrTb35flgnxOkm1btFq2wOIc40MYGjKg4S2tJduV+qBCnh4rxm
	 ZUYfjmDeua7F3LzjqQ93gDSK61YWH6e14d6hUgw4ncSZMzkSzqP5n5Y0++YQ6yiOwL
	 j/4C4aLoUtlWwqQkVySRNPZ1BlRHqCVb8/LWKwkqIs1kZNLR6Gfrzs/aE2aUWeb4Zu
	 L7dV0L62YGMKWxs196uhufTh8gYtbQcsmWJ5vtEJis5+DfDRD6LPdsfnPj2gJWQ+zE
	 6c6CyRwARwN5g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 7/7] selftests: mptcp: connect: cover zerocopy mode
Date: Mon, 23 Nov 2026 16:19:50 +0800
Message-ID: <0f5e8a01d62f02de8f2b7af3bd49c9e70b960c58.1795421388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
2.55.0

