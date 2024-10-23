Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A3381BA
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674039; cv=none; b=Y26oELnO6ZCs2qk0NF3ChJNSiZL1taO/IywiGPwcfjid0HPQG0mwnY2l2INJG/lmtqXQAA5UIV6XNJl5fcOYsZXleCa64izXxZYeCbzwvWl+3yflpdd4uDg3v6dn1y92NTD/qHPxiOi1glXEGvTreNPj5y263cFeCdhtJ1R+J1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674039; c=relaxed/simple;
	bh=CDf9mt3sG4HWiocgdwT36RlB+ocRg8Ba1PXlIEhbmwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbkiMRaqETexsX3uqxgLLA9cke27020MBDRq5NTWhsg+sOmtqFEA9BVIhvp5J2bdYnj1NoW27fM7sDaW6wNHFG64jtGTx9ofaFavSWwN+EVrZbKRj4AXPVhCfd1gmsgyi9XM4Hmv6JYpGiPiJCblINUDRVkBhq4ggsQmwJKkCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0VnbfcB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0VnbfcB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2991BC4CEC7;
	Wed, 23 Oct 2024 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729674039;
	bh=CDf9mt3sG4HWiocgdwT36RlB+ocRg8Ba1PXlIEhbmwc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=K0VnbfcB8/RhTow8pSLQGuqc8pnK0bbc3fC/yQ3pfpgi8nhDjphpR/pQUadCgTYMy
	 YKKYomInqXwKF60+fPNSRod7Xw4nCkZEkRcQoBNioewnyBKLpYXP+tPUDgjcbcAT2s
	 ypofWoPyAiQZkyYPswA4QgstQn+9W4BximXPUlBya9pVb5yuFFszcBdrRBRPhTUW9r
	 ryAQepKpFWmiyqH9zsqJ3a8C/dYUw62N6I9wsVX+bzNuGCBZNWjSPLqTkelz/ZfjMi
	 z2BIvyJl4O0bRVK+JcpCLOBQX6vdKcCqj/VPnbXt59/OVwMW2tvtxGsBXDCGSgTpol
	 6pKyq2EPasoKg==
Message-ID: <f9753af44988c9279cdc6e59db453a0bb451d6a6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 5/5] Squash to "selftests/bpf: Add
 bpf_first scheduler & test"
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 23 Oct 2024 17:00:36 +0800
In-Reply-To: <66d3e0b9-cafe-30c2-4d2a-09f29c3f1b52@kernel.org>
References: <cover.1729583414.git.tanggeliang@kylinos.cn>
	 <47d89319cf58196896a25ae6b3199b27ad73fe97.1729583414.git.tanggeliang@kylinos.cn>
	 <66d3e0b9-cafe-30c2-4d2a-09f29c3f1b52@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-10-22 at 17:10 -0700, Mat Martineau wrote:
> On Tue, 22 Oct 2024, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Use the newly added bpf_for_each() helper to walk the conn_list.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > tools/testing/selftests/bpf/progs/mptcp_bpf.h       |  3 ---
> > tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 ++++++++--
> > 2 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > index 376979a9c4f0..52bc8ac03508 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> > @@ -60,7 +60,4 @@ extern bool bpf_ipv6_addr_v4mapped(const struct
> > mptcp_addr_info *a) __ksym;
> > extern void mptcp_subflow_set_scheduled(struct
> > mptcp_subflow_context *subflow,
> > 					bool scheduled) __ksym;
> > 
> 
> Hi Geliang -
> 
> > -extern struct mptcp_subflow_context *
> > -bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data,
> > unsigned int pos) __ksym;
> > -
> 
> After this is removed, there are no remaining users of 
> bpf_mptcp_subflow_ctx_by_pos(). I suggest removing that function.

Indeed, I added these cleanups patches to v8 as well.

Thanks again.
-Geliang

> 
> > #endif
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > index d57399b407a7..f2f9e66455b6 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> > @@ -20,11 +20,17 @@ SEC("struct_ops")
> > int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
> > 	     struct mptcp_sched_data *data)
> > {
> > -
> > 	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0),true);
> > +	struct mptcp_subflow_context *subflow;
> > +
> > +	bpf_for_each(mptcp_subflow, subflow, msk) {
> > +		mptcp_subflow_set_scheduled(subflow, true);
> > +		break;
> > +	}
> > +
> 
> The iterator makes this more complicated. Use 
> bpf_mptcp_subflow_ctx(msk->first) like bpf_rr_get_subflow()?
> 
> - Mat
> 
> > 	return 0;
> > }
> > 
> > -SEC(".struct_ops")
> > +SEC(".struct_ops.link")
> > struct mptcp_sched_ops first = {
> > 	.init		= (void *)mptcp_sched_first_init,
> > 	.release	= (void *)mptcp_sched_first_release,
> > -- 
> > 2.45.2
> > 
> > 
> > 

