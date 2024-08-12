Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21A17A593;
	Mon, 12 Aug 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465590; cv=none; b=UKsvD3VpXFzDv6cuuLQjL1/+HDLdcSAAd/CExD5dl18H1uh90mBneOHFE39tqvGIfw8DKqOMslDp4VIG3TOMxq8VjVWUQ2in5oDwm7APmvoxBa+XD9AK7RXrPSHIz/aW3kCVLEOXOsqOZ87K/MvmZ8LeIJunRRxhCg8XUheZo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465590; c=relaxed/simple;
	bh=XUTb/XL5yDORoTKUi8IiRWH4BsEs94EXHKYnUw5pnWE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Y5ISupAdd867g5Js8bBNuBl57d0AwooHnc+rRBhqlLeTdgCtaGZL7lumrsl+Fx7fbKL5Xn0Pcnnb4NlLJWSl+iWPwG1QMBSuQZFQy59XqNuJtt5zrlsMMAaA+NlwKLuU0ZRCmJXEGQHAPhapCc1DJCvx09PqIp4zDtVNlkNtGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UCPyaK0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UCPyaK0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C86FC32782;
	Mon, 12 Aug 2024 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723465590;
	bh=XUTb/XL5yDORoTKUi8IiRWH4BsEs94EXHKYnUw5pnWE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=UCPyaK0Fey2pjzAugJzPSZhlY7+RfCRw7s6YXZTPgJFWpgb/J4r3T8u1WXjy1ePI9
	 HuvdhHYrUNWiAGbmB+Jx5rkEgiCrIEFuMR6+jQNgoGgyJQzu5Gz1/i+v816fXvCwsh
	 xHYpX74DYqgTMXqm4HLQF25+n72XiXCifRykL4F8=
Subject: Patch "selftests: mptcp: join: validate backup in MPJ" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:26:04 +0200
In-Reply-To: <20240808153657.2317378-2-matttbe@kernel.org>
Message-ID: <2024081202-absurd-flyer-25b5@gregkh>
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

    selftests: mptcp: join: validate backup in MPJ

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-validate-backup-in-mpj.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66069-greg=kroah.com@vger.kernel.org Thu Aug  8 17:37:57 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu,  8 Aug 2024 17:36:58 +0200
Subject: selftests: mptcp: join: validate backup in MPJ
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240808153657.2317378-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 935ff5bb8a1cfcdf8e60c8f5c794d0bbbc234437 upstream.

A peer can notify the other one that a subflow has to be treated as
"backup" by two different ways: either by sending a dedicated MP_PRIO
notification, or by setting the backup flag in the MP_JOIN handshake.

The selftests were previously monitoring the former, but not the latter.
This is what is now done here by looking at these new MIB counters when
validating the 'backup' cases:

  MPTcpExtMPJoinSynBackupRx
  MPTcpExtMPJoinSynAckBackupRx

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it will help to validate a new fix for an issue introduced by this
commit ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh because the check are done has changed,
  e.g. in commit 03668c65d153 ("selftests: mptcp: join: rework detailed
  report"), or commit 985de45923e2 ("selftests: mptcp: centralize stats
  dumping"), etc. Adaptations have been made to use the old way, similar
  to what is done just above. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   46 ++++++++++++++++++------
 1 file changed, 36 insertions(+), 10 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1800,6 +1800,8 @@ chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
+	local mpj_syn=$3
+	local mpj_syn_ack=$4
 	local count
 	local dump_stats
 
@@ -1827,6 +1829,30 @@ chk_prio_nr()
 		echo "[ ok ]"
 	fi
 
+	printf "%-${nr_blank}s %s" " " "bkp syn"
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynBackupRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mpj_syn" ]; then
+		echo "[fail] got $count JOIN[s] syn with Backup expected $mpj_syn"
+		fail_test
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - synack   "
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckBackupRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mpj_syn_ack" ]; then
+		echo "[fail] got $count JOIN[s] synack with Backup expected $mpj_syn_ack"
+		fail_test
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
 	[ "${dump_stats}" = 1 ] && dump_stats
 }
 
@@ -2633,7 +2659,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 		chk_join_nr 1 1 1
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 	fi
 
 	# single address, backup
@@ -2645,7 +2671,7 @@ backup_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	# single address with port, backup
@@ -2657,7 +2683,7 @@ backup_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc backup" &&
@@ -2665,7 +2691,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc backup both sides" &&
@@ -2674,7 +2700,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc switch to backup" &&
@@ -2682,7 +2708,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc switch to backup both sides" &&
@@ -2691,7 +2717,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 }
 
@@ -3022,7 +3048,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 4 4
 		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 
@@ -3034,7 +3060,7 @@ fullmesh_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 }
@@ -3140,7 +3166,7 @@ userspace_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 1 1 0
-		chk_prio_nr 0 0
+		chk_prio_nr 0 0 0 0
 	fi
 
 	# userspace pm type prevents rm_addr


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-6.1/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-6.1/selftests-mptcp-join-check-backup-support-in-signal-endp.patch
queue-6.1/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-6.1/mptcp-export-local_address.patch
