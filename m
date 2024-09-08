Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B47529CF7;
	Sun,  8 Sep 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804205; cv=none; b=LeVkdksLo2y20iMTicGnWrTa9Bj7SEjSsbd5tUwi7xP9qCkzJHpAhKIaJf8f9Z9dhUyp1vXDCVvDOyYeXOQrYCEcrotKtO6Mb7fTt3p3rXIELywapFzRkcDQTLYCQL6Cmz8IBTjel3fFKNcvWIqgqr00ht8dxS4aKsP2/YTTl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804205; c=relaxed/simple;
	bh=D4zwMRUcJutABljXoTZ3uol/qydE+Z2ugl9CgGfs2hQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=cnpLcnhjjuT8LMWxGfUI5voqpWp1nZYEhVCSI/U/0HaoRVW8qgBvXX765tVzqVRG4/0We4HLzQxJBQQz74g3Qubx6TPIiAjo6c4kdSSXxyIx+HBqhoJ1ddvhQB5wC2hL92xWlExDfeUx3hIeBWWjE2pyau4RkBFmLWGOEv4DeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/IJe0s7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/IJe0s7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47730C4CEC3;
	Sun,  8 Sep 2024 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725804203;
	bh=D4zwMRUcJutABljXoTZ3uol/qydE+Z2ugl9CgGfs2hQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=s/IJe0s7H/9GUoKkJoJ8TiMVNjIRsdu48CStfdb7IzonDYoqg6XOuF9w7j/wIzMT2
	 rrLaLmWoZuNRPsA229TpoZPhknVH3/qf5nnUm5ZxEQTP4hCOatkXGOr5aU6lonLVyC
	 3PYJIM47oi1C1SvlO6lhEjgGLecWBCS9+IZqyJaQ=
Subject: Patch "selftests: mptcp: fix backport issues" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 16:03:20 +0200
In-Reply-To: <20240905144306.1192409-6-matttbe@kernel.org>
Message-ID: <2024090819-duo-example-753c@gregkh>
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

    selftests: mptcp: fix backport issues

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-fix-backport-issues.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73611-greg=kroah.com@vger.kernel.org Thu Sep  5 16:44:27 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu,  5 Sep 2024 16:43:08 +0200
Subject: selftests: mptcp: fix backport issues
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20240905144306.1192409-6-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

By accident, some patches modifying the MPTCP selftests have been
applied twice, using different versions of the patch [1].

These patches have been dropped, but it looks like quilt incorrectly
handled that by placing the new subtests at the wrong place: in
userspace_tests() instead of endpoint_tests(). That caused a few other
patches not to apply properly.

Not to have to revert and re-apply patches, this issue can be fixed by
moving some code around.

Link: https://lore.kernel.org/fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  138 ++++++++++++------------
 1 file changed, 69 insertions(+), 69 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3236,75 +3236,6 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_rm_nr 0 1
 	fi
-
-	# remove and re-add
-	if reset "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_set_limits $ns2 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-		# broadcast IP: no packet for this address will be received on ns1
-		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
-		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
-		local tests_pid=$!
-
-		wait_mpj $ns2
-		chk_subflow_nr needtitle "before delete" 2
-
-		pm_nl_del_endpoint $ns1 1 10.0.2.1
-		pm_nl_del_endpoint $ns1 2 224.0.0.1
-		sleep 0.5
-		chk_subflow_nr "" "after delete" 1
-
-		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 3
-
-		pm_nl_del_endpoint $ns1 42 10.0.1.1
-		sleep 0.5
-		chk_subflow_nr "" "after delete ID 0" 2
-
-		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
-		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 3
-		kill_tests_wait
-
-		chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
-	fi
-
-	# flush and re-add
-	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 1 2
-		# broadcast IP: no packet for this address will be received on ns1
-		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
-		local tests_pid=$!
-
-		wait_attempt_fail $ns2
-		chk_subflow_nr needtitle "before flush" 1
-
-		pm_nl_flush_endpoint $ns2
-		pm_nl_flush_endpoint $ns1
-		wait_rm_addr $ns2 0
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
-		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		wait_mpj $ns2
-		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
-		kill_wait "${tests_pid}"
-		kill_tests_wait
-
-		chk_join_nr 2 2 2
-		chk_add_nr 2 2
-		chk_rm_nr 1 0 invert
-	fi
 }
 
 endpoint_tests()
@@ -3375,6 +3306,75 @@ endpoint_tests()
 		chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 3 3
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		chk_subflow_nr needtitle "before delete" 2
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete" 1
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete ID 0" 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
+		kill_tests_wait
+
+		chk_join_nr 4 4 4
+		chk_add_nr 5 5
+		chk_rm_nr 3 2 invert
+	fi
+
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr needtitle "before flush" 1
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		kill_wait "${tests_pid}"
+		kill_tests_wait
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-join-validate-event-numbers.patch
queue-6.1/selftests-mptcp-join-check-re-re-adding-id-0-signal.patch
queue-6.1/selftests-mptcp-fix-backport-issues.patch
