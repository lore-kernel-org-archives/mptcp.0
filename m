Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE063BCD38
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458193; cv=none; b=PK2OZl1GrhyHEJROIG1TNsqp5lIh/f7M0WkL6yRo48ljStqj6QP6MBUVABOC49I2jULrnPIWX6dyW42Rt8AWhVmkpXq+KDSuzGxQ4rFh88cOelWDedW/Rjqf4kVMZPyL0nAurPrQI/cGMUWqYJ5M2/e+3HM6g65iOhn1tDwzSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458193; c=relaxed/simple;
	bh=A55sq2edNjZboEYvRjmz1w8Hi7awVEJszg3Hm3RWqN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEq9WMk0crM4rCUE4hwsiLaTDzY1nykHE9Ng68SZ2m5kATk8lX8+LuWFWJzIaPgJTjH7wcS5kfVKaEBVdw0yzefcwWAvMTGzixf6SVZ446s5ljw2CaArSOVhuuYBlXmC2gDbHE58mrjtZOAHzImGyVpFoIh38y37jdhQgt36XZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QogO61z7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QogO61z7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F88F1F000E9;
	Fri, 26 Jun 2026 07:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458191;
	bh=KowOka6LBWeuRshCNI0XQ7D8AwApQokRL2Xpia17PAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QogO61z7iOMD0KZsJWclcbT5+VKlIMDnjT+FFNM6ir4KeQCs0Zwoq9oZMkaRnfLHn
	 OuLwdVhhltvgCA9PGqpMEhVlZbFUQbyQsakOIYPQHOFWT+TJoSBuMR3jnSKaLbh5Hd
	 EFxqmzUU/QSbhH0fOYKHwH9N0kwuCodmmvnPKBM6lLS8K2hj4vyJYgmNk0Yv3n4mhW
	 2KERiX+P3u1Q34yT2/e2RtDxbO+9JCzwg81DRPTEL7OizDX05GdERpc7vZJaVcYW90
	 Q/BinjNCNVif+pmWixt/mUYsmGp5b4ojEkJIrb7mWPLmQHxnQ7RVh/IbZ7dufr3nHJ
	 PjdsR6xWoVZ1w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 2/3] selftests: mptcp: join: update userspace dump_addr outputs
Date: Fri, 26 Jun 2026 15:16:17 +0800
Message-ID: <00a48ea4c0e2ccb4254312e2cf01553e0e601b6f.1782457962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782457962.git.tanggeliang@kylinos.cn>
References: <cover.1782457962.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now address entries only be removed from local_addr_list when sending a
REMOVE_ADDR by the userspace PM, they're no longer removed when a subflow
is deleted.

To make userspace PM selftests in mptcp_join.sh pass, this patch updates
the outputs of dump_addr.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 550a6b6117a9..e1cdde5ba722 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4089,9 +4089,9 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
-			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
+			$'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' "after rm_sf 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
+		userspace_pm_chk_dump_addr "${ns1}" "id 10 flags signal 10.0.2.1" "after rm_addr 20"
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -4119,7 +4119,7 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
-			"" \
+			"id 20 flags subflow 10.0.3.2" \
 			"after rm_sf 20"
 		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
-- 
2.53.0

