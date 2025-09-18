Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF11EDA26
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217364; cv=none; b=Wid+CCZOy6mBDkOnhoxcnXWivqGB5/DV7uojd8BvgGkmc1aMRLsG+vdtkPFVVfoB/nddtN6i3E/6OzJ8ND2bvWPlGeoWc9cZg8UpML5H7I1wwBKj8fq2iqaiRUYXipQggqvbZkijEFN+JpzShQRIADpnxYYRdr+RoOh4LTjWMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217364; c=relaxed/simple;
	bh=IO0imr0lXPu+AMjv/YgEapArURTSl0U9KERqY4WfOeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZznPCX2KksVMAn8d78Gzs9DqLbWfJXoNP5bDfGkgDB85eNBRh1A9JILj2FM76NpoZBBmvIqJgHAuOdU5RFcbtXlz4ZNHv820XUIPEFURUwdwPpnrWsiWU79H4pkZNXQzFNr3bulmhR/BSW9mZJQCwS6n24hqC8Dh8rjOj+yrzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMSLON0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMSLON0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70465C4CEF0;
	Thu, 18 Sep 2025 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217363;
	bh=IO0imr0lXPu+AMjv/YgEapArURTSl0U9KERqY4WfOeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PMSLON0slakBFFPBFVOtEtagJ7VMQ3/ZjeSaDUKsAAH4h8rGMFpa/wAWO5ukq/jQO
	 V3NolRc76KxAaNoNBaDicD0g5Xkqk/iAGOdLB4DnZ+k21XzrAdwhZfvVv78ySwr6uU
	 CbosF83biLOrCn8sCDvE3ceCCktuPVug4NU6vXmQ/WEv1a2smK8eCSYt+aRSa2uV+R
	 8D1uywR72DMF4XhFb5cCQSTHuD/XEVQt7J1atovhdepHsEngNTutb86QzPKyMNyTnE
	 2DfmZ31MxZ7Nv4nf7kJ2LzChkND0hv2XHwMJJTZNAEwhjfhOsIsAHXDub84yYp19gw
	 /HtfMFfYB4v3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:17 +0200
Subject: [PATCH mptcp-next 01/10] Squash to "mptcp: pm: in-kernel: usable
 client side with C-flag"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-1-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IO0imr0lXPu+AMjv/YgEapArURTSl0U9KERqY4WfOeM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuLSt8Nxw/0vAnT+s/1+w3/iSUH98A8eWwEknOs5f0
 u+7X9/G3VHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjAR+22MDBd5JI3+MauJbbq/
 7MwJ5WOH3My5eTfcYTK3cNkuWBdtwsfIcHi9X4vEnogJR0P/XryltVtL6lHcxk8+k1k4T99fzPr
 8MgcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The id_avail_bitmap is only used when either the 'subflow' or 'signal'
flag is used, but not with 'fullmesh' only. Here, it is replacing the
'subflow' action, so check if this flag is set.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d7cd89fa6a11a1ea7703edbfbdf2bbe86a6a3054..277f81f38134d07918143331746a50bc316d81ca 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -411,7 +411,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			locals[i].flags = entry->flags;
 			locals[i].ifindex = entry->ifindex;
 
-			if (c_flag_case)
+			if (c_flag_case &&
+			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 				__clear_bit(locals[i].addr.id,
 					    msk->pm.id_avail_bitmap);
 

-- 
2.51.0

