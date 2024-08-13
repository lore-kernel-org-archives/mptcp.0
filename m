Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DF19923D;
	Tue, 13 Aug 2024 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553342; cv=none; b=oRj2X7GEAFN6alxVFdmfKnLugdK+KQlcA3OvCUQ9mkHcUWcWQzGW9/gM2usutf25o/qwmtXrAxjFmLfU5PyqUjMfqo3Qwtn23/oY18YzliKKJYuMlHtZJIRiyeuJ8KGnP917rtGPJN8XljZDhOoJxLT0bjhwTdeYHpgM8vEnPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553342; c=relaxed/simple;
	bh=2M4wFW5odSMa01Y0StgDeTXr/j4zKDMQoVHQTN4XJ1E=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=No+ENEPZkJm2zfT2bEkeUJDdhDkCVPKrPgDE3nxLj5QpQVHCqaQ19z7CzRkANCKeuAVs9fak/ssLFT6ry5JDzdgy2MuA+ARtcXBSV6jAOlZGpDET3HCYcl8Yp0qYxZm3KZcQjYq6sAj9G5qHvFxYQIMbrcrF3uMD26Bu/V6sSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BfQVs8SC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BfQVs8SC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066A3C4AF0B;
	Tue, 13 Aug 2024 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723553342;
	bh=2M4wFW5odSMa01Y0StgDeTXr/j4zKDMQoVHQTN4XJ1E=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=BfQVs8SC9GUM5JeLnVeS83a9RjU4UwGk6Fg3yIMvi8Y3rv1Xfl4xkwoQZsgk2CMUC
	 irGb+MEkAbu7UFEeVBmCbvNY4XZEbXrEWWd7y6aiws2ZRNrFoUaQzB4ATr3oBXvMNV
	 m3QuBuk0Ycgt5GPK5D3aWk+2D+95R2q5FzjFPnTg=
Subject: Patch "mptcp: fully established after ADD_ADDR echo on MPJ" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Aug 2024 14:48:51 +0200
In-Reply-To: <20240813104642.1210553-2-matttbe@kernel.org>
Message-ID: <2024081351-undercoat-tameness-2416@gregkh>
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

    mptcp: fully established after ADD_ADDR echo on MPJ

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fully-established-after-add_addr-echo-on-mpj.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-67463-greg=kroah.com@vger.kernel.org Tue Aug 13 12:47:13 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 13 Aug 2024 12:46:43 +0200
Subject: mptcp: fully established after ADD_ADDR echo on MPJ
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20240813104642.1210553-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit d67c5649c1541dc93f202eeffc6f49220a4ed71d upstream.

Before this patch, receiving an ADD_ADDR echo on the just connected
MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
resulting in an MP_RESET. That's because only ACKs with a DSS or
ADD_ADDRs without the echo bit were allowed.

Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
we are not supposed to send an ADD_ADDR before because it requires to be
in full established mode first. For the MP_JOIN 3WHS, that's different:
the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
can be received on the recently created one. The other peer will already
be in fully established, so it is allowed to send that.

We can then relax the conditions here to accept the ADD_ADDR echo for
MPJ subflows.

Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in options.c, because the context has changed in commit
  b3ea6b272d79 ("mptcp: consolidate initial ack seq generation"), which
  is not in this version. This commit is unrelated to this
  modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -923,7 +923,8 @@ static bool check_fully_established(stru
 	}
 
 	if (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo)) {
+	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	     (!mp_opt->echo || subflow->mp_join))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/netfilter-nf_tables-bail-out-if-stateful-expression-provides-no-.clone.patch
queue-5.15/pci-dpc-fix-use-after-free-on-concurrent-dpc-and-hot-removal.patch
queue-5.15/netfilter-nf_tables-set-element-extended-ack-reporting-support.patch
queue-5.15/mptcp-fix-nl-pm-announced-address-accounting.patch
queue-5.15/mptcp-distinguish-rcv-vs-sent-backup-flag-in-requests.patch
queue-5.15/mptcp-pm-fix-backup-support-in-signal-endpoints.patch
queue-5.15/netfilter-nf_tables-prefer-nft_chain_validate.patch
queue-5.15/mptcp-mib-count-mpj-with-backup-flag.patch
queue-5.15/selftests-mptcp-join-validate-backup-in-mpj.patch
queue-5.15/netfilter-nf_tables-allow-clone-callbacks-to-sleep.patch
queue-5.15/mptcp-export-local_address.patch
queue-5.15/mptcp-pm-only-set-request_bkup-flag-when-sending-mp_prio.patch
queue-5.15/mptcp-fix-bad-rcvpruned-mib-accounting.patch
queue-5.15/netfilter-nf_tables-use-timestamp-to-check-for-set-element-timeout.patch
queue-5.15/mptcp-fully-established-after-add_addr-echo-on-mpj.patch
