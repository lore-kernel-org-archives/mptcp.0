Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261334A3A5
	for <mptcp@lists.linux.dev>; Tue,  7 Jul 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442943; cv=none; b=LHedDyafSZJ59c1HzGQtY64B4MU4hddjHr+asH/kqozlQpkOEbsqomoGNy7gUlM6SPVd5Xmk1J2QhLs/xAy0D1UZer8tmm1vO7WvxqdLoFrBIQSVrlSz/NqyqBeZFxW3MZHZLQjEXZYRt/GFqyibC61cwcZ6h/LNP+TXXNdge/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442943; c=relaxed/simple;
	bh=tXP1wN8jtwmL05FRcpvwLFuDaw7xOIG+w1zGsZ3TRyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m/9R2qAlvgrU+8JkkeOli+bJSC5ReGFfvyDYdZhTMU+hoMnTRN56sPwJ9ZuEXnqSNWNOOfKBvMpicDNj9KSakXNxnI2F2q4a0hxzjubm2fr2yIif1GB9oO6BZuM5Mw2Mu6QzHEhXi89VqWJqMtPUQn45XFEKNXcYazUAuAP5WBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAXqFa7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAXqFa7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FB11F000E9;
	Tue,  7 Jul 2026 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783442941;
	bh=BzcYekZioZyp1BCvfqtZqBsRrgmCU5ByGU9JnNH1YxU=;
	h=From:Date:Subject:To:Cc;
	b=jAXqFa7nQS+IqP8PmgYoddKED3vD45mAKzxCFbHGawJGc+08w1T426K43wevuVniD
	 ly5b18k700VjmNO+nsqUA+uCLEt5sX8Jf+Y6ENBE58nEMIDGnlGm/tXvTtAsY/wfTC
	 om/7xkR13VL8CTpNw0eX/y2N1Jl1/EKmlCQbEOz5f4Y0mtF+Rkdc8pfJvg/UUM3FDR
	 ztDRDM86QtyfdBQGpzL8jDDfESfVvpUpxCaJ33HXpVwv7e0I9FKSVJSLlks5tax+Nr
	 FkT/N5l36bu//2+2MdrZN1wVCK3Ag+AU4pC4bHAtG4NIQW6ZRGEIGpREDY16k4rK+S
	 xoA+1uXqOTqWA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jul 2026 18:48:49 +0200
Subject: [PATCH mptcp-net] mptcp: fix BUILD_BUG_ON on legacy ARM config
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-mptcp-opt-fix-config_aeabi-v1-1-f428d0aa0318@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQrCMBAFr1L224UYoUGvIiJp8lJXMAlJKkLp3
 Y32c3hvZqWKIqh0GVYqeEuVFDscDwO5h40zWHxn0kqPyijDr9xc5pQbB/mwSzHIfLewk/DJjzq
 cNWC8oR7IBf3zj19p9yIa3fapLtMTrv3itG1f5wy2kYkAAAA=
X-Change-ID: 20260707-mptcp-opt-fix-config_aeabi-3d62f92ee7d7
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Frank Ranner <frank.ranner@intel.com>, 
 kernel test robot <lkp@intel.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tXP1wN8jtwmL05FRcpvwLFuDaw7xOIG+w1zGsZ3TRyo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJ8df9we68obLT7WKik6mJxXe/V9zff5AqPaTxq4qz13
 2C/J62ko5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJemxj+F5TKF1ypYsgvqPg0
 IyZ6+QSl2gaO45UXroh3BQnNr5/UycjwQ89cqEfk4P7URwvbX1YKeu/6FLLF3WeHrNj3LEumlxc
 YAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 0-day bot managed to find kernel configs that cause build failures,
e.g. when using the StrongARM SA1100 target (ARMv4).

On such legacy ARM architecture, all structures are apparently aligned
to 32 bits, causing build issue here. Indeed, on such architecture,
'flags' size is not equivalent to sizeof(u16) as expected, but to
sizeof(u32).

Instead, use memset(). It was not used before to ensure a simple clear
operation was used by the compiler. But at the end, it shouldn't matter,
and the compiler should optimise this to the same operation with or
without memset() when -O above 0 is used. So let's switch to memset() to
fix this issue, and reduce this complexity.

Fixes: 5e939544f9d2 ("mptcp: fix uninit-value in mptcp_established_options")
Suggested-by: Frank Ranner <frank.ranner@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605312026.Srgsz7Tp-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202607031100.upQfRZTM-lkp@intel.com/
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0ca60314d667..47d4a1b520d8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -571,10 +571,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	bool ret = false;
 
 	/* Zero `use_ack` and `use_map` flags with one shot. */
-	BUILD_BUG_ON(sizeof_field(struct mptcp_ext, flags) != sizeof(u16));
-	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_ext, flags),
-				 sizeof(u16)));
-	*(u16 *)&opts->ext_copy.flags = 0;
+	memset(&opts->ext_copy.flags, 0, sizeof(opts->ext_copy.flags));
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 

---
base-commit: 44982139bcde9e34b46ddca0f91f3da9226ebf9a
change-id: 20260707-mptcp-opt-fix-config_aeabi-3d62f92ee7d7

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

