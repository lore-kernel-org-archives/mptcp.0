Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4F1DC04C;
	Wed,  4 Sep 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460409; cv=none; b=jJhs3lamrODRI2whUn1/XWv9vt4INwyVKWYoIGjI4qSN5ZDdb9Dh8p6H2T3s5Xx4rfuEOo6WemAQNat67mroKKB4R6JfayGBFE/Y3liJaAPddxFK78VPqY6qeVMRw8vI3ns9CsaRgkUnUg4FHYBVqoTp0Lmpvvqsd0cTh6vmFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460409; c=relaxed/simple;
	bh=30GUW7QVJB+QIia9SvGc0NS6Q6/f9zE78ow00ZJGqNc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=tbwZhkpoZ+We0jAIh5juA7FzAbX+tVcAuF1LOWVDeCyfC4Wrhro0Edm991dHPjyTeUEjnz+5KDBbe7136AHxm1zORlH/Cl0/XlYqQSFiC9i9T8DVVS3UzD06sPejrVUYdr4eexxcmhs5C2If7KL/415KnWAuH6Nb4gsmJg5VOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wWzwrm0E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wWzwrm0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12A1C4CEC3;
	Wed,  4 Sep 2024 14:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460409;
	bh=30GUW7QVJB+QIia9SvGc0NS6Q6/f9zE78ow00ZJGqNc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=wWzwrm0EktfziHe5l1C2+ClYEYxYGNi0YYra3Djmh8c77ih+aw4Fn1FCTX5Yo/2XM
	 JmwdgBEAFTVtnyMd/Itp445qYnpVPhpTSNN+M16d080Acx5rAWx7tw38vHUR8JeFY6
	 UsWRwnzOzWCflbnQP+GJiAyNjaRLHEVVLYev2c10=
Subject: Patch "selftests: mptcp: join: validate fullmesh endp on 1st sf" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Sep 2024 16:32:53 +0200
In-Reply-To: <20240904110430.4084188-2-matttbe@kernel.org>
Message-ID: <2024090453-direction-cage-c61e@gregkh>
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

    selftests: mptcp: join: validate fullmesh endp on 1st sf

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-validate-fullmesh-endp-on-1st-sf.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-73007-greg=kroah.com@vger.kernel.org Wed Sep  4 13:04:50 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed,  4 Sep 2024 13:04:31 +0200
Subject: selftests: mptcp: join: validate fullmesh endp on 1st sf
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240904110430.4084188-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 4878f9f8421f4587bee7b232c1c8a9d3a7d4d782 upstream.

This case was not covered, and the wrong ID was set before the previous
commit.

The rest is not modified, it is just that it will increase the code
coverage.

The right address ID can be verified by looking at the packet traces. We
could automate that using Netfilter with some cBPF code for example, but
that's always a bit cryptic. Packetdrill seems better fitted for that.

Fixes: 4f49d63352da ("selftests: mptcp: add fullmesh testcases")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-13-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because the 'run_tests' helper has been
  modified in multiple commits that are not in this version, e.g. commit
  e571fb09c893 ("selftests: mptcp: add speed env var"). The conflict was
  in the context, the new line can still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3023,6 +3023,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
 		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1


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
