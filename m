Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF71171075
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676955; cv=none; b=J6VVZNdMpijsxIO4P1cwWtyYe7z5s05VNiwdMS95+kHBAlcYLJCvQ5bFw7sYPRWxI9pnt3OVaSDzGuq+1ddMz/XDEc4SPuA0qL+T0otOcCGJRHyj6q/gd0QzCpXGRlwLdJalAaYHb4uEkgolszBsAc70ClYOhNb9HYsHz8O8Ons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676955; c=relaxed/simple;
	bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hp5GqlDULvtANuGSeUiA1AxX5UMjzlBQY8KsiDm/xveHbx8GusRw1VsBiR4vVeRr39lZ+03MJdyQPWNaX7spqj4jp1Y6tOTdg3zyI169qw3Dx7Kcv0MyIcvZu012sF2tP6VaewbaIClpYsdn0anBatClo6NgF/ga2hRpyd9ZPJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc1J5gjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc1J5gjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FF1C4AF10;
	Mon, 22 Jul 2024 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676954;
	bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cc1J5gjyG6mJAPvAzvKxqKDizj9BxN5ZpDLjtERqmrYF3LbX2gmI6mSrjFTYcg9N5
	 qGEEQ1ZmmZ3jPsnk/5+BktTiv2rxiytLy6xvVzJLuGk3XD6UHT9hLuVSv9TklfO8Vr
	 jQGConEmUdoq/ZPJNHhjBT4buxGLATwPQILLxil+jTtua4O6qIP42UJZLrTLhqYQfV
	 PZ83YzDO4DQJ8pYp6eUHGSHQGt9N4tjioHVwsB4162STyc4iffRno1wBgc8OUGuAAk
	 7DEKYKUceJNSPYiZ8otm4yOH4AxLkmEuDM7rTrqay/TTLExGF0m4EuXmWuZjVo0eQz
	 zYZHObPRXVzlw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:40 +0200
Subject: [PATCH mptcp-net v4 02/23] mptcp: pm: deny endp with signal +
 subflow + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-2-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VTCYuWArzYhunK5hbwYMqWdj9fMJvYLpw+Ge9TGDPd8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSWCplLSmEhqiLDAtrmfOww8fScxa96maVuL
 VeSlNSDUYmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 c3huEACHd3pyanfqC1q9AGeZgAhyhtcI6kJhxjat6rmbNi8V4QL+R79OocWYnVv/LWO6GQ9utij
 0U/hAV1Zr5Ty/VX31rc7LCAOdPIQdmqqaRMZEtaK/69bHb7Hlrm+Gn2e+MtAPkLZfSurm6uq3rj
 UQORGVtwvvhLZuTjVlmgYre/u39Vh1oTNV2IGLoWWRyteiAiSUzMD43NvBc8p8T2WGHLrc5NWhs
 NtnMA7kafKt9kgsVSCoGaGCsidVETLBicYe5d6zbAEtknAfVkUvsgxc+etkKUlOsmxbLYKzMWjC
 31GKPSbmo0z0kLGTRBOS+rd91hpofKB9eYKWPnfODzhcuD3n1N7W0W8Fb+kvNHxqRJwvUljqb5o
 KEIeshWIR49efW8bx5m9aWaD/MByspsulBKIYOWvWGSgHLl8h+NJKdkX7yjgiJE6FzH538sPxSH
 olI2uzoz+ArJ1EkBWxMt2kS/UFBfFwvcBBxpazXbqJMrB+rWJ8oZew7U7DYWKoCcAgZeCubq+IK
 +9h0Rb0akI/IKA7Acv1DxCyZsJSNN5m+n9j7KZdDL23EAeukebN0dqHdqTNCqp/jkJmHYhwhGQF
 MJJMGPt5rEEkpWjcqGhc1lfcofaHfSSV6Tk5YBnw1gtWWiGJkCteOONi8wVpqyfXShO9pxQUV+R
 Kz/0JR9cvZ4xoNw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in the 'Fixes' commit, the port flag is only supported by
the 'signal' flag, and not by the 'subflow' one. Then if both the
'signal' and 'subflow' flags are set, the problem is the same: the
feature cannot work with the 'subflow' flag.

Technically, if both the 'signal' and 'subflow' flags are set, it will
be possible to create the listening socket, but not to establish a
subflow using this source port. So better to explicitly deny it, not to
create some confusions because the expected behaviour is not possible.

Fixes: 09f12c3ab7a5 ("mptcp: allow to use port and non-signal in set_flags")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f65831de5c1a..c44b0ae51cdf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1311,8 +1311,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	if (addr.addr.port && !(addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		GENL_SET_ERR_MSG(info, "flags must have signal when using port");
+	if (addr.addr.port && !address_use_port(&addr)) {
+		GENL_SET_ERR_MSG(info, "flags must have signal and not subflow when using port");
 		return -EINVAL;
 	}
 

-- 
2.45.2

