Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738943D6CC3
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643239; cv=pass; b=Nft2A4qAqWzPqCxeGYc6ikm90h0HSJlsCqLS+4hn/cfjKi8jTojf0pROcUv77Y2gEq5DXE3S1G+ZX+Ek+dg7RBI46MDss4JlWCBd1r6GvoBST3n1M8eiYEPkZCl8DSz2pfPqYpK0EV61kRfFYyvG+KipouRGqWYLXVWXn6Cvp3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643239; c=relaxed/simple;
	bh=41xDYFQQpziqncNzQ0S4/AEnmyQN67a4Es40OByesrQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XVWPPYfq2cRpfiNGKXimaqatVWzbVUJogwR26jlQjqpY2DIVgonkRtOJnswaFsAhAoUh65seFIvE13FotINqF37AtIeC/72T4RJt90dv2Aw84P1ZT2GrWZB0azeB0NTNbXoPFCLtR+lr9+0tc3E10g2PyxET8bJdjwPGCYiU1qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=cx+4F74d reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="cx+4F74d"
ARC-Seal: i=1; a=rsa-sha256; t=1789643207; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DNhOUAo1jlLUwd02itr2IC9/qEoshkkTg5q/bVmOFU4XdxD9q2qwZY8TRcwfpsJQfNDEo7oznARWc5S8PYWDMMy8H0sM+mAGAQIQmWORZkBHJO+PlJKi5YvORnVwDCM92K6ozp9hR7oGMecfu6iYnqJUtQjJGi5ganGYS6NBtoo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789643207; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z3q7s9EkdzfJ7kZtJqAQ2XTDo7/rlMeQle/Z1w4CZ80=; 
	b=LKp6I1bIqSg8QGNSljTD5GfubvRBYXnT0f3IHMqP9Di8yLqzPtSwSVcEIHXYMemEruGpPOBojYbiNw6WT+iSvVkOqMzRC/P71HLL2DRtBgV6LeJQZ3CekDt1cHtRxk0ONxJVqgZ0OlidZl4zXwxwOuicJdz9gbbLf19FkcZy1Qo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789643207;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Z3q7s9EkdzfJ7kZtJqAQ2XTDo7/rlMeQle/Z1w4CZ80=;
	b=cx+4F74dSU/bo4Pxw3BLUrMwMFbk2b2ecyo8ZgNAHkZWIjqdQUOChlds6s8kmKxn
	R+et3e8K/fiXTC4vm5hI030I2JmBkpQdFgJJWEeh6qXA2//QeNwmlCK+t6flsbe+7Wc
	+hUqzKDzfuwUvn1cLNwL6rk3KcI7XAwtTzEvEfUc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1789643207468545.0938849369105; Thu, 17 Sep 2026 04:06:47 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17896432040711007.7801553990827; Thu, 17 Sep 2026 04:06:44 -0700 (PDT)
Date: Thu, 17 Sep 2026 16:36:44 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "Jiayuan Chen" <jiayuan.chen@linux.dev>, "bpf" <bpf@vger.kernel.org>,
	"mptcp" <mptcp@lists.linux.dev>, "VEGA" <vega@nebusec.ai>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"John Fastabend" <john.fastabend@gmail.com>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Jiri Olsa" <jolsa@kernel.org>,
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	"Ihor Solodrai" <ihor.solodrai@linux.dev>,
	"Shuah Khan" <shuah@kernel.org>,
	"Mat Martineau" <martineau@kernel.org>,
	"Geliang Tang" <geliang@kernel.org>,
	"Matt Bobrowski" <mattbobrowski@google.com>,
	"Tejun Heo" <tj@kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>,
	"netdev" <netdev@vger.kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Message-ID: <1a0af0c25d8.352950d2114190.972790069861537729@mpiricsoftware.com>
In-Reply-To: <18f86b06-7477-4750-b57e-094df4310e4a@kernel.org>
References: <20260917081209.361367-1-jiayuan.chen@linux.dev> <18f86b06-7477-4750-b57e-094df4310e4a@kernel.org>
Subject: Re: [PATCH bpf v1 1/2] mptcp, bpf: reject bpf_sk_release() on msk
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt, Jiayuan,

Thanks for looping me in, and thanks Jiayuan for catching this.

