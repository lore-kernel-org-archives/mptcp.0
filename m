Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0D1CD06
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533345; cv=none; b=YUv8N6yhLR2RBP3bXta8Ho8tKIe/P3dHkn877MWPZ8cCT1ly+CwVNh05IpK6diDu2X48YDBzRUYI9A1XPLQQ7K7qykdBHlCTUzskhi8V1Cq3ZSGMTLPHOx8wPwDqnLpnaEiczEQazSW1uHMRKylUtS43zT1UWppcKfWQMexhoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533345; c=relaxed/simple;
	bh=aHCtjdh6+rJVHVct9JaQ/sVbsDM5Iq4vPqBYpbmkC40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuu+nK/hNtnOvITdKz45yVJET93z9jgcntYzIKMr1QwEcjsYoFAlzk5yfHUtNV5TmvDSt+0tlnXfg93CqFBQ0d4hFmv1d0HVH5jBNfCjsL68bBH/39B8jsB8TE5y2V4v54fDIMyvWFEBAAmrq/VjgwTRCNhSLVyk76/8zPxNQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/JDSjCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/JDSjCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A65CC2BBFC;
	Fri, 24 May 2024 06:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716533344;
	bh=aHCtjdh6+rJVHVct9JaQ/sVbsDM5Iq4vPqBYpbmkC40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/JDSjCFneexdoiYc6aHCP72fuYt7JAdXh4A3YznYhTIB3gFjokNv9rh92zFQHH8E
	 E81GbwkuUl4JvQxLs+ten1/6U+fdLDg22SNYiRvrNeM+13Pv4mJWbUP4uE3+3BusGg
	 5sCLd8LdoVsoBLPT1LB3Iqfw4ys1ouJqVujRv8H32PNTuR1CCGkzfmHyRvUafHOn/2
	 PiIXYNgDjhV5g7TXY/enjTnacieSxfzcgvD3D3wkvB2galradLXCf2Vngrr661H9vH
	 tDaHjYskGm0SYW1p6gnJCZHITnGK8IoPYtCJCtNyvEAboOxtQkXO4qCCgBiKdZh3j7
	 W/CntzsYOz0Zg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/6] selftests: mptcp: rename ns to _ns in get_counter
Date: Fri, 24 May 2024 14:48:47 +0800
Message-ID: <e6adf1ed401342f0065b6dcee02e43b7c769ef2a.1716533107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716533107.git.tanggeliang@kylinos.cn>
References: <cover.1716533107.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

If "setup_ns ns" is used in diag.sh, it fails with errors:

 ./mptcp_lib.sh: line 289: local: ns: readonly variable
 13 ....chk 2 cestab                                  [ OK ]
 14 ....chk 2->0 msk in use after flush               [ OK ]

That is because "ns" is also a local variable in mptcp_lib_get_counter.
To solve this, this patch renames it as "_ns".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 6ffa9b7a3260..3397bf511f41 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -312,11 +312,11 @@ mptcp_lib_is_v6() {
 
 # $1: ns, $2: MIB counter
 mptcp_lib_get_counter() {
-	local ns="${1}"
+	local _ns="${1}"
 	local counter="${2}"
 	local count
 
-	count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
+	count=$(ip netns exec "${_ns}" nstat -asz "${counter}" |
 		awk 'NR==1 {next} {print $2}')
 	if [ -z "${count}" ]; then
 		mptcp_lib_fail_if_expected_feature "${counter} counter"
-- 
2.43.0

