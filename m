Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88372DDC4
	for <mptcp@lists.linux.dev>; Sun, 25 Feb 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708852413; cv=none; b=YBraLBOoe8E1yyoElic3DKgV1Rg8qCGEGZkLP/wto0k3G7VJ6Y/Llz/OZh5Gr0viKpdt6Nl+MdvNScxNhjwqjiZuAIttdhBk/S54WbkqdeIvn5C57f+vDhcA6gWj8b+3Hp9VmK4jl+r+Tr/XPk4Ud8XR2xZmyznO+lDF60Q3QBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708852413; c=relaxed/simple;
	bh=tF0QObIedMoOr1NWG6q3pFb8Y4fOSGuD94Idpxh1gxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=th67XLKpTtSC9dl5gm92p6zpFj0XjnBOUzAlB0hP61WExT5PO8szIW7IJfVOLLzBFVYNMw9LdTdYUBpmjLm7kA7rYDrbgFNAR/vFi73NQKLvC1cyKXuZ7zn8jkyoyfoXjmPydkG++30iWTbCSpJlPH8d81vA8ajiYws1BpLGlYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VztZq3WX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VztZq3WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867EDC433C7;
	Sun, 25 Feb 2024 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708852413;
	bh=tF0QObIedMoOr1NWG6q3pFb8Y4fOSGuD94Idpxh1gxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VztZq3WXZfnbNwdk4bXhk2djMIspboz7TZWAvXGXnngAalSTSupOz33iVOQdl7lAT
	 s9KUPOU3wW5fvoxwMWKH8GvBBLU79kFDKVnGlXubTnsjmyvu08cs91ZcDff/7fCZsR
	 dsouSu2n4+D7liaZqTedfIutL0P4Coy3OdoS1Vqke55bLqamTySIAUYY9HbnOAoysF
	 ZwqdG6i7OiJfqCP+pgQ9HI3qAmlNgBtql2m4fU8PV5EeBL3G+2SISACkp84pXBefeb
	 ENQj2qw0WAuEi/ukLntSfBPoFXAFunJDh3w0u+QS7KH8AwkRQSB4rbEQmUPiKTBIb9
	 xhyM+q3uHOHWQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 09/13] selftests: mptcp: move test_fail out of check_expected_one
Date: Sun, 25 Feb 2024 17:12:30 +0800
Message-Id: <742a1d817d5e4a8f82d61722bd936ef4b5e54d61.1708852208.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708852208.git.tanggeliang@kylinos.cn>
References: <cover.1708852208.git.tanggeliang@kylinos.cn>
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

