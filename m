Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057417729
	for <mptcp@lists.linux.dev>; Wed,  3 Apr 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110917; cv=none; b=dRYKF0A1GtV4MFOfYoYeGOU66DxUcSpcTcTcS4QXA1H2Pq6PBfjUGiFbuReNLDHWLBCLN+zNbTaoLSn7g7uNuy4thl7AZq5gJbdNhiB8YunAY5O4M0tmPb/5nFXEkFOOFsjOAiWxo5Lbx7vxWjz46kNzSjRXfJreQMsKOsHyUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110917; c=relaxed/simple;
	bh=OZZ7OSHf1+nWeVqc4+NpA1DK+7ezp49wKEgQW9YiM5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tNSaUH7nQW3wjZ4f5o668N8A7qV+UnY0/dsueqO691n4MDLTxV74hp+HYx0Z8JJE5iv3IznukyeFvAgbgIpJHyYwsrSkHTT0xfv5FRo3ng7mQvuAYZWGBlu9Ux+yDa2uFi2a2tcGEHROftO4Dlt61JfNBrZSkLS7oKq54Y8bdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaO+p9pS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaO+p9pS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F604C433C7;
	Wed,  3 Apr 2024 02:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712110916;
	bh=OZZ7OSHf1+nWeVqc4+NpA1DK+7ezp49wKEgQW9YiM5k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IaO+p9pSWgY/hkrMYiNapaWw07sM3aB6/cUj/KJa09WLxN6fDdjW+i6yOc2qcoatV
	 VG5YTK5ffnBfk+s3Quz/pekQIoOlp7U8lq8iH6bHJ0qWxju6CxbP101k/kD3bq2jAo
	 FN5a15Uu5E3tzGocMTvha03jrw34zoAbJnAnUKbTm7aBB2TZFNcJvX/gJCUMByzFlj
	 Eikl1Z59PMk39iLwitZkp3NA/4auROtNEwdN7NtK7BPoLi/HDTNrzZSSPHuSUBFOKs
	 4HO3eaueg+tB5gmf3s6xAvL3vxKJcSkvDiEx1DaqJXNw8OrzTyW5ONNIOkRAEWUiqG
	 ZO0Jj9PTIW+cg==
Message-ID: <693d06adab316872e68130afd47857a5b352ac0e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 06/14] selftests/bpf: Add mptcp subflow
 example
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Wed, 03 Apr 2024 10:21:52 +0800
In-Reply-To: <4843ee1e-5983-34be-31a6-02b358616613@kernel.org>
References: <cover.1711612876.git.tanggeliang@kylinos.cn>
	 <e74823731ffc54c1512611c251cc6f7aa30d5926.1711612876.git.tanggeliang@kylinos.cn>
	 <4843ee1e-5983-34be-31a6-02b358616613@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-04-01 at 10:06 -0700, Mat Martineau wrote:
> On Thu, 28 Mar 2024, Geliang Tang wrote:
>=20
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > Move Nicolas's patch into bpf selftests directory. This example
> > added a
> > test that was adding a different mark (SO_MARK) on each subflow,
> > and
> > changing the TCP CC only on the first subflow.
> >=20
> > This example shows how it is possible to:
> >=20
> > =C2=A0=C2=A0 Identify the parent msk of an MPTCP subflow.
> > =C2=A0=C2=A0 Put different sockopt for each subflow of a same MPTCP
> > connection.
> >=20
> > Here especially, we implemented two different behaviours:
> >=20
> > =C2=A0=C2=A0 A socket mark (SOL_SOCKET SO_MARK) is put on each subflow =
of a
> > same
> > =C2=A0=C2=A0 MPTCP connection. The order of creation of the current sub=
flow
> > defines
> > =C2=A0=C2=A0 its mark. The TCP CC algorithm of the very first subflow o=
f an
> > MPTCP
> > =C2=A0=C2=A0 connection is set to "reno".
> >=20
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> Hi Geliang -
>=20
> This patch (and patch 07/14) are listed as "New" in patchwork, while
> the=20
> rest of the series is superseded by "refactor mptcp bpf tests".
>=20
> Do patches 6 and 7 of this series still need review? Are there any=20
> dependencies on the "refactor bpf tests" series?

Hi Mat,

I changed them as "Superseded" since v6 of this series has been sent
out yesterday.

Thanks,
-Geliang

>=20
>=20
> Thanks,
> Mat
>=20
>=20
> > ---
> > .../selftests/bpf/progs/mptcp_subflow.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 73
> > +++++++++++++++++++
> > 1 file changed, 73 insertions(+)
> > create mode 100644
> > tools/testing/selftests/bpf/progs/mptcp_subflow.c
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > new file mode 100644
> > index 000000000000..9553099ffd5f
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> > @@ -0,0 +1,73 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2020, Tessares SA. */
> > +/* Copyright (c) 2024, Kylin Software */
> > +/* Author: Nicolas Rybowski */
> > +
> > +#include <sys/socket.h> // SOL_SOCKET, SO_MARK, ...
> > +#include <linux/tcp.h>=C2=A0 // TCP_CONGESTION
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_tcp_helpers.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +#ifndef SOL_TCP
> > +#define SOL_TCP 6
> > +#endif
> > +
> > +#ifndef TCP_CA_NAME_MAX
> > +#define TCP_CA_NAME_MAX 16
> > +#endif
> > +
> > +char cc[TCP_CA_NAME_MAX] =3D "reno";
> > +
> > +/* Associate a subflow counter to each token */
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_HASH);
> > +	__uint(key_size, sizeof(__u32));
> > +	__uint(value_size, sizeof(__u32));
> > +	__uint(max_entries, 100);
> > +} mptcp_sf SEC(".maps");
> > +
> > +SEC("sockops")
> > +int mptcp_subflow(struct bpf_sock_ops *skops)
> > +{
> > +	__u32 init =3D 1, key, mark, *cnt;
> > +	struct mptcp_sock *msk;
> > +	struct bpf_sock *sk;
> > +	int err;
> > +
> > +	if (skops->op !=3D BPF_SOCK_OPS_TCP_CONNECT_CB)
> > +		return 1;
> > +
> > +	sk =3D skops->sk;
> > +	if (!sk)
> > +		return 1;
> > +
> > +	msk =3D bpf_skc_to_mptcp_sock(sk);
> > +	if (!msk)
> > +		return 1;
> > +
> > +	key =3D msk->token;
> > +	cnt =3D bpf_map_lookup_elem(&mptcp_sf, &key);
> > +	if (cnt) {
> > +		/* A new subflow is added to an existing MPTCP
> > connection */
> > +		__sync_fetch_and_add(cnt, 1);
> > +		mark =3D *cnt;
> > +	} else {
> > +		/* A new MPTCP connection is just initiated and
> > this is its primary
> > +		 *=C2=A0 subflow
> > +		 */
> > +		bpf_map_update_elem(&mptcp_sf, &key, &init,
> > BPF_ANY);
> > +		mark =3D init;
> > +	}
> > +
> > +	/* Set the mark of the subflow's socket to its apparition
> > order */
> > +	err =3D bpf_setsockopt(skops, SOL_SOCKET, SO_MARK, &mark,
> > sizeof(mark));
> > +	if (err < 0)
> > +		return 1;
> > +	if (mark =3D=3D 1)
> > +		err =3D bpf_setsockopt(skops, SOL_TCP,
> > TCP_CONGESTION, cc, TCP_CA_NAME_MAX);
> > +
> > +	return 1;
> > +}
> > --=20
> > 2.40.1
> >=20
> >=20
> >=20
>=20

