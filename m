Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D01CFBC
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316912; cv=none; b=p4eXUHB/AjzF442FOQG/s/mYMukyN6rexMmoUfTc3SbVC4MOGSF2rxxfFQ2Fp8RexlpR5PMU4KjqR2pwZwULpo9il7K6u2pDRyJuLyxOrq5VOMe/OnBABVJ6TRG2HAAjFRWoURzSoGuy1I4DXCZtayw41nmuBvmDP1bOHHDJRL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316912; c=relaxed/simple;
	bh=y0A0VA9Ew4m2Vn3OvhP3BG6Y7XGY81pYeOBP/JjCKek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k3Mbd7cbNqUl3+G9NT8HbGc+DsGsXJlRCZLf31Dxya3aa0eFfYfuU7SzspsZ/sbyVwjXUQL4Kl31ognreH3kuLMEiYqBw5Rzeetu6rCV6vEWQNo6ROpFZZaUJHDD5Ae8+54aJYsxoj4Sqt9rgxoS31agZBL3bOAkXwh3m2Ozggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9KUxiw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9KUxiw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A67FC4CED1;
	Fri,  7 Mar 2025 03:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741316911;
	bh=y0A0VA9Ew4m2Vn3OvhP3BG6Y7XGY81pYeOBP/JjCKek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b9KUxiw5W76HxTE0YplRNkgoGglB+fLcnydpouRpkcScPJWJeQkI/ZJa5kGm3/6yp
	 A/TEBNaJBuneDgzxJuuuOJuht9i43sM3wIb9XdsZ9mLL2Svh/YXSD9od/ncBGqkzkT
	 jLEip5OX50uxCMRMSgsWMCAxVObFV00toAxuqrh8RpHTKzSAXK3KNSNci3z9rcIR31
	 zS/SlGwO/tYx390oHSPpshIYg8Pzla9UHGFqZk3s59PSyu4elKzCPyoFxUH6BXUetA
	 hYXiMafpqVnKFVScPyxjogIy+GfNNUzS8rb8fR39ooMkP0uu5sDe4HItSgtZbMqPZh
	 WMtp9VR2gxMZQ==
Message-ID: <02622736c58386a5d074b5a64af5d76b7f35248d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v15 0/8] use bpf_iter in bpf schedulers
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 07 Mar 2025 11:08:27 +0800
In-Reply-To: <ba7822fb-a0cb-4636-89fc-ad1355e4c234@kernel.org>
References: <cover.1739788598.git.tanggeliang@kylinos.cn>
	 <ba7822fb-a0cb-4636-89fc-ad1355e4c234@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt, Mat,

On Wed, 2025-03-05 at 17:14 +0100, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> 
> On 17/02/2025 11:41, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > v15:
> >  - patch 7, add the declaration of bpf_mptcp_subflow_tcp_sock
> 
> Thank you for the patches and the reviews!
> 
> Now in our tree:
> 
> - 07aa0978f6c6: "squashed" (with conflicts) patch 1/8 in "mptcp: add
> sched_data helpers"
> - fa29b1f91c26: conflict in t/bpf-Add-bpf_mptcp_sched_kfunc_set
> 
> - 311895dc3441: "squashed" patch 2/8 in "bpf: Export mptcp packet
> scheduler helpers"
> - 3c6796421a18: "squashed" patch 3/8 in "selftests/bpf: Add bpf_first
> scheduler & test"
> - 86c995604f64: "squashed" patch 4/8 in "selftests/bpf: Add bpf_bkup
> scheduler & test"
> - 0b70cc3bdfe5: "squashed" patch 5/8 in "selftests/bpf: Add bpf_rr
> scheduler & test"
> - 8213e7e2d049: "squashed" patch 6/8 in "selftests/bpf: Add bpf_red
> scheduler & test"
> - 3fe124ac24c8: "squashed" patch 7/8 in "selftests/bpf: Add bpf_burst
> scheduler & test"
> - Results: 3161a41b78f4..a37b7ba9c462 (export)

Thanks for applying this set.

> 
> While at it, I added two patches, as a follow-up of b68b106b0f15
> ("mptcp: sched: reduce size for unused data") instead of patch 8/8:
> - e74f811b4626: Revert: "mptcp: add sched_data helpers"
> - Results: a37b7ba9c462..a44778c76bc6 (export)
> 
> - fe2716bcac00: mptcp: sched: remove mptcp_sched_data
> - Results: a44778c76bc6..516dcfe47eed (export)

I think we need to keep mptcp scheduler API unchanged. We can keep
struct mptcp_sched_data and mptcp_sched_data_set_contexts helper for
future use, as I said in patch 8.


The bpf_iter_task [1] that I am adding recently can actually use them.

I've been thinking about this recently. It's not a good idea to add
bpf_iter_task to struct mptcp_sock. It's better to add it to struct
mptcp_sched_data instead since it's more related to mptcp scheduler.

1. Add bpf_iter_task in mptcp_sched_data.

struct mptcp_sched_data {
        struct task_struct *bpf_iter_task;
};

2. Set bpf_iter_task as "current" in mptcp_sched_data_set_contexts:

void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
                                   struct mptcp_sched_data *data)
{
        WRITE_ONCE(data->bpf_iter_task, current);
}

3. Add a struct mptcp_sched_data parameter for
bpf_iter_mptcp_subflow_new:

__bpf_kfunc static int
bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow1 *it,
                           struct sock *sk,
                           struct mptcp_sched_data *data)

4. Check data->bpf_iter_task in bpf_iter_mptcp_subflow_new:

        msk = mptcp_sk(sk);
        task = READ_ONCE(data->bpf_iter_task);
        if (!task || task != current)
                return -EINVAL;

        WRITE_ONCE(data->bpf_iter_task, NULL);

        msk_owned_by_me(msk);

        kit->msk = msk;
        kit->pos = &msk->conn_list;

5. Use bpf_for_each() with "data" parameter in bpf:

SEC("struct_ops")
int BPF_PROG(bpf_red_get_send, struct mptcp_sock *msk,
             struct mptcp_sched_data *data)
{
        struct mptcp_subflow_context *subflow;

        bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk, data)
                mptcp_subflow_set_scheduled(subflow, true);

        return 0;
}

WDYT?

Anyway, we can put the patch "mptcp: sched: remove mptcp_sched_data" on
the export branch and wait for a while, don't send it upstream
recently, and wait for me to send some squash-to patches to modify
them.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/7ff2760dcee1532f624e2ccf4fd67e83ec09a01b.1740997925.git.tanggeliang@kylinos.cn/

> 
> And the adaptation in the BPF code and selftests:
> - 0228f6dcc40b: Squash to "bpf: Add bpf_mptcp_sched_ops"
> - 145b54903251: Squash to "selftests/bpf: Add bpf_first scheduler &
> test"
> - 4ebb90f81181: Squash to "selftests/bpf: Add bpf_bkup scheduler &
> test"
> - 2af0575eda92: Squash to "selftests/bpf: Add bpf_rr scheduler &
> test"
> - 1dd84d973730: Squash to "selftests/bpf: Add bpf_red scheduler &
> test"
> - fff0e60b0834: Squash to "selftests/bpf: Add bpf_burst scheduler &
> test"
> - Results: 516dcfe47eed..62dab9e8d979 (export)
> 
> Tests are now in progress:
> 
> - export:
> https://github.com/multipath-tcp/mptcp_net-next/commit/a5cceef4fc35169482ecfd086c3d19c15d23e7e6/checks
> 
> Cheers,
> Matt

