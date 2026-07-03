Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400B2F25F0
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097872; cv=pass; b=AsdNh+nqZ9Eak6rbayfwWSI8W0ggOtiG80SDHZk7kEctlycPs+W39uD9Lc5LV+06zr/GnG8E0THVfJrW1Hxe4YDZj275ZiWJ8PwZN6eaNmBySc+OBW/ZJYcbLXIplsI8TzS/ZcWYeQlk1ccRh5YCS1XJALthyuboCZOTl9w63mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097872; c=relaxed/simple;
	bh=jitpQd2+8qWaDrPhdre+KCi8xQcPh0sEIVxHTwUPKqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCXEr+CaZWHZAXVrAkNJiGtO/Ia8iR3hkgFLgsTsLgC6ZXRePwqwc+5SIo55eqEy+kSIJEoXUmrxT7DeAoPPQyi9aHAvrtKvvm/m2oNQ0Yih9f1igU45+hTY9UUm5xz6ooXi3DEkKfG53Ez/Txs4skspQF9GuNbGdP7TFU5F8d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=u25YVHoC reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="u25YVHoC"
ARC-Seal: i=1; a=rsa-sha256; t=1783097851; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eylmZ+r8DzB/RaGtT8j2jg79X8870YluLoVLsVE+MKt5dLe4IRyCdEbcQDO5H/g/Z2XmtbPOZbx/ZLR0/sKeWygEucFNjRxMMIQAIsVa2/WJ0Oatcz0OCEuYoP5xR0NjT6hJCT4Muyl3qVPoFprkW5RL04fVQZZxOW/A+LPNu9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783097851; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oAz/coNgtv/PXSMi7xpEgJ38onaRCDNm5A7nN60kG5w=; 
	b=FvEibQf4fQoTxqGL6cK+pj7E9wMUYIpY97fuE6igSj9Me2I8bBDw3GIUaOrhFYDcjN6w5fhLLmYbZGInGQ3O/j3JL4tiHdW0/f/pT7GF1zgO5YPfHjdOv3dLywdQBM0wkCFqxauUsyTOrwR5NWY9P2a1qTobxG9xVpXbV9mAMv4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783097851;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=oAz/coNgtv/PXSMi7xpEgJ38onaRCDNm5A7nN60kG5w=;
	b=u25YVHoCKZywlXovXuLUfuSEPrb3MpyGL5Ys1/Y7Csri/nT3T+RhsQyVDMBbONJK
	Hgf8AnMyeuXVDA7EsTTqkjlhtbGb+hcigffReZYZxnN2SJ2EAuXVYxW5DhziEmQybx4
	3BHS09l8g9q4Pvq51jR9YBU8mQK+S70WHmMtO+Ok=
Received: by mx.zohomail.com with SMTPS id 1783097849791117.08005737241285;
	Fri, 3 Jul 2026 09:57:29 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 03 Jul 2026 22:27:10 +0530
Subject: [PATCH mptcp-next v2 2/5] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mptcp_bpf_kfunc_fixes-v2-2-87ae3c64dc7e@mpiricsoftware.com>
References: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
In-Reply-To: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

mptcp_pm_subflow_chk_stale() is exposed to BPF MPTCP packet schedulers as
a kfunc taking a generic "struct sock *ssk", but it treats ssk as a
subflow TCP socket: it derives the subflow context with
mptcp_subflow_ctx(), an unchecked cast of inet_csk(ssk)->icsk_ulp_data,
then reads and writes through it. The verifier only proves ssk is a
trusted struct sock, not that it is one of msk's subflows, so a mistyped
or foreign socket would make the helper operate on a bogus context.

Register a bpf_mptcp_pm_subflow_chk_stale() wrapper that validates ssk is
a full MPTCP subflow TCP socket belonging to the passed msk before calling
the helper, which assumes both but checks neither. This mirrors
bpf_mptcp_subflow_ctx(). A scheduler passing one of its own subflows is
unaffected; the in-tree burst scheduler selftest is updated to the wrapper
name in a separate squash-to.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/bpf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9355fb53e89d5..e2d2c3394ad71 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -306,6 +306,18 @@ __bpf_kfunc static void bpf_mptcp_set_timeout(struct mptcp_sock *msk)
 	mptcp_set_timeout((struct sock *)msk);
 }
 
+__bpf_kfunc static void
+bpf_mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+{
+	if (ssk && sk_fullsock(ssk) && ssk->sk_type == SOCK_STREAM &&
+	    ssk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(ssk)) {
+		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+
+		if (subflow && subflow->conn == (const struct sock *)msk)
+			mptcp_pm_subflow_chk_stale(msk, ssk);
+	}
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
@@ -327,7 +339,7 @@ BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, bpf_mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
-BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)

-- 
2.34.1

