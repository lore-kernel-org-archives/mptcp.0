Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC643164
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499636; cv=none; b=f98Sx0iPh4n/lJ41LFQbX7zi44DGw5KsNRgXqHNMY94U49YVJMEQ/qJuKRbi482YG/uPh3dGpME4XjM+N8BElYiS5Kfma+BKtdaOjRydjWUiTcTFgwSGygq7cxlYysphsy3RWTu7pvfhDrY7rG7z6p7AtrmxALU6KNQptVqeUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499636; c=relaxed/simple;
	bh=Tq08SLZzDAhqrGXS5HqJEDTMk09WlVZl7E9I2C+nylg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzURBhcySAi/kubV7MDFthzeJ0hoFsCPe0Gf8OHBei6Vnk0Ez5FUrSGTp0Ma3hU4FCeTYAwktPvOwMuknFZT/3Ou+fTg8+kc29l99eWK1jh7aU1+u+0+QUNF3Ls9z4sMR2ONTbp2AOhpKhBDTbqnC1zt4EFaBcviM0MtSH9fNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba522DNr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba522DNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B399FC4CEF6;
	Fri, 29 Aug 2025 20:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499636;
	bh=Tq08SLZzDAhqrGXS5HqJEDTMk09WlVZl7E9I2C+nylg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ba522DNrbRKc9uVANA+cW7gAunOqVaSq77oKbMuB4mr5QmdmBxxKhl+clRLucEgOc
	 4oxJ6bQv2RRYfgZq513++AGvRRp13RcjkJAvuIaWbBFe/gqo9o45kl53hL+wt9Bhoy
	 UM9M93lLS9uTkEbgduEHHp3AvxdqkqnDXQPl959oUE5/BfJ7B6UZM/bOq0Lz3kuCBm
	 /loZjCa7mPfmRH5ZKYg4owZulSXf8xU43gz+Khj0icpJ+X2XUtEqEehU9H8jv2M6XN
	 m3vszdrbRmjSrY7LIW0mcTiBYAGARhQrkgmdQIdhTOI+vrsR35ssiVqIagTuCyryoX
	 N2411qGyhXikg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Aug 2025 22:33:39 +0200
Subject: [PATCH RFC mptcp-net 7/7] mptcp: pm: nl: announce deny-join-id0
 attribute
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mptcp-pm-user-c-flag-v1-7-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5615; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Tq08SLZzDAhqrGXS5HqJEDTMk09WlVZl7E9I2C+nylg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI28a2N+iJfHMlSFLRooeYTfebfHZ8+OK262ZastubB1
 u9zcvp+d5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExE6DDDP/UGs9bO+raTpeuX
 tGczqfx4xPE2YMH8k+wLv91xYzHvvM3wv1A8QzezjYM95xjj7oNmyUw1DF9ydhs7Zl44z73IIlq
 bFQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

During the connection establishment, a peer can tell the other that it
cannot establish new subflows to the initial IP address and port by
setting the 'C' flag [1]. Doing so makes sense when the sender is behind
a strict NAT, operating behind a legacy Layer 4 load balancer, or using
anycast IP address for example.

When this 'C' flag is set, the path-managers must then not try to
establish new subflow to the other peer's initial IP address and port.
The in-kernel PM has access to this info, but the userspace PM didn't.

When a new connection is created and established, the Netlink events
will now contain a new deny-join-id0 attribute. When set to 1, it means
no other subflow to the initial IP address and port -- which is part of
the event -- can be established.

Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-20.6 [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/532
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
This patch is marked as an RFC, just so we can agree on the attribute
type: should we use a new dedicated attribute, or start using flags? It
even looks like we have defined a "flags" attribute, but it is currently
not used. Using "flags" would allow us to save some bytes, and in this
case, 'server-side' should have used "flags" too. The problem with the
flags is that the userspace cannot tell if a new flag is unset because
the kernel doesn't support it, or because it doesn't need to be set. But
is it really an issue? If the kernel doesn't support it, the userspace
will probably not know what to do anyway. So fine to use flags? Or not
needed, because it is unlikely to add new attributes later on?

If yes, I suggest:
- switching 'flags' to u32 instead of u16 because it doesn't change
  anything, and it is currently not used
- deprecating the 'server-side' attribute, and adding it in the flags
  (but keeping it for the moment, maybe we can remove it in a few
  versions?)
- adding deny-join-id0 as a flag: MPTCP_PM_EVENT_FLAG_DENY_JOIN_ID0

If no, we can use what is proposed here.

In any cases, I would like to add a test. I initially added one in
userspace_pm.sh, but due to "mptcp: pm: userspace: respect deny_join_id0
attr", it is no longer possible to set allow_join_initial_addr_port
sysctl knob to 0 there, as the value is no longer ignored by the
userspace PM. Probably best to add a test in mptcp_join.sh.
---
 Documentation/netlink/specs/mptcp_pm.yaml | 7 +++++--
 include/uapi/linux/mptcp_pm.h             | 5 +++--
 net/mptcp/pm_netlink.c                    | 4 ++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index d15335684ec3d6256505f2b3887ce5818eb57462..0b53d8b5b4524b6026009cfa4510e7a6e141acf1 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -28,13 +28,13 @@ definitions:
           traffic-patterns it can take a long time until the
           MPTCP_EVENT_ESTABLISHED is sent.
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side.
+          dport, server-side, deny-join-id0.
       -
         name: established
         doc: >-
           A MPTCP connection is established (can start new subflows).
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side.
+          dport, server-side, deny-join-id0.
       -
         name: closed
         doc: >-
@@ -266,6 +266,9 @@ attribute-sets:
       -
         name: server-side
         type: u8
+      -
+        name: deny-join-id0
+        type: u8
 
 operations:
   list:
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 6ac84b2f636ca22935c191c645449fb62b673899..6c751c488e51d6ab711607189041d5e2ea222e4e 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -16,10 +16,10 @@
  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
  *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
  *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side.
+ *   sport, dport, server-side, deny-join-id0.
  * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
  *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side.
+ *   sport, dport, server-side, deny-join-id0.
  * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
  * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
  *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
@@ -126,6 +126,7 @@ enum mptcp_event_attr {
 	MPTCP_ATTR_RESET_REASON,
 	MPTCP_ATTR_RESET_FLAGS,
 	MPTCP_ATTR_SERVER_SIDE,
+	MPTCP_ATTR_DENY_JOIN_ID0,
 
 	__MPTCP_ATTR_MAX
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 50aaf259959aeaf36e7ab954c6f7957eaf2bc390..93455b63ef80395ff19f40d84cd28438a3578b98 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -415,6 +415,10 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
 		return -EMSGSIZE;
 
+	if (nla_put_u8(skb, MPTCP_ATTR_DENY_JOIN_ID0,
+		       READ_ONCE(msk->pm.remote_deny_join_id0)))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 

-- 
2.50.1

