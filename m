Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E81DFE26
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731243; cv=none; b=Vevv6TpzSHbsPDutWDBlqJafAj+JghK5OQ+cDe00sSbgAF2apV6i3JbzYlC1OYOyzeyMb0zo+gS4wzEstwm8eNnolNAeUfPXWCPcZtfUO/O7AJwWW0TdDCTzgE6dXeIqib8YCFn5kX/94L7E3PEZ3oaPyeNIFCrRvDGCnhEStRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731243; c=relaxed/simple;
	bh=DMW34tbEoKsul9FuN+wymT8UDV5jEqmOjz8JHxNivqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g2zsBFODS5wsPPP9aD9uBmLEBvurPLcXM0wEZKW3ID41zAcwFahDe9Y4WG1Ggl4dKSJsekuTVBAXNdkbXyWvyhIa1F4/LXootLVu81wlKrJ4jTLYf3CFsoPw9YFsK9E3qKwbRFHcG5gIY8N8r4Yy/HX1loRqe2Ofpc3SLzxLwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNmofOzf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNmofOzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98D9C113D0;
	Fri, 26 Dec 2025 06:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731243;
	bh=DMW34tbEoKsul9FuN+wymT8UDV5jEqmOjz8JHxNivqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rNmofOzfmcXjyH2GMN0z69wdOBcqvvS591d41izYWCICSjPLMjfJT+V3PZ/0xiwT0
	 Ix26t87RUh1ouTjYFJLIN1+y4Scr1dTovoOihtoXrn2Uv6K64feSgVliqBS6h4g07H
	 KQ5fChenplEp/6mINdN5xHHelK7TSGaAqSdJ+fVM62ECivFcZjDHL/ze4kmqhnBYzf
	 P6PKgEN1CafPK1fhjeU+P/KRqFOZP9PtMf/l7/IxnPutimxqtvmMEkJAY7ZLHwCkMu
	 DpovlzxGgWIUHMkqg1b7PaGCgfuYhFOid8zxFcNRMH6k8MHl1megZh2ezH/1ZO2WgO
	 tFSUgoFFa1EGQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:21 +0100
Subject: [PATCH mptcp-next 07/11] selftests: mptcp: join: userspace: wait
 for new events
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-7-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3035; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DMW34tbEoKsul9FuN+wymT8UDV5jEqmOjz8JHxNivqU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dB8s+yt5yL0srTU4zivw0rc3Ua7Zs++2hdz6nLjJ5
 Q0rU19nRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETaPzAy7DRmkNn44pB+jry5
 +alj+09cu/fm0sMDbLeTz2w5n/Ao8jsjw82M21y+lsuuZD1+F2XJmxGpJldyN3RB+bRJehki58V
 b+AE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of waiting for a random amount of time (1 second), wait for an
event to be received on the other side.

To do that, when an address is announced (userspace_pm_add_addr), the
ANNOUNCED is expected. When a new subflow is created
(userspace_pm_add_sf), the SUB_ESTABLISHED event is expected.

With this, the tests can finish quicker.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index cf28537b71f7..63a84a4d43a6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3717,7 +3717,6 @@ userspace_pm_add_addr()
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
-	sleep 1
 }
 
 # $1: ns ; $2: id
@@ -3748,7 +3747,6 @@ userspace_pm_add_sf()
 
 	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
-	sleep 1
 }
 
 # $1: ns ; $2: addr $3: event type
@@ -4000,7 +3998,9 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
 		userspace_pm_add_addr $ns1 10.0.3.1 20
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 2
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 		chk_mptcp_info subflows 2 subflows 2
@@ -4033,6 +4033,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -4063,6 +4064,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
 		chk_join_nr 1 1 1
@@ -4082,6 +4084,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -4106,6 +4109,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4132,6 +4136,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 

-- 
2.51.0

