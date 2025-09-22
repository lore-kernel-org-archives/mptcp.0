Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579427A906
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579852; cv=none; b=REnajE086f8iToMPP/fGfVu2SBHpOuvI4PsBhUNJg27LgFFSK3s6Y3KuBRS+T1dRxgJgV4Lhe9Hz2lFyvlT16L6mt7Mj98ZvJnGOL38MJyL92b3jeVc15eLhD7LhwK37ZgwGCjZ+uToLm73jZewODhmkmTmubig5e4580/PMiDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579852; c=relaxed/simple;
	bh=BZGVScledBPyxgT9ajdqZAv+wSsrJH7qGc+H2E0ax8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPXbt4uKd1HQ983kS6l/BtG4WfTNaa2PgRNNHErFZWnpLLG6C8PORtw+xt6uULmx5EItR6IwNciHFYRvFWll+3i8Quq5QhjUtJURvUdtXTcvFYPW1FQcrYByXRkOrS20f37BsdJL+c4h5UHWvwDtReTHWvV14vOivSEomHUwwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOCUiJaN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOCUiJaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3978C113D0;
	Mon, 22 Sep 2025 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758579852;
	bh=BZGVScledBPyxgT9ajdqZAv+wSsrJH7qGc+H2E0ax8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vOCUiJaNLYN3vBJVnCgfz7JfdkK+dEYaP/w6NmIdeeYn4lrQjncQEVLFvwcC3dfl/
	 Ic/ai3XIaNjxrKISBdPkf5mJBtlNogYZC+M0GqdTtadLhc9212s8/Zw0x9vyuC2DfD
	 NWMJ1wxrxyUK2oYYPBSWk8i4uSVQk/4PlwvC9wLGU0uZjTwD5z0ytfAjt+rVRUlsC4
	 GXBaL9l6+a/JPW56EnnDhk5FA6uyUUD4FEBkIUjp/VdAwpsYxJQXr2R1I4jO90EvJn
	 D54BEnat4vx4fvx5dXJzVArAWFCPWBuJ+SSYbrozMJ7ttf6ycXqmdNUSwFEzLhIfIe
	 h1UGCwE5RShXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Sep 2025 00:23:57 +0200
Subject: [PATCH mptcp-next 6/6] selftests: mptcp: join: validate new
 'address' endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-pm-kern-endp-add_addr-new-v1-6-60e3a8968f45@kernel.org>
References: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
In-Reply-To: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4594; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BZGVScledBPyxgT9ajdqZAv+wSsrJH7qGc+H2E0ax8A=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIunmkV1roiMWmxuLnYza97T0vPfyujfE3t+2GNaUuYo
 qaXeSW5dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkgY3hv5cQ476P9z/aFWa4
 R+1b0tMtOaf/6mUh6cNTXPevW1Y3dRYjw/Kaif9LfVi/spvf/muWKNXbbPUtW+zjYgHreV25dzm
 O8AIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are a few sub-tests for mptcp_join.sh, validating the new 'address'
endpoint type.

In a setup where subflows created using the routing rules would be
rejected by the listener, and where the latter announces one IP address,
some cases are verified:

- Without any 'address' endpoints: no new subflows are created.

- With one 'address' endpoints: a second subflow is created.

- With multiple 'address' endpoints: 2 IPv4 subflows are created.

- With one 'address' endpoints, but the server announcing a second IP
  address, only one subflow is created.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 56 +++++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |  9 ++++
 2 files changed, 65 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a94b3960ad5e009dbead66b6ff2aa01f70aa3e1f..b0d935e3c8381ea34e74c3878e869610b1a6fa41 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2320,6 +2320,61 @@ signal_address_tests()
 	fi
 }
 
+address_endp_tests()
+{
+	# no address endpoints: routing rules are used
+	if reset_with_tcp_filter "without address endpoint" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_address_max$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		run_tests $ns1 $ns2 10.0.1.1
+		join_syn_tx=1 \
+			chk_join_nr 0 0 0
+		chk_add_nr 1 1
+	fi
+
+	# address endpoints: this endpoint is used
+	if reset_with_tcp_filter "with address endpoint" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_address_max$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags address
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+	fi
+
+	# address endpoints: these endpoints are used
+	if reset_with_tcp_filter "with multiple address endpoints" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_address_max$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $ns2 dead:beef:3::2 flags address
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags address
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags address
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+	fi
+
+	# address endpoints: only one endpoint is used
+	if reset_with_tcp_filter "single address endpoints" ns1 10.0.2.2 REJECT &&
+	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_address_max$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags address
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 2 2
+	fi
+}
+
 link_failure_tests()
 {
 	# accept and use add_addr with additional subflows and link loss
@@ -4109,6 +4164,7 @@ all_tests_sorted=(
 	f@subflows_tests
 	e@subflows_error_tests
 	s@signal_address_tests
+	A@address_endp_tests
 	l@link_failure_tests
 	t@add_addr_timeout_tests
 	r@remove_tests
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index d4981b76693bbddca74169437a540ad6294cf1d5..9164c2e797bd003d933d274a54791b23928748f6 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -830,6 +830,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 				else if (!strcmp(tok, "signal"))
 					flags |= MPTCP_PM_ADDR_FLAG_SIGNAL;
+				else if (!strcmp(tok, "address"))
+					flags |= MPTCP_PM_ADDR_FLAG_ADDRESS;
 				else if (!strcmp(tok, "backup"))
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 				else if (!strcmp(tok, "fullmesh"))
@@ -1018,6 +1020,13 @@ static void print_addr(struct rtattr *attrs, int len)
 					printf(",");
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_ADDRESS) {
+				printf("address");
+				flags &= ~MPTCP_PM_ADDR_FLAG_ADDRESS;
+				if (flags)
+					printf(",");
+			}
+
 			if (flags & MPTCP_PM_ADDR_FLAG_BACKUP) {
 				printf("backup");
 				flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;

-- 
2.51.0

