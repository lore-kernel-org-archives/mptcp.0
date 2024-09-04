Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE129402;
	Wed,  4 Sep 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460752; cv=none; b=FqdsMh/TSvGU4UFC7CL65dYUW+bcCu0fXlUAaGVd37n5NhVxRJcSGtJZaoC976bdAERWRyTTuDDurTgfl30VwT0Cx7EX8ZzfUrFEXF+JfwKgNTEjGJumSkRUSSBZhqKNT5EkvfvokUL/WOzieSySW2Zkx9A0uqdyoJH5PVuwVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460752; c=relaxed/simple;
	bh=5naRVhnsCq6glFf4fbMGv27t1bQfjLZyTx95HIvgDfU=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=WKeyU6eamINfNWnDSHcuoGnJzG7MFZY3SdQ4awCljmdKRzRL8FTm9qNsWJip6UL9HC6jpN9aFZ31JLSyoYgHbVs6+5gVd7qUnKLPguin/F+3PTQi71KNn46K6/gjs4OPGIaK11OB28py06mVrL4eVxcd/Ut59xn/q+/hNVRynqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dU2HZCQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dU2HZCQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173AEC4CECC;
	Wed,  4 Sep 2024 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460751;
	bh=5naRVhnsCq6glFf4fbMGv27t1bQfjLZyTx95HIvgDfU=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=dU2HZCQ3+ZJOQscKV0DLY9UnuFS+8cKA6Pze9TwkCBOPIW7cFMxa9T0vz5A2fnpZI
	 8fNYNYIeAmihmXH76+bXV4AY99PFNky61JBz4knx2aVsDWgz1qQnV2SjblUXoWBRK1
	 /tg3AMZp4pB0BEO1240eqnvXtZI+fZWtn75xX+oE=
Subject: Patch "selftests: mptcp: join: cannot rm sf if closed" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:39:08 +0200
In-Reply-To: <20240904111548.4098486-2-matttbe@kernel.org>
Message-ID: <2024090408-freezing-dismay-ea2a@gregkh>
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

    selftests: mptcp: join: cannot rm sf if closed

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-cannot-rm-sf-if-closed.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73024-greg=kroah.com@vger.kernel.org Wed Sep  4 13:19:25 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 13:15:48 +0200
Subject: selftests: mptcp: join: cannot rm sf if closed
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240904111548.4098486-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit e93681afcb96864ec26c3b2ce94008ce93577373 upstream.

Thanks to the previous commit, the MPTCP subflows are now closed on both
directions even when only the MPTCP path-manager of one peer asks for
their closure.

In the two tests modified here -- "userspace pm add & remove address"
and "userspace pm create destroy subflow" -- one peer is controlled by
the userspace PM, and the other one by the in-kernel PM. When the
userspace PM sends a RM_ADDR notification, the in-kernel PM will
automatically react by closing all subflows using this address. Now,
thanks to the previous commit, the subflows are properly closed on both
directions, the userspace PM can then no longer closes the same
subflows if they are already closed. Before, it was OK to do that,
because the subflows were still half-opened, still OK to send a RM_ADDR.

In other words, thanks to the previous commit closing the subflows, an
error will be returned to the userspace if it tries to close a subflow
that has already been closed. So no need to run this command, which mean
that the linked counters will then not be incremented.

These tests are then no longer sending both a RM_ADDR, then closing the
linked subflow just after. The test with the userspace PM on the server
side is now removing one subflow linked to one address, then sending
a RM_ADDR for another address. The test with the userspace PM on the
client side is now only removing the subflow that was previously
created.

Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240826-net-mptcp-close-extra-sf-fin-v1-2-905199fe1172@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
[ It looks like this patch is needed for the same reasons as mentioned
  above, but the resolution is different: the subflows and addresses are
  removed elsewhere. The same type of adaptations have been applied
  here. The Fixes tag has been replaced by better appropriated ones. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -957,8 +957,6 @@ do_transfer()
 				dp=$(grep "type:10" "$evts_ns1" |
 				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "$addr" \
-							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))
@@ -1024,7 +1022,6 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -3227,7 +3224,7 @@ userspace_tests()
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_rm_nr 1 1 invert
+		chk_rm_nr 1 0 invert
 	fi
 
 	# userspace pm create destroy subflow
@@ -3237,7 +3234,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 1 1
+		chk_rm_nr 0 1
 	fi
 
 	# remove and re-add


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-join-cannot-rm-sf-if-closed.patch
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
