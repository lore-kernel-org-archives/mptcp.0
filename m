Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8793D984
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435441; cv=none; b=RCXOGWGnGaQvJuM+Xw8R8erzoOYjjUSkUM22KsOd6VVQshviHoAU60SoWBi7LHLnWFew4KtiLwTmSZT9iELopYPY0viFrLcX2k4aftMh/VKI1aJOCx6cbRX2RFRds7ArigPQ444VFJa5rmfdjfz2ZBQjHdWyWjXkbhob7Ic519Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435441; c=relaxed/simple;
	bh=cRy72xvnkv5utd+tnwXzYt3aQFsFyahS9CQijmhm/H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jn7u2Cxjj/aQnWG6++QvcJPgWVafDtZ20B1JSk6/xvGf6f6xpF1HXH1sZx6fSL+tL1kJMm+X79/nfrFzMX3x/srRLDAlcBVBh2fNK/88boEGMsv5Rt31FhJRSal0swTJffnoxXZJcWRNjCDftWX082el3ekwU68MNrXtBAipSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCpHqRJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCpHqRJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E4C4CEF9;
	Tue,  9 Sep 2025 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757435440;
	bh=cRy72xvnkv5utd+tnwXzYt3aQFsFyahS9CQijmhm/H8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BCpHqRJDU77As3oU+gPt1cMLD21S347G0qbNorU4fnTKPyCwXBVNazYQysI0kVAfM
	 U6+A/WFAq3hOUbG+MySYIGM2jPI66PJuKGBVg7+/QpLatH9pyXX5rHhbsicw9BBdeh
	 CRbph8jQv53KGybZ7wHV7ztkH0CTR8DEvNz9kzzwjLcUGFf1SxfZBkcOcjaapalqzZ
	 kbsUbvke25S4avDYKI9hLicqU8gl4uIneC5jFVZC+CtQWCkibC8wBoFrSkmaK4dyYk
	 RmV1pJds9qe9e7quX21K4BbiBeYD62MHmgCjjUbhNaF4n8KpooqzPINR6HuiRSfo6Y
	 OvtqQKw0BkkCQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 18:30:14 +0200
Subject: [PATCH mptcp-next 2/4] mptcp: pm: netlink: announce server-side
 flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-server-side-flag-v1-2-cb8e2b8d1c0c@kernel.org>
References: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cRy72xvnkv5utd+tnwXzYt3aQFsFyahS9CQijmhm/H8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOhGllCCbwq3HrzXhQfETa0yu+1nZ76Ym13gsqO+X35
 W8pzs7uKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEi3CyPD/63rzXarX+MtO/K2
 WWHd3WOHpJmShZd8bJ688sLMCd80Ixn+CnAn5VdZP2B1Kum7cPLPfvfE4P5DB0X0pi+99Nj+4tx
 rHAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Now that the 'flags' attribute is used, it seems interesting to add one
flag for 'server-side', a boolean value.

This is duplicating the info from the dedicated 'server-side' attribute,
but it will be deprecated in the next commit, and removed in a few
versions.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 5fd5b4cf75ca1e0099e0effa351507d3ab002f1e..95d621f6d59810126cbc37b1d6baf896a40dd9bc 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -32,6 +32,7 @@
 #define MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED	_BITUL(1)
 
 #define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
+#define MPTCP_PM_EV_FLAG_SERVER_SIDE		_BITUL(1)
 
 #define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
 #define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 33a6bf536c020b59717472aca2d38add26255419..aa0c73faaa6acad3fd66ea0942726ecd4d0abcc0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -413,10 +413,13 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	/* only set when it is the server side */
-	if (READ_ONCE(msk->pm.server_side) &&
-	    nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
-		return -EMSGSIZE;
+	if (READ_ONCE(msk->pm.server_side)) {
+		flags |= MPTCP_PM_EV_FLAG_SERVER_SIDE;
+
+		/* only set when it is the server side */
+		if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, 1))
+			return -EMSGSIZE;
+	}
 
 	if (READ_ONCE(msk->pm.remote_deny_join_id0))
 		flags |= MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;

-- 
2.51.0

