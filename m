Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDF1DA631
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702710; cv=none; b=I7flDG3YGvLpFwXoGmHAcAom8uTRT6f1BILht3nVM6D6wJMX6vrOWlIGtFLkcHD1zqGccPoyKWSDtE9SKrCCZP4ULy6ymNSObcsvYRDGGJE/MuniunNb/hK0FY/gKERFn1c7oNDDVfwlQrdbEGO8pD/+SW+J+JaR4FbzRxWrb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702710; c=relaxed/simple;
	bh=KuNv0+rd3Q6a++xI+nDM0W/N89DQMle6c7EhV18iqXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqdPMZMKRWf88fxzdw6mXq+aTWsx2awEC7XFubJ9xf3+BtnMS6YgvT6vFtPlTQWt8jq3ChdkF43xOWMmFFpCNka49V5jilMyVdxzoPT/NXmxnOy6BqPSZojbuVhHlfara54wh4CAdOdPi+eJmed7YWASrW27LA7diMy2DTAnYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK4VtTSE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK4VtTSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769B9C4CED2;
	Fri, 24 Jan 2025 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737702710;
	bh=KuNv0+rd3Q6a++xI+nDM0W/N89DQMle6c7EhV18iqXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qK4VtTSE5QkEzi1Q588Y6lHJlqDuxmKm4+qmBbiya/PIqtcmHs1/a8Qo2FtOD3EYF
	 ZHprKRbLWgRQn8uSaYm5l0qO+SzTl4gptUm6qD8szTnsgRxY6hRVDXLxd2vztYbMaO
	 /7G3Cw5kBk9k0Iq7+mfZSn+PxxksK2c8nTN0qrUECPqln3PTWGmo2MDYNBrDx9TR/n
	 QY3boQ/pzQdZgIp4QtpCy4pZsOiIfdLmoZDmLSFjdL0Rexc95OThxqBjGiDbnItGUR
	 ETU3jnmEgmuAX13ozXBFgeAKzNcm7B92CP9Nf9jdM3llj+BkX9NMrxc6Gyi9LUXIPb
	 i5Ao5+mWhXxNA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/5] mptcp: use ipv6_addr_equal in addresses_equal
Date: Fri, 24 Jan 2025 15:10:47 +0800
Message-ID: <6f6f731472cb7ac93f1e1689902673ebfee922ed.1737702298.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737702298.git.tanggeliang@kylinos.cn>
References: <cover.1737702298.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use ipv6_addr_equal() to check whether two IPv6 addresses are equal in
mptcp_addresses_equal() is more appropriate than using ipv6_addr_cmp().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1462dc7e886d..6461aa742385 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -64,7 +64,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			addr_equals = a->addr.s_addr == b->addr.s_addr;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else
-			addr_equals = !ipv6_addr_cmp(&a->addr6, &b->addr6);
+			addr_equals = ipv6_addr_equal(&a->addr6, &b->addr6);
 	} else if (a->family == AF_INET) {
 		if (ipv6_addr_v4mapped(&b->addr6))
 			addr_equals = a->addr.s_addr == b->addr6.s6_addr32[3];
-- 
2.43.0

