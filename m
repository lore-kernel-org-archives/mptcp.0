Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645557;
	b=SiHFYhwivuMn1O3idM2rfDMkIwFw04SUMeuL/FM4mUdOQtzybdW8EjVzjVrs9BA+81dv
	 fHWkvKSLADj8bBE129EeesJcEJsLqr8/gBAkO+q1VqeU6RncxbxN1xPAOzQfQrX4hOtW2
	 0GevLH4PLFjmCvuROyxLZsHhvG3ZC2FhiOK0+qZa7VpY3+iJTKfzQ5MfCSq5jyt7RGzSb
	 6hnez3/9DD9w9B4FfVqMYs3C6hnjosAS/kSiMv/kclZ8eOeUo9GdXQG93a8LkSsJFFZl3
	 7up5sU2F73x/V+UMsGBi73nfvZIm/6soWx/0088oqMqTnWRetZGNh0XG765jXF/+TEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645557;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5FaHmBo6O0c2GLXYinYKyXxyaDFOuKgWbHISbo4W72E=;
	b=tfHvQ9zeRvNl4G/UtnsRSrsm9ZqKqo/QgGwxGVivzyX3bFl/VfcOwZ5gC0bJRIadFCuG
	 OnD2uQyqc3FGkTidslXzusLha5Pt7RW4dQQtPZD8HFMDfkMvK9TNbILm4L6QdK7aWLdCk
	 jzV+6OoC41vAY8P11Lx/m1Bp7sv5uwXT32C0UuwC+R1X+LG6UGMcvmMMBDdsE9if3yt+O
	 7horZJTlfeEdQlG+de+0GSsS+oCKkYwIJ+vP7sspVR3eH7JhpjpJoHbN4Drd9+6DtqpTl
	 68BGEMK2m+06AGqLQ3dUR+j1BDw1koh542YY6Ugfokq/CUX2muDjgTFIErrPIVLNZYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaKZer+D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42736606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CaKZer+D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6352B1F00A16
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 18:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793645556;
	bh=5FaHmBo6O0c2GLXYinYKyXxyaDFOuKgWbHISbo4W72E=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=CaKZer+DaNBxZgHJOFNxWiCbXJ5dqDM5SqbTZFBi0/9H2qS+IufdD+OAVXESUBBka
	 KGewemvIXUT7EryFV4makdFovAz9oNZr65ECJfCXSZU/DsXGys3W94z6qSXWWxaTkL
	 N/lW12cHLj3Zuo4q3gbQ9og4UImjZ/9Euc2GmVOdGV6cAf++7AWFCQy2ngkACLAhMl
	 AFsqE+pWo9Tl1MShBVSZV8n4kRM0JuOQRyzWUJn4k4Oi9aIqq/NhsCxLv42jixKJq0
	 So5NtdYnAnerpOWNhWgMkbOLebn/Totf+lqnuwXR+yl/dqlBJdCxnZyQsxIPlyLVO4
	 nauy2r3bFPOkg==
Message-ID: <46f86900-a7aa-4ffd-8c34-a15fa8c8d460@kernel.org>
Date: Mon, 2 Nov 2026 19:52:34 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add mptcp_subflow bpf_iter"
Content-Language: fr
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20261102-mptcp-bpf-kf-iter-ret-indep-v1-1-dd262e520168@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261102-mptcp-bpf-kf-iter-ret-indep-v1-1-dd262e520168@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 02/11/2026 17:45, Matthieu Baerts (NGI0) wrote:
> Since commit d09c2aa3109f ("bpf: Track borrowed iterator results by
> default"), the verifier ties a struct pointer returned by an iterator's
> next kfunc to the current element by default: it is invalidated by the
> following "next" call, and by "destroy".
> 
> That breaks the MPTCP BPF schedulers tests, keeping a subflow after
> advancing the iterator: bpf_rr keeps the first subflow, and bpf_burst
> keeps the "best" ones to use them after the loop. Both are now rejected
> at load time:
> 
>   R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_
>   (...)
>   # test_rr:FAIL:open_and_load: rr unexpected error: -13
> 
> The returned subflow is not tied to the iterator position: next only
> walks msk->conn_list, destroy is empty, and no per-element protection
> is dropped. In fact, the subflow is still valid thanks to the held msk
> lock. Then declare it with KF_ITER_RET_INDEPENDENT.

It looks like it fixes the issue reported by the CI. I suggest applying
it now, not to impact other devs. I can always change this later if needed.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

