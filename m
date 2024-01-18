Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9288F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558360; cv=none; b=UExk38UhGDC0y3BioC2P6EXJq9XGiIpR9Ga9Hc2FxGwtWYR/Sl56ujsd8xJYvHp52ulwrtDeIfYVmwP8tmSPcqtjwe3oCoepOgFo2TYz4Gx40KZzQ4P0wrq+rXqFbyOMZ3faYwZucpOWGfgtXMN2/yEw7RdI7IJZGdh1C5bdQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558360; c=relaxed/simple;
	bh=Y1KCkJpxwWzlU5JBiGBOAc9ZAIbuZZxPpvoYmSCi8mM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=maJxu5OsF10JFjIMUAtRxZ6J9T0+b5OjxwzngYYZLNeuuhyv6JwHD5slLRpHGG4nnYbSUYyS68pZfTtXchK3xIFk633jaBWZsx16hP0Jo8tOr3CYveLQUiaTz4zfvm5kECzGW789/eH4h3owtglMGgQg/+X9Phr+ma0GPCC6wgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9vx1wTk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9vx1wTk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D134C433F1;
	Thu, 18 Jan 2024 06:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558360;
	bh=Y1KCkJpxwWzlU5JBiGBOAc9ZAIbuZZxPpvoYmSCi8mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9vx1wTk46a8LsXwy+vx4iH0t9Uf2jgpHw9nHD7/VRq3o+ksz/+raaqe3dALUsLuN
	 oKse17OsWz2uuUv9uyve6xBDatd3warEqDfdriuNtKdV9YgM3MCwRSGg7Myu9SLWY5
	 9hFqGYeVM+fDkwsukzfjvtS/vTVTpzpkOqbJU64dOCBRF4ExnGrHKQ9qSnQPYfDMWP
	 y5AKb1eaZgwhT69qjT7bm9sBj7sP1hZTLxxsBdqMTqCnuilYqTT1DmRWlMhWYSKDdn
	 KNczaKuSf17yZFUrrFnsfF7ta9UON21NxrtAMecADYh9XeGmkA6A6cMWQeRGz8Icq4
	 2rZEVVRuRQ9yg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 23/23] selftests: mptcp: flush userspace addrs list
Date: Thu, 18 Jan 2024 14:12:03 +0800
Message-Id: <9281e7e64896c26a3d33ea78be3abe3041fe37d8.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_flush() to flush all addresses
for the userspace PM. Invoke it in userspace pm dump address and subflow
tests. And use dump commands to check if the userspace pm local address
list is empty after addresses flushing.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0b325b5efccf..65e8d9d61ac9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3385,6 +3385,31 @@ userspace_pm_get_addr()
 	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
 }
 
+# $1: ns ; $2: addr
+userspace_pm_flush()
+{
+	local ns=$1
+	local line
+
+	userspace_pm_dump $ns | while read -r line; do
+		local arr=($line)
+		local nr=0
+		local id
+		local addr
+		local i
+		for i in "${arr[@]}"; do
+			if [ $i = "id" ]; then
+				id=${arr[$nr+1]}
+			fi
+			nr=$((nr + 1))
+		done
+		addr=${arr[$nr-1]}
+		[ $ip_mptcp -eq 1 ] && addr=${arr[0]}
+		userspace_pm_rm_addr $ns $id
+		userspace_pm_rm_sf $ns "$addr" $MPTCP_LIB_SUB_ESTABLISHED
+	done
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3606,8 +3631,8 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
-	# userspace pm dump address
-	if reset_with_events "userspace pm dump address" &&
+	# userspace pm dump & flush address
+	if reset_with_events "userspace pm dump & flush address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
@@ -3626,12 +3651,18 @@ userspace_tests()
 			     "$dump" "      get id 10 addr"
 		check_output "userspace_pm_dump $ns1" \
 			     "$dump" "      dump addrs signal"
+		userspace_pm_flush $ns1
+		check_output "userspace_pm_dump $ns1" \
+			     "" "      dump addrs after flush"
+		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
 
-	# userspace pm dump subflow
-	if reset_with_events "userspace pm dump subflow" &&
+	# userspace pm dump & flush subflow
+	if reset_with_events "userspace pm dump & flush subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3650,6 +3681,12 @@ userspace_tests()
 			     "$dump" "      get id 20 addr"
 		check_output "userspace_pm_dump $ns2" \
 			     "$dump" "      dump addrs subflow"
+		userspace_pm_flush $ns2
+		check_output "userspace_pm_dump $ns2" \
+			     "" "      dump addrs after flush"
+		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.40.1

