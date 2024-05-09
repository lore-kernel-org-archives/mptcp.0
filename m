Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F1304BE
	for <mptcp@lists.linux.dev>; Thu,  9 May 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251726; cv=none; b=VglDniL/ss4ay/zwy4LeqevtX3Rj7m8dt04r6IURuCBjAULDopkiolG607QvBEOKFUeMU+roYxF3luigKMFkp89miGAsPCmcQy7IrGKmUpt/2894Vpt0BuuOzDa8M8HrIbFj3ar0qbx+cnmLkYkCVcVzOYh68gpP9qqOyYBscoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251726; c=relaxed/simple;
	bh=l3MdJu72Q019WCRCg5hsxvWTYaRFlkaSPHG4yOfbwFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kB0/y3Dg00GfbZl1rdhcOqZVFf9D0NMi4v4Vr9YpAeKq4qhL3KjwU9oY6t+28qm3P5TZzuAt0O+IKVGO3N4zWWffqIijqpntHA626n0cAmMcMQ9FaRWK6NsuO2QKleSAMKfOueDhF8wRelfqrXwVUoIV6xD/yCcZAYijH3JM+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7tJ6QCO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7tJ6QCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5917BC4AF07;
	Thu,  9 May 2024 10:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715251726;
	bh=l3MdJu72Q019WCRCg5hsxvWTYaRFlkaSPHG4yOfbwFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t7tJ6QCO+ILutp50P+0VEc3ESD+I+ihXsFN9/2kbUN8VDwpN52FzT04wfT/jJ58FT
	 GO7h4JU4uXc+pKV2QhXHjDfbMp9tFPfqvW6oN8OqdbpZEQJpdfS7KBb/eK0/n2j3Qj
	 TeI/03+VBF+Fj1DQUy+E+rZV64LcqNNR2ddiBX3QrsHDHDXmSXcL/eqltu8VR+EyIq
	 1/W2cz8fsgsGDBF69tNcs1VmHeMR/Jn1L5fjnm0Kx7EGXlwOe6R/tEH4xkHoDYOlKE
	 cxTTryWBetPyYsY6n/3V7Z6B7m/HweFgt0bv6qRij82aYBMawfSDNshaAMfTr7JNQM
	 hNfYRlFtzhGIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 May 2024 12:48:21 +0200
Subject: [PATCH mptcp-net v2 1/2] mptcp: SO_KEEPALIVE: fix getsockopt
 support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-mptcp-tcp-keepalive-sockopts-v2-1-5f97067847a2@kernel.org>
References: <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
In-Reply-To: <20240509-mptcp-tcp-keepalive-sockopts-v2-0-5f97067847a2@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=l3MdJu72Q019WCRCg5hsxvWTYaRFlkaSPHG4yOfbwFc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPKoLw8cyCbZFsQ1kg84n+cRqpC4AcQpHo1rvI
 VS0CRcsyOuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjyqCwAKCRD2t4JPQmmg
 cxQmD/415QYnsEr4bu+AQ+oNoY95nMTMMa4yZY3R3JmmtWt03I8UNvplbwzJ6gkDn3OHsG9wrHd
 ExUW4SfgIW2DewheDJ6D00nGXZ4g9GDM6gr81U3h4tlzBE3xCENxL4xSc2yMS7xhkBSuwVxLxO1
 Qpz82vE9rqq5uxUOJO5lj8jK4/hSgLAxR20w8O+exjL9O4EOGHjPkQolbbTiIdKn6ldrMGU0tRM
 KnEKxL8xyFjbaIrtrXz5BU3pj16PChh2NA/hmjN5nfxx5QIjDRmRUTmn8uaS6DT+gLOswI1JlFy
 1HSpu/xB3QfZzvAvEXwe7VYFX/TJlVIZIk69Kj2O29ATwqjyl4MZm2LTPmQ6FxdL+uKEdLLr0I1
 O5oPgeGW1TE9Rj9RGFGxdb7LovsH7zi79YBcBKVZumn9toT0A9+lhQcYV4uPP+npfZXTBItXYo4
 hYlEqWkHHIk6Jo/jXuhrjUUFORE3EpaYgHMAA5m3mCYfmy6Dplw7ypBn+4uL1J0WjVHy0vv9V8x
 +2pRvndGWRT3pRhVK81yaLYg79HwfsPI/rzntYxgdqDGKcdCJga7wsiuy24idc8MGwiJOfbK4S/
 k9YObJKOu9XUngrx5maI9oKDwglyNtp8nZD914e676jBafIXQ4s+kyz12+I2X63oDOelcUA/Pyf
 axUBwYc5ls2dzWA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

SO_KEEPALIVE support has to be set on each subflow: on each TCP socket,
where sk_prot->keepalive is defined. Technically, nothing has to be done
on the MPTCP socket. That's why mptcp_sol_socket_sync_intval() was
called instead of mptcp_sol_socket_intval().

Except that when nothing is done on the MPTCP socket, the
getsockopt(SO_KEEPALIVE), handled in net/core/sock.c:sk_getsockopt(),
will not know if SO_KEEPALIVE has been set on the different subflows or
not.

The fix is simple: simply call mptcp_sol_socket_intval() which will end
up calling net/core/sock.c:sk_setsockopt() where the SOCK_KEEPOPEN flag
will be set, the one used in sk_getsockopt().

So now, getsockopt(SO_KEEPALIVE) on an MPTCP socket will return the same
value as the one previously set with setsockopt(SO_KEEPALIVE).

Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2edaf1a16005..d9f0d36e24ad 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -181,8 +181,6 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case SO_KEEPALIVE:
-		mptcp_sol_socket_sync_intval(msk, optname, val);
-		return 0;
 	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:

-- 
2.43.0

