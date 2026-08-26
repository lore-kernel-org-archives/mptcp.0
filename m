Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188D37DEAB
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765443; cv=pass; b=tRCnndbguLTz+deefPNlMu6mbR7s2Sxr2TR4qNtmeoB03wZmEnQx7Z3dI5jKgfUrwrKtwOtjT7fi8Wg13UbnBPzcZrgDNfWd8AITJPsgdkDbjOqN9wp1k89wz8QAEMUlgJxLRVoVqfjXsKuJXZI7BTfLv5fpGyAPqw8v4PsWCW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765443; c=relaxed/simple;
	bh=6I/1+qMQ471+4RYnld66Y6RCA6m5prbOV7XKezci6Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHLCHA7xOC3hhC5cFsIX/RShXm5SeDLEZQKZf8zIDkEc3WwOnMvY4ZjCOvEJdK0q4HJoa7IWpmWitYcpdJwHeREZdzdClrElaiiUxKXxBIAkxkHvgiTCcYcp9QyeRLWcJelIy3Au8xecmgquHt0TVZWLmtMAIeSL/PRgImNZ/4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wdpv0jl2; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wdpv0jl2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-52f9e79ed93so3484551cf.1
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:30:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765427; cv=none;
        d=google.com; s=arc-20260327;
        b=PgnNNDZA4D2QdWTLTdjWpAWSD/KzUJxkLkiswUaafut+8Lm685EdGyebU0d+3x8+qp
         0qG3/7VC8fhFKszm6f51P7J/ihZuI+BkDsouUMXTh3qGAx8L8bEaBQx4FO0uIgWCYjnU
         id1LJ8+8a5JeLXbLggl7rivHjnLz0PRG+roqEnY8xXMGEtUlbi9zCk1mub9froEGsWrl
         F7BhfGszFpdd+/OtYM4Jj/+JMu26DbvTzAwqEUNfh7EU1apRWYfUyjumlftm7stnw97F
         dIqxChYcfZPiqdMd8A1mxV6Ew6Gi8D8fzDAglqcZCVtCxxD4YpV1s6opLiKbJi7dqDnW
         zZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        fh=EWdru0zHC3b2JEeKiFePGChYnnnaYszVP2XBM8xAZjo=;
        b=jN8dCnc2udrA6bnZU6b6kLhjA0xtLPFMQtTwsKjWXWMFOcgHtYplrRK4zEDqxV+O/L
         8xY/TXi9mMmlccGqE+0utafVXX+8m9w7MsV9nQ7FbGUgOUldnIKhAgXou/BRpuucF74K
         L4n9lI2q5WgEge6yzlQJXyjnS5l+NDs7L/ok/cq+pKpPNVhNoToz5gS/ol5imBkZYSnb
         nnQkATU/kcbDH8RNFbDj1eNsvzfSv88Ob6rSA+TXCpmkxOkQYEDgQ4JNKEryFuaP5I9x
         oqdnzwTbI6sL77eustqMAaNUtsnn8hMu/lHmUtHb62ng8jFX6SPDkPSIxHgPfk5JwHe1
         y/NA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787765427; x=1788370227; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        b=Wdpv0jl2UUlZrSRHHOSrHnSMbtBfPpwzTI9IAHgWPi3wigtD4HkoP5NdeJ8PpKtyuN
         GS+Du6LIWRppZIiqBUtkTzjhpdXMru/XUc8/5lLvZd/Zx7cAhOBlCXmt7xVc0CeinS43
         ptqAX295AMhJH8LJhc38GIpWJuZJMQToJW7oK4GJiRDmzlDPMMFYKDa7h5ino4V4CJhB
         eXKXC2QC3sMzbIgsIzb/ciIvpyYIr/bpkKtEsdAwT2uZcoM1B/q5b6aC/MLe2k1nxmsn
         cCUgDf5cPEUc+GjbrKHqAkU0hwZ8b8iuC64bnWQKngrvgx+vPcOE0a5s1x3J+B0p3MWi
         +dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765427; x=1788370227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mADOW/zXjYAYuEehDtg7mIumLwYtucuRE6QwBoqgK9s=;
        b=siZc0ump8a7+jGpHoapb6jctnP9DyVhFO1I/pdY8p4Z4SDJAY3kQCjVoto2DoS2WNe
         lPrGZiAj4MkMnZCIkAPw+GIxyZcP1GubD4NPl31hNJ4jkWc6t+npq4sTRRFwXPi9WB3I
         rCRb4crf7aJBTTDbSG/8tRm+WSV2lzg8IXfCi7Frq/cTJPP7ONMGvNETJdWk5kgkpuMj
         8zbYN1h4CGmXLNqQqkpn7FpemWWJ/4mz/GzSfE3Cx3LSs2kx8aRWjhdlakgeg/a1hN2s
         aagoWF0ZP8CIfsz1qiT8GPRbW6u7+YJUWEHOx9bhVzGhw/nFVkFA4TvXgY1T3LHBpjF/
         Nkmg==
