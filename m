Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3318B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269796; cv=none; b=kSf2QXAzOS4WNizZok842INg0D6HiAiRfn8NNLuRYYopnASHjs/Mr/DhQ1DbcxME+yiLz9O5ET4pzlrYdTC5CvmG1Q+UkWgoo5ODP8hjZKYumi+ZnrCxcHJQtn4nKx6WL7UE92ZT6fug8mGWaazfPzIg8UXLxTZqMq1FwleDn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269796; c=relaxed/simple;
	bh=ORHe+HyANduhzbj7hP/x+sQ0j4alZdtOlWgCsIHI6c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZ1dZdvt9a+PCY/NxnPcIirrYVNERYTgbrhdKZGAtRIqBMAeTos6CS82WHeTZlSgonT/yfE138VahD/VvJSTXecKFq1zjcGGr1R51Pqe4ZYqZz9NZB0BNVVABv+WhApR9HcQiGPZF+MFqmJfGImT4VZ6/1evcV0KJR4h2s8hB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzqszy0t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzqszy0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DF4C4CEDE;
	Tue,  7 Jan 2025 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269795;
	bh=ORHe+HyANduhzbj7hP/x+sQ0j4alZdtOlWgCsIHI6c0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xzqszy0tKkcz1JFc9aBUCu3C5pcTaaVwvxUOZmxHu78NSeaybQ442cofaUH13WVOv
	 t+2jHVbfwdlLuRYxDQSkYESD47J5OoxbaBYqQO6PxOLW/Ui+KyymZZrAO3xEnshZTW
	 bInr2O3ygFTS8vj3wbcgLBncAARzR56cvG+3sTB8peRa9eZYtaEbR+FqEfjGzPe5wu
	 1hXeG2p9ZDZ56Sy6ZUdDkB9nuMYPi21gMIA/AMpCcYqhdjsGhQWUAnM1vzDgEwecGO
	 BgIAKdUywu+vVIFZvLhwQhIZOXwoNYrtzjRZoGjvSEw5kAV4Se1uRpwf2zo9IjaKZo
	 MltC/GUo8SLMA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:32 +0100
Subject: [PATCH mptcp-net 8/9] sctp: sysctl: plpmtud_probe_interval: avoid
 using current->nsproxy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-8-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ORHe+HyANduhzbj7hP/x+sQ0j4alZdtOlWgCsIHI6c0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/acGdLX+Z8CxLtVM+fPMWDrULcOi/x4euw2
 BaEdrS6Z6uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 c8ocEACjC6vvYgwJlx4gsEuhSwojJku40KNQi1OvB0SGKiz1iMyHAeJYxdi5IRYutYTzY3+/Zjw
 wij1rqqZZY1YxSlSjQG1gcA5jONH2bexdQuAavMadIwyOPwCT55+mOSoYuB0kgtGtbaxxfeAgLj
 CKhUMEgm/i+0hEoFzUCGL38i+0kb+glaemOGMwP6yrOzxhQ+ApRDfyAm47V89GjbdJxh/tzV4zC
 cow4rb3g8BG8/LlJ05hWPZQAN15TKggU7aOXBcL6eln3ISa9yn2tti05A5E+NwkxiIpR8VVGZn5
 TP/KrC+koU7ZXB4E7nL7JMbCRgJ+5jcDZ4u7FSpt2pxJf9n1PZKQPvXAymByhkUAeRZwqU484oq
 AG6D7Xi98bhEFWEYlZSzFu56kbinQugGkpTsJHOD05iuJ+blPIwIydOQ6Qf6ayL0Yp6I1J2gI07
 dFntwlsyBJOPTB1iNLhXQR/MTbqfbu8OolpoDQ1X891GGh20X+vMa0PHRnQk0zr5glv46tQ654V
 p/sG8wG3SVLCkmIW+pC5TfGw8FdBLix10M7KvHKiT711m4RCUpccC+mg4m8b7PDm5lFAEOxHL/O
 05OS8vf+TDGNkHNU4IqYgx3ryk1cfOLJyosnD592AMq0acI4hDkuvYECDviC+QzTs2KUn0RXZMN
 pPn3VHUef6Kx7Xg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' structure can be obtained from the table->data using
container_of().

Note that table->data could also be used directly, as this is the only
member needed from the 'net' structure, but that would increase the size
of this fix, to use '*data' everywhere 'net->sctp.probe_interval' is
used.

Fixes: d1e462a7a5f3 ("sctp: add probe_interval in sysctl and sock/asoc/transport")
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 18fa4f44e8ec8c86f8415b1251ef8a2979c7f823..8e1e97be4df79f3245e2bbbeb0a75841abc67f58 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -569,7 +569,8 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.probe_interval);
 	struct ctl_table tbl;
 	int ret, new_value;
 

-- 
2.47.1

