Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0D43164
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499633; cv=none; b=GSSvnnyeTAwdgwrsXCpfcs9Sqihq28qflvGu1GOHan1/l0O/d1eMxzbU905tC6AjKFLxDgUvfWY0/HZJg7jqHCw4W8isJBLi4tuJCanQ9OniyYXol54glUx1Da8teY6CtPbCwULBr7BO8JiUmEU8jDFX7pj4ja+F6NyZB65R74s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499633; c=relaxed/simple;
	bh=phkh1oyOpFzwyQWIWC84ieXCahTRZMlNzgz8Cr1mz9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n36jFytExAOlGXgiN1H//+pDfljDssICdSJZ74VoqJqa3sHgmab1cVzlz/jmB6st9SrExoGOA5VmLv99hsPOsCqy4MEfLv1XfYBWPpw2pl1MFuKODrqShFbYMwSMfI/tZwUBaUYZVXcyyCHtxohPnXc41s8tFQwC1moD7/EF6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAHJDDVg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAHJDDVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BDBC4CEF0;
	Fri, 29 Aug 2025 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499633;
	bh=phkh1oyOpFzwyQWIWC84ieXCahTRZMlNzgz8Cr1mz9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NAHJDDVgGdgvzZq7m39u0+CGHV3dQuPYSTTOcYcL+WqzNXzDMilnLWkFrxWP2E7Vm
	 V2fDaBFaGJmJrowiqxgMmBQE3CD2kjuL0KDg15GxeCzgK5cgfcVJANInfocAfZolfh
	 knVER7uu4Gc184uHeYzE4mWcH8iTVSa5anpPlzQSPkWYvivDCNw7WLLpaq0QZc74od
	 AexS3zNJuqT6VVq70YMstEUK1XocgBn0KgR5FsmdkunhrihrHrYavP0P/S2te4EidZ
	 qW6K74jx9z5nHl6zA2xex9We7UCFWGLGRJv32AMB8kjOQszljgHmGaOcOQwFwodZx4
	 SsTjHhnQ+o/HQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Aug 2025 22:33:36 +0200
Subject: [PATCH mptcp-net 4/7] netlink: specs: mptcp: fix if-idx attribute
 type
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-mptcp-pm-user-c-flag-v1-4-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=phkh1oyOpFzwyQWIWC84ieXCahTRZMlNzgz8Cr1mz9E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI28a36uO24leX0jWGv1mq9cWU1mdJ4u3TvrWyv1ddWS
 mxal/VJuKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi0kaMDCufmR3av/kWf6JH
 g9t/2VPNz1kmvmg8Py9ix75pu+ISPWYz/FNpPvWua1Nm6N6jnEeSPl/yKnjOdqTke004R0ug6k7
 GY1wA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This attribute is used as a signed number in the code in pm_netlink.c:

  nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))

The specs should then reflect that. Note that other 'if-idx' attributes
from the same .yaml file use a signed number as well.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 02f1ddcfbf1cfd81a398dd03c52bb9f281c1aa08..d15335684ec3d6256505f2b3887ce5818eb57462 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -256,7 +256,7 @@ attribute-sets:
         type: u32
       -
         name: if-idx
-        type: u32
+        type: s32
       -
         name: reset-reason
         type: u32

-- 
2.50.1

