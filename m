Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C921C163
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731244; cv=none; b=d/OkDXA7j4RjygHC2fwinEh9iLBuqf+pC1SG7/OPd4bj5XV0y2BexwIv7rL0Yu1z+JdeWBKOR6/8UvbVa4zgEGUI5TsJN6hmzOMDgDHmUDQeO8QIY03bwS3kfKsgCwyaCqlsJfy+Y3j8CjbRpToTAKOd7voFrU0cgM+CYkapqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731244; c=relaxed/simple;
	bh=GlDwT9qgtQH30wgJpwvOD9NItVpCeYGnuyWNngZIUZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENZqpl0D2sLus7Ug9Rj+/xClFomWIHfj397Xx/floNgjXfHf9uNiygtqaOIUVo6VfKoxn8ySPpNHlXF+DLD4z5F8e424rPpGGVrPB2Weh/ZeEtln1TyStOfMwtkrFl8ff/5qxKZ51Sgi9wptUcJXR5jTI3DRJ09IGvZm/swMhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDwAONtW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDwAONtW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902C0C16AAE;
	Fri, 26 Dec 2025 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731244;
	bh=GlDwT9qgtQH30wgJpwvOD9NItVpCeYGnuyWNngZIUZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IDwAONtW/QuMBKBGSyNlep08oSqDzvjIhyn31BRC1t8pgwjkcphS1cycWmFvj1Gis
	 cbNJw9OGwnkw6GMS2KZ4C2aKfjKtkCcUyz21u9o7gtEjZ2RgaQkCZOD5H0B46maUW2
	 2TzISanmgNfxeKoC0Qm8dTYsTJko/m1YPKPcRp57m2Zh7r9kyI9b9cG5Eb4ymRAZdu
	 rRjwDNAErV3pzuSeg4LgRQ5u9kiqXEk9wM+PBUZQ0EzYSvb4gNWS9wTNEZIXQTduCi
	 8E7GT0wqzq4i6HkRjt+WNG+zz9BMvp8G8ixlZL+yL6Hz8X7QhkezUEgNzGEi4Y3YeX
	 GF2ONEpb7ueSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:22 +0100
Subject: [PATCH mptcp-next 08/11] selftests: mptcp: join chk_stale_nr:
 avoid dup stats
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-8-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GlDwT9qgtQH30wgJpwvOD9NItVpCeYGnuyWNngZIUZU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dB/e4Xa7w6ba02olOt3D8RjX92dfXm67v6HgQlj6/
 +NWlb03O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaid5Dhf9r+gDKp089y/t89
 mN1Ws9l+7bxmcdWs5778t50mCcSF/WBk6Pu5uJ9z1g+F5AOV1i+0tiX/em7A+lpvl9AjL5vqyO/
 72QA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

nstat outputs are already printed when calling 'fail_test', no need to
do it again.

While at it, no need to use the dump_stats variable, print the extra
stats directly. And use 'ip -n $ns' instead of 'ip netns exec $ns',
shorter and clearer.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 63a84a4d43a6..80e03168b419 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1648,7 +1648,6 @@ chk_stale_nr()
 	local stale_min=$2
 	local stale_max=$3
 	local stale_delta=$4
-	local dump_stats
 	local stale_nr
 	local recover_nr
 
@@ -1664,16 +1663,11 @@ chk_stale_nr()
 		fail_test "got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta"
-		dump_stats=1
+		echo $ns stats
+		ip -n $ns -s link show
 	else
 		print_ok
 	fi
-
-	if [ "${dump_stats}" = 1 ]; then
-		echo $ns stats
-		ip netns exec $ns ip -s link show
-		ip netns exec $ns nstat -as | grep MPTcp
-	fi
 }
 
 chk_add_nr()

-- 
2.51.0

