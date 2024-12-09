Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452591EB3D
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734045; cv=none; b=gMUod8Sy4tyCfvdS2V0byZAGbnFItDFTpnVKPo6enFup5ahej+t8t1ck53JbuGK30B3/GuGp4qt09astFuJsWSSpIV9w1R4MfD+UlOMEWGh4gapw9cVlT+Vsc1OU4IFrM+jMoAYqPfFnY4Bylfydu4mA4Hrf/gob0oj0d68bP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734045; c=relaxed/simple;
	bh=PDPl9RB/6dCKKUJchPq9UX9loOsc2k2o0XbbZp0CIYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgB1NwOWFtt6mxQriXGRKfTf4+DuXoPrV8nIunaYElvt6+WCZbbqI4BIY70wMBORYREa9+9a2rOxQZOK1j4sQqmb0fWkwairUWRaPo3Pg2GbWvQhw3JJlw/EH62gW4wGWO4WSy2jJmqtQEdiNzJdkLiABqWK6t0KK2/TIWNzkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmWGydXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmWGydXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2841C4CED1;
	Mon,  9 Dec 2024 08:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733734044;
	bh=PDPl9RB/6dCKKUJchPq9UX9loOsc2k2o0XbbZp0CIYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmWGydXc/8+WcDXts8NgMnELrSyCDMlMPXazOh1YDpRa92+wzzU4ssClr0cYQsFMQ
	 H2ZK0IGJiNsdAbN6FHx+TYVo3l9G8GVQXg123525JsA4/YZaAh5kYh8Vec33EAXzyh
	 oHjEobHxf90L3+edLYgwAKaPkcF2u8GDZ0e4sf6bcoCTh0mlwmAjYLa3DHCNuIe7dU
	 vIt/FDnGiJgjxWzC+Sy9YztM3u6x8LaL36fiJtMeHKxwqrfmB4bAg8bfZlJ2JKtWoX
	 eCPGU8gGyCQ1s051dQIaiIz86CXjLqA+3JDfl9HeID6/sttXVZoCWwsNUtVym9Ex3i
	 XoYI4j0+y0NaQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/5] bpf: Allow use of skc_to_mptcp_sock in cg_sockopt
Date: Mon,  9 Dec 2024 16:47:13 +0800
Message-ID: <b9f5c91345d3f545372463f0880c2617b2756728.1733733573.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733733573.git.tanggeliang@kylinos.cn>
References: <cover.1733733573.git.tanggeliang@kylinos.cn>
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

