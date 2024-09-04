Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0215163D;
	Wed,  4 Sep 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460393; cv=none; b=FVTX/jq3QiawCFmfTqTOwORvKEdWAdcLUonCc5dJDGxtLm2+tvpPa7/RawTqMay8YKJbgU+4VT6xuQVjdZ4nxPqot43xrYtU7fg8q6mZPkfyPhQtN4buEHsqTmq4owuzKBSDZmMkzdsf7HDDt5/BuciCYKwmtH4mHOivq+4X3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460393; c=relaxed/simple;
	bh=1Jxxi7ZDoW7l2sB2kmqvPQC3CfJ+FzvfLxLMen5m5i4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=NM+MGaEqC3S2tTVR31GDLFVusNYfZJmh3lQx1VRGD1Fclb4ZgH0A9C54iuSylJsDecS4klmQz8GAetOgk+oCTwRRqBygj/Lq4axZm4EnOeaCMpbfxHEsq6DqHKmu82iqqWWeahn/9QhroXQHLa6OGivMVhXhjhoa8TwmnI/ywnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CR+c1bns; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CR+c1bns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F94C4CEC3;
	Wed,  4 Sep 2024 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460392;
	bh=1Jxxi7ZDoW7l2sB2kmqvPQC3CfJ+FzvfLxLMen5m5i4=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=CR+c1bns9tZ/W/WmknWdro5LRrFAyzruI/ttFXEtMZLSA0C4jkpjNGts2HyYGaNCy
	 r3TT2PMxxz3OlHH8xuCmT3h7n0R3drCacSIfwFd+Y/zJ6T5OU/N9zq9wvUGeoOpQeb
	 tl0abl3/0NhYC2aV4pS62osUSyiGTUmPbMJ+qkgo=
Subject: Patch "selftests: mptcp: add explicit test case for remove/readd" has been added to the 6.1-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:32:51 +0200
In-Reply-To: <20240904110611.4086328-3-matttbe@kernel.org>
Message-ID: <2024090451-cabana-impulsive-1e09@gregkh>
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

    selftests: mptcp: add explicit test case for remove/readd

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-add-explicit-test-case-for-remove-readd.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73009-greg=kroah.com@vger.kernel.org Wed Sep  4 13:06:37 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 13:06:12 +0200
Subject: selftests: mptcp: add explicit test case for remove/readd
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, "David S . Miller" <davem@davemloft.net>
Message-ID: <20240904110611.4086328-3-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit b5e2fb832f48bc01d937a053e0550a1465a2f05d upstream.

Delete and re-create a signal endpoint and ensure that the PM
actually deletes and re-create the subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
[ No conflicts, but adapt the test to the helpers in this version:
  - run_tests has been modified a few times to reduce the number of
    positional parameters
  - no pm_nl_check_endpoint helper
  - no chk_mptcp_info helper
  - chk_subflow_nr taking an extra parameter
  - kill_tests_wait instead of mptcp_lib_kill_wait ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3239,6 +3239,29 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		chk_subflow_nr needtitle "before delete" 2
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete" 1
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 2
+		kill_tests_wait
+	fi
+
 }
 
 endpoint_tests()


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
queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-readd.patch
queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-closed-subflow.patch
queue-6.1/mptcp-pm-fullmesh-select-the-right-id-later.patch
queue-6.1/mptcp-pr_debug-add-missing-n-at-the-end.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add_addr.patch
