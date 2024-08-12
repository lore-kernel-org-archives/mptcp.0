Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19316D9AE;
	Mon, 12 Aug 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466716; cv=none; b=A091NmRWmPkwqDmA62ETQko8BW9gUyG2cKn1KS5HUhQwlriVWm9MlVj755iF48L4cVBSfN6SWw8Et+xTv1rRm5kqnM38/Jj0UrqVyu5bMZ2tBd0ilEFyOwUZNm31BS/eW/RX+b5iDKax0hVunvzh7osck45PoD4ePcLtwZa+wcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466716; c=relaxed/simple;
	bh=OspWTV924ijdEEsZ47khZwdDjzoKj6MDxD80H/qPdCs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=jWPEVngbxVWUTkl9Egd7gorm57jR63lcXPmLaqXfZInGaIk6aNtP2Nvrf6SJQn/TaVuUVgYCH4RN9CpcTW4RanS7B7bED8GReUwk+O7i1JWCY7nNKr19rUygIERtn5qQqPLsnojSPnBKxx6JFEo7PKaUS33Gq5U/FMJpxMLngBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PMq1k3wy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PMq1k3wy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A0C32782;
	Mon, 12 Aug 2024 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466716;
	bh=OspWTV924ijdEEsZ47khZwdDjzoKj6MDxD80H/qPdCs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=PMq1k3wyOTq+S9SUTrJqkuZ890KJ1fDO/XbpTjP8zyohzm27O8w7Q4t46gjVDTgCf
	 T7HqNp5c1H2rIGTCFyw5GBaN4WZVlJtRFxlrjKvlOjkjfiv80NrDlv4Jy4imy4c2eA
	 q29iUYhNe2I3chOEADdQS9JG6CC3Ln4UiLFwhiIM=
Subject: Patch "mptcp: mib: count MPJ with backup flag" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:44:53 +0200
In-Reply-To: <20240809105514.2902623-2-matttbe@kernel.org>
Message-ID: <2024081252-rejoice-sprint-8dd3@gregkh>
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

    mptcp: mib: count MPJ with backup flag

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-mib-count-mpj-with-backup-flag.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-66252-greg=kroah.com@vger.kernel.org Fri Aug  9 12:55:30 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri,  9 Aug 2024 12:55:15 +0200
Subject: mptcp: mib: count MPJ with backup flag
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <20240809105514.2902623-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 4dde0d72ccec500c60c798e036b852e013d6e124 upstream.

Without such counters, it is difficult to easily debug issues with MPJ
not having the backup flags on production servers.

This is not strictly a fix, but it eases to validate the following
patches without requiring to take packet traces, to query ongoing
connections with Netlink with admin permissions, or to guess by looking
at the behaviour of the packet scheduler. Also, the modification is self
contained, isolated, well controlled, and the increments are done just
after others, there from the beginning. It looks then safe, and helpful
to backport this.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in subflow.c because the context has changed in
  commit b3ea6b272d79 ("mptcp: consolidate initial ack seq generation")
  and commit 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
  which are not in this version. These commits are unrelated to this
  modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/mib.c     |    2 ++
 net/mptcp/mib.h     |    2 ++
 net/mptcp/subflow.c |    6 ++++++
 3 files changed, 10 insertions(+)

--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -16,7 +16,9 @@ static const struct snmp_mib mptcp_snmp_
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynBackupRx", MPTCP_MIB_JOINSYNBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckBackupRx", MPTCP_MIB_JOINSYNACKBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -9,7 +9,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNBACKUPRX,	/* Received a SYN + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKBACKUPRX,	/* Received a SYN/ACK + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -135,6 +135,9 @@ static void subflow_init_req(struct requ
 			return;
 	} else if (mp_opt.mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (mp_opt.mp_capable && listener->request_mptcp) {
@@ -347,6 +350,9 @@ static void subflow_finish_connect(struc
 
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
+
+		if (subflow->backup)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.10/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.10/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.10/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.10/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.10/mptcp-sched-check-both-directions-for-backup.patch
queue-5.10/mptcp-export-local_address.patch
