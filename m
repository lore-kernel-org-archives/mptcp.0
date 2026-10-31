Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486697;
	b=bCYsVFsKUpkTB9UdY2EVqfsLO3a5g1XrcaAng4beKWYnwFymXjXCGeqBGejMhWgrKGuY
	 xiEhWzNP+PRWOe0WnquvOEfU9Uc5SHQ3M4JFe65HI0IUCpHjtc7To+WThu+/yx1nnYJ1f
	 AlV4kPY9Kc5UoIt/n89csz1Awtayx7ZbQTS5TWtWdlhstoQMIvSbOF7lQ+71auVSRiT74
	 AFYtG6wrnALOSVQWlNbKOHdIN/aS+5EmpcWYOIUr137pEiSg90tvEEAekKs7JR4/Q42bR
	 vCuqWkvPaX9LmGzzxeFMUxpEX4qkrKOfFfVVvExxNUkK+W45M4k0ifrRJF0EH3FJCog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486697;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=olDO0WMW9E7339UNa/dF5nkzOhMW9qqN5s+oJew3Rl8=;
	b=FwcJswpX6bQkWXboE3D3x80yb89LiA0OHN0rwjEORwMubU8AA7yp7y70i0vvd6wTfi3e
	 fqNR7+/4hFu6ANr8V3Dwy8Ep/SJEhep+qVwG6spiePoVrHOY9NS60ExIUqzaVnKzS81nP
	 vs5PHVQGHGdOHPgTmF8UgwEJyCLaiFScnzFI/LCIbCHx0slYcYvFHgVgx52nJWtTM45On
	 T7C8J/Y31YktwC5O2wUAb3B52sJYQx7d584RuTW8iSC7tL6GEfDJO6KEKdQBSc2rZoNpd
	 0TAih9liAKBeMyIxpeujs+GGt5kSWN6RBm2TQXQG6AcT23G/xQTLuDtqoi68JdHlL9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NytY45dj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53C606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NytY45dj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD35B1F00919;
	Sat, 31 Oct 2026 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486696;
	bh=olDO0WMW9E7339UNa/dF5nkzOhMW9qqN5s+oJew3Rl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NytY45djeRdfLvfMvaIk/eZ0K2W2B1+pimxTVKSSkcIy6wdfG395KnYFSHL9y0RWs
	 zFMEd9jm+6pjB84oFPMmUgEFmqrNecoMxBG/ht8W0bZbC+62YVHNngKszqQMVde296
	 cs78jOnNkq+K0kZY0zYjd9zCd5ep0sM3WFQ0wuTZ/vhtsZYF28L1Dr838FdNohXDxQ
	 gpLtSbqQ/WcLJIgYwxM5mapL5guy9a3hnOouiYhUHutgFcDGaKJXgEhr0CxbKXDb6m
	 2Xr1BEnc+NW4moGBwU2l9WL6BX8YyD/+uByP8te/pqUMp7oQU7VPCNrPzzNd6reInU
	 mkRf9RmKdw/CA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 31 Oct 2026 23:44:38 +0100
Subject: [PATCH mptcp-next v2 6/8] mptcp: sched: let a BPF scheduler set
 the send and reinject limits
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-6-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DiZMaCeYF/ikUIPynJuYh3wBqd3wmXM7j1aSizM9Blw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKe5ccnn7rd431ShdkxfDdPhK2oWNjl7g9nOqyb9jsfd
 nAIv8DeUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBHLHIZ/9g5b2tyf+aT17jqn
 vN6T+5TAMYnTn8/e2JYpe+aOrgTPIkaGU+fMbucJCAh8dpr+XqC361/jvJs2K1euufnshdOhV88
 zeQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Abdul Wasey <w453y.me@gmail.com>

A scheduler can limit what is sent for one decision with send_limit, and
what is resent on an idle subflow with reinject_limit, but a BPF scheduler
cannot write these fields of the subflow context yet. Allow it, so that
it can set them in get_send and get_retrans.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 53111d7a9eee..832dd807f672 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -63,6 +63,12 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 		case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 			end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 			break;
+		case offsetof(struct mptcp_subflow_context, send_limit):
+			end = offsetofend(struct mptcp_subflow_context, send_limit);
+			break;
+		case offsetof(struct mptcp_subflow_context, reinject_limit):
+			end = offsetofend(struct mptcp_subflow_context, reinject_limit);
+			break;
 		default:
 			bpf_log(log, "no write support to mptcp_subflow_context at off %d\n",
 				off);

-- 
2.55.0

