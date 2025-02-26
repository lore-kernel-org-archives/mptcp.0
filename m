Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953684A1A
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593274; cv=none; b=T7/HxNg0XT7y0oMJ5m1dEk/uRIIcKeYlomeCW6nrOkTSMH53rZguBCyxLnturnubai8LBkdW6oXrHUP3N/0G6S43NimCXses4+0JaYMWTR8FRYQ2/PkCwUu0cOTRmMCEKfH88BWftb2UsQvSTXkgj0H/hJF1MddcVZcoNvMVn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593274; c=relaxed/simple;
	bh=I5SlRipvjJ6G3txu2eiqpvd9rKu4kkwB9aZw+zft0DI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jO3H84bOX8Vkz9gEV43JvrHqI5KpenrzDGDk/IytDfUqjvCvMxVpINNLKfellWH41ASvmD0ZzV+ZR/KWVJimZ02F3gUXlCMgAmrebOdA45HH6RWA2CJ8mvJ/M1KC32VrRAOu0eE0PApWeLBC6+cAWrgZRox+V/ZX/HbajWto/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSnJQ0HK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSnJQ0HK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4532DC4CED6;
	Wed, 26 Feb 2025 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740593273;
	bh=I5SlRipvjJ6G3txu2eiqpvd9rKu4kkwB9aZw+zft0DI=;
	h=From:To:Cc:Subject:Date:From;
	b=VSnJQ0HKNm6AE6jDqqJVUjl6Y1wl5kmA80xNy1GV5dEAwWFiIsqGf98LsjsIeFGFZ
	 saPCaqojrfalalZD4EOoBC3g2Aaa0noVM6G2KB667FzQW8gVCJZsj/KHwx2trTgF/d
	 1y7GS6B79N4wikqzzXgGMy0ph6dPn2ms0uk7G1NWsAZujzYNP0K9Hr5EhT9SsDfR9Q
	 ac6wvaafcSc3GSfCBV+c4pK7bf4n3DznwZv2PPrYD+ou4EAXXsB8J5+6ViN3okfO/D
	 qjFsxc1OK8lT3+/nW8KvBQTkWssqLMg8ZoAzBXfASn7ILVyDT3hvGbdCZhbOoi8+mi
	 ddCeGjVwlofNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Wed, 26 Feb 2025 19:07:28 +0100
Message-ID: <20250226180727.2499531-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=matttbe@kernel.org; h=from:subject; bh=I5SlRipvjJ6G3txu2eiqpvd9rKu4kkwB9aZw+zft0DI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnv1hf3Y4Zj4VfhpicgoaDhiyLuF2GyM4APnrec 1gVAHS2Y2GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ79YXwAKCRD2t4JPQmmg c38ID/98fUR0ydIk/mKyt+6uA+W4LMIh5vYFVi+caKK+rayUZp6w9cpuBu+e7mXCy/p1ZwdQ67M 14DUWY0lv9uNUBrWNw2Qi2+WP+/+hd5ehpViwTmMD4fuyB75dIhc0oklXTDNE8dpHE6G2w70/ma vdwmpNuLYbjcqoNjHfU6gq4/UKgHHsqAopPtZN0Wi4ipjiB85pgQXtEPf6EYlNllBCADDbv6Aps OX41TeKFauBLzEcSJjBLUsx1/XPj++Mk/UdzOIcZTMPEuP5IFUbAGQ+FSMIS4rRn9L+x8vq2tex xz6WLoSNVgQTq/5FboqtDURZ/CUsUIgQN68Z85wvXVLs+zCJ58tqoPLys+j7ofaKZclg8eIKp2n yc7+XRSah+PYO65PCpPMLMZex/E/SvuMoDQ3wcXGl4Qk7LYHtNWNDrud5XE+1x/6QD8xg/hR1lj Mp16fF2CmmOWf2lJ+JaKV9HRi48Vm0eAP062DiHba+AieNIScn1FGeol85ltM+dEml8bJjc/Q90 np7nTyCxQyMuyogX/HyZb+wnVoc2ssvXZBdb8VyomqMZw22TkL67gDpnLcfFsGLEq1TP8fnioI7 6NIvr6ezt5H4ojKNgEBn9ZTnmpgtH96tyZ0kanN6D65dsJejT3f9Z6P86td9L+r8WfDb5HG6rKf N6FechVthN44fSQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From what we understood, when being used from a CG [gs]etsockopt hook,
the socket lock will be held. It seems that the BPF infra will make sure
in this case. Mat will try to get the confirmation.

The idea is then to add this msk_owned_by_me() check to make sure the
assumption is correct, and will continue to be: the new selftest should
complain if not when used with a debug kconfig. In other words, if the
tests continue to pass with this patch, the Squash-to series can
probably be applied.

Note that this is just a debug check, hoping that the selftest will
cover all cases. We can then not use this check to return an error if it
is not held.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Based-on: <cover.1740368110.git.tanggeliang@kylinos.cn>
Cc: Geliang Tang <geliang@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index ac7744c6006f..9e8c24c88022 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -252,6 +252,9 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 		return -EINVAL;
 
 	msk = mptcp_sk(sk);
+
+	msk_owned_by_me(msk);
+
 	kit->msk = msk;
 	kit->pos = &msk->conn_list;
 	return 0;
-- 
2.47.1

