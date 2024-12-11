Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB91FBEB0
	for <mptcp@lists.linux.dev>; Wed, 11 Dec 2024 03:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886728; cv=none; b=N3LaDeTXiglfGYfRzNSbnx1NwEklZVee3DWNO/XBxgoVj4LhgHpxOKQ7H2vJmHZLrnSXY+QS4WfMX0ClfZZw7/e7LAVB4SSr/PX1FHOLuZjNTSDwdTKOOoG2LFJAO8uYAoDQHbrTrqpm67VpEflskk9HjZ3pRxqWCkD7mV3QdYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886728; c=relaxed/simple;
	bh=aSoxMkRuS6FrPLEbSoIBOLQISKqR8T8VOlvc600xB3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc2cYiLgcPtq3PsriEBBntCIfeyUnszHvpswke5eAkq/1llq63lQijgigLb+SSrBx0wVopdOCgiMq/ShA3/UwzJVlo1BznSCZdqN00oT2CnD9xZU5Xx4AhADMpP+Yus5+TCwA7KbqAO7uag7z7RbzGoSloppXg2rERgqN1oeQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abG8ez6B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abG8ez6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057F9C4CED6;
	Wed, 11 Dec 2024 03:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886728;
	bh=aSoxMkRuS6FrPLEbSoIBOLQISKqR8T8VOlvc600xB3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abG8ez6B6l6uoeUA8lLrUCXj6yo+cfCK9BaNwRFE62OoYoUu8xaW/I+czM4ByCiOa
	 LZZ9HTgI1t1Z2jJNDCPimDAVkh++sP/E90YHQ7wZx6q6mxClS/WYNVKC7kkKkT7Hrw
	 ZiMec0loTjK1tDNyOwdsmuEXpRai28923x8ZHzG2tOVUPyNmzFsy7aX07v3EIxC3b7
	 Zp/7wk3sWPitJYybJSXIY9jaKi2WP52bcIJS9w879VGvR2BrTuAFr7TEZra1EaWpoW
	 pcmz8VmuWSSUpS6DeMTpU+tEIqjLDriQ9pFhvBVF4LPGjotFQUwyDPmi1wQ2t1PlRJ
	 rwvCuzP4Ao3xg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/5] bpf: Allow use of skc_to_mptcp_sock in cg_sockopt
Date: Wed, 11 Dec 2024 11:11:53 +0800
Message-ID: <8521a7350fadd389e60b24bd67c21aca67d9b03f.1733886326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733886326.git.tanggeliang@kylinos.cn>
References: <cover.1733886326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently, bpf_skc_to_mptcp_sock() helper is not allowed to be used
in cg_sockopt. This patch adds this permission.

Thanks to the previous patch allowing skc_to_mptcp_sock() to be used
with MPTCP sockets, this permission allows this helper to be use it in
CGroup BPF hooks, e.g. [gs]etsocktopt.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 46e5db65dbc8..1ca22e4842cf 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2358,6 +2358,8 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
+	case BPF_FUNC_skc_to_mptcp_sock:
+		return &bpf_skc_to_mptcp_sock_proto;
 #endif
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-- 
2.45.2

