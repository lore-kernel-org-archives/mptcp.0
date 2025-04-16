Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753C18D63E
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787992; cv=none; b=J1MFQvL4ocidB0R9z9uglFd/l8YH/4AdbzPSr8sLi2XT/oIBBf0UzQY76yiw9e40RAegZzWTLqE5pb4qQHh8QkVmWOKAAFce7ANa8bh3tYPPTYnXRu+Qc1E8y28nWZDXIGBMUZ5BBy6X3BiH3G4KSPokQfvNOAMrI9ctN5OvX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787992; c=relaxed/simple;
	bh=d/6wuDhHBSsnjHX9AsWufhTG76l2GNyGFlbNc5T2Rkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0iUIL9Tcd9/6ZVdztysFRsEN/GpkXItVtttQFDOBc3uyqjlGeSduIm9rGWeORTE/Wf6ICwOU46lxcYhnTq19ZDWWMVzY0fWy15IF3H1dhsd4HhO78CpIoQDjaRSSqUDbqJhyxZj3sei7JUo536XC1rUTjjWVmxsRPLEKk2HUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXaaFGoF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXaaFGoF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7CDC4CEE9;
	Wed, 16 Apr 2025 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744787992;
	bh=d/6wuDhHBSsnjHX9AsWufhTG76l2GNyGFlbNc5T2Rkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXaaFGoFSREBbTK54cS/yl+z9cOIh5nx/Gd/IZLH3Ygzs7DQ5rT9B5EOFbbrHfG/O
	 V+LEOAH+uFx5q7ahOYSrlPS8DhVRKF10qQqdjJfdZTaQ9nwZkIdKaDCwHg7mWknJlA
	 nUT5p9tMhrzaz+yNCHpFWjetcfcd605jh6m2kTwnFAeMRtINJK1yo7G7IOAyN+pzgJ
	 nG5+hEzo6ShsErzO9WTn51D228LZjj/+eZJVP0buMG4JATTa4ob7GLlmE3mkLYwBgh
	 aeJrFtfs2khnQbVx1bUZKCuYAdy8PdbfnfeQmye/Xm2xe6FJrZqgGeoXrs1xXF4MYl
	 r49heOC0uM9mA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/3] selftests: mptcp: join: update userspace dump_addr outputs
Date: Wed, 16 Apr 2025 15:17:08 +0800
Message-ID: <a2395f74ef8b411d92be6ee694e75a1d1c86800c.1744787273.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744787273.git.tanggeliang@kylinos.cn>
References: <cover.1744787273.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3a..eed9f68edb0b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3625,9 +3625,9 @@ userspace_tests()
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
@@ -3654,7 +3654,7 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
-			"" \
+			"id 20 flags subflow 10.0.3.2" \
 			"after rm_sf 20"
 		chk_rm_nr 0 1
 		chk_mptcp_info subflows 0 subflows 0
-- 
2.43.0

