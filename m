Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D758F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558356; cv=none; b=CeldbeXeuwveVhpy0UUGD8XlrypI/Onitd8ovpRmRtNsO2edWvDqNFbvN8wHLytD+6wsk34PsJvp662BEcsza45qZBAUCD1oi+MsQaqTWRuaGqpWpP2PaO8TVaYB2qyXMiaE9ujjms2xP3EO41v1jbxn7+j1lO4UI+7LIPQBJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558356; c=relaxed/simple;
	bh=WmmoC/rULymSuVHmwj+6Hw2xz4nU1M4q6L3S5+Oc4ko=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=nib06IO6rOjyV6j96GEjg8u/p0Gcia6omFclalkynEkvrUEJVGIQwEjCxSz9iEj4OB53gxGUZCMN4X17FqjuPY0s13QhPysznnOkesywOgfu3XLqNusouyeLe9n6B4+Vg1BuwETi8gl6tEkK2Qb9VmU2vv+hg01hfYss/1IgoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRJy2F2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRJy2F2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D00C433F1;
	Thu, 18 Jan 2024 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558356;
	bh=WmmoC/rULymSuVHmwj+6Hw2xz4nU1M4q6L3S5+Oc4ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRJy2F2XTYSu1crSc6kcAGPOv2AmEXgfDN//nQUyFvGsqLYsSSJRVGfws7hXhXlHE
	 1Gj6voNxZ8l8/EUQdO4yj8qhv33HzX7betoOxSkh6fYxoL3d2IKUZkEl+1WGvpvrFO
	 TE/UH8sBZl0YFP201cI3wA8gcZkZH7TVZXMKpooczX7nsTL+3NBgCIF6rGQt89fDf1
	 +ZwQTVP5jw3uWRXN4hKFGqp1yewbTnqxjrrw97XgOQSdXNd0Wo2qj4UuJRAnM8UJKD
	 9jz3vdlIBpe3K9T9DaSxlHm9v8caN0wAChu2dXYKUTpSCG29b4R6nm+Hom1rAi3S1D
	 uz1EjuZDsTzlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 20/23] selftests: mptcp: userspace pm get addr tests
Date: Thu, 18 Jan 2024 14:12:00 +0800
Message-Id: <8168bdbf409719f5e5f6dfe86809b17d22db7e71.1705558030.git.tanggeliang@kylinos.cn>
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

This patch adds a new helper userspace_pm_get_addr() in mptcp_join.sh.
In it, parse the token value from the output of 'pm_nl_ctl events', then
pass it to pm_nl_ctl get_addr command. Use this helper in userspace pm
dump tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cec4bfc5193b..0b325b5efccf 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3373,6 +3373,18 @@ userspace_pm_dump()
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
@@ -3610,6 +3622,8 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		local dump="id 10 flags signal 10.0.2.1"
+		check_output "userspace_pm_get_addr $ns1 10" \
+			     "$dump" "      get id 10 addr"
 		check_output "userspace_pm_dump $ns1" \
 			     "$dump" "      dump addrs signal"
 		kill_events_pids
@@ -3632,6 +3646,8 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		local dump="id 20 flags subflow 10.0.3.2"
+		check_output "userspace_pm_get_addr $ns2 20" \
+			     "$dump" "      get id 20 addr"
 		check_output "userspace_pm_dump $ns2" \
 			     "$dump" "      dump addrs subflow"
 		kill_events_pids
-- 
2.40.1

