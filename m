Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6D1C696
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935501; cv=none; b=rRBR0BZFDYHvxkT3ZzaLg2jsFXkfMHbsAsX8Hzycmw+fwwz4EsAjORA9dgjpq5oRlWHQD0yhk7oTu5E9aLxMrAEYDdpMLNfsExdmIsxlE/3dTes7lOJa/2vHdubRMg56yoIp2g1Gmbnt7rYkyN0bX1rNXZce/GGqjnGgs68gMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935501; c=relaxed/simple;
	bh=3mmsfu3iK1ss81OMx56mOa5UE9/YU3QMIacTB+kODfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MoirdIt7RzR7vgLwX4fbB7V3s543ODddwq7/Gi11wr0c9bFALgPMYPLRwcqKTngkfUUWBLYL9KibOHFGaUPawcZ41Pkg1D5THVjJG4WPtDFiOsBz29O/m0D/JytA2DbeiIciv0flsvGlDz9ueS/tvR2A5O9kV962zfdm8T8mvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzxQLX/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzxQLX/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DFCC43390;
	Mon, 26 Feb 2024 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708935500;
	bh=3mmsfu3iK1ss81OMx56mOa5UE9/YU3QMIacTB+kODfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EzxQLX/JEpkCm/ykC4mS3kyqk2pfTmSSwqPw6xbnV9wB9xsqTeryahJZtMoSz5hNw
	 NreLpAUEuJMWanAh+ElaXs/rfyh5tul5V/+10hHdXkYKHaLO0ANnaq3FgQG208MOjW
	 wngFf1EJczBMSuEQiBZPj5jq709KrUWKl+GcFEKmKh7n6KeQy2QhKjkMAaEs8wde73
	 oGeOfcaF9zrm2EpB03EfqHLv2QbOLQC6zd8dcCBgBtOyVKakqT9lAYpQyhNu08iYOV
	 HublMBcAy+0vz1KfGs+YpmU+cpziKtx293gN15V05fyBUZTTn/acJaVCAuD92cFzbC
	 9sq9/m7aBlrAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 09/13] selftests: mptcp: move test_fail out of check_expected_one
Date: Mon, 26 Feb 2024 16:17:54 +0800
Message-Id: <c87c03020da7553c2e79889a2bf4675b2a231de7.1708935196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708935196.git.tanggeliang@kylinos.cn>
References: <cover.1708935196.git.tanggeliang@kylinos.cn>
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
index 27f308601005..473639a8009f 100755
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

