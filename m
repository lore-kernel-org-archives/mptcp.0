Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADD4242925
	for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130205; cv=none; b=eyogiHrlbTX2+qNyKs066HQqRsz1hAsDYL/s4Eal8YGhu/9q1hmZm1QjcnHjWeD05Kj7B6VJdPMWGxcePrPo+0SnIryLWVWwLqpvHwfShG/eQ05z4O5/q2nITa9PNMp3rkdRpRCsolZQV9lR4nz3Id8GfwYWuWohJHo1kGXDctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130205; c=relaxed/simple;
	bh=i+zfIWSk5Yyh+CsgJiQoi9JopyK74XFsgZ0y4qXuiVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XrludAxXUNasRErvcc/NoaHotAVi5OHlvtQORdBGUhwSeUeiY+17g/Y4wHxIlB4JerCLFruP2aeqWJvQ2bhhzKE5pia3szYy5xI0z8U76mt8ACGTBaxSun5A1fSeiOIl8ftgnLf2dla2VmxxFvgWjBDv0XllQVDZYT16dmMNNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCeZl1It; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCeZl1It"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b39280167fdso3400442a12.0
        for <mptcp@lists.linux.dev>; Mon, 21 Jul 2025 13:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130203; x=1753735003; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOvDOtNuHuKEQ0AG8licv0sCiHFkG4hjeCZ8hfYKZ/g=;
        b=gCeZl1ItfO+BcBDmdtcCeaXa68e5KfbmXh3BDeaGS9egtVF7JNhRLE3K+UGUjLRGPF
         ljma7uQ7j0n+UKf5dk6eOs/Glkmq4IRrY+VmA0U6SGAu/+GckqZPs8i8oEGKjvNI4xoF
         BudpJqKNMQc+tAGFQJv01ImlO+C1DkU+M/VsF2lxH7EkhK0puO4XAxzwjl+ILb/omKBY
         E+T9DnjhxGChTBQTVbcCE9dsQDrZjobqsm9dmu0hMkISATK/v8ZRXozBj5TrbaljDtea
         KO0g2QYGX9OSWLLd/InJVkUqWZSeyYNLsZjcpOJjOnoXcimPU1T70tubA2lT35+UaorK
         olfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130203; x=1753735003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOvDOtNuHuKEQ0AG8licv0sCiHFkG4hjeCZ8hfYKZ/g=;
        b=GFuzsgIXDvK8o0+RnpQKQIsBPn82Dke72axK1hJZZTSAHcWnnWuuG8srQSLhpifZ6r
         e4lBN4yMThYZwrNGYmxUGe0Jr8hyK90dh1QM4J/myfdpwgzksXD56zWURagM3kGZSyLu
         XdG61ve/uHHV2zDINWjIp4vTvDgMAVA3HdvYcWmXECR1c15va6q28C0VFN2CQCtAqe/G
         P0WNiS4BLZtQZ5OEpS5We4HUJ6PyFHiZsPkXGpjU5EVsp/e7CtgYbyzQ6HYqOlKVSaeO
         ywcQBCLu6o5g13aJQgS/w5lDiGuwBmabzSxtuoFqB65HJPM+43iZKWdA+igsF+nT7vA7
         1TWw==
X-Forwarded-Encrypted: i=1; AJvYcCVpP+7iY+mfAhh3e4G/5IwY2xpa3FvIIqj49kulqR1x2Kry3ScF3f1evLKIRkHXQ2e0tWysmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzklBdoLxe/FY8Iwpyas6A/qzuLzNPPUNv9Pq/wIe8SvMsWzSud
	wG92DiB+K+h+CEhnVG5J7tUrMSFNrKbsIbWaG5+npr4KB/6VvfSj1/BFKMGqw5pPLkFQ2rNEcLU
	Ro9Q02A==
X-Google-Smtp-Source: AGHT+IFVGe379XDWUF+9CY2yjFXvtKB+09OD1v073Z06Drs+S2iB6DNfmLq4LLNVW9Zv/pSwEo/nmwsHGbs=
X-Received: from pfbkx24.prod.google.com ([2002:a05:6a00:6f18:b0:747:7188:c30])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9150:b0:234:4f62:9b3e
 with SMTP id adf61e73a8af0-237d701a40cmr37381983637.27.1753130203466; Mon, 21
 Jul 2025 13:36:43 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:30 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-12-kuniyu@google.com>
Subject: [PATCH v1 net-next 11/13] net-memcg: Add memory.socket_isolated knob.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some networking protocols have their own global memory accounting,
and such memory is also charged to memcg as sock in memory.stat.

Such sockets are subject to the global limit, thus affected by a
noisy neighbour outside the cgroup.

We will decouple the global memory accounting if configured.

Let's add a per-memcg knob to control that.

The value will be saved in each socket when created and will
persist through the socket's lifetime.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 +++++++++++
 include/linux/memcontrol.h              |  6 ++++
 include/net/sock.h                      |  3 ++
 mm/memcontrol.c                         | 37 +++++++++++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index bd98ea3175ec1..2428707b7d27d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1878,6 +1878,22 @@ The following nested keys are defined.
 	Shows pressure stall information for memory. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
+  memory.socket_isolated
+	A read-write single value file which exists on non-root cgroups.
+	The default value is "0".
+
+	Some networking protocols (e.g., TCP, UDP) implement their own memory
+	accounting for socket buffers.
+
+	This memory is also charged to a non-root cgroup as sock in memory.stat.
+
+	Since per-protocol limits such as /proc/sys/net/ipv4/tcp_mem and
+	/proc/sys/net/ipv4/udp_mem are global, memory allocation for socket
+	buffers may fail even when the cgroup has available memory.
+
+	Sockets created with socket_isolated set to 1 are no longer subject
+	to these global protocol limits.
+
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 211712ec57d1a..7d5d43e3b49e6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -226,6 +226,12 @@ struct mem_cgroup {
 	 */
 	bool oom_group;
 
+	/*
+	 * If set, MEMCG_SOCK memory is charged on memcg only,
+	 * otherwise, memcg and sk->sk_prot->memory_allocated.
+	 */
+	bool socket_isolated;
+
 	int swappiness;
 
 	/* memory.events and memory.events.local */
diff --git a/include/net/sock.h b/include/net/sock.h
index 16fe0e5afc587..5e8c73731531c 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2597,6 +2597,9 @@ static inline gfp_t gfp_memcg_charge(void)
 }
 
 #ifdef CONFIG_MEMCG
+
+#define MEMCG_SOCK_ISOLATED	1UL
+
 static inline struct mem_cgroup *mem_cgroup_from_sk(const struct sock *sk)
 {
 	return sk->sk_memcg;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d7f4e31f4e625..0a55c12a6679b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4645,6 +4645,37 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+static int memory_socket_isolated_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%d\n", READ_ONCE(memcg->socket_isolated));
+
+	return 0;
+}
+
+static ssize_t memory_socket_isolated_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret, socket_isolated;
+
+	buf = strstrip(buf);
+	if (!buf)
+		return -EINVAL;
+
+	ret = kstrtoint(buf, 0, &socket_isolated);
+	if (ret)
+		return ret;
+
+	if (socket_isolated != 0 && socket_isolated != MEMCG_SOCK_ISOLATED)
+		return -EINVAL;
+
+	WRITE_ONCE(memcg->socket_isolated, socket_isolated);
+
+	return nbytes;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -4716,6 +4747,12 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+	{
+		.name = "socket_isolated",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_socket_isolated_show,
+		.write = memory_socket_isolated_write,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.50.0.727.gbf7dc18ff4-goog

