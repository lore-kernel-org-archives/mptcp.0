Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B31755C
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987109; cv=none; b=aBFMdgcOzM69XoNGAT1GhbA3hpIyKZfBWxfAQw/YZnFF8evAB8faTLV0OWXHl1EKmLGWl+6qm9DfQVHMem7zRql27NT7J/0vZfv587kcyIj1amVXO1k8jq+6beyKC/z9QJm6m2ZK1esdUc0HXThuNmY/Uy5UdkjZNlX1vReSkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987109; c=relaxed/simple;
	bh=qDdqHdcGxPDTj/mv2nTeJVub1oxQDtvYdII5/k1oFio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1yKycyCre8kXwVdR562TQZ18dm6kHZ7iN2eCXWSoKAh5gmquy2UHnN13VTAf6Yb1fRi5sQaXMAC9658Et2+otjNF2TGYK8wtN3Xqed7SLwvYdq54sgwMjP0O/+PhexX90F+W/I7WS+QzeAtxhxPz0knwXaKJJgnRBELkDWVHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a59q3otR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a59q3otR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090BAC4CEC4;
	Tue, 10 Sep 2024 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987108;
	bh=qDdqHdcGxPDTj/mv2nTeJVub1oxQDtvYdII5/k1oFio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a59q3otRAGOQmdNUYi2LmcR3EhPkDghr6OrUkCCeecWykn+HOQhEkRhcv6giu2LuX
	 Bp7o+IdBgoQssi4JCyXZwt6KDuFn+xcjKqObF2O1j5OgH5Ka+vlrEgalYJVUv6pE24
	 T1jhYlPacFOJ6ev/J381XKir+tQOM1mxH1PBzIrVBdnFJXGBhbsZuWSIdCPKwz1rOn
	 w0/hT+vrdnM6ocW9T7iVPZlkyzSxnidWQHsdwDXn1EzCvBl7wQx5kwuwdtE9esCAhK
	 n8bCbvJYpCZ4cv4v0833sKTNQfbRfG2WaVX/Pr4zF4gfBfS1IwFM24oMiDmDjf8z+W
	 GDqnaqIsBepvg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 10 Sep 2024 18:51:41 +0200
Subject: [PATCH mptcp-net 2/3] selftests: mptcp: include lib.sh file
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-selftests-mptcp-fix-install-v1-2-ed1fdb92aa02@kernel.org>
References: <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
In-Reply-To: <20240910-selftests-mptcp-fix-install-v1-0-ed1fdb92aa02@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qDdqHdcGxPDTj/mv2nTeJVub1oxQDtvYdII5/k1oFio=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm4Hkh+Z72cndli8JsO4QzE4Rg0tbtalSmno/Bt
 +Blv+J3Gg6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZuB5IQAKCRD2t4JPQmmg
 cwjxEADctN047fXRyJ46PXcPCWHsN0v0oWabg5t7bvEmG6cWpjsqXLjWHTR4jkY2zS6v9hVm8xP
 ouiKUWaIYCplXzouzgJY9RcezcBFDQwfddo1h4qU8jzutmnQx58WgDXtiduNP33fC5Y/ASkyUW+
 0HTAubw8j5c2KPL66D1APZ8NdnVhXlmZ/B7JiR4Sjx4Nec0UrqdCqag9tgbpw3PnczgOPxWjgZg
 eXTBB88m+StiSQ3R4fmjJwPpm9GlpZt/dR+CQcPRxn71ne8pGX+5eV8fA5OWzGHNhAzG9yJOy7c
 Gl3oGjkIbdQWC+kMJPjrVhfhZ9hES4liFhzUSpcZgHe2eiMS4J7Dt34qBtUhevddtM95ZIFpKUo
 I6USFkuEmzo1WobaO6HvHqUw36jFLG/pqHgghUfChGOkYl3wY1efvwX/QkK7bh4a0qCCOSUdHuZ
 4vtmXb77AmnsVG3xxY2JwRvGLli8YbADuXfinxh8bfnflAFNXcHPQ4lGZ2TdGjMfz4VS2K3wS2w
 S+buApmhuPpjSS7A6KcmLHycSkRofruNEL/a95X0YiPRPSWzu+3uYu6llaEnumpOC+wyMdyAAPn
 wMtR/Wcf8ymPApJEazoHT7elHwE0zAs7Z/NCMQs5o0fdyEnxVCkYaZx+vhz1BD1RvsbNZRjC8cp
 +QOF2lk1vxT2/MA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The lib.sh file from the parent directory is used by the MPTCP selftests
and it needs to be present when running the tests.

This file then needs to be listed in the Makefile to be included when
exporting or installing the tests, e.g. with:

  make -C tools/testing/selftests \
          TARGETS=net/mptcp \
          install INSTALL_PATH=$KSFT_INSTALL_PATH

  cd $KSFT_INSTALL_PATH
  ./run_kselftest.sh -c net/mptcp

Fixes: f265d3119a29 ("selftests: mptcp: lib: use setup/cleanup_ns helpers")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 7b936a926859..68924053a1e6 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -11,6 +11,8 @@ TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
 
 TEST_FILES := mptcp_lib.sh settings
 
+TEST_INCLUDES := ../lib.sh
+
 EXTRA_CLEAN := *.pcap
 
 include ../../lib.mk

-- 
2.45.2

