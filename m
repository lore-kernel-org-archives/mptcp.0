Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B191A9FB0
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020511; cv=none; b=jhIryLl6HDEz3OPUDH/LubgFviDqXpdXk9R8R0q0/39reN7kA/IomfjLdGMwGISsKtQBorRi2QBgtQ3MA//+AhI9ISDb1XyvlU0HDVUmGwghlkHrueghwaQYZaZfXTIb6L5w7MD+kBBiMuKbqxRd77G+UqWRo2mSLT+pwI5kth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020511; c=relaxed/simple;
	bh=8odgN9Xy6DCiBeeIdbfBEWfhPcueV9/CekUHNa6oYek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihITZISzss2MzA1IZ4hZZyqVdjkrF1tQPIsul2kEH38FzPjKxvL+JmWUc+9r9KP0W++rbStVpEKU9Zfm7n6m2qzPqNvLToag6gY5rZFrpkU0dQlBiHHj6C2f7Eqoz6b7PDuo1FyVKFY9rGNwqJbx2bJ+98vgzxdxCxCtwyCz/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzOSjctq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzOSjctq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D3CC4CEFA;
	Tue, 16 Sep 2025 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758020510;
	bh=8odgN9Xy6DCiBeeIdbfBEWfhPcueV9/CekUHNa6oYek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZzOSjctqa7mbL4qs7lVV1D1PD8RRNZLR63BRt3JZpgwtBKv8lQzAMrpq6BR1EUYIZ
	 tMi1iHQFiPPxR6zLT5+35myQjZhPmvDwe0QWsoLy6MHzw3chbFP4jlsW7nmop7btYg
	 VLXMiSSdtgrNRgvoHaGCk86UGP3MHmNbvGcFkYXpKIul4XgyY+xd38Pjyoe9Hayvh1
	 rht4qB/k5k0GwBWf28x03insdURrf655otFuQk7sgHSbRBz+lCeE/+VD0USTUBj8iD
	 NMq3VAojc4i6nYjjx5PW7sgbeOl0Y8KVoLgRog53hJ34ZKx2NvzF02Bou3AL66sbwW
	 9//Rk590r7QTg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Sep 2025 13:01:40 +0200
Subject: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: validate C-flag +
 def limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-pm-c-flag-client-default-v2-2-3be2c5bc4d6a@kernel.org>
References: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
In-Reply-To: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8odgN9Xy6DCiBeeIdbfBEWfhPcueV9/CekUHNa6oYek=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJOOs/+M/8W/+GnMtk7nuclPbea6SN+LDnhwq1d+o/lr
 vbfnOht1lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCR5F+MDFuK/t19+2JnxpbS
 JPt72nV/ir+X626K9+jh22/zYHLmdTGG/5lfBKw7RXRF7s2evLE0zDB07iqJJiGtS7u395wp4Pv
 swQsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The previous commit adds an exception for the C-flag case. The
'mptcp_join.sh' selftest is extended to validate this case.

In this subtest, there is a typical CDN deployment with a client where
MPTCP endpoints have been 'automatically' configured:

- the server set net.mptcp.allow_join_initial_addr_port=0

- the client has multiple 'subflow' endpoints, and the default limits:
  not accepting ADD_ADDRs.

Without the parent patch, the client is not able to establish new
subflows using its 'subflow' endpoints. The parent commit fixes that.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- v2: move accidental .c modif to the parent commit (Geliang) + limit+s
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6055ee5762e13108e5e2924a0e77d58da584d008..a94b3960ad5e009dbead66b6ff2aa01f70aa3e1f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3306,6 +3306,17 @@ deny_join_id0_tests()
 		run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
+
+	# default limits, server deny join id 0 + signal
+	if reset_with_allow_join_id0 "default limits, server deny join id 0" 0 1; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 2 2 2
+	fi
 }
 
 fullmesh_tests()

-- 
2.51.0

