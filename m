Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682890;
	b=efufjCEZjb1GzCl5VTFf8HMsIaStfMPtNwQnTkaTU/MjZGfRDJI5PX8vmA+71JcGXVw3
	 bNn9kWhedSKe6HpzMs+Pp13OiWSC4XnGeFinwgpi81BDIopEeSO8BOBIBWXitXhssrR3a
	 Gfb3xY2sboVCFx/eiDiREt6jld2Y3Yk8IDI9KWiG2cOyFipvXFO6Eufi5FL/nj4C+PNxQ
	 reGbmzTfU5DSpl9oO8AD61O8R361adhtyHRVgM0ucpwHYdAUPSdxRjnmr68qFZPy5NDFB
	 RoZ666j1hZDPKwQHsf4fJIgxwdwBIpxNd+2ZVfj7OdNJSUn2pri1hQNIyqX760DQDpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682890;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=eEqrglkqWiQv9ByDl8q6YHM+PPnMMtPyGy7NziGSOCE=;
	b=MNfQxCRSiNWiSvpr4vJoMDoEN4bNkkjKkjs1vZ3AE88EXZKpx5IGaKnfNzdVvkw2Pd64
	 xmKz+46CRgAg6goRj284wSRj5ydqEDCSWV2EZ0B2mr1DoIRtAy6Ti5eVnZl0ZSuAA5kNT
	 D9/Gck0neZ6+Jtsnwg3bnCUEVN9GBd6p05gQBAO50s2AZKrvSuoj2GgPFrANF9AovgCxV
	 ceNx3cnoVFYwkn3PQT9AI4u3K7n9S58QGflltXdbWkY35O4C7jF2KVUWFwKtdkBWS1WTA
	 Oxh9L13M1a29Zfz93DRxpBp3AQBE0eqOoOvVg1l8GDTzJQSL6Sw6OH8nq7+JW6ASz8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NoJtdc7e;
	arc=none smtp.remote-ip=91.218.175.75
Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217A606A337
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 08:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E217A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NoJtdc7e
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=WzPAXzKv5qNfueG+8GIA/dCl0/+muC6HE/6UOijGqYY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795682888; v=1; x=1796287688;
 b=NoJtdc7eHcyjs0Gk2e+oksFBOH6DdHwmMxLokBqwbEPNc6bCNY6l4Hi8Z/XBHHbpCSwakxn5
 Rl5EVvNk/AKV9yLLBGN0gtsePes7OiB/95gsXHQCJ1O5KM+9/kVx1AnWaCL8y1gfXw0lG7NG2do
 qMUHkLES9nTAO0Zd5Dn7Q9U8=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 5446df3b68f9b5ae;
	Thu, 26 Nov 2026 08:48:07 +0000
X-Mizu-Trace-ID: 5446df3b68f9b5ae
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Thu, 26 Nov 2026 08:48:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <133c1ca98af6beb48c0db1e6bb539a2a76ccda49@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1 0/6] net: avoid stack canaries in TCP/IPv4
 fast paths
To: "Xuanqiang Luo" <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Matthieu Baerts" <matttbe@kernel.org>, "Mat
 Martineau" <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>,
 "David Ahern" <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Pablo
 Neira Ayuso" <pablo@netfilter.org>, "Florian Westphal" <fw@strlen.de>,
 "Phil Sutter" <phil@nwl.cc>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, "Xuanqiang Luo"
 <luoxuanqiang@kylinos.cn>
In-Reply-To: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>
References: <20261124130631.1886963-1-xuanqiang.luo@linux.dev>

November 24, 2026 at 9:06 PM, "Xuanqiang Luo" <xuanqiang.luo@linux.dev ma=
ilto:xuanqiang.luo@linux.dev?to=3D%22Xuanqiang%20Luo%22%20%3Cxuanqiang.lu=
o%40linux.dev%3E > wrote:


>=20
>=20From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
>=20With CONFIG_STACKPROTECTOR_STRONG=3Dy, a function that has a local ar=
ray or
> passes the address of one of its locals to another function needs a sta=
ck
> canary. The canary is set up and checked on every call, also when the
> local is only used on a path that almost never runs.
>=20
>=20This series removes the canary from functions of the TCP/IPv4 fast pa=
ths,
> by returning results by value, by using storage that is not on the stac=
k,
> or by not calling a function that has nothing to do.
>=20
>=20Patch 1 returns the two mptcp_space() values in a structure, so that
> __tcp_select_window() no longer needs a canary.
>=20
>=20Patch 2 changes ip_neigh_gw4() to take a pointer to the address, like
> ip_neigh_gw6(), so that ip_finish_output2() no longer needs a canary.
>=20
>=20Patch 3 uses pskb_may_pull() in icmp_filter(), so that
> raw_local_deliver() no longer needs a canary.
>=20
>=20Patch 4 turns skb_try_coalesce() into an inline wrapper over a functi=
on
> returning its results by value, so that its callers no longer need a
> canary because of it.
>=20
>=20Patch 5 returns the result of the TCP receive coalescing by value, so
> that tcp_rcv_established() and tcp_data_queue() no longer need a canary=
.
>=20
>=20Patch 6 calls bpf_skops_write_hdr_opt(), which needs a canary, only i=
f a
> BPF program reserved room for TCP options.
>=20
>=20The bloat-o-meter numbers are from gcc 16.2 on x86_64. The functions
> named in patches 1 to 5 also lose their canary with clang 23.1.6 on
> x86_64, with and without ThinLTO, and on arm64.
>=20

Hi=20Xuanqiang,

Thanks for this series. Besides the code size, do you have any runtime pe=
rf
numbers (TCP_RR, cycles per packet...)? I think it may help the maintaine=
rs
judge the real gain.

Thanks
Gang

> Xuanqiang Luo (6):
>  tcp: avoid a stack canary in __tcp_select_window()
>  ipv4: avoid a stack canary in ip_finish_output2()
>  ipv4: raw: do not use skb_header_pointer() in icmp_filter()
>  net: avoid stack canaries in skb_try_coalesce() callers
>  tcp: avoid a stack canary in tcp_rcv_established()
>  tcp: do not call bpf_skops_write_hdr_opt() unless needed
>=20
>=20 include/linux/filter.h | 2 +-
>  include/linux/skbuff.h | 35 ++++++++++-
>  include/net/mptcp.h | 13 ++++-
>  include/net/route.h | 16 +++---
>  net/core/filter.c | 2 +-
>  net/core/skbuff.c | 50 ++++++++--------
>  net/ipv4/raw.c | 25 ++++----
>  net/ipv4/route.c | 15 +++--
>  net/ipv4/tcp_input.c | 99 +++++++++++++++++---------------
>  net/ipv4/tcp_output.c | 25 ++++----
>  net/mptcp/subflow.c | 9 ++-
>  net/netfilter/nf_flow_table_ip.c | 4 +-
>  12 files changed, 178 insertions(+), 117 deletions(-)
>=20
>=20base-commit: a4c450594f5d1dc0fc4daacfb95d40554d99dead
> --=20
>=202.43.0
>
