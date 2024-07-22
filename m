Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED00171640
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676974; cv=none; b=FyNJo/qqn+lde+P3F5vVzyIwOvhYOvGo8RKolKDJk3zVAeqLrfyaloD4L8QOv2foSdLY0sFnBs58mMhjEJ8he0NJSNvyrA0F1SYoj/B/yQORMpmAfnc8Y4p3ZYmfnK3e2qYORDQv6ZZ8iKH01Byua6AOhxzIRr8yJ9N+UCXecOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676974; c=relaxed/simple;
	bh=O8Iu5MYAsOMjwlWVDXEjbmXBzNq6+yIhkRZl0uBMg8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNBv1PW6tLFH+tqY8InARVzKz3Ujs4lpVuEtwF1SWpalfdmc0i+nxi8qII0GMrhKgnbb9V/Qxw9j5Fyh5aQCmGJD0k+J79NkCOeLOz5uWcMVEMlOnf0FL5F8Pnl5dwgV2QNwqHobRBRdl01tF7dHV7hPqyrk2/Fc5RL9orEhoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coMe0NrV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coMe0NrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD22BC32782;
	Mon, 22 Jul 2024 19:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676974;
	bh=O8Iu5MYAsOMjwlWVDXEjbmXBzNq6+yIhkRZl0uBMg8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=coMe0NrVPpGVGsO/Y8ktmTHxuIaRV/5RqR9ynfih4xef0QllhmwTHNRZd7UxNEY0b
	 69loY5L7czI08/tk0U4iU78u00pj4TFAO/H4gxjMzlKUEXJ3idMXAumBwxV7bvSVmW
	 zzknN0frNsJ4TF1LuzNOIUjhPbKYgrfQFW37h+aAmba0pjqjAAZ4spAMbIjPF6EJ9q
	 QW3DVklRDL9MUFYV89Kb5mWmwGEswktTjQh0HS4DP7RHPyW9gqbDkNma841b2Co6Vg
	 H+P0wv3/6YwoIYgZz53TMG2+QGS6pUA1CVs432ZY4A8EFGZ1TNHGopnyZgSJuP6Fwo
	 HpnT91nNbh5IA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:57 +0200
Subject: [PATCH mptcp-net v4 19/23] mptcp: pm: fullmesh: select the right
 ID later
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-19-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O8Iu5MYAsOMjwlWVDXEjbmXBzNq6+yIhkRZl0uBMg8A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSXTrIU78J+oAPZTC2dx+45O0S/z+5MqsCCg
 Q49cSPvttSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lwAKCRD2t4JPQmmg
 c78zD/435reFAtg7UyTOM+eTzDE3SIgOOdLARYZ5kYSUIXipU2+UPai+VzMGGLVog2SjJIjn4qr
 VTtSjNrH22HrJuezNya6f3pcCnm12YemM1qNsiyT22d/VqO7v3/B3d/OVfeg4RYZTLSTB8nB4rI
 VinjSDebxyu5jW67WfIHsNiz3tpBGCwqpLA/PVzfg6toocrz9ehMoo0QDJf3nt8xQQmI0NGdcO1
 GgJcWQoALtzKBvOYfrzMdehgnEx9WSbgGnFNQtvvPAw+VEZnRbGn0fhKnrsBby8xmHsYh6zXJw3
 ArjX8MNPjVdWDPc4ZrVWHH5R+pTLsulPwxKEhN88drv3CSRwpgKQeuA3WZAwq2Y334voLaH/7vt
 1HlzjhPyFr1yDwjQ9o5wpn8KrL25FQuubChxPHOIi1vF/yF42666irTDQz3pZ8bc7p7nLasqplh
 ECUVzmgxXZSRgtDJ9SPHjwp9XmiiNH4jLaihf58GCT46PtQCzWcyp0VIik1MNRMXhT2NQHy3E8X
 g7n/fWFKxi8whJdGOQrny6oz6gHCBJdgg9rzIWPPO8iQxShJ/k9Mtd9zcpt8ghy4EDllkTTXb7C
 op7uMnE7zzqSbhSzQsidM2fmNtbmqVj49/VHEm77v0Cv9q4c6q9OJtym+EV6PBi4H5QbZEeuxQT
 oqh5oQwFWuk3XyQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When reacting upon the reception of an ADD_ADDR, the in-kernel PM first
looks for fullmesh endpoints. If there are some, it will pick them,
using their entry ID.

It should set the ID 0 when using the endpoint corresponding to the
initial subflow, it is a special case imposed by the MPTCP specs.

Note that msk->mpc_endpoint_id might not be set when receiving the first
ADD_ADDR from the server. So better to compare the addresses.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v4:
   - Check that msk->first is not NULL.
---
 net/mptcp/pm_netlink.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ec23bb32862f..2c335202aafb 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -637,6 +637,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -644,6 +645,9 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	if (msk->first)
+		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -654,7 +658,14 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (msk->first &&
+			    mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();

-- 
2.45.2

