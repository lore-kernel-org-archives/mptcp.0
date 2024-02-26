Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378060877
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940623; cv=none; b=rj5G40u66Gy7zZU+6nQhgns/YrOe7/ZA+BwdV5ruj69z7ws7VhTZdCCM/Y2ejz/S0mrpLGigpOFYXzimpBEpYwwWn/11+/EEla2undjTKywJL2MZhyNh5Br7p4cOLw0CMso6v4AI6ndM2qYbNsOueM4ZW+dUaJWSHsosAQOLumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940623; c=relaxed/simple;
	bh=3mmsfu3iK1ss81OMx56mOa5UE9/YU3QMIacTB+kODfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aov4iON6JkrYY6X+DuQ2X7mt5Tbn18S33m9v6IQGq4yygEXFPtjnb3GoUR/lQw981vrDD+Jks357Vne7BYDLlF+EiyJF8CR3MMhrilN2pUBNix9pTPIB1sphCXH70DMDg1HnXle+acUOJxGL365241uURQ/GxeOADPuRLPk78io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njYRLnkF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njYRLnkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3D6C433C7;
	Mon, 26 Feb 2024 09:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940623;
	bh=3mmsfu3iK1ss81OMx56mOa5UE9/YU3QMIacTB+kODfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njYRLnkFAJ4Rhm+CvLQi01yzLlCgS1cRqiyaboxbNCm8x1PLOIJ6ljIU5t0Qv+lJA
	 zHEQucLUBlXMXr/1LLLtjm1NlSuhhhLDA6yN0nWBwzDToyDeDXSkETOOFj8+hu0Ejn
	 gZGmyHgG3kwUM11mseV7zN16rPgx5wu9i1UlKSmb6Sc05naHshou0e0eC4EdWlcuL3
	 p9oEO8/fB4SWdq9gvaRCm83g0YFi7Z9zbrIQzUBZShVcUvMaSLz1/scIq3lYIDZUDv
	 uXTk1WwS9NbbMNNh/W6DmrJMf6B6mgounxskIh1KUt/GAeU6SVqXboRfcBbQoz3ot4
	 q7tN1ApSb5Eow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 08/12] selftests: mptcp: move test_fail out of check_expected_one
Date: Mon, 26 Feb 2024 17:43:19 +0800
Message-Id: <906425f25bc2951a4c18187befb60443e9d777d4.1708939962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708939962.git.tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
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

