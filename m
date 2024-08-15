Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A356BA53
	for <mptcp@lists.linux.dev>; Thu, 15 Aug 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754765; cv=none; b=T2r3NbyiR/tkg2QJmIxvM/SXucU4Yop+rbgiZM3170rjrcoWtWtKQ72ZCr72GzkK/InKb8b0KB/PL7BMYM1TBeQfMfg1rlEvk3kmUt/T4uIvS4XZ1z9VTNyaK9/QORWdRPBVcgKeavksfXVhZ/iDQrzhmniIGeGwS1PaplyI1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754765; c=relaxed/simple;
	bh=LVAGW+m51cX5GlqSgTa+wBpD22XWDMdDSNnxUUITNx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGbbkvlo6vEwkWT63TtMC8ZOHVmu02AYQIDmH2moFjbhzsHgNQx65ygW29E1z5432qdOCS0CHFyy4RxpsFyL7bW/1SHT9BRimxtKV7aUyDx+7N2lK21trHX7kd/ax2ozn2R69umc41sCNhW6Yhpmzo+5bkPxaXyOJpqEa38PD0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrBFqPmO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrBFqPmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F9AC4AF0B;
	Thu, 15 Aug 2024 20:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754764;
	bh=LVAGW+m51cX5GlqSgTa+wBpD22XWDMdDSNnxUUITNx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UrBFqPmOKwL/mDLrUXyczw24giXaeGfJPthNoLLvhOBFAhRon/V4Y6uQWDvJaCENg
	 KfvLPWwP7VSKZyuQDaOrD+qjAIczrPU64JETQi2hLXCwd/+cGEfM4RX3Mya39iw7IS
	 4k9Ns50kQq66vQGSPkf6RtgqRB7EzX0Zg8vLD9f8DtdutArbyo/axauU3mwQGlh1zu
	 aOpQodPpKRmSLf8kN7eGaQLYsJU6jbrjID0/f4N/nUgHYD97g+O23H6A3Zwns8zTOe
	 WTodbjwjdawW2C91sHbZex7ubx/zmImwhPS8zslLolaf4oLI44Fa+DF/oaL85vK6h8
	 u7SJFgeUUuzpA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Aug 2024 22:45:42 +0200
Subject: [PATCH mptcp-net 01/10] Squash to "mptcp: pm: re-using ID of
 unused removed ADD_ADDR"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-mptcp-dup-close-evt-v1-1-5a551d3a66cc@kernel.org>
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LVAGW+m51cX5GlqSgTa+wBpD22XWDMdDSNnxUUITNx4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvmkJkQ6h+5tGjlDhcrlgOmZuFFD8CCOy3oaSd
 DC8bbPsw8aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr5pCQAKCRD2t4JPQmmg
 c2RKD/9rPY51m/4IIb4K2BF6qaDjps/7lsymHULoeuxPwA7dNVFbmc/PixzA41oVxNxuT2Ujfic
 43NzJnbcmvqtd4SUwzg44v7a7+WkM9L9bHX75HKJsWfRqNHGdAWq9Y0pmds/Hn5C++UMjVbacKa
 IqWTy+feTGNUWI9qKL/uiwt59p6jbQzS1IZvymS8kzTpcEGnpbJmXIhlF7ifCxgr2fHZJLkuUvM
 gp8GL68mAdZqKVbpqqeYe03nTQ3cL9pTGB7gi1NXAaUOewnkbE47hgcFxjuYW51lVXYSh+uI7no
 Ohs1wW2M3MALk7TJaPobSK4sy9rl6bsIbgBdlZA+xfDpfTlQip2djInzriuIjcxrG52LBg3DwmC
 mcnFbZpBivhVUwDUpB6L8N4E8+cw8C+SC0BwirrPvvQcHz6ihRoe/dnsteabvUSNfEbgB3+fO+Q
 mjV7/oOP1ZCLaxQGfZfhqXOQq8pjx9I8wW/5Hfh8lxsPKQBmGWspICgKArppnPa1zPYWeoyDrwh
 KPMTy1agEVFUqkglm5pVmqD9czYb3DTzxa4Uwe8d4xGhovsuY0EX8iGOGuUxVbbk/qJBoy6a4gm
 h4PbbApK6baLWh31iU/l32DxsbcHnrnOeSh/+eVuWO7h72TuazwRJv3B5R1GA636iYHg/EWyfgQ
 /v0fLFWcIvFC88w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When removing an announced ADD_ADDR, the ID should be marked as
available only if it was announced before. Otherwise, local_addr_used
will not be decremented when removing the endpoint.

That's somehow the behaviour we had from the original patch, before the
previous Squash-to patch [1].

Link: https://lore.kernel.org/20240802-mptcp-pm-avail-v6-1-964ba9ce279f@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d3b1b459e6f3..0881983f505d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1455,8 +1455,10 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
-		__set_bit(addr->id, msk->pm.id_avail_bitmap);
-		msk->pm.add_addr_signaled -= ret;
+		if (ret) {
+			__set_bit(addr->id, msk->pm.id_avail_bitmap);
+			msk->pm.add_addr_signaled--;
+		}
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}

-- 
2.45.2

