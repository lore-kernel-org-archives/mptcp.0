Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074336;
	b=EtJ1qHSxUqpyZoUJaR6SMXd+NQxqcy25HUtm4+VN1O15SQP14U2SHCR2wWpyFLt3p7ts
	 tB4JDxL+GEhktmAesEldgym60fgrJM5/Y5iyShZ6f2R0jeQWuNQHJdPQkptG1+eGD344o
	 eTIAb/EmU8uF+OO3fm5SGI7A56TW3Vgrjsih9LhShUoBsDZni7B2yqP5ZsBWBaSa+uJk9
	 ogC3W7L7n4jJrWILM445TKUGnaVwYVIynJ1p5ehuP7yS8c4bJ1weU5ZxnvAO4qGoh2oRt
	 xdW9aUciFrZoLLXqiYGRKLTj8eJ+MnvbqP1YlC/k1Nt7EUE2gzYVxYUuZR+mTt4FT7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074336;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SBUfgzkZdSg6rC6LJU9CWg4kViQWPy795hwm8knXZ/Q=;
	b=hp3UcY1e/zKzqLgNIvz7NFJ2mDKvs6EtVUM6+gcXcMi/dBaAC1UF4RSoLm+wOjVicdPs
	 M8hzXoJUY8a2KZuV6cDQsXTV5XTAOpNSgrQshjQj4Cf4qRuZOThrJRYAqHscysJcz7xnh
	 LdSbpR9JbIqUnldHF4MY+cbiGFpamexqSp/dGaaIX+eBaPYBXHMsSILMG6bXMNBR/mpNa
	 MmS8bAzC3LyR4oS4OGi3CIzH6SK0o6HVKPB0ZrY5Is4Dqss4KSV6lPmFoaZsiScG+Zp75
	 tKClUroLn5QoqF05L+vNg7liQqkR3e4QT/IbvfA4ORZLTCniiok1SZKO27vZNkOMyhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhdaBLgk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6350606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhdaBLgk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5911F000C7
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795074336;
	bh=SBUfgzkZdSg6rC6LJU9CWg4kViQWPy795hwm8knXZ/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mhdaBLgkvEtXqgRwh1/NkJG2t/tp9Pjgt/q12/QrCu6/JOQxB+roB+NiTfGEI24xB
	 KBcE40CCvrcBTrBF65KO3Iit2I2yAjqhQRGIQqGfRy8uBx9/8gqW015Fk2KcLCOjFU
	 YnU6sPd6uLYAPHOVFUefuGFmuXDn8YDNooebEAkBe97epRR57U9/sdSff6o+d2rq7b
	 NEracQs48j/9cJqxxsOkJZyjEi6mM5ExePoetQFIagXSPGy9BRZKUd44AmlyOc+mQ+
	 sJQOnL8E0jCuBxJ+48WAQC6gT9M6OBOXaD0TS49RV2wbxLXIvjV74wRLBWMex/lgxX
	 GzIkHWunPnqjA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-844a8bf7e25so1241426a34.1
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 23:45:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF9WIh6XEACNez3Ujzcz0RegIBse4fCR8QJU3c/9aYhnp+Lmq6yspR/ydqgM5KckfliHfQ9sA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9JLIRw3pISFW1CICQdPwVx1NM6auIIbcyo8t8RkA28wmtV7tGn
	CTS8fc9QsB1i9dNjKjNnmQRPkupts8YRjcqZ9fRwCBB46weu/CqBw0/8DiX5AHWyumhp4PYu8eb
	nANkDc6TLpbHtLqwH77KmkMeBQC6VrLs=
X-Received: by 2002:a05:6820:1518:b0:6f9:4f1b:3987 with SMTP id
 006d021491bc7-71b185a5970mr4488025eaf.59.1795074335679; Wed, 18 Nov 2026
 23:45:35 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261119071649.374106-1-kuniyu@google.com> <20261119071649.374106-8-kuniyu@google.com>
In-Reply-To: <20261119071649.374106-8-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 19 Nov 2026 08:45:24 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqxviZXjjKiq46nZpi_gJhv4t+Zt-pjDNGo6YomG1UUMg@mail.gmail.com>
X-Gm-Features: AclHuK8q1NYPy7OwMZm_4Qfybi6kVjrj8aT7eu4EHODsBtRYZIpM839xh-M-_AY
Message-ID: <CAL4WiiqxviZXjjKiq46nZpi_gJhv4t+Zt-pjDNGo6YomG1UUMg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 7/7] selftest: packetdrill: Add test for tcp_collapse().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 19 nov. 2026 =C3=A0 08:17, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> tcp_collapse() now does not collapse high-density skbs and a
> low-density skb sandwiched by high-density skbs.
>
> tcp_rcv_collapse_bloated.pkt verifies the behaviour by
>
>  1. set a large SO_RCVBUF
>  2. send one high-density skb with 100 bytes read()
>  3. send one high-density skb
>  4. send one low-density skb
>  5. send one high-density skb
>  6. send 30 low-density skbs
>  7. send one high-density skb
>  8. set a small SO_RCVBUF
>  9. send a small data to trigger tcp_collapse()
> 10. check TcpExtTCPRcvCollapsed via nstat
>
> Without the series, the first high-density skb is collapsed.
> In addition, the first low-density skb drags the following
> high-density skb into collapsing, consuming more memory.
>
> If we remove sk_forced_mem_schedule() without this series,
> sk->sk_forward_alloc becomes negative at the end of tcp_collapse().
>
> Note that 30 segments are to make the memory savings large
> enough so that the margin can absorb minor size delta of
> struct sk_buff or L1_CACHE_BYTES across configs.
>
> skb truesize, TCP_COLLAPSE_MAX_SIZE, TCP_COLLAPSE_SCALING_RATIO
> depend on PAGE_SIZE being 4K, so the test is skipped if getconf
> returns non-4K PAGE_SIZE.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
