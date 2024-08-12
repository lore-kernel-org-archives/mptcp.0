Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17E17A594;
	Mon, 12 Aug 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465585; cv=none; b=CbucMtjWuQS6pNpYjS+tLBZ0ccYGuh/jAdP1xzzEmjYyiTQu//PAEOl4u29OHph1DDLm1HGw9P4YcETFyvZYMVrIy6ynUjKfMKZTSqyJarBztZx4MArWqqe8rc6+eQAXdYUGOXwH1/16sLC/ZPjLsArDnnu3/+Z66FvNSLCvnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465585; c=relaxed/simple;
	bh=/tCo7zzpSmhNaRmuy3xgJllaAqL2rwXn1Tp53cskKXM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Cbe/fcyTVvEql7emLRFuLt6D6xSp6PnowZ3kAGvOq+951KX6KIc16ZRz6RlYazH3PbtqU/co6j6bUBDpXk7SgPCTLr3i5lGccwMuKjtyL+d19jQc+SxqUd5J/kwmgabv9W/M31lD29qQ2bSF57NDnJg7SzmYLBF732jOvgAU6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2j1jEDzW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2j1jEDzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3976C32782;
	Mon, 12 Aug 2024 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723465585;
	bh=/tCo7zzpSmhNaRmuy3xgJllaAqL2rwXn1Tp53cskKXM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=2j1jEDzWaoK+KFeNmx6YHGPKqb0aLqttRP9fVCpk00BWnkJl1rBxVwlCw8zIBrTUt
	 qmzpXyayNBVffxIwyc2YceTU8Jny2uEiw5ZkUD7Wb72wBCEZUKp1/C7uB2sYRyrhVH
	 Fsc5V6SzBapNOmVUZf/3T1rd3VXW8TjsgQJLb92k=
Subject: Patch "selftests: mptcp: join: check backup support in signal endp" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:26:02 +0200
In-Reply-To: <20240808153829.2319257-2-matttbe@kernel.org>
Message-ID: <2024081201-outnumber-endorphin-3f60@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    selftests: mptcp: join: check backup support in signal endp

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-check-backup-support-in-signal-endp.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66070-greg=kroah.com@vger.kernel.org Thu Aug  8 17:38:49 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu,  8 Aug 2024 17:38:30 +0200
Subject: selftests: mptcp: join: check backup support in signal endp
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240808153829.2319257-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit f833470c27832136d4416d8fc55d658082af0989 upstream.

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
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh because 'run_tests' helper has been
  modified in multiple commits that are not in this version, e.g. commit
  e571fb09c893 ("selftests: mptcp: add speed env var"). Adaptations
  have been made to use the old way, similar to what is done around. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   33 +++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2666,6 +2666,18 @@ backup_tests()
 	if reset "single address, backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
+		pm_nl_set_limits $ns2 1 1
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_prio_nr 1 0 0 1
+	fi
+
+	# single address, switch to backup
+	if reset "single address, switch to backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
@@ -2678,12 +2690,12 @@ backup_tests()
 	if reset "single address with port, backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1 0 0
+		chk_prio_nr 1 0 0 1
 	fi
 
 	if reset "mpc backup" &&
@@ -2696,11 +2708,20 @@ backup_tests()
 
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
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-		chk_join_nr 0 0 0
-		chk_prio_nr 1 1 0 0
+		chk_join_nr 2 2 2
+		chk_prio_nr 1 1 1 1
 	fi
 
 	if reset "mpc switch to backup" &&


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-6.1/selftests-mptcp-join-check-backup-support-in-signal-endp.patch
queue-6.1/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-6.1/mptcp-export-local_address.patch