X-Forwarded-Encrypted: i=1; AHgh+RqYklp5rRqbmAo0M6c46vSkaje4PkHepX3Mn5LKkLqJW6Q0jmZqTNy6nijj435QvDGgUUyTpg==@lists.linux.dev
X-Gm-Message-State: AFuF++nanBifCY2wC3PjuZTnE2bfxsECO2d87io/IM8Fa3SenVYaK9qF
	GkaPA1lopFLdsovK4sOzaXGis7FRGCVV7tYnQb5irgpoxh/3CoG6FYHE6v9skgebc4z7EL+LEPh
	r1dfBkwgXi7RTOFDfGSFBFqOB7J6+uUcg/opGBO48
X-Gm-Gg: AR+sD11Il8+wduOjirwLoHxXtCVI5AX5zU+TgNyfRCGlhTMv5hiTAyjKd8ZeEoHtkml
	oRerH//mK7t2kF96ZGzhQcO0MpVNsnSd9DnReOcoj/17cQJQLH6l8K+Z0ru30e9gkM3aA+CFAvF
	iaGpjrP8kP4c2zMd87wOhsHuc9AbVdMrTxk2NXXmq7Y56uOJN0WCGi+Ls3DoppqYnoksV6POesX
	fnjPoAAMogOGvXpqTQGoWK0dLtpiCam/xwFjyOBhr92HJneiqK7F7xTGxCydhnUQiSzD6H9JyDh
	bhoC+HasaH0JcfuaiWo819DJLMn6x7R0/8myUKFTstSgpQ9+4TOs3HMfdg+ZTMe4xz8NiBTp+qZ
	t3/tXfY+zsNxxEIAVmWIOCN/7UF527vyAgr69ZzWwT5cMt7dRhGMK1+f5lE8=
X-Received: by 2002:a05:622a:3d4:b0:52d:7b2a:93f with SMTP id
 d75a77b69052e-52e422d73camr87475071cf.3.1787765426178; Wed, 26 Aug 2026
 10:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260826171344.4133-1-blbllhy@gmail.com> <20260826171344.4133-2-blbllhy@gmail.com>
In-Reply-To: <20260826171344.4133-2-blbllhy@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Aug 2026 19:30:13 +0200
X-Gm-Features: AcwNN1XFn8gzzgrjQfG4ZiFeGArbznLUn8IBe3QpZkDe5XgxFwMYGCWbJrGLGFE
Message-ID: <CANn89i+5+3-u3T0Tbu_NeDSc2L1_Fpqtf_inKB5k0tN=9SUaiQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@google.com, horms@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, yhs@fb.com, kafai@fb.com, 
	andriin@fb.com, ast@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:14=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmai=
l.com> wrote:
>
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
>
> do_tcp_getsockopt() reads icsk->icsk_ca_ops->name without holding
> rcu_read_lock(). Since commit 0baf26b0fcd7 ("bpf: tcp: Support
> tcp_congestion_ops in bpf"), icsk_ca_ops can point to dynamically
> allocated BPF struct_ops memory that may be freed concurrently via
> setsockopt(TCP_CONGESTION), leading to a use-after-free.
>
>   BUG: KASAN: slab-use-after-free in _copy_to_user+0x37/0x60
>   Read of size 16 at addr ffff888013505260 by task exploit/149
>    _copy_to_user+0x37/0x60
>    do_tcp_getsockopt+0x158a/0x2460 (net/ipv4/tcp.c:4585)
>    tcp_getsockopt+0x91/0xf0
>    __sys_getsockopt+0xf7/0x170
>
> Fix this by holding rcu_read_lock() around the ca_ops->name access,
> using READ_ONCE() to load icsk_ca_ops, and copying the name to a
> stack buffer before releasing the lock. Also annotate every explicit
> icsk_ca_ops store with WRITE_ONCE() to fix the accompanying KCSAN
> data-race issue.
>
> Fixes: 0baf26b0fcd7 ("bpf: tcp: Support tcp_congestion_ops in bpf")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Link: https://lore.kernel.org/all/20260821182449.79785-2-blbllhy@gmail.co=
m/
> Cc: AutonomousCodeSecurity@microsoft.com
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.c=
om>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
