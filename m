Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD733EB15
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435440; cv=none; b=KRMTFT/Y7pcwZYyf6q1aIpQzsfyRjxImvpB9RzIBpfFqhHvxsC3Z+CMpjQFT/51+ntRRNSi7OBYAe8uoqUW6mOwmV7VOm3KfeLNfFv4hHRz77asTsEekKWysuv70ffsfW8dzOKG4a8GZr8zjJMhiJNJ12PlnxU/cCbp6UvbJgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435440; c=relaxed/simple;
	bh=BcW/DlHkbdeECwqh/GwccUSfJOwusgerG1DrZQ/WWfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kC/3dcpzayUnr2M/E8pvB/nrgv2y/plFznZ4zhzWWRJkL7QkN2vIR92DwHfT4GNIuuvgACCDGv5Yn+hWN4jWrBPwY/+EXO+z8ku+kXEx5IOV1RT9Ny5OEfZml8MFLEN+coVkfFf3sD+qcnYzBEY5bmcbm6eNAO3RCR6sGHxaRI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNy+e207; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNy+e207"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAFEC4CEF8;
	Tue,  9 Sep 2025 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757435439;
	bh=BcW/DlHkbdeECwqh/GwccUSfJOwusgerG1DrZQ/WWfE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PNy+e207Tdsp+0NNkPGpsV0E206h8+weWhCGAt73c4MCokABag276Wdn8PZZXWUq/
	 MAbWxzNyv9m6sBxSVCZ+W4VXRNRME+N/4xoZilEDV3Gh2LXNHdrMPzZ8ivRie9iaAk
	 1muTKAgbeZr/ypYb0Ch9N26zG7TG/66NYOl0bVLLAkwRQG+zSqEJV15UVektQZbZDo
	 uIH5A2+LIuvJ6zOHnpATLaRWidEfaHUmazUcy6adQ8yQzi5ROorV4qaemDNywEikm0
	 QnlpK47wYK+FeyPdqnBZB9bRffTdQ1EG5uJruHyfotE74ZcNhgvpb84Gu7Au5AEllw
	 phWwZ/mXeAzLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 18:30:13 +0200
Subject: [PATCH mptcp-next 1/4] mptcp: pm: netlink: only add server-side
 attr when true
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-server-side-flag-v1-1-cb8e2b8d1c0c@kernel.org>
References: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4089; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BcW/DlHkbdeECwqh/GwccUSfJOwusgerG1DrZQ/WWfE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOhGkuc9MVtXCfNMUkS+l9JXPvOdOqWeqntD/+8Q5q/
 ndc/sm8jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlssWNk+PS+6+jd6d6SHP/u
 MGu1qqWnLT/H8OLp+TCvL7Gi/3MD6xn+6TgvF3p1/qeFQe1hsxt+ja2y3ju0OFbNWjVr4XKzXRU
 FfAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This attribute is a boolean. No need to add it to set it to 'false'.

Indeed, the default value when this attribute is not set is naturally
'false'. A few bytes can then be saved by not adding this attribute if
the connection is not on the server side.

This prepares the future deprecation of its attribute, in favour of a
new flag.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml         | 4 ++--
 include/uapi/linux/mptcp_pm.h                     | 4 ++--
 net/mptcp/pm_netlink.c                            | 4 +++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index d1b4829b580ad09baf4afd73b67abd7b4ef6883a..fc47a2931014c0304efd3215cc24485ea22e1ede 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -28,13 +28,13 @@ definitions:
           traffic-patterns it can take a long time until the
           MPTCP_EVENT_ESTABLISHED is sent.
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side, [flags].
+          dport, [server-side], [flags].
       -
         name: established
         doc: >-
           A MPTCP connection is established (can start new subflows).
           Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
-          dport, server-side, [flags].
+          dport, [server-side], [flags].
       -
         name: closed
         doc: >-
diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_pm.h
index 7359d34da446b94be148b363079120db03ba8549..bf44a5cf5b5a1e6d789632682a9bedbf8090feb9 100644
--- a/include/uapi/linux/mptcp_pm.h
+++ b/include/uapi/linux/mptcp_pm.h
@@ -16,10 +16,10 @@
  *   good time to allocate memory and send ADD_ADDR if needed. Depending on the
  *   traffic-patterns it can take a long time until the MPTCP_EVENT_ESTABLISHED
  *   is sent. Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side, [flags].
+ *   sport, dport, [server-side], [flags].
  * @MPTCP_EVENT_ESTABLISHED: A MPTCP connection is established (can start new
  *   subflows). Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6,
- *   sport, dport, server-side, [flags].
+ *   sport, dport, [server-side], [flags].
  * @MPTCP_EVENT_CLOSED: A MPTCP connection has stopped. Attribute: token.
  * @MPTCP_EVENT_ANNOUNCED: A new address has been announced by the peer.
  *   Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 483ddbb9ec406a3e965376ee5a833ae295896a02..33a6bf536c020b59717472aca2d38add26255419 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -413,7 +413,9 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
+	/* only set when it is the server side */
+	if (READ_ONCE(msk->pm.server_side) &&
+	    nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
 		return -EMSGSIZE;
 
 	if (READ_ONCE(msk->pm.remote_deny_join_id0))
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 0801d57a9710406a5942af742719f694e3907558..189bfc5bf86611575381542fe59b86660f335294 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -241,7 +241,7 @@ make_connection()
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
-	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
+	   [ "${client_serverside:-0}" = 0 ] && [ "${server_serverside:-0}" = 1 ] &&
 	   [ "${client_nojoin:-0}" = 1 ] && [ "${server_nojoin:-0}" = 0 ]
 	then
 		test_pass

-- 
2.51.0

