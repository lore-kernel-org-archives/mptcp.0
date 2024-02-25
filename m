Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6FDDDA
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866261; cv=none; b=BIDn2sQ5zdNsXPIWd6z/Rhm2YCNdZPt79LawYvmYyPQz0mkTP3nv3VI5fW2VI0w5tv6yHckMfmjp7PGpjVJBDrpFXewgAE/BAk8j6u1U8KbP110hntWFAJxJ8TOOuARQGmDCcth3wpc8nkP9jlNgqYPSRCUUEznjWqHGBO2GAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866261; c=relaxed/simple;
	bh=tF0QObIedMoOr1NWG6q3pFb8Y4fOSGuD94Idpxh1gxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQ7SdzUQAvCqMSAwmV9eUxf9q9HGlV+M/i67Autcb/g/cW/K+YtDp983+DDkJREluxpLBYOANDUCD7WwEiolYABV3NCiRiY/X/n5owwNjiNocoxkko/Zz8bVDYS9ZucvD3LggaU2kenkxIBPOs2c61r/M3ILZ1lPbIiHSnkilo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApwYaiiu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApwYaiiu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A4BC43390;
	Sun, 25 Feb 2024 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708866261;
	bh=tF0QObIedMoOr1NWG6q3pFb8Y4fOSGuD94Idpxh1gxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApwYaiiuEETU5pB/u3wLLsePpWgo7E+MHKM1/x5mrXnvjqvcAqkhRGmJCdQDtCXiY
	 WvaLG6GIEW/I913rzLKPAuMgr7ZU7CRknp2ssLz/B0hJx7k69t5p03Ya0a43657/ju
	 cH3NP3/LhymzI7rBH6OXuD5+Fe1eWMkj7P2dpKAJSVRrhVqCeb/3ZNoCPMmu/oxyv8
	 X9yBJ+gknl7NTugdv0fbU9SMQ0G8Xmp9eX+Gogz0luUnfR8tiSQW6R0qf0lnQ/784b
	 +CEYF5Ix8Zsg+81bTK9lxyX48FqY7KAx+P899e0ICdIYmo8it0xf6StmYMJXKWm5Og
	 XpJEzKp9lik1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 09/13] selftests: mptcp: move test_fail out of check_expected_one
Date: Sun, 25 Feb 2024 21:03:57 +0800
Message-Id: <694d9be19d5c4a9f242355aae3beada5b0433f9c.1708866087.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708866087.git.tanggeliang@kylinos.cn>
References: <cover.1708866087.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch moves test_fail out of check_expected_one(), since test_fail
is a private function in userspace_pm.sh, and check_expected_one will be
exported in mptcp_lib.sh in the next commit.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e173a5e6569a..ced72741ed56 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -247,7 +247,7 @@ check_expected_one()
 
 	if [ "${prev_ret}" = "0" ]
 	then
-		test_fail
+		return 2
 	fi
 
 	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
@@ -263,13 +263,20 @@ check_expected()
 
 	for var in "${@}"
 	do
-		check_expected_one "${var}" "${rc}" || rc=1
+		check_expected_one "${var}" "${rc}" || rc="${?}"
+		if [ "${rc}" -eq 2 ]
+		then
+			break
+		fi
 	done
 
 	if [ ${rc} -eq 0 ]
 	then
 		test_pass
 		return 0
+	elif [ "${rc}" -eq 2 ]
+	then
+		test_fail
 	fi
 
 	return 1
-- 
2.40.1

