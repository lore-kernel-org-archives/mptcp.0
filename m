Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0C195B1E
	for <mptcp@lists.linux.dev>; Thu,  6 Jun 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694230; cv=none; b=ct/I4tH1gB6IHg/lWKRmpuP3AOlrNrB/x+exfsoHKpDf58opz7jxpaU663EvYrDC++9MTn4c6ZsxW8tf+eOAbMYxN7TudYiMUg1vhVUPHlXD9X7StqIyq41EbQBmklzxqtkus2kBWR9Db1VQ4lCCVdOxkiZEMIfkQRbGkjAP19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694230; c=relaxed/simple;
	bh=ciMGDGywyFfgMnIUW4+g2llkvuOg+Iw4LVMhlaPBS6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kjxEui4x4GLyBsFSA4ZvPpUsRFLwrWzdLuCotlx6ymIfOT//9xI5YLdEBsyNf3T0Xf3kTfHydwIFrTLuazy98FtjQwvK1a/+k5j67l4mSGCuEzmI4S4zXfyobJ9WdD3tvArPIHUTrp0UvDAB7kUJ2WtK4ua81Xja55psSwGA8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcZ/pJZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcZ/pJZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35275C2BD10;
	Thu,  6 Jun 2024 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717694230;
	bh=ciMGDGywyFfgMnIUW4+g2llkvuOg+Iw4LVMhlaPBS6k=;
	h=From:Date:Subject:To:Cc:From;
	b=ZcZ/pJZRy8td7y5+Ev60mTYC7j5PulH4pT8qgLiXriD/JfmEx1b3cvEsUKYLGZPmY
	 EyoMfkLsrK9bJNBTDPh4yd4/7t5Vl09LUDBevhlo5PHLHy5hhCwRATeAhvlatjWGSB
	 8yNTRSGVNRwh03Gubx+UMpn0Sy7El2FZhRb0Zyki8DB+Jy8PwSF8MBBIwF97J23LtH
	 aZaJ58jpv3DjUvziN2RzmT18yZtElZ55WFln9zCvzVs2HDL2G47gEofzjCNSFLhD4R
	 jaK/fHlPllLJl49/4SNPolexJrBgK0Sz/nrcswN0uNIJ7+KB59RlzaHP61CwoFaEih
	 cftGFJMt9srHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 06 Jun 2024 19:16:50 +0200
Subject: [PATCH mptcp-net v2] mptcp: pm: update add_addr counters after
 connect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-mptcp-pm-inc-cnt-sf-create-v2-1-67c4759a4885@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAHvYWYC/yWNzQqDMBCEX6XsuVv8iVF76nuUHmSz0QWzSgylR
 Xz3BnuYwzB83+ywcRTe4H7ZIfJbNlk0l+p6AZoGHRnF5Q5VUZnCFhbDmmjFNaAoIWnCzSNFHhK
 j82R61/adL2vIgjWyl88pf8KfU07wypOPS8A0Ze60l21pG1N3tsG6NabDEkfJalaHHAaZcZbvo
 uOc86BJNN/NTEu4kcJx/ACaqCgQxgAAAA==
