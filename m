Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BDD29402;
	Wed,  4 Sep 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460620; cv=none; b=aDTInOx3QpCLJ9nj7rc/hyAX2rAXowQb3Jz+E2XN5jtdNI0TrnUdYItRqVucJSNRg+EV7WZfJ7lPRdkMyddS09X4QsZ2O/l/luzVzVaV/gFLt294Vma5rCONXzoYaoRcNsp7k5mjVoViJ8G74fnz5ydciKYOXP+bcyfioHcvuhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460620; c=relaxed/simple;
	bh=wQHg/KbLw+GdTe2GQ+kFBfA3b1R7VWO7/5YPo5biREA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=D0QRoZavg6K6yrcovDIjEZNodKaQG7waJwHyt2M/LBae6B8wd0mlVAEhhQyi7J2zbPBp/EzmApwXgEQp9ltIvQtifiuC1b512B/S8J3O08FaNYZ7ZRFgSDxO/DDm5+dPOL/BGObcMZ4VJZ3z0lyWE2uxcCfXSLZJcg+yU+nju9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RosMCypV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RosMCypV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7979FC4CEC3;
	Wed,  4 Sep 2024 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460619;
	bh=wQHg/KbLw+GdTe2GQ+kFBfA3b1R7VWO7/5YPo5biREA=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=RosMCypVRnKdntKTnDdj+dgOyHz2UOc+ARh99qibo05CGkwQRYbOE/6ovEzou67MG
	 bzka50N3bj6d6HqOJ2VaH2ZuN1Em3VyrCSeu/W+WXUsgYEw8UR5ZYsPVsJ77Yx7K82
	 Yiw32y9/HIzPaZqjyXmVd0WWasB/2hWMAa0f988I=
Subject: Patch "selftests: mptcp: join: check re-re-adding ID 0 endp" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:36:55 +0200
In-Reply-To: <20240904111302.4095059-2-matttbe@kernel.org>
Message-ID: <2024090455-district-barista-2478@gregkh>
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

    selftests: mptcp: join: check re-re-adding ID 0 endp

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-check-re-re-adding-id-0-endp.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73021-greg=kroah.com@vger.kernel.org Wed Sep  4 13:16:18 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 13:13:02 +0200
Subject: selftests: mptcp: join: check re-re-adding ID 0 endp
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240904111302.4095059-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit d397d7246c11ca36c33c932bc36d38e3a79e9aa0 upstream.

This test extends "delete and re-add" to validate the previous commit:
when the endpoint linked to the initial subflow (ID 0) is re-added
multiple times, it was no longer being used, because the internal linked
counters are not decremented for this special endpoint: it is not an
additional endpoint.

Here, the "del/add id 0" steps are done 3 times to unsure this case is
validated.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh, because the helpers are different in this
  version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3312,7 +3312,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
@@ -3333,18 +3333,21 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "" "after no reject" 3
 
-		pm_nl_del_endpoint $ns2 1 10.0.1.2
-		sleep 0.5
-		chk_subflow_nr "" "after delete id 0" 2
-
-		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
-		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add id 0" 3
+		local i
+		for i in $(seq 3); do
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			sleep 0.5
+			chk_subflow_nr "" "after delete id 0 ($i)" 2
+
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+			wait_mpj $ns2
+			chk_subflow_nr "" "after re-add id 0 ($i)" 3
+		done
 
 		kill_tests_wait
 
-		chk_join_nr 4 4 4
-		chk_rm_nr 2 2
+		chk_join_nr 6 6 6
+		chk_rm_nr 4 4
 	fi
 
 	# remove and re-add


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/mptcp-pm-fix-rm_addr-id-for-the-initial-subflow.patch
queue-6.1/selftests-mptcp-join-validate-fullmesh-endp-on-1st-sf.patch
queue-6.1/mptcp-pm-fix-id-0-endp-usage-after-multiple-re-creations.patch
queue-6.1/mptcp-make-pm_remove_addrs_and_subflows-static.patch
queue-6.1/mptcp-pm-avoid-possible-uaf-when-selecting-endp.patch
queue-6.1/mptcp-pm-reuse-id-0-after-delete-and-re-add.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-id.patch
queue-6.1/selftests-mptcp-join-test-for-flush-re-add-endpoints.patch
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
queue-6.1/mptcp-avoid-duplicated-sub_closed-events.patch
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-readd.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-closed-subflow.patch
queue-6.1/selftests-mptcp-join-check-re-re-adding-id-0-endp.patch
queue-6.1/mptcp-pm-fullmesh-select-the-right-id-later.patch
queue-6.1/selftests-mptcp-join-no-extra-msg-if-no-counter.patch
queue-6.1/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
queue-6.1/selftests-mptcp-join-check-removing-id-0-endpoint.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add_addr.patch
