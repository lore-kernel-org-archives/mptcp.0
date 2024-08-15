Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45026BA53
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754770; cv=none; b=D76ckhWtMCIqOW6/lf+DQQ6/YcXjn2bLphRga30nFrpu+047ePxFyEd5gji3ghFMOhlftoQ360mBI4SY1ubIn6YHXZhCodeckounNBbrhF0oZRuXa8z4QKRVOSRv4qfRt6JEzqRAax5SyutopZCpKRdO0aWwTEa0iq9mwNqEdus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754770; c=relaxed/simple;
	bh=MhZtPAQpQiUhMe5YQjVGhj0SH+lZFTkpf5yWENfo1mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ka0oQCMNn+ytQkS/vjkThQ8Km/CifSv3yzQRg6pK+mE34tkDbCDK0s50Ie2cpFDegl3tJBOvoFRgp9SRDsR+IzXHL/65TtdC2whKsXjJGc4W+WiJSnnOrYhW1CgMDyV4kf7iBRSxk6qAsTjCp+a2zMcpizhRCLPr1tjEWkeKzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brQgBtIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brQgBtIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63654C32786;
	Thu, 15 Aug 2024 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754770;
	bh=MhZtPAQpQiUhMe5YQjVGhj0SH+lZFTkpf5yWENfo1mM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=brQgBtIbTq7ynhPZjFQjX3hfVo5KkzDVpD62nuwbUyd8Ngd8oJNjVGlKgUePnRNg+
	 ryoP0mSkxRVo0yHbQ2dNahidoahYpmSMSrwrs0NCdqyfycqMofsF6O9r/Z58MKdA8x
	 jmQLYdLz1rPM1L3VPE8i9bpipbJ0sMzYcSnhEjDluPkFoNTwq3++Lf0IFn5mVGrx3+
	 9bhXBmir/5ajXSlM796oiyEg3f/mK7lNAQTIKzEa7gopJnNDuhuahNquZwzaIpnmCP
	 UZzni3m/fsPVu4Gu1b8N8CbeTyxpsZ0wgU3yVVEaqWL4DI/5tf6IEgAoOgy86bp3o3
	 fnfEibMWVrG5g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:47 +0200
Subject: [PATCH mptcp-net 06/10] selftests: mptcp: join: check re-re-adding
 ID 0 endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-6-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MhZtPAQpQiUhMe5YQjVGhj0SH+lZFTkpf5yWENfo1mM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJJFSKjJzaYJExL8Vn2vXRHYyS9QH96b6cB
 cSUACdo1oSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 cx94D/9Cw9XXHGm6/2bmk82GhT0Q3i8FOQ7FMnX58K0xtRjQon0rzRmcRtn5DtMsyVvhylAcHhf
 OWcHF8DJNAz63kvrQ7qobIniR5OafSvzkYk18C2byiK10nHz2Y+yW+B/1rRjDzFJUC1ThxIpk1Q
 U/s5OgvjvYiRamvYRGQCZMHau0BshBLqi7AeZb83GQ1YK+wA5DpzIu5ITKONQUJBdxNVURNNfcj
 +dkFS8RoKtyopxk8fM8snlBpapSiBvzmUKL/YRY/K0S6y++QCaDOUEnMeJhE5LCgH/qwfc2FNUT
 AonrHAeX6/MHFtPXUfeUlm0YNNNwOPU2EWSK935dETwvwqMufNVRVYUeM+ngpfXFNSRSIqYSvm+
 6qnxQjWOfxJ5pGwBTRFiZ+rcRmBH1bhLrI3LH5z1vpZGNacLX0wi87BJFsMx8NnOB7/fSjE3YJs
 cbfnkZCGUhrT0EXgNKpstYtoQo40W1Z8Jb0BQXlx/I8YqJ3JUIGEke5THsAA/zaRFyhVAY6kntZ
 Xx73SBhLjGof+ZWazYxhEbEWDQDzNuLnhNy0/t+UKhYlaqnrsVBxIn599H+c4qrAD9IGuypOIK1
 00OIhlb2Ml2pRJtEjuN8jFl5wGJvC2r9452/1nP80N5HcEe2uNGVpv3y6AZIj44VowYApqI54aV
 2yjk61IMc7PVypQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit:
when the endpoint linked to the initial subflow (ID 0) is re-added
multiple times, it was no longer being used, because the internal linked
counters are not decremented for this special endpoint: it is not an
additional endpoint.

Here, the "del/add id 0" steps are duplicated to unsure this case is
validated.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0494610694df..af722227b9cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3694,11 +3694,21 @@ endpoint_tests()
 		chk_subflow_nr "after re-add id 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 
+		pm_nl_del_endpoint $ns2 1 10.0.1.2
+		sleep 0.5
+		chk_subflow_nr "after re-delete id 0" 2
+		chk_mptcp_info subflows 2 subflows 2 # it was an additional sf
+
+		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+		wait_mpj $ns2
+		chk_subflow_nr "after re-re-add id 0" 3
+		chk_mptcp_info subflows 3 subflows 3
+
 		mptcp_lib_kill_wait $tests_pid
 
-		join_syn_tx=5 \
-			chk_join_nr 4 4 4
-		chk_rm_nr 2 2
+		join_syn_tx=6 \
+			chk_join_nr 5 5 5
+		chk_rm_nr 3 3
 	fi
 
 	# remove and re-add

-- 
2.45.2

