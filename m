Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF526168DE
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069368; cv=none; b=pcPlYcD+XKMNyzNBapLFRKji5dvUHgDS8QJMDnStbQiD29cKPEP9hOgGsL6LIUwysg+oYyUY7tXYTUQWtKbgXPmlYv+iKmshzyFThAwEKQBEXiiv7z+jI5kbHwId2o8rjjxmsOog38DKknZLu15V/+V39+aewEs9tO+pfRe4HMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069368; c=relaxed/simple;
	bh=/egh2wvSp17UgjqFFrBf9fkYhBW6q+UJccwU01vH3GY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hb++0KLIM5aUVIVxj9eaXKBKUQiBRUzcYKYMrv1lAJErlV9zTNAQDrBu7Rh5TYt59n6QIYaKI/oHt8yzPz/peo/9NXi4Q7Q7YwRTWKU/LFBXwvD539uNmCtCb/JzCnEAGxdy+EaddMyhRKaZ7qu6ksjZ7Sae22GcfXSXZQs/LLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfMKg6zb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfMKg6zb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93538C43390;
	Fri, 16 Feb 2024 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708069368;
	bh=/egh2wvSp17UgjqFFrBf9fkYhBW6q+UJccwU01vH3GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfMKg6zbvQknBKSGS4AW5HqBdLb/ZU/eN6SrWXwzC78VsjSBdhhHXnZN+WlKqiMv8
	 pKasqMhcIOqC6LI6bxTU2w7rTQ1OfyiRvj2+yxulnVLxWxtSzNULMj8zai0IOMz2d8
	 8ovJ+bCKNvAiG+wzKw15o6kWoUD+CS8i8ui1602yQWlqVBlaMuUhZ4t0b8Y+RMhXjg
	 Dgbi9rqt5TsdtaDKBUZQIcri/eYa5IcwOC6ApT09OquohF8MZhJaocz4PyzL1sQoIW
	 LB6S7FYEIrTNuBhlkkXSyj3HxjtFdCW3VbpJhWQDqy+W4/UEZEiBrdYfu2HE+IiB+m
	 +t24rHUBkxT6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v13 14/14] selftests: mptcp: userspace pm get addr tests
Date: Fri, 16 Feb 2024 15:42:16 +0800
Message-Id: <93caac2c12105bab2e5536906c1f65b42a29f14d.1708069036.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708069036.git.tanggeliang@kylinos.cn>
References: <cover.1708069036.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_get_addr() in mptcp_join.sh.
In it, parse the token value from the output of 'pm_nl_ctl events', then
pass it to pm_nl_ctl get_addr command. Use this helper in userspace pm
dump tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fb9b3ee9fee0..a4d121f9e467 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3362,6 +3362,18 @@ userspace_pm_dump()
 	ip netns exec $1 ./pm_nl_ctl dump token $tk
 }
 
+# $1: ns ; $2: id
+userspace_pm_get_addr()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3482,6 +3494,14 @@ userspace_tests()
 				     $'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' \
 				     "      dump addrs signal"
 		fi
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
+			check_output "userspace_pm_get_addr $ns1 10" \
+				     "id 10 flags signal 10.0.2.1" \
+				     "      get id 10 addr"
+			check_output "userspace_pm_get_addr $ns1 20" \
+				     "id 20 flags signal 10.0.3.1" \
+				     "      get id 20 addr"
+		fi
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
@@ -3520,6 +3540,11 @@ userspace_tests()
 				     "id 20 flags subflow 10.0.3.2" \
 				     "      dump addrs subflow"
 		fi
+		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_get_addr$"; then
+			check_output "userspace_pm_get_addr $ns2 20" \
+				     "id 20 flags subflow 10.0.3.2" \
+				     "      get id 20 addr"
+		fi
 		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
-- 
2.40.1

