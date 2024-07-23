Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2F13C3EE
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752298; cv=none; b=qq8tlrF1IFcwKdnA2BL7x7GHRR9jCgmYXaT4GKdv1mcjLQ9ZWqBPLoD+1oQ3srR9fHHZm6akf/Gy8Z58JENicKuVRyfnAtTSOfIfKwEYhUM96IKI8JcigUmil/EBwO0iLrF08IesF0wRPRHok8tehIdy3Y9+kRlohH7PTJ+8VPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752298; c=relaxed/simple;
	bh=F4MAuB6QFQmzQhtbpngs/2R1rQblHEYfrO/wmuPILXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkfodW2wwhBz4m+1GBgX+wHlVCaz9d6wOIF/9Y9O9seFtVlsx51r35fNeZcgUD/K2fGVZpR7wlPzpD0uPPx7F0o7hpETZ5RGldDWGTMfVDjUfcZXGXIKI7OBNVGshcG6rbh1U9ZbhfpHzHKMvfHZO7UqBrudoUdAxRZ7Pp685uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf6trVTU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf6trVTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32E4C4AF0E;
	Tue, 23 Jul 2024 16:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752298;
	bh=F4MAuB6QFQmzQhtbpngs/2R1rQblHEYfrO/wmuPILXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bf6trVTUSex5BVXGjM6n365o+OQkEQOude1z6//EWHXPhciSa9ZBCHpuy/9+oMf3C
	 eHhCjG68QZvoTevg9wu+IAFJBXS5c6CgP1x4SKieKej/UoyvN+JczOEcdGKiFWffIO
	 ZwLUg2o3YO3GpoiYnT5jsFWark8HyB46/hFEi3FMF5fb3MTju0RramR9U09xuNw8RQ
	 X0ujQpyss9f1VSjUFVE7Ic8R6zV27PcFfO7Fz/RHViuE3uv4Up1IsQt64ve5fpa6EO
	 UBq87zN6qtI5Ff4GJey3rodJ6iHZjHrZQ7eNHSXxb/o/243zaTd+a6V5wU7cDCcKIf
	 lbIZOSeQuLdqw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Jul 2024 18:31:10 +0200
Subject: [PATCH mptcp-iproute v2 7/7] ip: mptcp: 'id 0' is only for 'del'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mptcp-user-feedback-v2-7-59f18975401c@kernel.org>
References: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
In-Reply-To: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=F4MAuB6QFQmzQhtbpngs/2R1rQblHEYfrO/wmuPILXg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmn9rhh/uqAM9UJGkfrXejSHfVvJ1eZ6r/Uoyg9
 k8nGuY/1i6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp/a4QAKCRD2t4JPQmmg
 c53QEACu5/xrueytf+nHW/cVnoTcULbnOw5716bplBHi+UovNKPGRpzTC86KcGMvd3B3wb43/tG
 Lcs7SVE/BefHclaWeybcQ5jHBCBxcjfUhRoVqbsfSboLipMDRu4qIn6W3pMujefUZihE0/EvB3v
 zs0R0tT9u6Abc8EB4iolCeK/V1AFDfvs5epIRX1asM/4vpU9Kk4FubRvySy/v7ankKo+m1RcD27
 WP0IlRYO513Jvq2Fke2pe8jBqGT1Qt1t3iqs3Tw1ju76k/bodXah6dKYGHux5esZxvUeLGt2stK
 hJI+LsHH8M7UMHIAaGHuHM6/fRrj3Ohy0BOLZ6+nNmf/r4J4Ht3KE+1+OlU7ZAOMbUEBTjuIIfz
 4P6FLlgPFXGR0GQ1PcmKf5EFV2e6n8unvjja6Uw7lTLvSmhcSq7JfrcLYESF/JY/dYsL2VYKtoC
 21cEeMI4InWDOEtgg9oE6tx0IMpQvp5J1ooqhj9QItAAbQFRSQFtLSkfNBBwsRM3dmt6lquRcri
 Ex1ZxkCHWUp563dnOFMKsy36bjuE64QfrhcENQbDB/APVPsHcrhwA2+54ekl6HAIl4xGhoLJ3LN
 JLlnXMpxdxGIBm4aIJsL4+pNoPFYjybyqdkGSCgA0F3TILKWo3QjpwILVkrKPV6ufGka1t4MfcU
 nlT8jvBsBcWh19A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding an endpoint with 'id 0' is not allowed. In this case, the kernel
will ignore this 'id 0' and set another one.

Similarly, because there are no endpoints with this 'id 0', changing an
attribute for such endpoint will not be possible.

To avoid some confusions, it sounds better to clearly report an error
that the ID cannot be 0 in these cases.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 9847f95b..118bac4a 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -174,6 +174,8 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
 			invarg("invalid for non-zero id address\n", "ADDRESS");
 		else if (!id && !addr_set)
 			invarg("address is needed for deleting id 0 address\n", "ID");
+	} else if (id_set && !deling && !id) {
+		invarg("cannot be 0\n", "ID");
 	}
 
 	if (adding && port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))

-- 
2.45.2

