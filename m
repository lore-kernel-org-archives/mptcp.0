Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E414276
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0w4LEF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF84C433C7;
	Tue, 19 Dec 2023 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702978046;
	bh=T3wW0NCaQQeMc6EbF39nsEHBN7K8GUL/moC+syjJwQU=;
	h=From:To:Cc:Subject:Date:From;
	b=i0w4LEF98ZOvrJNhFuCHcufoF+HKrZmm3DYBFXmB0sjtTKl7KsoVKeOXrmaVAmsaT
	 QkdGyQDpRORqc8ZSKTEzb2QD6JFYPXjKnuzVyS26q5TtlWpal1n4seCn9hPn9dkYOA
	 n5tExnRecUzQil0Ke6FHjA/lOjpQepkirue+YxChXN4UkPtnRywHVReRoeryrAUHxA
	 uKda/RIzA+E6MzLqiZ8pCG3OGimTbQMhkeOOJXmYCWzKETBuIlbUKSCH63qKPqUsee
	 h1F+rgcwP6yHKzrEdGSlszhBlZpgZ1OmimFeVomXy550nombp8KbuxiuDqHA69OMEd
	 DXDqpoPU/b5hA==
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue, 19 Dec 2023 10:27:05 +0100
Message-Id: <20231219092705.4120179-1-matttbe@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=matttbe@kernel.org; h=from:subject; bh=T3wW0NCaQQeMc6EbF39nsEHBN7K8GUL/moC+syjJwQU=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlgWHpg5/1zU1T4oixhqIrr/CTIb6wQMARTw2Za c/UL36zKECJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYFh6QAKCRD2t4JPQmmg c3kUD/9UYdSurlc+F3BLpxBiw/7ywPtAdit4z80ROt7FLLbGW83Nx25h4apJZ9OAafn0wQdVS/D gWeC96p3ZW4D+6W/Qbk6u1RPEy4WLw1Xh4yTVXxhcrZdKn08jqS+ND3SGDW9eJnBd24KOoR1pFj 1T/8Dam2EQXCh2y76XKaT5AAqSoKLdcoLJmb2dbnMFWZ0XKsSa1yVQFR/ScwWNSCYQKCzPR/O8V 7E4cP96XhAk4p0sRPfsDGyZkV82qN4MwMPW2VZACyNrtOkaG3qRKgGh+qp6MgSbWybo7KhNMT48 t8WdOATo499f0JqYzlSpRemoZZYH2HrNpCAjYKmeEZwvM5vegHyezbdxYerPoX29AafAKNs1RyA CWyECW7MMnZOU7S2BsCDAtgOhWPMLakULyVa+2mJ2mR3tDOk5elWDbcYO6qqA+BV7J1Y1EpOst8 5LR7Kk0B5UmnWULH6PL03T26nG0VvsSNCU/1lUkuBwMyWrVm+EklizGjDMCG+6yzl1bqKKbUrEX myNX+4q45Z9LPvdMgZSJra3r9d4CXEuXpRNUuwVwRd8PZ8fVdHaMIOT39YKT5GMHTnjD2Lennkz /R4ryKoIh2f/bBSlum9QxnVdFpTsAwKZKCEnUcM6rxgRe+56BUuxuVoC0gmUmwCl6znhYSR13eH bU2JvtRY+iZdhKA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This fixes a compilation issue that we have in our tree after having
synced with upstream. See the Fixes commit for more details.

Fixes: 4cbb270e115b ("bpf: take into account BPF token when fetching helper protos")
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---

Notes:
    to be squashed in "bpf: Add bpf_mptcp_sched_ops"

 net/mptcp/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 6b61dd54e69f..dfcaaf0e07dd 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -35,7 +35,7 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 	case BPF_FUNC_skc_to_tcp_sock:
 		return &bpf_skc_to_tcp_sock_proto;
 	default:
-		return bpf_base_func_proto(func_id);
+		return bpf_base_func_proto(func_id, prog);
 	}
 }
 

base-commit: 5763f7d7b0e50d486c63e51c0495459f2eb93d2d
-- 
2.40.1

