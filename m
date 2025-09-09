Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78834AAE6
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428434; cv=none; b=jGEwdon7PHouZc4pZ38Ydw5/Yq4iD8AdwYUWB8BT//i5oGKMU9hYaNU8EoPBFq/jLkp0XaunByCUph/10mqCXeOd+r/SeBVUlrpUraLQxHeI6ynuvJhIUac2+n0P+uAyM9wmNiQTPHjqtZIoDQGIjQ6wHa9xwlKMyhjvpqRhogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428434; c=relaxed/simple;
	bh=WT4n6Liho45omjO3GNmG9PPgJc/I24mqljKnIRJ2Buo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twe1mfuAQZQYXUN1K00JX9vf10825fULnChP2j1/G+R40D2EB/lH6QYdaAFDQLRMJbLH2OXxorEKPQ0r9t3ksvaB78UoekvQCNjuX0w1CIvKlZpYvcEdzLzO6ldxii43J5RVwhUgqrLqFhYWTeLGYYe4nD33Trt19P3rfLvscvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCZOY6/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCZOY6/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE613C4CEF4;
	Tue,  9 Sep 2025 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428434;
	bh=WT4n6Liho45omjO3GNmG9PPgJc/I24mqljKnIRJ2Buo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cCZOY6/ysxfrUGLOcZ/YLOkZW3eGXpMQCiR7V3/GTWHcWOB5qRzWJVo2hcxbjMshL
	 +DLWxQt0kiluZATsNCYS15OmL6jNOGowxVW1XG+c90SDxYaB7W4/n3X9bqFm2wcla0
	 DN7ZWjI4OlmBwC7PP6kyjCM1Zk6KBxERV+Fw4R1ncebKL+JeVifhRnMNfNZMaO2ULV
	 ckC4B7+MW22dpXzk533XP+XzbWYSn1rQLC95n8eFL/OoD3rP37VDPVP5ZkXwZlhb67
	 tQKXTp0vxDAL7U8hfBNyq1Nx/gZsaDKlFzHA6KqZVPNBx9UO5fzD2Ucu/oKtfDMKpC
	 LIMG2VsJi5Pbw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 16:33:33 +0200
Subject: [PATCH mptcp-net v2 4/5] selftests: mptcp: userspace pm: validate
 deny-join-id0 flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-c-flag-v2-4-a6f9542481c5@kernel.org>
References: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3765; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WT4n6Liho45omjO3GNmG9PPgJc/I24mqljKnIRJ2Buo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOWJ2+ISDsWXnv0SXHS8Esp+O+HgsKP2afJeY5l/07j
 1bH7TtaHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZvJOR4Thfk/fBB/u/6/Ie
 CPPd+yPy2enQ0N2LhYsPpUQf1RLa+ICRYfVNVqX0CqMn6lXTNOWiTvMGVO46o3Pg5VGH7b+vhRV
 c5QUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The previous commit adds the MPTCP_PM_EV_FLAG_DENY_JOIN_ID0 flag. Make
sure it is correctly announced when it should.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  7 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 +++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 994a556f46c15163bae6cb517c371801f0cd6e3b..93fea3442216c8fef43731a99c1d5710f234b150 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -188,6 +188,13 @@ static int capture_events(int fd, int event_group)
 					fprintf(stderr, ",error:%u", *(__u8 *)RTA_DATA(attrs));
 				else if (attrs->rta_type == MPTCP_ATTR_SERVER_SIDE)
 					fprintf(stderr, ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
+				else if (attrs->rta_type == MPTCP_ATTR_FLAGS) {
+					__u16 flags = *(__u16 *)RTA_DATA(attrs);
+
+					/* only print when present, easier */
+					if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0)
+						fprintf(stderr, ",deny_join_id0:1");
+				}
 
 				attrs = RTA_NEXT(attrs, msg_len);
 			}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 970c329735ff14f87f0048ba0030dc7edaaa86bc..0801d57a9710406a5942af742719f694e3907558 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -201,6 +201,9 @@ make_connection()
 		is_v6="v4"
 	fi
 
+	# set this on the server side only: will not affect the rest
+	ip netns exec "$ns1" sysctl -q net.mptcp.allow_join_initial_addr_port=0
+
 	:>"$client_evts"
 	:>"$server_evts"
 
@@ -223,23 +226,28 @@ make_connection()
 	local client_token
 	local client_port
 	local client_serverside
+	local client_nojoin
 	local server_token
 	local server_serverside
+	local server_nojoin
 
 	client_token=$(mptcp_lib_evts_get_info token "$client_evts")
 	client_port=$(mptcp_lib_evts_get_info sport "$client_evts")
 	client_serverside=$(mptcp_lib_evts_get_info server_side "$client_evts")
+	client_nojoin=$(mptcp_lib_evts_get_info deny_join_id0 "$client_evts")
 	server_token=$(mptcp_lib_evts_get_info token "$server_evts")
 	server_serverside=$(mptcp_lib_evts_get_info server_side "$server_evts")
+	server_nojoin=$(mptcp_lib_evts_get_info deny_join_id0 "$server_evts")
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
-	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-		   [ "$server_serverside" = 1 ]
+	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
+	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
+	   [ "${client_nojoin:-0}" = 1 ] && [ "${server_nojoin:-0}" = 0 ]
 	then
 		test_pass
 		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
 	else
-		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
+		test_fail "Expected tokens (c:${client_token} - s:${server_token}), server (c:${client_serverside} - s:${server_serverside}), nojoin (c:${client_nojoin} - s:${server_nojoin})"
 		mptcp_lib_result_print_all_tap
 		exit ${KSFT_FAIL}
 	fi

-- 
2.51.0

