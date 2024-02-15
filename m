Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C67132478
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009581; cv=none; b=oYz55fKdZ3VQ691N3sZgjmzEVHet4MnqkxnLNMs+g3kRX+5o47TFiPsWHGAKdpAYwydwkkEoVR36qSyjtxsjyP1U+67ZrIwYp5AO7+htIfXDsv++eIHqJumw936PSSF8TpehIta6mP43DSVydDwQldt3Hi72EgEsFopbxG6CPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009581; c=relaxed/simple;
	bh=zVWRv0b16fPb5blJn0KiIo6ZDKNtOQhZ5RsmBCjYRsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rkLvf/kcbd95tZqZ5CBd8cIuvqaUBHfTU5oguEDcixTSasMQ+hzEWScabDLQCL7ArGAoFHzWKCYaYC9rqju5sqmGBiu3bgPtgbXOjwPSS64jXo39XRdhaw35cRwS9GE5n6TP0LoBgyObjqeSp7SkG3irYs2nCkYrkHdXIGD9kag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggbc4s+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggbc4s+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBB7C433F1;
	Thu, 15 Feb 2024 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708009581;
	bh=zVWRv0b16fPb5blJn0KiIo6ZDKNtOQhZ5RsmBCjYRsM=;
	h=From:Date:Subject:To:Cc:From;
	b=Ggbc4s+70hPKb4KV6dVYUzIokPQCkt7m+VKNYzEGnRaV8HzT+3WmGIk71EAZOL6mF
	 Bj4mYSaDj3kR09d6LJTltGMSIeqqWo7Gukkm9crdhiYfoPGclpCF7XLI+XJBe0lhJ8
	 vby+rtOtMePmFo5Iw/4BUmUz+LL+OE/KQGT+TSeh4Q5rAkSztR4KUbjNLESQFbQgPa
	 EYocdSLUXmkiIB+z9zhoQlu8K8KwzB7+Qun9aIQFkwav73lriBKVHbAxsJW+mTnIjS
	 pgV5rbpLkfT9j1gj2zi4gRB4Vx+LfAjMdR3b8LPz5KtTfY263F7L4lxYU3Z9056at8
	 B0COFLHi3baAA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 16:06:14 +0100
Subject: [PATCH mptcp-net] mptcp: avoid printing warning once on client
 side
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGUozmUC/yWMyw5AMBAAf0X2bBOq4vEr4lAs9qCarVci/l3Dc
 ZKZucGTMHmooxuEDva82gBpHEE/GzsR8hAYVKJ0otIcF7f1Dke+sFun3aMTPI1Y1FVhsjwrqlJ
 3EGonFKTv3MAfWdqgfZ4XbOoli3QAAAA=
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zVWRv0b16fPb5blJn0KiIo6ZDKNtOQhZ5RsmBCjYRsM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzihsIjULQVIDWsY0qcJ6qfAuU9t8SlNShVv0g
 GH6s8SIoNuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc4obAAKCRD2t4JPQmmg
 c1yHD/94z7I525ZhMCJVOGtSOlXzk1QH50jfOs9C0oc6dUQU8QYVUVqqC6Y39oLnGjU9ZPGvTzy
 YsOJTfku8r+xeEMrEm9lpvPwjTDPfftWknmQh2tnGG9z8t6mtpeNQxf4yoHCe1u81ttCIrwq6Yg
 KThTiA4HYPqTLSw9a3oYeR25DnPclILC5A/f3HLkmlpwrxIVPG0MrVbRfIQhYaO9U41QWhW17r/
 SG7lowmAwnsJPQ+8YescWFisPuNqQeZr8DDCkdYnATaAzOa765KyLBiB1OPue+n/7bXWo5ekopQ
 tQbfhQDz62DQu1l63dGSAlhDDdiuutgr7wYRVZHNdwz9LhFtoN3qelbqxyJHGHfgZ8pSK1MeQKY
 qmDuHZvL8StawsshQ4U0wKU7K9UIgMeg1rEisUOMictcWzp1PZA823W1oQeWfyllKYO5i3urScQ
 WyKff4kJ8MKLBxCICAmopx2rJjakS4MC+jfiafIp5qias+31P2MN0c9cfNwa9gXds7+KSev347K
 Vd0m/SsZdqpHYbwAkZjxdq0fWod/lzwUl5b6i7vClR0FO6cgWnAnYPvmkvpSrCG2zbK9NRDyYKg
 xOtcwIERMNLPPp5GQZQlmzlL4p9zcNq6S7vkBlBC3RT++5nlAtaz9PhAt+0tJAFsOY4pqyZi0qS
 6uBmiGzN/FAA2gg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the 'Fixes' commit mentioned below, the client side might print
the following warning once when a subflow is fully established at the
reception of any valid additional ack:

  MPTCP: bogus mpc option on established client sk

That's a normal situation, and no warning should be printed for that. We
can then skip the check when the label is used.

Fixes: e4a0fa47e816 ("mptcp: corner case locking for rx path fields initialization")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Should we convert this pr_warn_once() to a WARN_ONCE()? Or just in
   our tree? Or just in DEBUG mode?
---
 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 23e317ffc901..27ca42c77b02 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -981,10 +981,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	if (mp_opt->deny_join_id0)
 		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
 
-set_fully_established:
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		pr_warn_once("bogus mpc option on established client sk");
 
+set_fully_established:
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	mptcp_data_unlock((struct sock *)msk);

---
base-commit: 52e05de42e1094a943053af93ea08c51a44091f7
change-id: 20240215-mptcp-fix-bogus-pr-warn-497a3537984b

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

