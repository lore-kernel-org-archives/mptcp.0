Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8FB1547C9;
	Sun, 21 Sep 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758474805; cv=none; b=Hq99UpkiqNYr+7uRqmid39Otj/ckBEUWvGLiw7JCxzvde+qhRRZsEZdlmbAtBBA+W3teLbX/n1sttVd4nMjcDG25kZwIQVkhhgq5BQzQ3tgYZUwKJTFZIIPmUl07n7+HFelJBs9Mhzve1AXXUcGseoISUFGyoGGhf09+bINfwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758474805; c=relaxed/simple;
	bh=W9N7Wc+59gkFccuImeoL6tSU1cueiwifSL4lrqYsA1M=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=H/YOKQPVKYnJhrzyhnxak9fua01Zu6nusuIIEIPeJzBgXLAmn6Z56MFO2ACj1zlrdHg2Ixh5y+IKKc50Nic54g7XMCfAJdTkBhGVirv9onURw3nP0osMOxy05yTpq24KQ8kZldl3F9BsK0ThzvtsiDOKGWsb7L2Cfz3qG6pzdrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kA31TPpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kA31TPpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAB8C4CEE7;
	Sun, 21 Sep 2025 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758474805;
	bh=W9N7Wc+59gkFccuImeoL6tSU1cueiwifSL4lrqYsA1M=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=kA31TPpYkIxO0dkD+M96Dl6kEBoR52w54pqb2OiXNngrp2YoRwbcFuHtlWhM5Im2Z
	 nry6bfX05gxRWhEBMe9+NOsf/DK5RtoL4oH20Gwh2xCBZHO1/HKgPUlFmV2GMkC/fs
	 uOf5G/rVW3uV9wo/ysKrMLG5yfehZ04G2DSpj4PY=
Subject: Patch "mptcp: pm: nl: announce deny-join-id0 flag" has been added to the 6.12-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,marek@cloudflare.com,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 19:13:13 +0200
In-Reply-To: <20250919215222.3519719-2-matttbe@kernel.org>
Message-ID: <2025092113-crisping-flaky-79e5@gregkh>
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

    mptcp: pm: nl: announce deny-join-id0 flag

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-nl-announce-deny-join-id0-flag.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-180710-greg=kroah.com@vger.kernel.org Fri Sep 19 23:52:47 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 23:52:23 +0200
Subject: mptcp: pm: nl: announce deny-join-id0 flag
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Marek Majkowski <marek@cloudflare.com>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250919215222.3519719-2-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit 2293c57484ae64c9a3c847c8807db8c26a3a4d41 upstream.

During the connection establishment, a peer can tell the other one that
it cannot establish new subflows to the initial IP address and port by
setting the 'C' flag [1]. Doing so makes sense when the sender is behind
a strict NAT, operating behind a legacy Layer 4 load balancer, or using
anycast IP address for example.

When this 'C' flag is set, the path-managers must then not try to
establish new subflows to the other peer's initial IP address and port.
The in-kernel PM has access to this info, but the userspace PM didn't.

The RFC8684 [1] is strict about that:

  (...) therefore the receiver MUST NOT try to open any additional
  subflows toward this address and port.

So it is important to tell the userspace about that as it is responsible
for the respect of this flag.

When a new connection is created and established, the Netlink events
now contain the existing but not currently used 'flags' attribute. When
MPTCP_PM_EV_FLAG_DENY_JOIN_ID0 is set, it means no other subflows
to the initial IP address and port -- info that are also part of the
event -- can be established.

Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-20.6 [1]
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Reported-by: Marek Majkowski <marek@cloudflare.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/532
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-pm-uspace-deny_join_id0-v1-2-40171884ade8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_pm.yaml, because the indentation has been modified
  in commit ec362192aa9e ("netlink: specs: fix up indentation errors"),
  which is not in this version. Applying the same modifications, but at
  a different level. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml |    4 ++--
 include/uapi/linux/mptcp.h                |    2 ++
 include/uapi/linux/mptcp_pm.h             |    4 ++--
 net/mptcp/pm_netlink.c                    |    7 +++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -28,13 +28,13 @@ definitions:
         traffic-patterns it can take a long time until the
         MPTCP_EVENT_ESTABLISHED is sent.
         Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, server-side.
+        dport, server-side, [flags].
      -
       name: established
       doc: >-
         A MPTCP connection is established (can start new subflows).
         Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-        dport, server-side.
+        dport, server-side, [flags].
      -
       name: closed
       doc: >-
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -31,6 +31,8 @@
 #define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
+#define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
+
 #define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -16,10 +16,10 @@
  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
  *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
  *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side.
+ *   sport, dport, server-side, [flags].
  * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
  *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side.
+ *   sport, dport, server-side, [flags].
  * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
  * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
  *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2211,6 +2211,7 @@ static int mptcp_event_created(struct sk
 			       const struct sock *ssk)
 {
 	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token));
+	u16 flags = 0;
 
 	if (err)
 		return err;
@@ -2218,6 +2219,12 @@ static int mptcp_event_created(struct sk
 	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
 		return -EMSGSIZE;
 
+	if (READ_ONCE(msk->pm.remote_deny_join_id0))
+		flags |= MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
+
+	if (flags && nla_put_u16(skb, MPTCP_ATTR_FLAGS, flags))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.12/mptcp-tfo-record-deny-join-id0-info.patch
queue-6.12/mptcp-pm-nl-announce-deny-join-id0-flag.patch
queue-6.12/selftests-mptcp-connect-catch-io-errors-on-listen-side.patch
queue-6.12/selftests-mptcp-avoid-spurious-errors-on-tcp-disconnect.patch
queue-6.12/selftests-mptcp-userspace-pm-validate-deny-join-id0-.patch
queue-6.12/mptcp-propagate-shutdown-to-subflows-when-possible.patch
queue-6.12/mptcp-set-remote_deny_join_id0-on-syn-recv.patch
queue-6.12/selftests-mptcp-sockopt-fix-error-messages.patch
