Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5369D2B
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046798; cv=none; b=A7Q0gPm9WUF8r1jh2dyAM3iQPQOuwQfCzGx4ZNTCBg+mqQY7WVyhcgWyel4OWaRzX5UXaziglCPMm5027CfJBqLjZy4HWKVLcPl9yprSR3pRkWkhtpXBzfAdL97FKgjeEoiufp31/S8w/t+akbbfiRczOXYOt+VJ68TRXUhP7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046798; c=relaxed/simple;
	bh=8fB+UmCs8R0kK5rvVEIqyaaVVQE6NSzQW3cZYewl1DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsnVOufiuJIqGfWq3MCGhnUdgH/Qs+yExzR4sJBRAvwTISiUR+uRaTrx4B31USiYGQp7Stet7Jmb05JW/vOYWLl/vHjmxwm+/F8RThrOJ34qi7eGOGzc710ZS4/fxcYin+euDXWy+d9vM6Y0HeOAocDR0RgvCuOJbmURSF7Bjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKjqD5qd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKjqD5qd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A54C4CEC7;
	Fri,  4 Oct 2024 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728046798;
	bh=8fB+UmCs8R0kK5rvVEIqyaaVVQE6NSzQW3cZYewl1DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKjqD5qdA6vA3in5zUecr/OpiYo7gcJu3vMSRBa2fEgGNaZ6SAN69Ho7GnWgAjzut
	 XnoG7hxv4IGwLg3sYV7xpGFiRIkDPEMnOc7pbUdES961c0FNWisqeh/qZf0cszTR/T
	 TUovS8v5BlPq1aPxpbCslfiR+Peu5nER4VOScrJMgZp0bnTn8ZkvLQtp4SPGixCecg
	 44SIIloraltW2vD9GyTlgv//07iHX2Zrvl+JUFKQfQ3MLPNqfJUdoWUj39MV2QJjn6
	 SywpInDS+17cjcWfQwKQ0WdbbxeIwkbxijWbRNnzAMaS3hu5DCIfxMDKyVWBWDl973
	 54dPaVk3vT4Fg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/9] Squash to "selftests/bpf: Add bpf_first scheduler & test"
Date: Fri,  4 Oct 2024 20:59:42 +0800
Message-ID: <518c7c2a4b67036de2473d1094bb90db17729fed.1728046491.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728046491.git.tanggeliang@kylinos.cn>
References: <cover.1728046491.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h       | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index ada2273bf7b6..9ca152a99dbf 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -57,6 +57,6 @@ extern struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
 extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
+bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index d57399b407a7..807685b3ab97 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -20,7 +20,13 @@ SEC("struct_ops")
 int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
+	struct mptcp_subflow_context *subflow;
+
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		mptcp_subflow_set_scheduled(subflow, true);
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

