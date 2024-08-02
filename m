Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146FC1AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622671; cv=none; b=QuRsOcoCnPJlr96lweO8s/EEbku/Bo2OLRQoKWBsFsNlIEZDhNL5u/2FWxe96fC2elT3XfuCDdBPifTdZxsRIegNH3yHHdECDIQlaTbUQN/T3y+/2rF7w6SUp/b8rI6Rv3xncWKkzxj0MfSc5bDLOjOHlCO32m9psrRFRJYoA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622671; c=relaxed/simple;
	bh=uM4Gq9zI9UOP2ANRhGukPPi6D3oGnF4sUdpTutMU+ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M17VNvVn2Ao13fpbUcRtAJdnetarJ/fSkvMyydzu+pucDHwKqxPzts1otmGWP1F4lVAAa0/5vRv3VIb3V5H7AcDV6DgY6TDzOKqDL2HU2IIYgQQkB3jIbPPH4huHhsDIeU5qQ19tILUg28feHpDOx3ELuwvPVyjUJCxU7dMiRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoQChIci; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoQChIci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB45C4AF0C;
	Fri,  2 Aug 2024 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622670;
	bh=uM4Gq9zI9UOP2ANRhGukPPi6D3oGnF4sUdpTutMU+ms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GoQChIciaZ6XWPmVFLYr7ZtmmQ2LCCPXdZ86p4/waSwmzjTHUdiqyQtfSq82xBsSu
	 J5/02eqXf0FoVjGNasyn/TaTm0zfUKxoDsLTnprMP/LwXZvG7VzEv0Ud583howc34L
	 w1DT8pWuhFyyJbahQrDUbeKgJKjt4vdCAXRHrqahFhWa7Fa69DaM7Mpcewf8DZfZrk
	 HDYDEoJOX0NsYQ4eR2mAVP558CUD0+DsqiC8emYp7XgNK+NaMj2HRhcx/u6c2vN66d
	 fP1QnRcI/OhwUlKSpSQ9B+JnBpI91TtcUUJSJHvXKj3/E8jRJPFeD28jy5I0ndpZp+
	 elSKaECJ5gSKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:38 +0200
Subject: [PATCH mptcp-net v6 01/11] Squash to "mptcp: pm: re-using ID of
 unused removed ADD_ADDR"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-1-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uM4Gq9zI9UOP2ANRhGukPPi6D3oGnF4sUdpTutMU+ms=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLK38+WAYimf/JdVss+4mN5A4vMfl6t6oXgm
 7gkXy6/PaqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iygAKCRD2t4JPQmmg
 c/5oD/4+gxIaa4+WhOm/ndUFtqj7pv9+Pq3PBPwu/k5GYF4NYM7vqIpp0NMzIU8tSThKZyAuRNW
 PHyiMUF/RaxBP05dcoDyufJ+Pqg0098FY0D3Fd5Jt5e7+UfNdeSAktU6y81Uorc37Uh107yVd9G
 dZ4tzcgOOPbzxba6C6NjLsVBj/HGtONQxlRps4VHKyYJPuJj6VzgRKsSnW5gGrEIHZb5xvfQhQw
 Mf92NTJkSw1GJE+F3O9JdAf3SVRX2l7Y3D2iRE85yoF4DKK7pBbWH7BXP7kPvF2ECHfCJOF3Rl0
 5X0W/8KIaknfGWlush33jHPdxO1dQO2D9KATWAXuBpxE3vZ+81Mk6qW+EVaOGSJ2WGGO5fyqNRk
 K5rSxHAZx5TfhhifmV6mfoZTIbpGVsqTNnlyZl7r+IQJfr7GL++IINHQYV9SUjqpTv0mr4vSbq+
 CZcN2n5EVH/dRaH9uoCe/bVzfuxOdz0rJIDXD2QVGzfXWhpROwiuDGcOIClU+KTdfnbsAEEpWeI
 QOKx5y1rZLUp2evfp1aLo+nEwoNy4/SbA8lWcZwQnujJuVZIukKjxaqa7IatQPBEneLvIi8gRYM
 VEuLMNXPlq3AXC5AYtUeqtJX3Y8O7dBAJ6z5n3P5vbPVYHRxBTCeoH0QorJcY/tEcrBJX898lDg
 P6QHohtteje837w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It looks better to mark the addr ID as available in
mptcp_pm_remove_anno_addr(), where we decrement pm.add_addr_signaled:
this helper is only used by the in-kernel PM (compared to the previous
one), and the mark was only done if an entry was found, which will not
be the case if the entry of the initial subflow is removed while now, it
will be done because 'force' will be set.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 469a16326b3f..3e552b4f1a21 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1423,11 +1423,6 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
-		spin_lock_bh(&msk->pm.lock);
-		__set_bit(entry->addr.id ? : msk->mpc_endpoint_id,
-			  msk->pm.id_avail_bitmap);
-		spin_unlock_bh(&msk->pm.lock);
-
 		list_del(&entry->list);
 		kfree(entry);
 		return true;
@@ -1448,6 +1443,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		__set_bit(addr->id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);

-- 
2.45.2

