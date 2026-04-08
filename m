Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC43CEB9C;
	Wed,  8 Apr 2026 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655085; cv=none; b=mS5qeo3Ke3SjHGk1agy/BKYfy0Mk/qq1EzapPMGj4UmvQKSpdEMuLjEg1MD5IigCZcalymcjOjA0r3sqZSSd0GOuEwv7xJgh50Za8EN6Ky0K8P8CIntHvxj5Cil8dQic1fIjJXsoQx4qpC7MFEh2uN2HoTIJScaPS5I3GGouNAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655085; c=relaxed/simple;
	bh=ZeDtvD8QZmjvgcXH9yXNYA3hloxCEeiClGkPvzAAGNQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=KDsDxsL8wRhdB7VUKa4MQT4liOyd0DHW4Vz4B5z6UXwyHMgmcCW0LKjgbCOX94YiKhGvq7cq+UL7kYxvkw9eTm26ZhQwvYOB7AjPRXCZoZYlypyFjNI74Rez/K+J8K6eGar5XxsI7YgZFLwIKLQ9g+p9DWBzv7+EtBSu9pB/Mhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i/qg71N8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i/qg71N8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80233C19421;
	Wed,  8 Apr 2026 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775655084;
	bh=ZeDtvD8QZmjvgcXH9yXNYA3hloxCEeiClGkPvzAAGNQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=i/qg71N8OReg52Ol/FssjrEJ/5r+fpWgXOS6n5OGSOm3WZLvDuFi0hh16idgcCaAW
	 swSqvYsbkG+v0nl1bx9sH03ACvPjC2q2/kZN7h+kMQzz9M7mm1NjoVOVhTyb3KTqII
	 I4Ac/L3h2srqMaefpmU4TpHOTrQkAGW/si2UZR9s=
Subject: Patch "selftests: mptcp: join: implicit: stop transfer after last check" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:30:52 +0200
In-Reply-To: <20260324094936.1826804-5-matttbe@kernel.org>
Message-ID: <2026040852-exclusion-draw-169b@gregkh>
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

    selftests: mptcp: join: implicit: stop transfer after last check

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-join-implicit-stop-transfer-after-last-check.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Tue Mar 24 10:50:55 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Mar 2026 10:49:38 +0100
Subject: selftests: mptcp: join: implicit: stop transfer after last check
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org
Message-ID: <20260324094936.1826804-5-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

With this kernel version, the 'implicit EP' MPTCP Join selftest ended
with an error message:

  115 implicit EP                          creation[ ok ]
                                           ID change is prevented[ ok ]
                                           modif is allowed[ ok ]
  TcpPassiveOpens                 2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       315                0.0
  TcpOutSegs                      617                0.0
  TcpOutRsts                      1                  0.0
  TcpExtDelayedACKs               289                0.0
  TcpExtTCPPureAcks               6                  0.0
  TcpExtTCPOrigDataSent           306                0.0
  TcpExtTCPDelivered              306                0.0
  MPTcpExtMPCapableSYNRX          1                  0.0
  MPTcpExtMPCapableACKRX          1                  0.0
  MPTcpExtMPJoinSynRx             1                  0.0
  MPTcpExtMPJoinAckRx             1                  0.0
  MPTcpExtAddAddr                 1                  0.0
  MPTcpExtEchoAdd                 1                  0.0
  MPTcpExtMPFastcloseTx           1                  0.0
  MPTcpExtMPRstTx                 1                  0.0
  MPTcpExtMPRstRx                 1                  0.0
  TcpActiveOpens                  2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       617                0.0
  TcpOutSegs                      315                0.0
  TcpOutRsts                      1                  0.0
  TcpExtTCPPureAcks               308                0.0
  TcpExtTCPOrigDataSent           306                0.0
  TcpExtTCPDelivered              307                0.0
  MPTcpExtMPCapableSYNTX          1                  0.0
  MPTcpExtMPCapableSYNACKRX       1                  0.0
  MPTcpExtMPJoinSynAckRx          1                  0.0
  MPTcpExtAddAddr                 1                  0.0
  MPTcpExtEchoAdd                 1                  0.0
  MPTcpExtMPFastcloseRx           1                  0.0
  MPTcpExtMPRstTx                 1                  0.0
  MPTcpExtMPRstRx                 1                  0.0
  MPTcpExtRcvWndShared            1                  0.0

That's because the test was waiting for the end of the transfer for no
reasons, which ended after a timeout with an error. In this case, the
stats were displayed, but this error was ignored: the end of transfer is
not validated in this test.

To fix that, stop the transfer after the last check, similar to what is
done in the other tests.

Fixes: 699879d5f866 ("selftests: mptcp: join: endpoints: longer transfer")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3429,6 +3429,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		run_tests $ns1 $ns2 10.0.1.1 128 0 0 slow 2>/dev/null &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3441,6 +3442,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+		kill_wait "${tests_pid}"
 		kill_tests_wait
 	fi
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-join-implicit-stop-transfer-after-last-check.patch
queue-6.1/selftests-mptcp-join-check-removing-signal-subflow-endp.patch
queue-6.1/mptcp-fix-lock-class-name-family-in-pm_nl_create_listen_socket.patch
