Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77C17B4F6;
	Mon, 12 Aug 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466338; cv=none; b=c16F5y8ou+MbTVK/9HFcz6FgHwNF+bZop5Z0b870tVlciaFXCY/VV18WRFtsBIC8ARR1YYTtH8AM2k+O1xFboJHpbTLFlqK85sB9L3uX1QplJjaCpdA5FNCvvAjP7BN25YyDhLLcR96jQm/A6jfsebuEPV3QqMN7tFcMAlJH7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466338; c=relaxed/simple;
	bh=PtejrSfx0zkq7sEqfr75QLCOXO3ECjO+iWnOkobR8ZM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=I5oICqQk1ezI1Gk7UmNHWTOLcG8UOuBj6sEXrMbq19EHGLmbMZWIOPYhYLvsCS70fKs7Aw6254QQloQLyZv0QiQXKEXmHrs0ddRcOW7zqDlhf9Oid2dZtzubmbpCloPsx1DaSMPy5FmYdmAChUsULGT7ZapJAV0Uf0gTnU3FibM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9TSh+qi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9TSh+qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAD8C32782;
	Mon, 12 Aug 2024 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466338;
	bh=PtejrSfx0zkq7sEqfr75QLCOXO3ECjO+iWnOkobR8ZM=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=T9TSh+qiM7416v1hQM+nDNGoidA/lHcZ6l01I/ifTKyrju9xcY+iA/SEYAzkOCzq/
	 mGrl99mve6X9A2XL8BzltRkG4v/bs9CK1lb8KhDAOQ5UGMkdNbJDAqmv2VUBG5qhI+
	 yNc1y9wz3WkGlPiBl+Snl/WBsXn4F2EVXaqUYMQA=
Subject: Patch "selftests: mptcp: join: check backup support in signal endp" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:38:29 +0200
In-Reply-To: <20240809091031.2703339-2-matttbe@kernel.org>
Message-ID: <2024081229-judgingly-tapioca-98d4@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-check-backup-support-in-signal-endp.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Fri Aug  9 11:10:41 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 11:10:32 +0200
Subject: selftests: mptcp: join: check backup support in signal endp
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240809091031.2703339-2-matttbe@kernel.org>

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
  e571fb09c893 ("selftests: mptcp: add speed env var") and commit
  ae7bd9ccecc3 ("selftests: mptcp: join: option to execute specific
  tests"). Adaptations have been made to use the old way, similar to
  what is done around.
  Also in this version, there is no "single address with port, backup"
  subtest. Same for "mpc backup both sides". ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1588,10 +1588,19 @@ backup_tests()
 	# single address, backup
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+	chk_join_nr "single address, backup" 1 1 1
+	chk_add_nr 1 1
+	chk_prio_nr 1 0 0 1
+
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
-	chk_join_nr "single address, backup" 1 1 1
+	chk_join_nr "single address, switch to backup" 1 1 1
 	chk_add_nr 1 1
 	chk_prio_nr 1 0 0 0
 }


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.15/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.15/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.15/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.15/selftests-mptcp-join-check-backup-support-in-signal-endp.patch
queue-5.15/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-5.15/mptcp-sched-check-both-directions-for-backup.patch
queue-5.15/mptcp-export-local_address.patch
queue-5.15/mptcp-pm-only-set-request_bkup-flag-when-sending-mp_prio.patch
queue-5.15/mptcp-fix-bad-rcvpruned-mib-accounting.patch
queue-5.15/mptcp-fix-duplicate-data-handling.patch
