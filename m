Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8FA321F29
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435441; cv=none; b=JqtMB97yqCKkShv6sk7KnvA9RhtTBwjuleqRzS8mtAJxAs+hjS5PKOz7C4LkLFvh65RSgv/BJZDBMfKjaG+IDlw6h+FCpw+icFk00uQzu/qEijveZiH6pfTzCRh7TZj8mWSzUUkzMxzdre/6ZrCH0WjSnVGJtAMnVuBA4uEA+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435441; c=relaxed/simple;
	bh=h5EBAoL8c5IbJUS7ZPFt6K9TMF5J3+GeZFUnOK3HyM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKRINRqj9CE2G3K99eGAfjNJWosbI3EjLCwmvi/eJwa4gerkClXK65zipWiqAlyi5wTMcqoz9iJrRIQutbVhO7RVqaEjQ4LO5a3cS5E2j2niTqdPOx2BCfzxj2vESDDFM2XQ1KwIeJWz61bMTKSzt1zxml/xxulP1qSKksTeFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7tBNKoE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7tBNKoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ED3C4CEF4;
	Tue,  9 Sep 2025 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757435441;
	bh=h5EBAoL8c5IbJUS7ZPFt6K9TMF5J3+GeZFUnOK3HyM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a7tBNKoEpJnxdguZpYK00srEFox2H7dhm6IEMaiwB0U8vd49N3RiX+9eRP+VOe46q
	 K3o9kL9+gles6glFvhPXZ2CHW+OtDgzCSaCu4OlrHI/DJPHnhsi7XLQwg+iZcmOmO3
	 mypoU3f7ujs7Z47CnuoEeOwTIc+Crj87CjscG14V5gRU9fDhoLyx3n49x1Q7o8syBN
	 KLVd+BEQj41B4omCvKiNG+lpnzsJ00kWlk+J01ZmWiL1L/ClUNM0rzW8TIJHjpdfaM
	 6x5M2cMj/ez6QMu46ti0GhW6cG7N1uy1upaX5pK1Jr831Pl/Fsd3jaIiW7M9ibB9T0
	 5e15WPkGJE20A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 18:30:15 +0200
Subject: [PATCH mptcp-next 3/4] mptcp: pm: netlink: deprecate server-side
 attribute
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-server-side-flag-v1-3-cb8e2b8d1c0c@kernel.org>
References: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1413; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=h5EBAoL8c5IbJUS7ZPFt6K9TMF5J3+GeZFUnOK3HyM8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOhOkYXdq9PVdy96nuysnb2j5GZHAuOr0lVufKc24d4
 Vh2WZ6zHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZ0cPIcIJLdM9CCZsnW7Jf
 6nG91LTr2r7n5pe+y3a2kVGTpbqfuTH84Xv/yfO+3JV9KuLH5suJWu6tXZsUXKu8N3SZX8mFKeu
 vsAEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Now that such info is in the 'flags' attribute, it is time to deprecate
the dedicated 'server-side' attribute.

It will be removed in a few versions.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 1 +
 net/mptcp/pm_netlink.c                    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index fc47a2931014c0304efd3215cc24485ea22e1ede..ba30a40b9dbf2d2d4f25cc07b309ea560712f65e 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -266,6 +266,7 @@ attribute-sets:
       -
         name: server-side
         type: u8
+        doc: "Deprecated: use 'flags'"
 
 operations:
   list:
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index aa0c73faaa6acad3fd66ea0942726ecd4d0abcc0..d5b383870f79956ce5e10bf384695621604f3ce9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -416,7 +416,7 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (READ_ONCE(msk->pm.server_side)) {
 		flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;
 
-		/* only set when it is the server side */
+		/* Deprecated, and only set when it is the server side */
 		if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
 			return -EMSGSIZE;
 	}

-- 
2.51.0

