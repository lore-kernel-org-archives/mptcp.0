Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6DA26A0ED
	for <mptcp@lists.linux.dev>; Tue, 15 Jul 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572965; cv=none; b=TVp2o6grN/lVWvP0Wjo08gSh+DN0giy1QmX8DmYDQNEUu6MiJyAGPLHlL8tGAajtM/bU/vYPSK95cml7C8AkXjjJE0B0TUvw37pT2HK3eQtoqOLkyIq6BsoxGtzBBhi14vGAuHYe06MhiS4eTbLoJ99x3Q0IVPMzFoXYTgtC+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572965; c=relaxed/simple;
	bh=olAI16RmxA1SAR1DYNNiZ+is9ZgqjS49ZKNLMfSrZnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0r9RLcLmOOCYOOxeRk6kaDt9pqmYj93f6BJlyu5qtrv8m2MWLKXiNQYOYsmDdiybTTMrhLcoFy3BNZZoSEakG7Bv+naWb9nf9R20I3BXeKbeGKQha9jjPtbmZMvXpF8VVJHg8gsty/roq8BJtJEOV5QV2shdRQlYtm8m+LDdIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVVd/5jk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVVd/5jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1079BC4CEF6;
	Tue, 15 Jul 2025 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752572964;
	bh=olAI16RmxA1SAR1DYNNiZ+is9ZgqjS49ZKNLMfSrZnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PVVd/5jkFOoBA5y0Rs3Niy2z3Fx6JOGF7wpn9x+wRnt072lJy09d1t5vNRuTIPKpZ
	 KhqfKtuVPCrrmOX0zrOJNuuO/43a/Rls3s4l4f2jAOM5gV8k2LIPLF/PfUnNJd0qT2
	 PBpZxEeSa5N++uwrfCmxGKj0U6Bq3Ka0Nk3NJbkKHHjSK9Hkab4O1i6V8DrjaM0Xo7
	 54NQlQpkEurBJXO10C5+GuuiNhGT8rjLkxa2yTsuQE0Qe8x0kGYpvoQgdoVQtx4Cp0
	 2Uo8vy69ORxtT0bb1EWycdD38hlFt03YGLQhN/XZmplx2mj4dOJlTh9yOK8YmRSGIz
	 yEJROEuRle31g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 15 Jul 2025 11:49:08 +0200
Subject: [PATCH mptcp-net 1/2] Squash to "selftests: mptcp: connect: also
 cover alt modes"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-selftests-mptcp-connect-modes-fixes-v1-1-58fc475d9397@kernel.org>
References: <20250715-selftests-mptcp-connect-modes-fixes-v1-0-58fc475d9397@kernel.org>
In-Reply-To: <20250715-selftests-mptcp-connect-modes-fixes-v1-0-58fc475d9397@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=olAI16RmxA1SAR1DYNNiZ+is9ZgqjS49ZKNLMfSrZnM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLKVBR1WReIvli+a+2rqPsri9ZMsov6c3PSk8PWD628J
 x13/xbxo6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi59cw/OEIlvnBOPOuDcv2
 KbJp747emXm6LNnZ/qCuxnLvJSuPZB1hZOgudpl/S/169PfEKq5PBbfPXaxcJL4p5XjrrOkfClm
 +JDIAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Without that, all mptcp_connect*.sh subtests have the same name, e.g.

  mptcp_connect: ping tests  ## from mptcp_connect.sh
  mptcp_connect: ping tests  ## from mptcp_connect_checksum.sh
  mptcp_connect: ping tests  ## from mptcp_connect_mmap.sh
  mptcp_connect: ping tests  ## from mptcp_connect_sendfile.sh

In such case, the CI will only see one subtest, not 4 different ones.

To fix that, MPTCP_LIB_KSFT_TEST env var can simply be set.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
index 09bde1303bf79198fe9f7890cbe89901859d78e8..5dd30f9394af6a88b14936a64c50ac9566be2e6e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-"$(dirname "${0}")/mptcp_connect.sh" -m mmap "${@}"
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m mmap "${@}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
index c50d08481581f0f8997c6f4f2174d606150bfa6a..1d16fb1cc9bb6d1f88a9fdc11206237ca2b790bb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-"$(dirname "${0}")/mptcp_connect.sh" -m sendfile "${@}"
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m sendfile "${@}"

-- 
2.48.1

