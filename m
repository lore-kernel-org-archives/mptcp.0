Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C833EB14
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428433; cv=none; b=HW8tRD3reN3ZBw8z3CDQ481XZAnxjyneK/o5ZkM0nLCcqv1dyJxtv1rgag+s5C+zbvk52u3AKj0fOH9nm/5rhrWsMuOVWj+xMd/d+k9SyrIVPR6VDw+/u0Pv/2f8YaUPvxCtMBvvhBtoEw09JU7yk+4rDBbrdKz2W31Lsy7LAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428433; c=relaxed/simple;
	bh=KJMs/owg2K/+WxGOQz3WbPqoN0gy13nceIjRxNYwCbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIzQu8ZC0LBbtD20bVgclhec+4WU3/48gqg72kLPZuh3Rm7fnbEIbSuc9o8sie/mpw/KhF63y0Tn/eQ9V/eqR2siNmIVw0p+HJHvp5CGq6wE1WhxNL5pDuvaxyoLbdJwik1/0l329+voJLvIKorStd5E9PqbrqHphjGztjmXUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+Y4BCsb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+Y4BCsb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA537C4CEF8;
	Tue,  9 Sep 2025 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428433;
	bh=KJMs/owg2K/+WxGOQz3WbPqoN0gy13nceIjRxNYwCbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a+Y4BCsbXCs/5BDlVEHVF4GHkgDEnvggcBvQbfk9E2Ya1bfPsxPfnw9e+im0RFeie
	 S/xlt+Y2LGxiOcgI7YOP9nMYv0MLXCnJSHN5hk+iXkdpHqZSzJcNvqhlUu6Wbm6bFF
	 cA59G3u04sKrJTzfGfu9L9UiKhPhyyND9L5+XHD8O9DjO9JxPbSPjXUHsp4JHck+nq
	 MBTfxUCRrSoLd5mL04ihk8Zip4/q8942yO2AoUomfyAUovICMixDOOWTQBOcokPEPp
	 XdtbPl1aGUZqGuBVPFAcBcdNqcWiLwYk2OrGCGcYW+d9T6ySBQTYXhwI6ydGX7AgCG
	 NhHXODvgBWtRQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 16:33:32 +0200
Subject: [PATCH mptcp-net v2 3/5] mptcp: pm: nl: announce deny-join-id0
 flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-c-flag-v2-3-a6f9542481c5@kernel.org>
References: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Marek Majkowski <marek@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5286; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KJMs/owg2K/+WxGOQz3WbPqoN0gy13nceIjRxNYwCbQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOWJ3ymt2z/lPzLwGDeSI8t3bFyVlLfVwaPK/I0Up65
 tq3om6iHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOpXsjwP1Jqi13eo51nF61J
 CPTovvyq3fz37zKfhAdO51RMnsm9i2BkuP84iENyDm/2qWrWyyG/F99Nfv/qQcCtkLNi1rbSiae
 juQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - now seen as a 'fix' (Christoph)
 - use 'flags' instead of a new dedicated attribute (Mat)
---
 Documentation/netlink/specs/mptcp_pm.yaml | 4 ++--
 include/uapi/linux/mptcp.h                | 2 ++
 include/uapi/linux/mptcp_pm.h             | 4 ++--
 net/mptcp/pm_netlink.c                    | 7 +++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index d15335684ec3d6256505f2b3887ce5818eb57462..d1b4829b580ad09baf4afd73b67abd7b4ef6883a 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -28,13 +28,13 @@ definitions:
           traffic-patterns it can take a long time until the
           MPTCP_EVENT_ESTABLISHED is sent.
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side.
+          dport, server-side, [flags].
       -
         name: established
         doc: >-
           A MPTCP connection is established (can start new subflows).
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side.
+          dport, server-side, [flags].
       -
         name: closed
         doc: >-
diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 67d015df8893cc1390a483bda034191525b8fef0..5fd5b4cf75ca1e0099e0effa351507d3ab002f1e 100644
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
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 6ac84b2f636ca22935c191c645449fb62b673899..7359d34da446b94be148b363079120db03ba8549 100644
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
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2225b1c5b96666cd4121854c967a7f3a79824047..483ddbb9ec406a3e965376ee5a833ae295896a02 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -408,6 +408,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 			       const struct sock *ssk)
 {
 	int err = nla_put_u32(skb, MPTCP_ATTR_TOKEN, READ_ONCE(msk->token));
+	u16 flags = 0;
 
 	if (err)
 		return err;
@@ -415,6 +416,12 @@ static int mptcp_event_created(struct sk_buff *skb,
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
 

-- 
2.51.0

