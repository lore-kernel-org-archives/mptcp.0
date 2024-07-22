Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987FB17109D
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676967; cv=none; b=Q7CHLrKGMwoBPMjln/pTbIn5Ieua3hV8ivGyvAsKCtXKXJGD1hGhnVZ9LYBG1rkah0Fi2gdt5ZqgTDblyn0hRQExMGJ3cZ8/gfndz/K6XPtqrikOafHBLaL8LAiiTC5UNBMICCDw7n6QLpNFlbyNcNJUA+a4kvboJ8kSTkfHEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676967; c=relaxed/simple;
	bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEI0Mhn3M4SrQYk0qiy1kBxXdG2rTE5quDHacCuHL8PSAuKg93wxR9jyu1k12vKR2G2ZOz0QneUdpOfussdptosYAMBsLS/yqz7dey0Vpowql8QNvzUqPD1P/E4sRmGTCi3yvJdvARl9xp+i/hw3SHc7+qTziCTeo86f35WxmkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjRE9Zze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjRE9Zze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B1BC4AF0D;
	Mon, 22 Jul 2024 19:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676967;
	bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PjRE9Zze5ZpJNkeiQcPYlsr1yOuqEot/hiNdO4BFYAZxKN1gMdd+qYTNqZb2o9CPD
	 BKYEshnvAo/ednrMtq9vqKO21VpJ24Mv4UigYrTaOD2GdRyBoi0DYSo+OVzYTnGLws
	 GBhEJw87dBabR6lkew40TEnWrpTgzehAyL0aKEOKjoDpkCtbwYWs+lHgCHgU5Y0Eqg
	 N32CnTUUZi+KIRF+zvDl8XgywNT1pRNp5Q7efj1J+QHcfoeE26IdumsDIDJy+a7DOu
	 DHDgU9j4Dz9wpZUcUnuYaCwR+j2zCBQgNdLzhFqAfWUpBDkRp4Mt37uzUZqYUlYUOF
	 cauRSJ6kkK5gw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:51 +0200
Subject: [PATCH mptcp-net v4 13/23] selftests: mptcp: join: test for
 flush/re-add endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-13-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=XkczOedmWFgLcnHwG5YodN3uumTEtKKu+YQSdFypLd4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSW7yukuNJPDFe66c+z4VlmBilJYue4zQQ7B
 hwbrPgCicuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c1U3EADY6ygPc5S0RIEzptiNkC37KW4UvssdUWSXkjvEdMYiWq8WUD5cZ714Ana/zt5QzJoQFRL
 NHBiQ1soQx8OypeYS8AmChBCPOKmg3t4TPp5jVSsOetUkXciMQggmxfZ9KtORFsGWV1wepoqAyT
 7kg7ab+Y3qKuNDF9cUfybYik96DMl2lujGsw7AmNbjPODCFWsqh7B2q2NS1uWz82dz1EPvcqXFh
 fCzQIYpqTBOozwcCqO1iKQued6Abn2Vh12YHUK+GabquBA25meP55bK/jvGiQxMk8tfGdEKwHNJ
 bfXrng472NrrZA1Iwi8q3+qKsRdBycMiWYwGCBtX3YfXbZVWLo9twAf+X5bevU6D4DuzeIXEQM9
 3O67dRI/pxyKxKtfBwdOIRXKp7PcEjwWSLYeTrEh44ILCBZm1tDUa0D6ix0Yo65zACOYGAX+WXC
 oqKA6izhk2nH0sIR7NM1u7KpYNWYzHtJDRubeC4Sn8RiDdtZZuuut4Ki820Od0zV6KOKglHc9Cv
 iYv+B0Dj+AwsmvmL1IlitBvDbs35TrQlhBVxJ/NQ2DRGuNLoH4vh0vJK2KfnBd67m9OObWi15+y
 qJhS5iE0goeVbhY6AA5W5Eu3d76IkTPx95BFXzjZxL7XbTePnn3hNpca2gNu2ztla9qfFSJDQkE
 fR6aonV57p4VS9A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After having flushed endpoints that didn't cause the creation of new
subflows, it is important to check endpoints can be re-created, re-using
previously used IDs.

Before the previous commit, the client would not have been able to
re-create the subflow that was previously rejected.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c5aa745a36f5..3565d8b48125 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3607,6 +3607,36 @@ endpoint_tests()
 		chk_rm_nr 2 1 invert
 	fi
 
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr "before flush" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]

-- 
2.45.2