This is a separate bug from what I was fixing. My patch hardens the
lockless read of ->conn (the NULL-deref/UAF from #622) with
rcu_dereference()/acquire-release/SOCK_RCU_FREE, but that doesn't
touch the helper's return-value ownership contract, so the refcount
mismatch you're describing exists independently of whether the read
itself is safe. Hardening the read fixes my bug; it doesn't and can't
fix this one.

Given that, I think Paolo's original suggestion (dropping the helper
from tracing_prog_func_proto()) is the right call. I don't see a way
to fix the refcounting issue while keeping the helper's current shape
(returning a different object than the input, with no reference taken)
without a bigger rework of what it hands back to a BPF program.

I checked which prog types can actually chain bpf_skc_lookup_tcp()
into bpf_skc_to_mptcp_sock() - it's broader than just tracing.
sock_addr, tc_cls_act, xdp, and sk_msg all have bpf_skc_lookup_tcp()
available and fall through to bpf_sk_base_func_proto(), which is
where bpf_skc_to_mptcp_sock() is registered, so the same pattern
Jiayuan showed is reachable from all four of them, not only from
tracing programs. sock_ops doesn't register bpf_skc_lookup_tcp() at
all, and cg_skb has the lookup helper but doesn't fall through to
bpf_sk_base_func_proto(), so neither of those two can chain into it
this way. I haven't traced the verifier's reference-tracking closely
enough to rule out some other path I'm not aware of.

I don't have visibility into whether any real tracing (or TC/XDP/etc.)
programs use this helper today. If that's a live concern for anyone,
I'll defer to whoever has that visibility.

I can send a version that drops bpf_skc_to_mptcp_sock() from
tracing_prog_func_proto() as Paolo suggested. Given what Jiayuan found
also applies to the non-tracing paths above, should that patch just
remove the BPF_FUNC_skc_to_mptcp_sock case from
bpf_sk_base_func_proto() as well, rather than leaving it there for
sock_addr/tc/xdp/sk_msg?

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Jiayuan Chen"<jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>, <mptcp@lists.linux.dev>
Cc: "VEGA"<vega@nebusec.ai>, "Alexei Starovoitov"<ast@kernel.org>, "Daniel Borkmann"<daniel@iogearbox.net>, "John Fastabend"<john.fastabend@gmail.com>, "Andrii Nakryiko"<andrii@kernel.org>, "Eduard Zingerman"<eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"<memxor@gmail.com>, "Martin KaFai Lau"<martin.lau@linux.dev>, "Song Liu"<song@kernel.org>, "Yonghong Song"<yonghong.song@linux.dev>, "Jiri Olsa"<jolsa@kernel.org>, "Emil Tsalapatis"<emil@etsalapatis.com>, "Ihor Solodrai"<ihor.solodrai@linux.dev>, "Shuah Khan"<shuah@kernel.org>, "Mat Martineau"<martineau@kernel.org>, "Geliang Tang"<geliang@kernel.org>, "Matt Bobrowski"<mattbobrowski@google.com>, "Tejun Heo"<tj@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>, "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, "Paolo Abeni"<pabeni@redhat.com>
Date: Thu, 17 Sep 2026 15:09:13 +0530
Subject: Re: [PATCH bpf v1 1/2] mptcp, bpf: reject bpf_sk_release() on msk

 > Hi Jiayuan,
 > 
 > +Cc Kalpan, Paolo.
 > 
 > On 17/09/2026 10:11, Jiayuan Chen wrote:
 > > A bpf prog can do this today:
 > > 
 > >     subflow = bpf_skc_lookup_tcp(...);
 > >     msk = bpf_skc_to_mptcp_sock(subflow);
 > >     bpf_sk_release(msk);
 > > 
 > > bpf_skc_to_mptcp_sock() returns subflow->conn without taking any
 > > reference, so bpf_sk_release() drops a refcount nobody took on the msk,
 > > and the subflow reference is leaked:
 > Thank you for looking at this!
 > 
 > Note that Kalpan was looking at this [1], and Paolo suggested removing
 > the helper [2] (but we failed to review the last version so far, sorry
 > about that...)
 > 
 > I don't know if there are progs already using it. If yes, I guess your
 > approach is better (but I'm not comfortable reviewing verifier's code).
 > 
 > @Kalpan, WDYT?
 > 
 > [1] https://lore.kernel.org/20260818120437.3949686-1-kalpan.jani@mpiricsoftware.com
 > [2] https://lore.kernel.org/e039e866-fe7e-41ef-ad41-92a76a123713@redhat.com
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 


