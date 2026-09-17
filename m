Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D03F58D6;
	Thu, 17 Sep 2026 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634228; cv=none; b=qXSNKnwUwBiCkpiWZ0E/Y+EB2qT6EcEkS0BCmwgrRH+I0IClcQE0xTaYteqAtN5k21ZCeQWE2BomXiZiaHWV5CqKSWovIbUBLeL1W8LGhgzJstl7SLg+iXJ3MYr9OZ8//G0RbMNWiRoSCbL0uWkOuZoIvnJA2066UO+kq0H5VGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634228; c=relaxed/simple;
	bh=a0XqQSuOzyPiY7WD8pDbuEQNCSz5eRDn+K1vrAq/1pQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e+T6HEPT/UFEqfedJ7cCJjYdVzHOLCcKdXFgumtQGf8UD9qpOLk9NdU1ZLBYF6gR3gju0PCy2FNVq2hb83sBBWDb0k5sxw536lOqJkBLov6eFXuxTiJ0csLORrLtFKgsyc1kOSDy/uIIPWGsHRGOEFanfPIg1YvfkInBl3eJFwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFgWYzmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFgWYzmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6851F00893;
	Thu, 17 Sep 2026 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789634211;
	bh=3C/KkJjlnOTJY+/ASrRnUTTi2gKf++MlSeKRIkkXDZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFgWYzmMVChaHrOzhsJhAMN3XeWBu/4pW6M6V3QJt3Rf2o04YmnCbQv6nSf3IHdSw
	 6NXN6j596sI8FXD+dVIESObOiaQClje5KCL7FKCixSxl2TJIahIsPaAYDtVKhtmoXI
	 1jnBAEtfLmRZ+DyfCX1VZlsZR4jcC98LHURUSxcp2eoteMP2AdrQId1i3KePd9qFGd
	 BdPeLDUcfnbjOTSu3Ea0Rezrlm52052yb1ItZuPXsO/3ud3HaQ0rD4mRkU7+JmRDDS
	 +W1D1fEN1WfEBjOXLJf7Mq/RIyRQGA42UOvjWg/jTFwmc/VFE2nnPJbIwdC/cyTuDY
	 Kw0tiw+V+L3kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 1/2] mptcp, bpf: reject bpf_sk_release() on msk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260917081209.361367-1-jiayuan.chen@linux.dev>
References: <20260917081209.361367-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 08:36:50 +0000
Message-Id: <20260917083651.4B6851F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: verifier use-after-free via derived socket pointer fields
--

commit 4a3543a3768c369da5d09b5be8da85c1dbd33f90
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

mptcp, bpf: reject bpf_sk_release() on msk

This commit fixes a reference leak by changing bpf_skc_to_mptcp_sock() to
derive its return value from the subflow using parent_id, preventing
bpf_sk_release() from dropping a refcount that was never taken.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5d7080c260d84..8271d9214da52 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11263,6 +11273,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
>  		regs[BPF_REG_0].type &=3D ~PTR_MAYBE_NULL;
>  		regs[BPF_REG_0].id =3D meta.ref_obj.id;
> +	} else if (is_ptr_derive_function(func_id) &&
> +		   find_reference_state(env->cur_state, meta.ref_obj.id)) {
> +		err =3D validate_ref_obj(env, &meta.ref_obj);
> +		if (err)
> +			return err;
> +
> +		/* Ensures we don't access the object after a release_reference() */
> +		regs[BPF_REG_0].parent_id =3D meta.ref_obj.id;

[Severity: High]
Does assigning parent_id without setting a reference ID or PTR_TRUSTED leave
the returned msk pointer untrusted in the verifier?

Because msk is untrusted, if a program accesses its pointer fields
(e.g., sk =3D msk->first), it appears the access falls through to the depre=
cated
verifier compatibility block in check_ptr_to_btf_access():

kernel/bpf/verifier.c:check_ptr_to_btf_access() {
    ...
    } else {
        /* Old compat. Deprecated */
        clear_trusted_flags(&flag);
    }
    ...
}

This yields a plain PTR_TO_BTF_ID without the PTR_UNTRUSTED flag. Since
pointer field accesses do not propagate parent_id, sk->parent_id would be 0.

When bpf_sk_release(subflow) is called, the verifier invalidates registers
tied to subflow (including msk via parent_id).

Could sk escape this invalidation cascade since its parent_id is 0?

If so, would the program be able to pass this valid, plain PTR_TO_BTF_ID to
kernel helpers like bpf_skc_to_tcp_sock(sk)?

At runtime, the helper would dereference the pointer without PROBE_MEM
protection after it has been freed, potentially resulting in a use-after-fr=
ee.

>  	} else if (is_acquire_function(func_id, meta.map.ptr)) {
>  		int id =3D acquire_reference(env, insn_idx, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917081209.3613=
67-1-jiayuan.chen@linux.dev?part=3D1
