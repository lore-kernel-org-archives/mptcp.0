Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0503CEBA4;
	Wed,  8 Apr 2026 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655082; cv=none; b=TXKT4oQkvoONNNXqDTmWZMHo48JCU/nCYq+YGlpEoR8e6dkKG4CgM+C3NjGxtXRaDLc3/8CbsbLa37q0ow3kjLpCIhg8MMUtzNcuJWU742YzQt9uKkFGh94E+w550eJRe4P5y+AqpnlISwIakmasewbClktNvzCz6ITodNbcipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655082; c=relaxed/simple;
	bh=aFBPHesMUjdPfj7gghCMt4tXo/PZlYIBahjUL8TvxTE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DT0AlAOZ37VWCje9LKKykrysCIRKp8BS6iHBGYhHUaoM8UPbUsM05tTe/AQRmuWhHfXY3mif6/bg0nk6QvblCHi7F5SbXov3ny15ug17dTkTrktathvnV885WuU3iw8wrmdRD3W6ve+M7DTN3HPaaIapStvMmzqeEguBLLM3nNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PF0RM1nw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PF0RM1nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C93C19424;
	Wed,  8 Apr 2026 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775655082;
	bh=aFBPHesMUjdPfj7gghCMt4tXo/PZlYIBahjUL8TvxTE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=PF0RM1nwONsVnbMH0alPG6D3IDaSpUPH+aXtyTsZG9VkYvhwFQ2/mlhzDeKJnZ4LU
	 lMkf70a+i3zZPagzH78UzIl738jLjgq5uIO3ZP9EyqYwXAqlE6wBVJOGRH9I0x6YUi
	 biQvYZ1Yewsn5ihZho67BObu0ssMXeZv3lTBGl+Q=
Subject: Patch "selftests: mptcp: join: check removing signal+subflow endp" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:30:52 +0200
In-Reply-To: <20260324094936.1826804-6-matttbe@kernel.org>
Message-ID: <2026040852-straw-shifty-e76e@gregkh>
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

    selftests: mptcp: join: check removing signal+subflow endp

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-check-removing-signal-subflow-endp.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Tue Mar 24 10:50:56 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Mar 2026 10:49:39 +0100
Subject: selftests: mptcp: join: check removing signal+subflow endp
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260324094936.1826804-6-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 1777f349ff41b62dfe27454b69c27b0bc99ffca5 upstream.

This validates the previous commit: endpoints with both the signal and
subflow flags should always be marked as used even if it was not
possible to create new subflows due to the MPTCP PM limits.

For this test, an extra endpoint is created with both the signal and the
subflow flags, and limits are set not to create extra subflows. In this
case, an ADD_ADDR is sent, but no subflows are created. Still, the local
endpoint is marked as used, and no warning is fired when removing the
endpoint, after having sent a RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260303-net-mptcp-misc-fixes-7-0-rc2-v1-5-4b5462b6f016@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but in this kernel version 'run_tests' doesn't support
  parameters set via env vars: positional parameters need to be used.
  See commit 595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2
  parameters") and commit e571fb09c893 ("selftests: mptcp: add speed env
  var") which are not in this kernel version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2407,6 +2407,18 @@ remove_tests()
 		chk_rst_nr 0 0
 	fi
 
+	# signal+subflow with limits, remove
+	if reset "remove signal+subflow with limits"; then
+		pm_nl_set_limits $ns1 0 0
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,subflow
+		pm_nl_set_limits $ns2 0 0
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		chk_join_nr 0 0 0
+		chk_add_nr 1 1
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0
+	fi
+
 	# addresses remove
 	if reset "remove addresses"; then
 		pm_nl_set_limits $ns1 3 3


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-join-implicit-stop-transfer-after-last-check.patch
queue-6.1/selftests-mptcp-join-check-removing-signal-subflow-endp.patch
queue-6.1/mptcp-fix-lock-class-name-family-in-pm_nl_create_listen_socket.patch