To: mptcp@lists.linux.dev
Cc: YonglongLi <liyonglong@chinatelecom.cn>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4435; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Q+7G1idArOsf3dh+3c6f+ibpb9/f2kAOMOFctANpULA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYe8UP9ELV+4NicmbhW8ztkRwU8KSeDOQBAmIG
 cMeLhslF7eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmHvFAAKCRD2t4JPQmmg
 c2rlD/9hDpBB9KDM7ad0/lkXmGpN09SPmDYKH2mFa21aE5wXhFUZWZpKNOuIfpqbDUcyCDL4yKR
 8iovTj9Z9q541YZurF4HpsbFcF9MmhvRcQKME8Clke07bgPUkHw3FogAKVKYP5ejedUonjL236B
 U79AZ0UZfcsS6+0ZcN1pyno1moXbd8AaMkVlLLswd/rV0JpPi2rqLZRGLzgmve1/J1rlhM+DQVe
 fcBMXGSBusRaGEn8c1oO4uV/BJE8RxzrDHoYlrO9mkKfayNAfqJNYceLzvLwLN320ZXvevc0Cdc
 jx53BW/LsosX2xd0vfC50VKGxZt+FbpWIJkQ+uH1jS+MMcsY7kzqdh3fTgDQRPYAOS0FbiL9/Ik
 vdk5YGaRszwrrkTUz6MIzso24IQRLv1w98SO4WJHnHSiiE5dvfQXeI1rSeaE5e+HChRtCl7GZoP
 E5xV8caBi4AOYLaXxVDV+mqtYCu04wBvmZkVGV59wLKaQgpKiweAtSgFedK+YsKkVbLoOSZVTMo
 gUcpnZ0Hhvg+/1E5KpxaFtu4TwJc4jnySo4PJyXJq5lexAEo4pH9C/jd3UXpnseqq01hFR4JGHH
 HEKpHMy/cUbgXNoy9XAaL03jup/cAUIIhMdJf4pJzwFr+pnWSkaKdCQAKZAPSuLtap1SoQ5a+kd
 uknxADPmYVTG+Ug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: YonglongLi <liyonglong@chinatelecom.cn>

The creation of new subflows can fail for different reasons. If no
subflow have been created using the received ADD_ADDR, the related
counters should not be updated, otherwise they will never be decremented
for events related to this ID later on.

For the moment, the number of accepted ADD_ADDR is only decremented upon
the reception of a related RM_ADDR, and only if the remote address ID is
currently being used by at least one subflow. In other words, if no
subflow can be created with the received address, the counter will not
be decremented. In this case, it is then important not to increment
pm.add_addr_accepted counter, and not to modify pm.accept_addr bit.

Note that this patch does not modify the behaviour in case of failures
later on, e.g. if the MP Join is dropped or rejected.

The "remove invalid addresses" MP Join subtest has been modified to
validate this case. The broadcast IP address is added before the "valid"
address that will be used to successfully create a subflow, and the
limit is decreased by one: without this patch, it was not possible to
create the last subflow, because:

- the broadcast address would have been accepted even if it was not
  usable: the creation of a subflow to this address results in an error,

- the limit of 2 accepted ADD_ADDR would have then been reached.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: YonglongLi <liyonglong@chinatelecom.cn>
---
v2 (from Matt):
 - Clarify the commit message
 - Replace the Fixes tag
 - No new line after the Fixes tag
 - Use 'sf_created' instead 'subflow_added'
 - Use '__mptcp_subflow_connect() == 0' instead of '!__mptcp_subflow_connect'
 - Validate the modification in the selftests
 - Added my Co-dev tag
 - Link to v1: https://lore.kernel.org/mptcp/1716543865-37448-1-git-send-email-liyonglong@chinatelecom.cn
---
 net/mptcp/pm_netlink.c                          | 16 ++++++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  4 ++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 766a8409fa67..ea9e5817b9e9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -677,6 +677,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
 	unsigned int subflows_max;
+	bool sf_created = false;
 	int i, nr;
 
 	add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
@@ -704,15 +705,18 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	if (nr == 0)
 		return;
 
-	msk->pm.add_addr_accepted++;
-	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-	    msk->pm.subflows >= subflows_max)
-		WRITE_ONCE(msk->pm.accept_addr, false);
-
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
-		__mptcp_subflow_connect(sk, &addrs[i], &remote);
+		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
+			sf_created = true;
 	spin_lock_bh(&msk->pm.lock);
+
+	if (sf_created) {
+		msk->pm.add_addr_accepted++;
+		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
+		    msk->pm.subflows >= subflows_max)
+			WRITE_ONCE(msk->pm.accept_addr, false);
+	}
 }
 
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index aea314d140c9..108aeeb84ef1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2249,10 +2249,10 @@ remove_tests()
 	if reset "remove invalid addresses"; then
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
-		pm_nl_set_limits $ns2 3 3
+		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=-3 speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1

---
base-commit: 91419da702aaa1ad2b0110a07fd50a1a38bade6c
change-id: 20240606-mptcp-pm-inc-cnt-sf-create-dfc49d798f13

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

