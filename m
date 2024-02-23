Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2EBA5F
	for <mptcp@lists.linux.dev>; Fri, 23 Feb 2024 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657703; cv=none; b=TLYBpe5NPwyrgj+N0ets0SPJuwewOsxD9w2yVhLSiYyHe5RBfSgwpcY4MFp5WmauMjxPMoDq5lh9zGFCR0J+dqpN16PHHCbaSpuwPNq6oq68KDDyAIrr8dstuE9BE5tAhaa2P0s6IzS2VrGsEG1/P0EoLOhwgUQWWooFkMAisOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657703; c=relaxed/simple;
	bh=qtE743CBwUfe7L8SHyjVOA2vgXRFI74deuIR7fgDU1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYWPt6NzpZz+alCAfqOPzb9ftX1n+/h0JueWPjWgg/EdyHo34t+9rd9qRPS4WzHkjxVa75uysH58RRYIYG4uQyh047poq2FJQFC/TDGeyV8fMz1NiO7dPt08hd/b67EOvIbgr1JlYdXLxu4FX50chhOw5b8VOZgDC+h+OhmxiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuZsp8tC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuZsp8tC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62459C433C7;
	Fri, 23 Feb 2024 03:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657703;
	bh=qtE743CBwUfe7L8SHyjVOA2vgXRFI74deuIR7fgDU1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuZsp8tCwABFlpgoFJJajUD79eWT590FfOl+kkuzvJ/zMkhwnsayDsii4qMUyrq+V
	 sgev6QrZKzaCVsnmBWG4lsUGsgKyk0RO+GO0YC4loZjLJnUVKaRV47lDeFdDsX9upQ
	 1Q37HI403xHGvPdZcaPkkcQXmuHQoA8SI3ttDQ5sM7nf6xKFo4a8v0ap0f9EnAyZs4
	 CeU0gmPtdvUVl8AWgq+peoZn5chQcJ4LepHoKCg3hjTuCtTBglgfmifJNO9hzTQ+Q3
	 NO5i/UqdegpOZJsdtF3fJYHLNyc6PyqLvN2pK4Zb0LO+hDSieBrNrJpwsDhIldu9Jy
	 kh6YW2JHRFSbw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/8] selftests: mptcp: move test_fail out of check_expected_one
Date: Fri, 23 Feb 2024 11:08:08 +0800
Message-Id: <f7ae01b44e1d559e27f9873431e37d663b3b17fc.1708657487.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708657486.git.tanggeliang@kylinos.cn>
References: <cover.1708657486.git.tanggeliang@kylinos.cn>
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
index 1bcde235e363..5ffa1157467c 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -246,7 +246,7 @@ check_expected_one()
 
 	if [ "${prev_ret}" = "0" ]
 	then
-		test_fail
+		return 2
 	fi
 
 	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
@@ -262,13 +262,20 @@ check_expected()
 
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

