Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6FF2DF3F9
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173866; cv=none; b=SONL+zkCAqGOZ7ybT3kMLyqJ3ikbZDPsc06q4MlSWeUQJ4eIavZUfUC/WV33g4iC7UkIs655lRIBJ6Al8aPlkepMeFtcg6W25ysy4/hm85LpltNYuedNvh+X8kkA2W99/QF1/lgH4L1RbxQdq33hSNEvWuHMqIF9tnCU1NrteXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173866; c=relaxed/simple;
	bh=vT6PArFNlD9ATQBYI/ysNDAumFVMhzxz9dljQq1FEo4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fAWfKbunZwNZmXts59GjugunFHIT2kFaeQx3SVHy7xJgvtIz7MlVL1+BuBC9Y22RFqCF/vTGV7zlRBfI+mw7Q8BYdTwvpN8jwhangwGbD/TWh2tjq6UGIQ8Tl4pyF1sCFxMyOFb3F1umEW8PNJenmYczLH/41rZhA0O4eSjmGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RmGgkokm; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RmGgkokm"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762173862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCESdiFfePQnHxAf5Hjx+NZwOKZOc1DIfGTWc/CkQFI=;
	b=RmGgkokmZWSo8UB9yGc4Wq07j7MdQpgB0b3cW0rSbLfwQyuO9LTYotTkkJPN3r4augRIlF
	l7yY27AMCqp6lE9/YHUWl6UdnxZg/JOhepCTkF7MTPAISgKfqjWtkrarP+kHNzCwFXBDP/
	MJigcA7V0TLszG04FEJ92ouXtktg/jA=
Date: Mon, 03 Nov 2025 12:44:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <3ddd7d72644ebd5826caa244cad6a6491410c00a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, "Jakub Sitnicki" <jakub@cloudflare.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Willem
 de Bruijn" <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Matthieu Baerts" <matttbe@kernel.org>, "Mat Martineau"
 <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Florian Westphal" <fw@strlen.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
 <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
X-Migadu-Flow: FLOW_OUT

October 28, 2025 at 19:30, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni=
@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 10/23/25 2:54 PM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> When the server has MPTCP enabled but receives a non-MP-capable req=
uest
> >  from a client, it calls mptcp_fallback_tcp_ops().
> >=20=20
>=20>  Since non-MPTCP connections are allowed to use sockmap, which repl=
aces
> >  sk->sk_prot, using sk->sk_prot to determine the IP version in
> >  mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assign=
ing
> >  incorrect ops to sk->sk_socket->ops.
> >=20
>=20I don't see how sockmap could modify the to-be-accepted socket sk_pro=
t
> before mptcp_fallback_tcp_ops(), as such call happens before the fd is
> installed, and AFAICS sockmap can only fetch sockets via fds.
>=20
>=20Is this patch needed?

"mptcp_fallback_tcp_ops" is only called during the accept process. Howeve=
r,
before that, for an already established TCP socket, its sk_prot is replac=
ed via the following path:
tcp_rcv_state_process()
  tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
    call bpf prog
        bpf_sock_map_update(sk)
           tcp_bpf_update_proto()

However, after discussing with Matthieu, we've concluded that this patch =
is indeed no
longer necessary, as we have a simpler way to intercept the operation."

Thanks~
