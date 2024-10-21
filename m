Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE81E3DE5;
	Mon, 21 Oct 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504264; cv=none; b=FmzuAhuaomqgZeTOpAHIVNwrSE7IP4WUv2YszzUnHDk2TcKyLgQY9zGPDOs3j/HrlAFMRJasCSuLdLHtvx7k+BDYTLFIgRdCm3cYDAVagk69rNhJRDwPEJEkYoacUhkVsUGGGUoeh460co9EA8YRGjDRCJNOLXNa41zG4QfInsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504264; c=relaxed/simple;
	bh=FBSCn9XCZ95xVbFI6pD6PvYdMUfDEdUFCn5HkbdPzaE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=MvKI6Fw8xumVReiecQJeHsWmiRUxsKqMKHYmyYpS8C3C5PBnh4Xj2k8taxpH+Bz2zRLxBABbgWyzcGT5mERqNgpRoLzIQFOmLiCMU8BFToduz+YocWoDNenOA4qHK6F41ubQHMJd4eqkZQEMgT3NON59AbRXvdeFVk2kNIj+Kpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGAeDm4l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGAeDm4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694AAC4CEC3;
	Mon, 21 Oct 2024 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729504264;
	bh=FBSCn9XCZ95xVbFI6pD6PvYdMUfDEdUFCn5HkbdPzaE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=VGAeDm4lPvlkIAAni4T5XY7h/gpAud2v/IaqHccQ+OrnoFmBvnF3L5OPM7ZQAz4DO
	 mVYkWgo8CipwY4rUOkL3vsFOT+24WJMYRsbA6N7eEmWQvR+Cu2HnzSZBIBb/lc88Rp
	 9ZPZ5By1ApRrUcemWDyt1pDAL1JdttyziezDq1gk=
Subject: Patch "mptcp: handle consistently DSS corruption" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 11:50:47 +0200
In-Reply-To: <20241019102905.3383483-7-matttbe@kernel.org>
Message-ID: <2024102146-drearily-trash-edbb@gregkh>
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

    mptcp: handle consistently DSS corruption

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-handle-consistently-dss-corruption.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-86910-greg=kroah.com@vger.kernel.org Sat Oct 19 12:29:23 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Oct 2024 12:29:08 +0200
Subject: mptcp: handle consistently DSS corruption
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20241019102905.3383483-7-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit e32d262c89e2b22cb0640223f953b548617ed8a6 upstream.

Bugged peer implementation can send corrupted DSS options, consistently
hitting a few warning in the data path. Use DEBUG_NET assertions, to
avoid the splat on some builds and handle consistently the error, dumping
related MIBs and performing fallback and/or reset according to the
subflow type.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241008-net-mptcp-fallback-fixes-v1-1-c6fb8e93e551@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mib.[ch], because commit 104125b82e5c ("mptcp: add mib
  for infinite map sending") is linked to a new feature, not available
  in this version. Resolving the conflicts is easy, simply adding the
  new lines declaring the new "DSS corruptions" MIB entries.
  Also removed in protocol.c and subflow.c all DEBUG_NET_WARN_ON_ONCE
  because they are not defined in this version: enough with the MIB
  counters that have been added in this commit. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/mib.c      |    2 ++
 net/mptcp/mib.h      |    2 ++
 net/mptcp/protocol.c |   20 +++++++++++++++++---
 net/mptcp/subflow.c  |    2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)

--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -23,6 +23,8 @@ static const struct snmp_mib mptcp_snmp_
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("DSSCorruptionFallback", MPTCP_MIB_DSSCORRUPTIONFALLBACK),
+	SNMP_MIB_ITEM("DSSCorruptionReset", MPTCP_MIB_DSSCORRUPTIONRESET),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -16,6 +16,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
+	MPTCP_MIB_DSSCORRUPTIONFALLBACK,/* DSS corruption detected, fallback */
+	MPTCP_MIB_DSSCORRUPTIONRESET,	/* DSS corruption detected, MPJ subflow reset */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -457,6 +457,18 @@ static void mptcp_check_data_fin(struct
 	}
 }
 
+static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
+{
+	if (READ_ONCE(msk->allow_infinite_fallback)) {
+		MPTCP_INC_STATS(sock_net(ssk),
+				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
+		mptcp_do_fallback(ssk);
+	} else {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
+		mptcp_subflow_reset(ssk);
+	}
+}
+
 static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 					   struct sock *ssk,
 					   unsigned int *bytes)
@@ -519,10 +531,12 @@ static bool __mptcp_move_skbs_from_subfl
 				moved += len;
 			seq += len;
 
-			if (WARN_ON_ONCE(map_remaining < len))
-				break;
+			if (unlikely(map_remaining < len))
+				mptcp_dss_corruption(msk, ssk);
 		} else {
-			WARN_ON_ONCE(!fin);
+			if (unlikely(!fin))
+				mptcp_dss_corruption(msk, ssk);
+
 			sk_eat_skb(ssk, skb);
 			done = true;
 		}
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -702,7 +702,7 @@ static bool skb_is_fully_mapped(struct s
 	unsigned int skb_consumed;
 
 	skb_consumed = tcp_sk(ssk)->copied_seq - TCP_SKB_CB(skb)->seq;
-	if (WARN_ON_ONCE(skb_consumed >= skb->len))
+	if (unlikely(skb_consumed >= skb->len))
 		return true;
 
 	return skb->len - skb_consumed <= subflow->map_data_len -


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/mptcp-track-and-update-contiguous-data-status.patch
queue-5.10/mptcp-handle-consistently-dss-corruption.patch
queue-5.10/tcp-fix-mptcp-dss-corruption-due-to-large-pmtu-xmit.patch
