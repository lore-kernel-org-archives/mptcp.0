Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769384D8B7
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318054; cv=none; b=eouMymBd/C2Tu42cqlFIc8CNtgx4/LbaaUIxyWDTP0HYk+nrbOybf7RdH5m2dUPrCGPt+LIOuEYjr5g0HXyzZFmzfSj4+NMQwnVoE7qhk9lT2pnSN0S3Mg+ZHsSTWCHA4DN4b84grYvVtp3QiwD22YAmofokb1wjyTlMeHJew3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318054; c=relaxed/simple;
	bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJEA+/hY2sRu1DuI4aU8GYBnYdm0MGx+dbxd5MuP8/o8oUEYEKwOkg/wCHehGk12jsHjqDKlxu6YylVCrJEwAVaFQJH+KOP3kUaujxPNDs9gkYA4Ezr0qWEMi/ijKeLRGYbxORkBE5MPeArXaqoh3gq0iGDeN68nSDPhoXHpLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx18+0TX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx18+0TX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F66C4AF0C;
	Thu, 18 Jul 2024 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721318053;
	bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vx18+0TXOLHhmHHp5qATjM67IedMKTuTHucWn86FIvGDLPEs0Pih7vy7dYodoFppf
	 0wIkkUwdUgBZyoHJu1Ht9kwcFk7Sf+fENCdcG7cVlsBVPXutMtkCmfDwlxyIFkYr0B
	 2RbKia1Z9d1ImxirsH8haLcLkVMhVQvJYbTkcljdOmUl2qjxVefnbEMb6QEbU6HKhR
	 B7utt9IB+fH4DcPHuSc9Fd1gEyflaHXT6piDl3nCBhyyvcVB0Y2EjqJElCpq818Z69
	 GDQMZGrzWq0wm8wXjZnyPcDEeSfrdGpsjIcfI2UbKzUhEzN497a7ckTI1tFiI/MH8x
	 kPueYP1lUCv5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Jul 2024 17:54:06 +0200
Subject: [PATCH mptcp-net v3 9/9] Squash to "selftests/bpf: Add bpf_burst
 scheduler & test"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mptcp-backup-mpj-v3-9-1f6cd9b89ee4@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Fn73rImpeWC8EQqc9FknandKAe95OLv5q72DUryxtME=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmTqbvRyP5z5HhM8q0lhyvhnZRZ8stOzsL4jWh
 ud6vhWHqtqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpk6mwAKCRD2t4JPQmmg
 cwSGD/9o+gn7O3FYQtJQxdMJkrff4EGmEG66i3j5SzgddfAhnD0fa42GY0kqst1/x3Fe/Q3Sifw
 tj2Q09FJ+7LKinxbvzJdA67sNp0ihZCv7bX1sGG0pTbsBm7VE4rCUeXszekpN6XriXjuf/YR4St
 EJ83/sI2usLLBjXoNGgZemqilCH01VdBKosU54kpFYlsyk60YMrwejzIVLHyn+fiAaQWYpVZm9N
 yds99KqK2wz9eDG7X/omPAYuhwkCK84eddaMPkMXpQAZWYWgU+EYOYjVeV91uRV4bql+yulBLFy
 lYcJ2b3Z/QLHmoJzdBcPwUMgqtT3doRUJyPGksrP5W2G6TG6mi/iL+AZuvkVkdZ5/OLWp06lz4j
 rAfB53JB5sTfLpRMXf7IgYyMiERWE4rF8EH253/Aqv+lzEs38MAnU1j3F/b8gRWEAifQJ0tpJPt
 95yYQoeuY07L+8s6z0HaKus153DIks028/pUI4we4vUOKVGMZcKc6wDRM0PIE8SwwmmuaRzqR8C
 YLebRHr6DRwj/QFeqK6ETRB2xg/bf4YUkHaHxRaWpJggAscf7al+9P7iKEao76q4zjfHoumsOwJ
 fiQmMd1JV3KKneKkLbve81N0/GdNBVqGjIlr8/+vYZ+T+pFOmuKLE+0I0BLmOie9xFVqETiROCa
 1n69tamANyQhOtg==
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

