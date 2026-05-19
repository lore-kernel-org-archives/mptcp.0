Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205003E8C44
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225934; cv=none; b=Q4s4EQd6iuKc9JYpKI/H4+OPgQ26WbfQMguZ9q47BrWPmcoclp8Xqi6wuOib4Pz+fW8YbFxH6NZBCMihbJS7RhwU4l1tpQFvR9LtDLyInr6LSrhu/MVpELTCQJCTpG8ERvNV+jOd8ZoOzqV7Ytjnr16eQChLBYQKrrsEycWZH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225934; c=relaxed/simple;
	bh=YrR4b2q+p22vMH2nHVoM29MHIk6a7m1eKf8ryuslchY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgTAryYZc70gRZM5LF0UalSq0dXPNdSXHnvppIn/zrQyJ6Qcm2TeySwLIwKKWt89/Nq5CMuukdSY5sb1H2nVwHWM/lQ1WFld6qS0MZFfiL/kVepkCfxgTXuCNo7N9Qc44aeGOF1AD6vu1WhUUHzBNih+ollho+K9LE1UW4uQeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBmmI2V7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBmmI2V7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061AD1F00896;
	Tue, 19 May 2026 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225932;
	bh=M7jY/+zsdQ5a4qabsuVjKuycu673lfxGVxABS9PHXuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HBmmI2V7/bIK5XvTwGWyeYXUWPwlBpJlfknQYgKtKCwO27sogmEvcxnoZW1a8nQll
	 Jq3RF3TlZze72asMS3YxF+Iuiyl9rRr1RH6eNFnjsSAEVdli+2pdMpefJHy47h97H8
	 x70LycXc/nIoqS3WDFbZF5BNxAqSARTKNpCSZUFzPxBw0xOpWFSfzB3EA+nQ7tNcQ+
	 KHTdF6B6mEeuB0vNLro1o+NY7tnAWttOT4Y4wYvEx7xBgrtsP7KMqxmW+8H30XgW3e
	 6IV4NFXQac+ms7DIb2xGh6r3bCABjM/lQ/0CPZSzVBxOeEO/bU2udYSgQsFfRXi9cK
	 JHMaq8H+Ru06w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:18 +1000
Subject: [PATCH mptcp-next v3 07/16] mptcp: pm: drop TCP TS with ADD_ADDRv6
 + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-7-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4970; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YrR4b2q+p22vMH2nHVoM29MHIk6a7m1eKf8ryuslchY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBHqcMaEGn6w3WMbC6mK8LR+AsgpcC3rvzQ
 ss1STt/11+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 c7AWEADj0neH0J7QO3ZWwq8Ldp9N4hDJp+cZP92Yg9ItW2XlrsT4T+qX0NLFkz9zWg2qPVaqQ8u
 sYjlmQAU4AnjGVuK0jzabP774NDNJg/hNLpwgWpdSptPHd3TF5UgABhBTrn8lc911F3wS9Zp/6x
 fuFgeOYwR09TlI+h2p/tI7biMUvW9gQY6UA8GUcNOpr8+5/XAVmCROquMPRgVnzUz4/wAz2MVl5
 EKWfKhEXnN6qqkwfRGvbJAlJssQSQeJKmvXiO/8FGWK1BvH/s4JZOHthAryUDenxHxyhWi4Yovs
 qT79XwJLd+ikm3ZK7FqQUsawfxwlG9kP/Xflt7xnVRu/ea/O0EdBlxQ64ZahV9S3tum4wrCX1aG
 aCyyQz/WzyLymu/Lbx2p0FpoCrSHQJSnIUfz7MLXYolnX3B52kYlCyC5EMmcsY7CJlkcgooq+0t
 0R2u+55RtTtUw2MEktpEiCUWGRkb7rEKiTumzOzQLUecXou4Qcknp457dcR+kPtk4StlZYwrKQF
 u6/GKrHH5ENtsWtiwam2v1xz8A/46ahxHl1DwPIWT+ugNZze5u7+Bq2QJfKbsqBOWInzEy34qAv
 6Q+lztEfkj+abYIX/H5dJGN0fT2IMd77IECmPs/Kgndle/9JBhVHxQgKgP2UauSwmzTt0zngqeG
 6iwedqobj2ECwMQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
taking 30 bytes, the 40-byte limit for the TCP options is reached. In
this case, it is then not possible to send the signal.

To be able to send this ADD_ADDR, the TCP timestamps option can now be
dropped. This is done, when needed by setting the *drop_ts parameter
from mptcp_established_options. This feature is controlled by a new
net.mptcp.add_addr_v6_port_drop_ts sysctl knob, enabled by default.

It is important to keep in mind that dropping the TCP timestamps option
for one packet of the connection could eventually disrupt some
middleboxes: even if it should be unlikely, they could drop the packet
or even block the connection. That's why this new feature can be
controlled by a sysctl knob.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/448
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: split + fix reverse Xmas tree order + change label (Paolo)
v3: split the TCP part in the previous patch + s/has_ts/add_addr_drop_ts
---
 net/mptcp/options.c  |  8 ++++++--
 net/mptcp/pm.c       | 12 +++++++++++-
 net/mptcp/protocol.h |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 94c182d845a4..398ece479aa7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -654,6 +654,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 static bool mptcp_established_options_add_addr(struct sock *sk,
 					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
+					       bool *drop_ts,
 					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -668,7 +669,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
-				      &drop_other_suboptions))
+				      &drop_other_suboptions, drop_ts))
 		return false;
 
 	/*
@@ -825,6 +826,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	bool add_addr_drop_ts = *drop_ts;
 	bool snd_data_fin;
 	bool ret = false;
 	int opt_size = 0;
@@ -875,10 +877,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	*size += opt_size;
 	remaining -= opt_size;
-	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
+					       &add_addr_drop_ts, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
+		*drop_ts = add_addr_drop_ts;
 	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 07536d5ba1ab..cc07cfef67dc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -905,7 +905,7 @@ static unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions)
+			      bool *drop_other_suboptions, bool *drop_ts)
 {
 	bool skip_add_addr = false;
 	bool ret = false;
@@ -949,6 +949,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		if (!*drop_other_suboptions)
 			goto out_unlock;
 
+		if (*drop_ts && mptcp_add_addr_v6_port_drop_ts(net)) {
+			/* OK without TCP Timestamps? */
+			len -= TCPOLEN_TSTAMP_ALIGNED;
+			if (len <= remaining)
+				goto enough_space;
+		}
+
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
@@ -958,6 +965,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		goto drop_signal_mark;
 	}
 
+	*drop_ts = false;
+
+enough_space:
 	ret = true;
 	*size = len;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2d6c8b1829cd..6323b5195b3f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1213,7 +1213,7 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions);
+			      bool *drop_other_suboptions, bool *drop_ts);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, unsigned int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

-- 
2.53.0

