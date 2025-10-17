Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFBF335082;
	Fri, 17 Oct 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712635; cv=none; b=V6gWwQpxC5/08IUSqYRcBncmk10ibC83NnaWSFHXOIIW1XRC40Bk0PHIXBVjP/3/4yOESFvw/87wVfLOuITryCPwFuC2PYCEv/AGxf5iHF6UlsdGlQgsC/KaBl9VNyLPMgtbSZpnSmJCOKc3V0xe7FExqOU2j18DQauRnGpDlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712635; c=relaxed/simple;
	bh=1VlzfByCdU4Gdqa1SQyDQyGaeOFMsc0jd3ttAdYq09U=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DQeZ3i+ZMLpgL+OIcYDyNyZBFhpJUCd3xAf6XRrWLMR/ISFjDgW52oRapFjnfQkZzPa+HHO1XrKZvaHMbgQ4AID2iLhiZNT7vullGkrldq0TBJADZGn243THDM3kWJXPys4+9AxaEscGBNfxLb643vjjj0SxnmlGrThLd2rX8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLHkqGT/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLHkqGT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1AC4CEE7;
	Fri, 17 Oct 2025 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760712635;
	bh=1VlzfByCdU4Gdqa1SQyDQyGaeOFMsc0jd3ttAdYq09U=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=xLHkqGT/s+15QaVzkuHPex/1DPs/MejDRGr/GBRX/kioyprpfi7uGl2Ge2fFROj+v
	 qYxWNXmGDCK+miZEKZyZMDOUTjIK2XksMmeIf/Aa0bFC4ZykqKqxeKtt1YHoDlL9D7
	 03VWNyxzTQHCPWhPTNlZXMPN/nbekTjL9sjCpYCg=
Subject: Patch "selftests: mptcp: join: validate C-flag + def limit" has been added to the 5.15-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 17 Oct 2025 16:50:24 +0200
In-Reply-To: <20251017143949.2844546-6-matttbe@kernel.org>
Message-ID: <2025101724-smith-crayon-f29b@gregkh>
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

    selftests: mptcp: join: validate C-flag + def limit

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-validate-c-flag-def-limit.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-186342-greg=kroah.com@vger.kernel.org Fri Oct 17 16:43:01 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 16:39:52 +0200
Subject: selftests: mptcp: join: validate C-flag + def limit
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20251017143949.2844546-6-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 008385efd05e04d8dff299382df2e8be0f91d8a0 upstream.

The previous commit adds an exception for the C-flag case. The
'mptcp_join.sh' selftest is extended to validate this case.

In this subtest, there is a typical CDN deployment with a client where
MPTCP endpoints have been 'automatically' configured:

- the server set net.mptcp.allow_join_initial_addr_port=0

- the client has multiple 'subflow' endpoints, and the default limits:
  not accepting ADD_ADDRs.

Without the parent patch, the client is not able to establish new
subflows using its 'subflow' endpoints. The parent commit fixes that.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250925-net-next-mptcp-c-flag-laminar-v1-2-ad126cc47c6b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because many different helpers have been
  modified in newer kernel versions, e.g. in commit 03668c65d153
  ("selftests: mptcp: join: rework detailed report"), or commit
  985de45923e2 ("selftests: mptcp: centralize stats dumping"), etc.
  Adaptations have been made to use the old way, similar to what is done
  just above. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1826,6 +1826,16 @@ deny_join_id0_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
+
+	# default limits, server deny join id 0 + signal
+	reset_with_allow_join_id0 0 1
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "default limits, server deny join id 0" 2 2 2
 }
 
 fullmesh_tests()


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-pm-in-kernel-usable-client-side-with-c-flag.patch
queue-5.15/selftests-mptcp-join-validate-c-flag-def-limit.patch
