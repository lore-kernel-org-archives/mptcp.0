Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEECEEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004127; cv=none; b=NXwOGvckH6m0Ye4lEuGG1XiBHbfyGbr0AcKzDOB7mrya6ev5Ac4MkOh6TxcvSgL1//Z5NpBmdZXmOZB3jgRMAJIM+q/MQS0u3jOmfKYaefFZWwwveBaHQ1WQseOT6o2gBY8LcsiKOxQe60wyP9JP/zwTmkUW458JDJA3JQoiSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004127; c=relaxed/simple;
	bh=CTC4imhwpdnjUeig5ztGalOlfqSBGDia+U0aTVysw74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJm/22No6lwWh0u5x7mRYtfgJPVubAx0TuoNachM5reWZ9taaeZEHaKxIpktjqziObHfaNvKAeiWHPMvJGdqCNNwmJAVyz/1M4u9thb27ajLYujadxec2STuT1uQTtSd8z4g61q+A52ytGRaoI0RvYutKFoTzY2gV47D7II+KUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKVHJpdI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKVHJpdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521A8C32786;
	Fri, 26 Jul 2024 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004127;
	bh=CTC4imhwpdnjUeig5ztGalOlfqSBGDia+U0aTVysw74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tKVHJpdIXGHNkeHCjd6XNvvxvDMUNF4IxaNU4p93c8slGCatpaagz1hMzxNg5Fy6H
	 Snp2zH/eL/NHf4847KqxOMpoth69tSLEZfs8IqvK1hvb+nMoljnVaSdX/DVywgVO9X
	 cYyV4ov/zzBD1fMJudh7d6xiXTvSkdvgpZFhnDa8njWmQtbUOqug6ioFUzjlmNHLl6
	 2pjkK2vpwhgck6jpe0+W0Y2Pm132skZdh0kn1NxYrcYkCVc6BoADAfb8/A+oGTVeAM
	 DYmx0yLA9qbQv9KPK0d9Wi3hbdwH49IJJF+EDG4XlSiAzJuoD/pxqmYbIs+E5OPX6Z
	 +Kuug1goOMg4A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:27 +0200
Subject: [PATCH mptcp-net v5 01/13] mptcp: pm: re-using ID of unused
 flushed subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-1-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CTC4imhwpdnjUeig5ztGalOlfqSBGDia+U0aTVysw74=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KbCTc/M63gndE9FQzjo49tma+l4iD3XO6EE
 JZ07HeivsWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOymwAKCRD2t4JPQmmg
 c+0tEADg8vQ0Lb4JyjJB07sf/gUxpmBOjUNvOhnFlQPvVEjhAbZLR4LgAeWWSFDyReS50d5/hy6
 L4EFw5DiTHStpNj42BoQqXqcQNYHMy+WRORmN0uE5erxCG9JHypxLQcvrohAKl39JKrNeQTjqLC
 n0Fcxz42MiOfYCXYBZSBpQvkoUW0hkpk4QunoRz/LHCmApRNmRCcX/S0pzvt/PJeHITALo7CfjF
 hLCQQ5BTEYiO3/4oWL+eDaYSaVIoH0wWhUKTEV3daLrKxplKr9nc4vzllgEASIuwHG8yplOMXcX
 aQi7nxmRwa8pcYbmbJCwyd4as292lcXkKuVFtwQyR/IqriKP8vUvCTjzBAABQNIffeoy8/5G5Nb
 2GLy/jXLxuEv83oIQYqdtesyIyrFCgG+DPOfXMXJqkdZjKCOkAZGhbeKDRJfhrVF3p2yEz5v2Im
 99fYVp3SB880FgMWYW3UGRjSSljwncT83C12xjGro+XY2HwnJT034lKeyVKIDxGL1jv0ROHdxtK
 WgkPaf1tEIWrZ0FBVLti970ZLSjE6EaSfp7NAsCXQUgvt/9byC6O6GN0Svk8jXXo+Z0aJsEyhts
 X5fRu+4T6xr8iUhaE1nASubNEKL7mWqF+kU8BxPg3SaoLSZAzFWpOPqTxUKwl4ZqijwONlOcU3K
 eieNW4U2Vhl/37Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflows are attached to the 'subflow' endpoints that are being
flushed, the corresponding addr IDs will not be marked as available
again.

Mark all ID as being available when flushing all the 'subflow'
endpoints, and reset local_addr_used counter to cover these cases.

Note that mptcp_pm_remove_addrs_and_subflows() helper is only called for
flushing operations, not to remove a specific set of addresses and
subflows.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v5: move the renaming of the helpers in a dedicated patch for -next
        (Mat)
---
 net/mptcp/pm_netlink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 44336ee22707..00b3184be45b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1625,8 +1625,15 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_nl_remove_addrs_list(struct net *net,

-- 
2.45.2

