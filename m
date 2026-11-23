Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438333;
	b=44ze0MhNZP94MLTpVzxTrx5NQfEkHzDrqtRpqe09GNFYHafh13Z5SNGH0AyfwCnJSc4Q
	 Pu5hKVAH2LoDMhDTXnrXUzC2qCgDTeOeunstAUHXfyxD8EfD64k6FHIs5bDZ7qjM2e87d
	 c0J3ZQRCdaRrgrzn1/Ts3mi1X4GxIRraAQV4JXwcqJn9UaNNxOZuuFYtTC1VdnHDqPIZx
	 4u+2z4PZxTwRVCmlhKQYMiy5mf78nDICeGD2acGiYmyOiEI7XE9iJpy1lA5OEq2zHehdc
	 +XUgQtkafcRQ8BYerLRfz3rg9nrTaHUp2vN0a4t4omqh8lA8gr0KGtWr9D7kczV/4hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438333;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8WgYlv490BfACbxaxQDJ/n9v6UB/u89pzGiMBwyOegc=;
	b=TD0QHJRiQcJUhPYsHnmlKWxD8MzPXY5mU892yFaACl6hijbvNDb6oPahwJLoMWTVqpFI
	 QAHLlVIjgeLdcTsljXtwFZYJIAezmQyW2UtlarvsGLuoLDRsDvYNKcut63fJ78T4tokbj
	 RgpMp69M7ZlLXlUaxTPqT5LrmmwRvQF3rc7dVcGSobSyi4/Pdc/eY8qt1OsBWwcQaplGN
	 C7BVxKG/hjbI4x1qH26IaPMKrJr/1pdYTuP9/KUQ9X2B6NYh242dVWG2VlZtFi27hvBDT
	 hkqN64ze4mD0j+PFt7MNG5rEUpOlP8YcstcfdlKDjg4Z203ZC2ZWJBE+j8ZynAm/zhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0yyH5M7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01121606A6A3
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0yyH5M7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E4B1F000D4;
	Mon, 23 Nov 2026 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438332;
	bh=8WgYlv490BfACbxaxQDJ/n9v6UB/u89pzGiMBwyOegc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=P0yyH5M7klcTLW1tiyxfs/zV7I0hj9cGOLTBR4+aW/h1FVQbaOtAxIfD0qvpstuYs
	 s8HdmDy5r/saa82Z7x1a/AqE3ASRTA/vXRC/K9sjBG9McDBBWtoEKVGW4cYOnoqVp+
	 XEpFCAvpV0zE9vMx//CH+RmH+vDBPU8DJ5JfsLayD+K4dIJTPiCyg3YHE6IR4ImgTe
	 VT1fGr0KAU3tWJ6OTOqW2u9R1p7I15IB9a/MZk8A5Fbv80wOjL53wCy3BzZvwUXMZa
	 RxJO805YHoL40i1EwKrZcwOjVvbJ3hwQk3S7LxCHxBjwk7pfSneJF7xJIyAdPXGA/6
	 Q0jQs9PEOO4Jg==
Message-ID: <sashiko-outbox-229270@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v7 2/2] selftests: mptcp: bpf: exercise the
 subflow avoid flag across rounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kalpan Jani" <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
In-Reply-To: <20261123123730.3265284-3-kalpan.jani@mpiricsoftware.com>
References: <20261123123730.3265284-1-kalpan.jani@mpiricsoftware.com>
 <20261123123730.3265284-3-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 12:52:12 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests: mptcp: bpf: bpf_avoid_get_send() returns 0 with no
  subflow scheduled
--

commit e0591a67aaa7c65d7522308b6dae0bf53d4fc54f
Author: Kalpan Jani <kalpan.jani@mpiricsoftware.com>

selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

This commit adds a BPF struct_ops scheduler selftest that exercises
mptcp_subflow_set_avoid() across send rounds using per-msk socket storage.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/349

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c b/tools/=
testing/selftests/bpf/progs/mptcp_bpf_avoid.c
> new file mode 100644
> index 0000000000000..8276ceb0e5397
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c
> @@ -0,0 +1,87 @@
[ ... ]
> +SEC("struct_ops")
> +int BPF_PROG(bpf_avoid_get_send, struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct mptcp_subflow_context *first =3D NULL;
> +	struct mptcp_avoid_storage *ptr;
> +
> +	ptr =3D bpf_sk_storage_get(&mptcp_avoid_map, msk, 0,
> +				 BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!ptr)
> +		return -1;
> +
> +	/*
> +	 * Wait until a second subflow exists before marking it avoided.
> +	 * This keeps the state unset until there is actually a subflow
> +	 * to exercise.
> +	 */
> +	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
> +		if (!first) {
> +			first =3D subflow;
> +			continue;
> +		}
> +
> +		if (!ptr->avoid_marked) {
> +			mptcp_subflow_set_avoid(subflow, true);
> +			ptr->avoid_marked =3D true;
> +			continue;
> +		}
> +
> +		if (subflow->avoid)
> +			continue;
> +
> +		if (mptcp_subflow_active(subflow)) {
> +			mptcp_subflow_set_scheduled(subflow, true);
> +			return 0;
> +		}
> +	}
> +
> +	if (first && mptcp_subflow_active(first) && !first->avoid)
> +		mptcp_subflow_set_scheduled(first, true);
> +
> +	return 0;
> +}

[Severity: Medium]
Can bpf_avoid_get_send() return 0 without scheduling any subflow when
first is NULL, avoided, or temporarily inactive?

In __mptcp_subflow_push_pending(), a 0 return from mptcp_sched_get_send()
when no subflow has subflow->scheduled set leaves keep_pushing true, so
the while (mptcp_send_head(sk) && keep_pushing) loop spins indefinitely
under mptcp_data_lock(sk):

net/mptcp/protocol.c:__mptcp_subflow_push_pending() {
    ...
		if (mptcp_sched_get_send(msk))
			goto out;

		if (READ_ONCE(subflow->scheduled)) {
			mptcp_subflow_set_scheduled(subflow, false);
			ret =3D __subflow_push_pending(sk, ssk, &info);
			if (ret <=3D 0)
				keep_pushing =3D false;
			else
				copied +=3D ret;
		}

		mptcp_for_each_subflow(msk, subflow) {
			if (READ_ONCE(subflow->scheduled)) {
				xmit_ssk =3D mptcp_subflow_tcp_sock(subflow);
				if (xmit_ssk !=3D ssk) {
					mptcp_subflow_delegate(subflow,
							       MPTCP_DELEGATE_SEND);
					keep_pushing =3D false;
				}
			}
		}
    ...
}

Returning 0 inside the if (first && ...) branch and -1 when no subflow is
scheduled would match the other BPF schedulers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123123730.3265=
284-1-kalpan.jani@mpiricsoftware.com?part=3D2
