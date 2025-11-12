Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86633B6C7
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964723; cv=none; b=aZqnQ6RO6wt+YTy0XNh97ir9U7ftvnjG1u1Y5CwWmpsdkStNBrRKmL4WAEQSRBX+t3eS7VZU6j3rcdbnxJ2gE+TvZqxxrlgtD6GEuwommppJIsbXTZmh9NXRZJeZF1aJiyLNInVbprBDNKSdBBLM4v+LAoKKoPIRZpnRqMPmj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964723; c=relaxed/simple;
	bh=KlrG62Sp7sx/d6n44I8YUk3pJ2OuRZbUh78BUdQ+B1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5cVWtSKILUMoixG4qs3e5rBmGfDyY+ifL7sAMTq4JJcAhNV/c6TnWiAFNjW/4++Et76vSFKb0KLvm30anGtXqNCRggTXjC5Gly6AOiqdyH8l4EAXEuMDqbpkjgLMo7Xor3reM4cX4IAb9e4hxmKEcxeviF0kba9qSG5DCPdLqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg3i5Bgi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg3i5Bgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E276C4CEF8;
	Wed, 12 Nov 2025 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964723;
	bh=KlrG62Sp7sx/d6n44I8YUk3pJ2OuRZbUh78BUdQ+B1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qg3i5BgiLgQLC3nq8ET963WRqUKHlvMHyeuXMflD+q/ar1WArPqDeFOGzuxRdAZI2
	 DM7l4+5g7Ybk/PA8W4deyauppLmqeZexoqGkFaYJ1GCCxGIXaBE5hMOac+ZhthTW6n
	 bHJlV2WHS9xGRvT64bzTL5qh10ATD9LaS+Tb17gHgqXtX0ZOkSlmf5pLAOfT9o2VjD
	 lfX1OhkzgfQQ3PMtOr0JAU3uyqcf/dzosKFM2R8ij88kAXploCWXSnYlo3WSJXagFE
	 E/lBVJmpY4ON4tNPXUJwWGJirXdEdkDIGiuTZp4evNAw7NxaiDpvrRfbSROsEuaPHu
	 L1WP/KG5+dCVA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Nov 2025 17:24:47 +0100
Subject: [PATCH iproute-mptcp 4/6] mptcp: monitor: add 'server side' info
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-laminar-v1-4-e23dbf584aa4@kernel.org>
References: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
In-Reply-To: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KlrG62Sp7sx/d6n44I8YUk3pJ2OuRZbUh78BUdQ+B1M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFtrwxliqKcpz9jo/n7rUw7TgRY4O7MZ8X/I13b1J+0
 7zyZlx7RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERElzD8r7rt4X3wo9LmM1wP
 7uTnOPa9Zvv2SpHdwOSh0LaNx8yvrWH4n34wcdGVJ3c7E3w/WgsuO5M189imFQa7tt8+O7NB+cH
 R37wA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This info has been added a while ago in the kernel [1], but it was not
displayed in 'ip monitor'.

Now, 'server_side' is displayed if the attribute is defined and set to
true. It looks better to do that instead of showing server_side=0. Note
that from v6.18 [2], this attribute is only defined if it is set to
true.

Link: https://git.kernel.org/torvalds/c/41b3c69bf941 [1]
Link: https://git.kernel.org/torvalds/c/c9809f03c158 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 2908b69e..aaacc0a5 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -536,6 +536,8 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
 	if (tb[MPTCP_ATTR_RESET_FLAGS])
 		printf(" reset_flags=0x%x", rta_getattr_u32(tb[MPTCP_ATTR_RESET_FLAGS]));
+	if (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))
+		printf(" server_side");
 
 	puts("");
 out:

-- 
2.51.0

