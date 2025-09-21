Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9C19F11E;
	Sun, 21 Sep 2025 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475171; cv=none; b=JE1l9m6UY4nKt9HVJuvqGGtbx3xqY/thUOBOcr9cf5nhD7ZdNqDYomgLvQ1sw+aFEpfBcZ9KHl94RZk8VBVvBeEXSQTkoWm4a8Kczkchjo2+EZds5f/NaE3U4Ui3cqG/ZTKidS1VjwDIlGsA2ci76jkEdSRz7n7q2NBbO/agfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475171; c=relaxed/simple;
	bh=/1kI4B14rkBJceHNT1Ck6i8EuAVNbFi8Ytp7sDunepg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=eemMXudK3YTB9xipkLald/eQWYOLFCKAdOGrm+Aw/rFByx3i4LDPyJuUfKQlxR5NVrw7+ICvyJf7DDASYzzF47Z26DTuyGucCkRJfOyDit4sEh/YApsqQdsD6REnVzYiJdkGCizvr3i+mv6U4GsNgalCHB13nftJ+ywMJVpiL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q2ZeLM62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q2ZeLM62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C6C4CEE7;
	Sun, 21 Sep 2025 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758475171;
	bh=/1kI4B14rkBJceHNT1Ck6i8EuAVNbFi8Ytp7sDunepg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=q2ZeLM62Qt7EijyXfgLsiCoJSZ5L94NJJ9mYq8F8ATDd/Eo4f9nL5N8WwLh5ahkt9
	 ougaTvHeLEwiPaDB0Vk6XJ2j/T5gLGfeCiexoogiADXvvuT0fg5Z8eusnh4bcInK8S
	 qhEFEMrNqHh7VZNo7n16qFmjHWW3kRQKrdkeO+vw=
Subject: Patch "mptcp: pm: nl: announce deny-join-id0 flag" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,marek@cloudflare.com,martineau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 19:19:21 +0200
In-Reply-To: <20250919223819.3679521-5-matttbe@kernel.org>
Message-ID: <2025092121-unveiled-unsubtle-9aa3@gregkh>
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

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-pm-nl-announce-deny-join-id0-flag.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Sat Sep 20 00:38:37 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 20 Sep 2025 00:38:21 +0200
Subject: mptcp: pm: nl: announce deny-join-id0 flag
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Marek Majkowski <marek@cloudflare.com>, Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250919223819.3679521-5-matttbe@kernel.org>

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
[ Conflicts in mptcp_pm.yaml, and mptcp_pm.h, because these files have
  been added later by commit bc8aeb2045e2 ("Documentation: netlink: add
  a YAML spec for mptcp"), and commit 9d1ed17f93ce ("uapi: mptcp: use
  header file generated from YAML spec"), which are not in this version.
  Applying the same modifications, but only in mptcp.h.
  Conflict in pm_netlink.c, because of a difference in the context,
  introduced by commit b9f4554356f6 ("mptcp: annotate lockless access
  for token"), which is not in this version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/mptcp.h |    6 ++++--
 net/mptcp/pm_netlink.c     |    7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -81,6 +81,8 @@ enum {
 
 #define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
 
+#define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
+
 #define MPTCP_PM_ADDR_FLAG_SIGNAL			(1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
@@ -132,13 +134,13 @@ struct mptcp_info {
 
 /*
  * MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *                      sport, dport
+ *                      sport, dport, server-side, [flags]
  * A new MPTCP connection has been created. It is the good time to allocate
  * memory and send ADD_ADDR if needed. Depending on the traffic-patterns
  * it can take a long time until the MPTCP_EVENT_ESTABLISHED is sent.
  *
  * MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *			    sport, dport
+ *			    sport, dport, server-side, [flags]
  * A MPTCP connection is established (can start new subflows).
  *
  * MPTCP_EVENT_CLOSED: token
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2252,6 +2252,7 @@ static int mptcp_event_created(struct sk
 			       const struct sock *ssk)
 {
 	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token);
+	u16 flags = 0;
 
 	if (err)
 		return err;
@@ -2259,6 +2260,12 @@ static int mptcp_event_created(struct sk
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

queue-6.6/mptcp-tfo-record-deny-join-id0-info.patch
queue-6.6/mptcp-pm-nl-announce-deny-join-id0-flag.patch
queue-6.6/selftests-mptcp-connect-catch-io-errors-on-listen-side.patch
queue-6.6/selftests-mptcp-avoid-spurious-errors-on-tcp-disconnect.patch
queue-6.6/mptcp-set-remote_deny_join_id0-on-syn-recv.patch
queue-6.6/selftests-mptcp-sockopt-fix-error-messages.patch
queue-6.6/selftests-mptcp-userspace-pm-validate-deny-join-id0-flag.patch
