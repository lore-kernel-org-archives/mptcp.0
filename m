Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBFB31AA9B
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225927; cv=none; b=GOJNkYqqeRnBjDLPPEOzo6oSyayaD/YyjtgtCssM+ig6SS28OCYnibAvMK1rjadpV5ZD271JO2HGy1VKEU596dWCnjb1NTyp+iMGzgkFinztSwAtdV+fMsjnvXgmEe2DBK3/9rCYdQqJAnE1QkG6RZ8WE0SwhVhMvs2Uckgh4z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225927; c=relaxed/simple;
	bh=1V/0E2Fp6bqGFvlNXIDG5IseSYm9DVjOBS+MuA0YryQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1m5vvbA17+XA4Vn+FlcRkaDmN7itme1/wfGjEmO8lCot7nOOJ0M/h39bRA/KxyEQ/kNKTxdKCSa8yn5shsit3ibvFX6cLl3K9vRPki57MIrJsQ4dmp7I2TBND0zKc4xguGDce2w/KCTaDWt3f0iusIL8us6s50su4yPNOrw4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2GYsigT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2GYsigT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFC71F000E9;
	Tue, 19 May 2026 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225925;
	bh=lW1Xl/o2x9TY6Qqx1v6ws4S2+j3E4UEmS90U3d0BfP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L2GYsigT2MDCA8elyOLTOd2FCmu5vDO12zuKE2BeBb/3tLDT1mp91djDyDwPW2E/g
	 cBbJvBk9ngKKtR04lUXurUg0b/1jKkV/DociXPg+AQceIUf7yf/YnSPbpssPG/llWk
	 J92udYLRUGo8C+UYCS6z8CK8iHA9gWM9OGHEAEIEP7FDZat+la1tofdSpOx5lLzuGT
	 3YkSZU3lJXF8YwpblZXXNZ020cOynFemW/kipRk9xksI13p0Xlaw3YWadyvpg/iCT+
	 xUVeLDnTF1s0nzSrSwu5cy9rGsGr605RfoPoozEebyCFxVNv5RCebakF99BAmNOg9T
	 1GYPeq81EWbFQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 20 May 2026 07:25:13 +1000
Subject: [PATCH mptcp-next v3 02/16] mptcp: options: ADD_ADDR size can be
 negative
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-2-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
In-Reply-To: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1V/0E2Fp6bqGFvlNXIDG5IseSYm9DVjOBS+MuA0YryQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVBaFZbs39fjuQg8ddvsJ2wYbdJGf/N1GRbX
 KPYhGSZsR2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQQAKCRD2t4JPQmmg
 c/+cD/0Sj70ut5j5VL1YSMzO4CaYcN7zmpO8y/14eJYIx68rAzc8D01MMr8opvYIDOSLF3rz9y9
 ohGP/gttf0hgy2hpOywEt0ysGntd2r+AP9yej37PBEFZu4biUwjfCUv6jdAMkIfRH+e5YnG/tkI
 oQaLzOOwBB/4/jSBpY86vTbdv6PXwNA+IiOy8v0muWaZJKMq+IhCFptqzv5AbDzBnB1/TWoOr7j
 XLS0YEiSQMg/rHD9WOKMHwuEaTQjPYIRtb9YY9yoabq4Ul0oYOaZCMvhoyYqKoe+eOWohrVVY8O
 stYaQ1N/c1aRMWvBhlWZwilbQA/6dqg7zlcJP0HskN2ELL37hxx+n87aRmyVhAql+8FEERf39kq
 GYZfEKutLxIe87pqDJsMFlyNBttwSoSZt/XP4LEwswue+UZdnAp4ACO2IFd1tpvMZ2+fP7kyhxk
 Ny2IwwPuRdYyEEgGxo5Jp/KH7pWjY7toZAVpNJv3a1NAB+H1mHTKyBOD2cBq51SzUGP187+MxwJ
 5lRC+o4ZJr+OaTTfrvviYLDT/T8ZvC1gB9OFQY5thcb9zndPl+Av2Jy71dTrnvn9jly9JwJ/Q3w
 XIElyAIo8v/sTyJghxB/ZmRtpHZDEqIzObkOzIqiLXwBNEDrppV/jsyeMlxW19PzQerkr2VSsDQ
 VrvsU2tJ3X7hJow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Use a signed int for the returned size, because if other options are
dropped, the size can be negative, e.g. to send an echo ADD_ADDR with a
v4 address, and no port.

The behaviour is not changed, because it was working as expected with an
overflow. But it is clearer like this, and it will help later on.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 4cc583fdc7a9..966f6a867287 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -651,8 +651,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 	return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
 }
 
-static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *skb,
-					       unsigned int *size,
+static bool mptcp_established_options_add_addr(struct sock *sk,
+					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
 					       struct mptcp_out_options *opts)
 {
@@ -842,9 +842,9 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-	unsigned int opt_size = 0;
 	bool snd_data_fin;
 	bool ret = false;
+	int opt_size = 0;
 
 	opts->suboptions = 0;
 

-- 
2.53.0

