Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DE55887
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163211; cv=none; b=MatxfhWavr7mkOUENPh/Yewju6bdXKAURq+FkchewNsFulkxpn2s2XWdbONFXbrrjWddJ0oqdR3i4u6qMOEf27BcfpyxgsZ1rH4y69nmEubcZ95ftIIKaLre9vXVPs4FGsD9t6Y+mN/Ot5JwwA/yOAVW9xoT5lsrlqHDHpd7v9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163211; c=relaxed/simple;
	bh=DZxSJViIqyjyo0gMt0iGjDdwjMEXDiS//iIfTEQ4RIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcOIC5PRqSi0NcjMM2rnp6cMvzs0cjogN/P51/qE0RuDmTKMLDW0mIrOKB5sjHoVYKOXbkhWbtkmjGVmUx0Kk9NHiadzFwsOc62Del64eyQywgkJK0v0F0x2lDl2MAvsi0J9/tYgdpQ/O2865ZpcyZfsn8A25REtQ/x/rc5EoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRfDUbWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRfDUbWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B42C116B1;
	Tue, 16 Jul 2024 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163210;
	bh=DZxSJViIqyjyo0gMt0iGjDdwjMEXDiS//iIfTEQ4RIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pRfDUbWhHhZ2m9K+rseDlrbD5NJkat3muuKUnp7ceKD+FMDShPdqpuVB1T8dcIYK9
	 pyEDhXvXhyEqxsnjlRY7Bc/gkvbbk7VV51MX1/9HeE8gWEv11hnBXevdoiEUA0/Zxi
	 XcL0Rg+WDh4puSYzkE099DqKC1Fnl9nuXrGVQQP5Fwvm7d3bOn3WbHCRvchxVqaggp
	 Shg2xKOAM3jf4tK97efFwU3EAtvc8XhTzpTqHJMg7a5HXCtJ6TABKLHybVP5K0Voap
	 KeCtRl2DNnAWiVSdglL13EpPB6Jz1RsDJpy87InOocfGmSXsdiT4yhbwlxhNUBiIhK
	 umVbj2r2n5LqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:53:19 +0200
Subject: [PATCH mptcp-net v2 7/9] selftests: mptcp: join: check backup
 support in signal endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mptcp-backup-mpj-v2-7-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3753; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DZxSJViIqyjyo0gMt0iGjDdwjMEXDiS//iIfTEQ4RIg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlt3B6VBCPaj3k9MxGFTUi5/QkrjjDFsxceF/9
 bQVijQg9WaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpbdwQAKCRD2t4JPQmmg
 cyPDEACzLMqg9oS36ZBwvfL/Vq5mfoDDdyQxtQbxiG5a6ZQpqX7F8+DuJ1cG9G2r6u2wMnuI8/t
 A+IMlCV9aJFYRfteLW87xtYRyN2E7SHRSAGqKroPTLD50Usi02+csoQQ4bGEqwRG6idUP2HFJUO
 oZ6SCEvJJfLCwhIKnMFOjhhzb5PHKs4r+L9kWXtbnxfjxMuDWLEd92WDV+t4Ez8nku3woO1zrt5
 wDktgzb9zEnksUFCPzuH2VVzfjGakpsneMzh9NSgHp9ai5G9y0W4vOSLnKwXEMSMProQD7I0s6S
 s7AZhMa6mPvKxiqOrrM8BeQb4hTNhI6Et0EsgEsf/XSX3J43/uo5+qPrFeGM8ADzpZmqV2mGhxv
 7rMgRuBCcKPgAog+QvqFplIg8LJlWclGDaOhRRk5PB14E4L0OyK2wb7fPepPRipEWqQV3Yd7fmI
 PaGXWDuiVufaIccJfUi4jhBngTc6C4m9gll7OLCN7rybsq1NGQqYSvdH78xdNben172+eVM4+zX
 ABXLyFhfV87Bc1QM7RuxbQWU2EkwTsZ29tYn1VIrtfs70B6MLmRlDOvCEQk6927d88+zXr7xttR
 FN1J42mQSGpvZ7Hyi19kk1LiF0IGgoNY1EWkpY+FXTXaL1KIlO4NEiXaD3nbKYZNftBsYfFV2rm
 ELCjmhDFwJ+3+pw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before the previous commit, 'signal' endpoints with the 'backup' flag
were ignored when sending the MP_JOIN.

The MPTCP Join selftest has then been modified to validate this case:
the "single address, backup" test, is now validating the MP_JOIN with a
backup flag as it is what we expect it to do with such name. The
previous version has been kept, but renamed to "single address, switch
to backup" to avoid confusions.

The "single address with port, backup" test is also now validating the
MPJ with a backup flag, which makes more sense than checking the switch
to backup with an MP_PRIO.

The "mpc backup both sides" test is now validating that the backup flag
is also set in MP_JOIN from and to the addresses used in the initial
subflow, using the special ID 0.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2:
   - Also validating MPJ to/from ID0 with backup
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 34 ++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 175127a9c00c..ffcf558b4610 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2639,6 +2639,19 @@ backup_tests()
 
 	# single address, backup
 	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
+		pm_nl_set_limits $ns2 1 1
+		sflags=nobackup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_prio_nr 1 0 0 1
+	fi
+
+	# single address, switch to backup
+	if reset "single address, switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2654,13 +2667,13 @@ backup_tests()
 	if reset "single address with port, backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup port 10100
 		pm_nl_set_limits $ns2 1 1
-		sflags=backup speed=slow \
+		sflags=nobackup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1 0 0
+		chk_prio_nr 1 0 0 1
 	fi
 
 	if reset "mpc backup" &&
@@ -2674,12 +2687,21 @@ backup_tests()
 
 	if reset "mpc backup both sides" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
-		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
+
+		# 10.0.2.2 (non-backup) -> 10.0.1.1 (backup)
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+		# 10.0.1.2 (backup) -> 10.0.2.1 (non-backup)
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		ip -net "$ns2" route add 10.0.2.1 via 10.0.1.1 dev ns2eth1 # force this path
+
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-		chk_prio_nr 1 1 0 0
+		chk_join_nr 2 2 2
+		chk_prio_nr 1 1 1 1
 	fi
 
 	if reset "mpc switch to backup" &&

-- 
2.45.2

