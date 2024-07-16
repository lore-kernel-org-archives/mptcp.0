Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CD55887
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163212; cv=none; b=WzGhW86XwqA8Cf2C90Gry4V0WKLFZQehYLBjHu8mPLc/xUItGHvxe7SCpcUqc3dG0zmD+S4zJWRe3aaUDfla6WlUOSArRmztYz57IPV0eoYrEqRztfKO/KSFXxJghnLBFrNtxgGgDvkkGgDZGgX4QAdYubpZ7siNkS2NlXigvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163212; c=relaxed/simple;
	bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spbveAfWDRo/0ZT+wDKqShYG4btoizky3QKCgZE1opFSp7oQVEImzpxTSeJDI0L23vPP9PmoTY8iL8olAaRTalbga2PQo9PMHYVXuZexPfS/U/NGAt98N5wjobWt7G75zAaMuw3WWST0t5Tyl1ilpTmHT3RdTWqOTnWXVhLGyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgPaqhUI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgPaqhUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0110C4AF0C;
	Tue, 16 Jul 2024 20:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163212;
	bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OgPaqhUIUsNtWQ8M8WPKdZVO6bDPdTEojQmRGWhFAT+JjCNPW5Bj4jJIzukisiR5+
	 CqTcG6yBHfllLCzb796+UdJ0jolzl9FzKPZbnN/FBPzL9wRGx2f3pzOG57PuJqO6ut
	 qo3X8bFn+tN05oetf3Zz2OD206BreWlSdYCkvroGJGaOT0c9c5NYdWAOc0HyK3qHb/
	 fi2IaoUupmK2loo3/gx2Q5d6wRpzJ7Qt1ZFN55/vdrnIpbqBRV+fQO3DfsSYsrVG9Y
	 fW3GtJvaj3iVBaZRJU2/mKYteLSkL+bQknPnS9X7qItJSk1eqW4oHgJ4JfcC/EgVVa
	 HSHTGja7tTzeA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:53:21 +0200
Subject: [PATCH mptcp-net v2 9/9] Squash to "selftests/bpf: Add bpf_burst
 scheduler & test"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mptcp-backup-mpj-v2-9-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlt3BRdur2vtp1mX/FWaTFkgBWjM2VgG9FwEs3
 C70vS2eCPmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpbdwQAKCRD2t4JPQmmg
 c7GQD/0UYS2Ksx4y7nIISAffKAo0L9VtfmgbNToU+aItzpxpetIpFK2Ao/yykqHuC8VqGuve4hB
 LKUoHklhGWtR38NW8Ktp5QYLRcryBLaBEzRBUwCGvnnC0Ezb2AlPNOJ8B0IdJhrJMeCPSgHBR46
 dDKUQqHDGr4MLx4hJ9LaBrIXwmcvRlFtlhiRpSaoWJ4Kp0gyYxQoIAuuC9oy10aFs6VKbOKJeFc
 jocmR68Dz7SmEMR6cnleSN0Eqpz+z8b58svMa9y/BiaVkRfiJHUXx4eIT2e2HscQHzOjnwKU62/
 tjMklovgvV3OYfr/gn5Sb5EuLQTIyhth7w5JTzElSVlmgO2SfKG8Au0U8wWdegWwRALlQkw51HO
 yAij5QhaFgkJ2hH55QPKgzYLMzOnxqkGPz/lJqI0axSPXN/AaLRatQPNeeGeZDyAjHv1AOFxzRI
 Bmx5hkqHBu4PACo0NYtrr8HAoMgs64YrNJz3s+CSVbCegjgVlYuX9ATWMiADFADrbFchaJk0w7M
 lRpmKOuuOttBoa7OcL/L0+H7ibJr7K9+W55HMjWY7X60SlZ2VQnDGbP4isUxbleP1+fDn9F7Qvg
 efF1FZ93HBZIvId7NTiDklu3L78biEB8Y9FTmM8kYAtuLOs8BzVccbU158MUMfHhCdYufEpuRo/
 qEPjgaLt3TorRSA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to "mptcp: sched: check both directions for backup": it didn't
matter before because the two flags were very likely set by accident.
But that's no longer the case now.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 0026587a94df..3a673291b4dd 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -85,10 +85,14 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	}
 
 	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		bool backup;
+
 		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
 		if (!subflow)
 			break;
 
+		backup = subflow->backup || subflow->request_bkup;
+
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
@@ -103,9 +107,9 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 		}
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
-		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].subflow_id = i;
-			send_info[subflow->backup].linger_time = linger_time;
+		if (linger_time < send_info[backup].linger_time) {
+			send_info[backup].subflow_id = i;
+			send_info[backup].linger_time = linger_time;
 		}
 	}
 	mptcp_set_timeout(sk);
@@ -160,7 +164,7 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 			continue;
 		}
 
-		if (subflow->backup) {
+		if (subflow->backup || subflow->request_bkup) {
 			if (backup == MPTCP_SUBFLOWS_MAX)
 				backup = i;
 			continue;

-- 
2.45.2

