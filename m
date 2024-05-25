Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F4125DC
	for <mptcp@lists.linux.dev>; Sat, 25 May 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716642138; cv=none; b=ZbN9rx32kU3n1DT968h1NxwKnWF2SZCY5E3Ii4Hfz2Y7YlOwP7HOAygRsdMIiyuftDKMfhg1vnFkgfyZh+abi1BxcyV41HrOujgb30s8Zv9i5eLXcOGbnY6/mEVhU6ERw+bFfPUXOl1hYokGBASIz0ojMSiOPswaLwn4Fc/NHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716642138; c=relaxed/simple;
	bh=Uo0GmWZpMxpDtd8A3glQRkAZD7udeDVgJ4hJvantlBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9vZVEBVvSlDznv6ACcM0zPIK9YxRZVrR1FJ2pwBa/VOYQwiOsOMGvyW+fd9HO1VlevtsPu+DEHNdAehtTJtfnM5gnuyArA7qTU45KlK1+5mFiJUk2q6EPJ32XvpG+gXCeieIsW47aIu4jsI0alDcctkPoknhKUuTjAIK6fb02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPBy9OmR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPBy9OmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE01C32789;
	Sat, 25 May 2024 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716642138;
	bh=Uo0GmWZpMxpDtd8A3glQRkAZD7udeDVgJ4hJvantlBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPBy9OmR0S5BvrVVTXj+vNDJCYwI2DtJ+NLO4t4Ci+kxs5+mdnHUYNwve+54asJcl
	 SK8F1Hpoo36o7fFNdlWjuP2MSg5BLhYksiVgpL02Qd0qU02GsuKqiAIhoVJ4mpuaqh
	 AE//sKCtoPn41O4tDYXFPG200qBdH7SCSo9KNkH0xsf6uGUAESRKBMd7/BbaXBNYwy
	 w/qlZ45wtp2UcY+q7N6uz7lgRcFR3r7BHzvEiVF4gG6WmcHg4PaeAMSVIEnuw8U3Sy
	 Peu8eRVx/q52I5/VqaOUu+11AAoAUf6wAiBX1CM9yx8CsZdYi1mXaWIkOvNEk4x9Xq
	 NbJUZ2k94+lnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/4] Squash to "selftests: mptcp: lib: use setup/cleanup_ns helpers"
Date: Sat, 25 May 2024 21:01:23 +0800
Message-ID: <029bea7a92e16983747025bc586910cbfa4dd2ac.1716641976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716641976.git.tanggeliang@kylinos.cn>
References: <cover.1716641976.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

setup_ns exits when it fails, so I think no need to exit in
mptcp_lib_ns_init anymore.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 194c8fc2e55a..7a461830539b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -428,10 +428,7 @@ mptcp_lib_check_tools() {
 }
 
 mptcp_lib_ns_init() {
-	if ! setup_ns ${@}; then
-		mptcp_lib_pr_fail "Failed to setup namespace ${@}"
-		exit ${KSFT_FAIL}
-	fi
+	setup_ns "${@}"
 
 	local netns
 	for netns in "${@}"; do
-- 
2.43.0

