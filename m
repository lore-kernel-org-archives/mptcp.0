Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB018B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269796; cv=none; b=OACSWJ/WR3JR+SgrDII7sJNiYP3pAVDVgcvZzR70lMKyjDzOkw9zTsMiVJyvTruEhtZyowmlo3iBIrwMVLgSiEjvv3rTp0sUnur5v+E8sQrrBTqPON5p1a7VNS95wM3MbBUYF9QSmmtXv7nBMRlhtfVrwBYkThstbSeaXJqe7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269796; c=relaxed/simple;
	bh=G73D+Bht6+hcOIxbDDu7QISkUjUhFAswMUSI8nRg8zU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0nW41N9QglBXJCp60wfuzreetfO92aampiJL3uLhbMiEQHDARb+f4Faehga4jpjJwonPyCYJz2L9RJC4F+Ly3I4JxGsDLkho7jvIZ9AtrqAXzf061ugbvkbYUD/AZez02jyCsAK+YVyLWlIj8quFgbTNpeL82MtU1ZuKquJR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpUUoYZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpUUoYZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DB5C4CEDD;
	Tue,  7 Jan 2025 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269796;
	bh=G73D+Bht6+hcOIxbDDu7QISkUjUhFAswMUSI8nRg8zU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bpUUoYZtqwkLrOyLzAyIfNyE4hhK+p6Mo/XdMSgefXT8SFIb4LGTb9x1izxf/mtil
	 Z/g0Wcyvil8bxNBDnC18wnjoAFsgviLTqFnLC8rN0rh9BNZGFHVP0ZAy11pRqHaguk
	 ewyR9RRD6SNKN9AAn/q23D/iHeJ0593MHXnQ0jIczC+7N1dr0DlqKHKUyY9pABTsaZ
	 lsoZI5CoougjFS/eN8tAd/IlrLCvkr4HvOrzis3hQOVemEIkVYuutO31Sl7PjYTX0M
	 5XZ5Z/1yLBI+CjlMXng2+5NZAqs7zm9RGAeXcvZzdvWx0GfxXTazIvN7pSkf0Fnm5Q
	 s8rzgSq7lWvkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:33 +0100
Subject: [PATCH mptcp-net 9/9] rds: sysctl: rds_tcp_{rcv,snd}buf: avoid
 using current->nsproxy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-9-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=G73D+Bht6+hcOIxbDDu7QISkUjUhFAswMUSI8nRg8zU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/aE+7MU+fLfJLn41H1lfKYwzxL++aziPHBE
 +EWVhujigOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 cxxREAC04uBLGO6GcWzg0buDiUXsvMhTEUhbPSsxEwY/H1tWEQ9++yxKlc2Zcz0WQH2eLu637EH
 oSaTSv6rgYc9HLocFVm1gJ8DGD4eKCZZJs/lD5SsyT4s3KPPOTDa/xLh9Ti2qOoJy0UMR+CsBeT
 flqUOP28JJGGwaTBw0FNp3fyT/c+6PgDtUxQt+URqSZpanJCBNSrX0Wtevme5HABSHe5BlJbdPx
 pJl6WNwDM7wf5E7S16ZV44SJzBcbSRiAe+QcYXVWU45zcHNpW3QcygI8pr2YCp9HVQS9XJS9A2e
 5G831isozNgsqKbNkCwyfdM2qCD3dCIhSiLIqdmagIwmyTSbrQe1uZ+53CjZ5dDLy9u6EjKqZO2
 DzPU99vqt7OaU/JmHSkXXM0w/MFFHgSPqOq3Grmj9uFAD8KEx2TF0FAbQu4Z4P/X3PSx3zkxxLr
 SLJ0ELVXFqpKWaR6pJEB2RADmRAsgnxI3ylboEV8KnmWvx6X10reCJdimdtv3vk08/ROshwfVuA
 ibFLq7qN8/oHyPTajdFHkKRHsl0m5odBhdyjCZQul63A8VNTZTgGhgiLgPSa4W6M6fqGXjJrQUC
 mPcBhb4Z+zBWPZrmj8Jh3e8HhlX2F75NJ7VirQnaL0dYT4sjuDsPJaaMRIe6TlTx5Orvm1E9fKY
 r0+f4OoLgz8432Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The per-netns structure can be obtained from the table->data using
container_of(), then the 'net' one can be retrieved from the listen
socket (if available).

Fixes: c6a58ffed536 ("RDS: TCP: Add sysctl tunables for sndbuf/rcvbuf on rds-tcp socket")
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/rds/tcp.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 351ac1747224a3a1c8b0e297ba53cdbbcbc55401..0581c53e6517043ad6c2ad4207b26ab169989ed8 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -61,8 +61,10 @@ static atomic_t rds_tcp_unloading = ATOMIC_INIT(0);
 
 static struct kmem_cache *rds_tcp_conn_slab;
 
-static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
-				 void *buffer, size_t *lenp, loff_t *fpos);
+static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos);
+static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos);
 
 static int rds_tcp_min_sndbuf = SOCK_MIN_SNDBUF;
 static int rds_tcp_min_rcvbuf = SOCK_MIN_RCVBUF;
@@ -74,7 +76,7 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		/* data is per-net pointer */
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = rds_tcp_skbuf_handler,
+		.proc_handler   = rds_tcp_sndbuf_handler,
 		.extra1		= &rds_tcp_min_sndbuf,
 	},
 #define	RDS_TCP_RCVBUF	1
@@ -83,7 +85,7 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		/* data is per-net pointer */
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = rds_tcp_skbuf_handler,
+		.proc_handler   = rds_tcp_rcvbuf_handler,
 		.extra1		= &rds_tcp_min_rcvbuf,
 	},
 };
@@ -682,10 +684,10 @@ static void rds_tcp_sysctl_reset(struct net *net)
 	spin_unlock_irq(&rds_tcp_conn_lock);
 }
 
-static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
+static int rds_tcp_skbuf_handler(struct rds_tcp_net *rtn,
+				 const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *fpos)
 {
-	struct net *net = current->nsproxy->net_ns;
 	int err;
 
 	err = proc_dointvec_minmax(ctl, write, buffer, lenp, fpos);
@@ -694,11 +696,34 @@ static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
 			*(int *)(ctl->extra1));
 		return err;
 	}
-	if (write)
+
+	if (write && rtn->rds_tcp_listen_sock && rtn->rds_tcp_listen_sock->sk) {
+		struct net *net = sock_net(rtn->rds_tcp_listen_sock->sk);
+
 		rds_tcp_sysctl_reset(net);
+	}
+
 	return 0;
 }
 
+static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos)
+{
+	struct rds_tcp_net *rtn = container_of(ctl->data, struct rds_tcp_net,
+					       sndbuf_size);
+
+	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
+}
+
+static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos)
+{
+	struct rds_tcp_net *rtn = container_of(ctl->data, struct rds_tcp_net,
+					       rcvbuf_size);
+
+	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
+}
+
 static void rds_tcp_exit(void)
 {
 	rds_tcp_set_unloading();

-- 
2.47.1

