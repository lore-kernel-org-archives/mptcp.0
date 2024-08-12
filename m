Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B63B7A8;
	Mon, 12 Aug 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466345; cv=none; b=mtacf63NWqN8/wdMO/GcY4GhBXL741CUVfPztm+0eIiMkHvxzt/QWPxlJpNnvM93eUDHRCc3pxEvNxyt+xpO2W/ipLnAkiDemsBnP6HeAUXKLLIp2moKlXLe+/0P3BMT4DXOXTm97eMgOB1q3UtIIGCVXh3CC5YpbUIDGjVajrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466345; c=relaxed/simple;
	bh=gwAtiEeLyX7N2OcYvJcn8gcy8wtatv0y9qDR4xeKCQs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=kh88HrkI9sPuHJe1/MXn9bW/DWbQ7F7byoKK6uFLoq+2uvEFF6PNICAkzJMDhhLtlTpgLM+uYWQiplYuaS5qmXy2/8+GljUdWK9w0wadRfJNPoL9YQPoRVFl1dy77mpu7UDbpj/8y0EccekjJh/9Ds6Lr8Y55ku3gyAYSEGuo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zdolmQw7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zdolmQw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DADFC32782;
	Mon, 12 Aug 2024 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466345;
	bh=gwAtiEeLyX7N2OcYvJcn8gcy8wtatv0y9qDR4xeKCQs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=zdolmQw7/QpJGqXmBdGbDtDXO4xMmcsFfv1s/yDTgxRtrOCh7XwX8H1J1VKvXYrz1
	 t1J/VwL56Isaot0lhDZPI3TXhsdL2IMQS/ovl7R2z32zdGD+/2cnnSYc0/kzQKukY+
	 QzpRMnvVBV1o2YhVEOHe20CuJhOS+Iay9gYQ2pSY=
Subject: Patch "selftests: mptcp: join: validate backup in MPJ" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:38:30 +0200
In-Reply-To: <20240809091002.2702612-2-matttbe@kernel.org>
Message-ID: <2024081229-alphabet-barricade-d499@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-validate-backup-in-mpj.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66135-greg=kroah.com@vger.kernel.org Fri Aug  9 11:10:22 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 11:10:03 +0200
Subject: selftests: mptcp: join: validate backup in MPJ
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240809091002.2702612-2-matttbe@kernel.org>

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
  to what is done just above.
  Also, in this version, some subtests are missing. Only the two using
  chk_prio_nr() have been modified. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   30 ++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -925,6 +925,8 @@ chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
+	local mpj_syn=$3
+	local mpj_syn_ack=$4
 	local count
 	local dump_stats
 
@@ -952,6 +954,30 @@ chk_prio_nr()
 		echo "[ ok ]"
 	fi
 
+	printf "%-39s %s" " " "bkp syn"
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynBackupRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mpj_syn" ]; then
+		echo "[fail] got $count JOIN[s] syn with Backup expected $mpj_syn"
+		ret=1
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
+		ret=1
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
 	if [ "${dump_stats}" = 1 ]; then
 		echo Server ns stats
 		ip netns exec $ns1 nstat -as | grep MPTcp
@@ -1557,7 +1583,7 @@ backup_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
-	chk_prio_nr 0 1
+	chk_prio_nr 0 1 1 0
 
 	# single address, backup
 	reset
@@ -1567,7 +1593,7 @@ backup_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
-	chk_prio_nr 1 0
+	chk_prio_nr 1 0 0 0
 }
 
 add_addr_ports_tests()


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.15/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.15/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.15/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.15/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-5.15/mptcp-export-local_address.patch
queue-5.15/mptcp-pm-only-set-request_bkup-flag-when-sending-mp_prio.patch
queue-5.15/mptcp-fix-bad-rcvpruned-mib-accounting.patch
