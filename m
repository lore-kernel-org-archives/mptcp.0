Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2439CCF8
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295460; cv=none; b=YwxmUO78/cCp1iqpUOqLtpiHSFUumSRJ5CqMybBVvSZEtOd2EE5BI6T/tmFy5bqnjRzLT9Hakq5oUSQfepJQ7/XgWIKN4tLnxulZbrCMeE8FJ4tCb0r9mMq5UtvloObJaHiSKR0vJOQ5tWJCqctrHQtDZ1wCbasHU+vc7f4cd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295460; c=relaxed/simple;
	bh=tgmjSQZPoMT8mZB711cY6eXr8Hu36aNYiQrYZv9O0OQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCeLXNHthvzLq5DJc/wYKPc2WbaHeW46jsydo0QW2x8mTqyd0T1Dm/iMvRrXP8mHoe+Tr+dDx4JLt8SQ65U/Ro0C/PBgV/vIz/vkvIP/2WrPdQaF2+DevrtHJA2WhWa08T9vhXMI+wbJClZCpKE3e983SjuhoBrnIU0GrYFN6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2Z+Zyj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2Z+Zyj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3886D1F000FF;
	Sun, 13 Sep 2026 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789295456;
	bh=cPtGzp0fhNhXV2o5E3ep5rr3oliubNiepafg4y+xyXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2Z+Zyj9LCsbIE1lLMH+QCpZ/jhIt4BIoPG98Yjf/A9ZvOAfTCO1abnbV1DgqPd/A
	 zt/C7RiXgxaQ563fKENEv/KFRG8Es4/uYxIYXhYFEVWt2SQrC9c6K/AaQwO70LnX8U
	 9mkFmc2mYtz83XMHKmqTRLrS36ewrJAc8iBFlYdpY56KAPy5SLPMBuzmEXbNthrspX
	 xnGLblpiRWusGx9rp981S2qytdeTN1xyEClZ0/evaK6GWWTNFGCrFDRxOgyQq2P2KE
	 HLU1G37qS/v38cyim5ETPIDt2Y0OENURq2x7HaMBgAR3V8pDMBognvyRZRHpqwueHw
	 UH1i1QAhU7hmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v5 07/16] mptcp: add sock_map_update BPF
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <393478c81ea50e72c49041752385e9b4fc82d469.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <393478c81ea50e72c49041752385e9b4fc82d469.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 10:30:55 +0000
Message-Id: <20260913103056.3886D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The verifier incorrectly allows bpf_mptcp_sock_map_update to b=
e used with BPF_MAP_TYPE_SOCKHASH and other arbitrary map types, but its im=
plementation treats the map strictly as an array-based BPF_MAP_TYPE_SOCKMAP=
. This causes type confusion and severe out-of-bounds memory corruption.
- [High] bpf_mptcp_sock_map_update modifies the parent MPTCP socket (msk) s=
tate without holding its socket lock, leading to data races with userspace =
and MPTCP stack operations.
- [High] bpf_mptcp_sock_map_update bypasses necessary socket state and oper=
ation context validation (sock_map_op_okay), allowing transient state MPTCP=
 sockets or ANY standard TCP socket to be unsafely inserted into a sockmap.
--

commit d25c16225b28c5b937139f3df217e21f3cd9bb7b
Author: Geliang Tang <geliang@kernel.org>

    mptcp: add sock_map_update BPF helper
   =20
    Add a BPF helper bpf_mptcp_sock_map_update() that allows sockops progra=
ms
    running on MPTCP subflows to insert the parent MPTCP socket into a sock=
map
    or sockhash. When called from a sockops callback on a subflow, it resol=
ves
    the parent MPTCP socket via bpf_mptcp_sock_from_subflow() and validates
    that the subflow is the first subflow (msk->first) before inserting the
    MPTCP socket into the map via sock_map_update_common().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd27..c58c2ba87d264 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -9075,6 +9076,7 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
>  		    func_id !=3D BPF_FUNC_msg_redirect_hash &&
>  		    func_id !=3D BPF_FUNC_sk_select_reuseport &&
>  		    func_id !=3D BPF_FUNC_map_lookup_elem &&
> +		    func_id !=3D BPF_FUNC_mptcp_sock_map_update &&
>  		    !may_update_sockmap(env, func_id))
>  			goto error;
>  		break;

[Severity: Critical]
Does allowing BPF_FUNC_mptcp_sock_map_update for BPF_MAP_TYPE_SOCKHASH maps
cause type confusion?

Because mptcp_sock_map_update() calls sock_map_update_common() which casts
the map to struct bpf_stab, passing a SOCKHASH (backed by struct bpf_shtab)
will write the socket pointer into what it thinks is the stab->sks array.
Couldn't this overlap with hash bucket lists or spinlocks and corrupt memor=
y?

Additionally, because BPF_FUNC_mptcp_sock_map_update is omitted from the
subsequent switch (func_id) statement in check_map_func_compatibility(),
could this helper be incorrectly allowed for other unrestricted map types
like ARRAY or HASH?

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 662b80ce2cf63..7ecafbf51fa05 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
[ ... ]
> +BPF_CALL_4(mptcp_sock_map_update, struct bpf_sock_ops_kern *, sops,
> +	   struct bpf_map *, map, void *, key, u64, flags)
> +{
> +	struct sock *sk =3D sops->sk;
> +	struct mptcp_sock *msk;
> +
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +	msk =3D bpf_mptcp_sock_from_subflow(sk);
> +	if (msk) {

[Severity: High]
Does this bypass the socket state and operation validation checks normally
performed before inserting a socket into a sockmap?

If a BPF program calls this helper from an early hook (e.g.,
BPF_SOCK_OPS_TCP_CONNECT_CB) to insert a TCP_SYN_SENT socket, it appears
unprepared or closing sockets could be inserted, violating subsystem
invariants.

Furthermore, if the socket is a standard TCP socket rather than an MPTCP
subflow, bpf_mptcp_sock_from_subflow() returns NULL. Would this cause the
helper to silently fall through and insert the standard TCP socket into the
map, completely bypassing checks like sock_map_op_okay() and
sock_map_sk_is_suitable()?

> +		if (sk !=3D READ_ONCE(msk->first))
> +			return -EINVAL;
> +
> +		sk =3D (struct sock *)msk;

[Severity: High]
Does modifying the parent MPTCP socket (msk) state without holding its sock=
et
lock lead to data races with userspace and MPTCP stack operations?

When called from a sockops hook running on a subflow socket, the network st=
ack
only holds the subflow socket lock, not the parent MPTCP socket lock.
Because sock_map_update_common() modifies the socket's protocol operations
(sk->sk_prot) and sets sk_user_data, could modifying sk_prot concurrently
while another CPU executes userspace system calls (e.g., recvmsg or sendmsg)
on the parent socket cause use-after-free crashes or data corruption?

> +	}
> +
> +	return sock_map_update_common(map, *(u32 *)key, sk, flags);

[Severity: Critical]
Does unconditionally calling the array-based sockmap update logic here cause
type confusion when a hash map is supplied?

Also, doesn't this truncate variable-length hash keys to u32?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789294365.gi=
t.tanggeliang@kylinos.cn?part=3D7
