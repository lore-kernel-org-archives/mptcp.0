Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AF539774;
	Tue, 22 Sep 2026 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075385; cv=none; b=cAKX0rVvtcFf+doL/sfZxGp+10IxZ3ABln9cIrRydr1lTJ5RkISdTCbBv3ai41zCVF0ICTg9qWffGCjBTp3KkLA7e7rCs+qPbh4BGozYT2ewkfjjOmSv9WXlfJZOn2LFI0jsqMr4Nona7g32ljA5zfjScz0G0Qar0VnEk0F9XFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075385; c=relaxed/simple;
	bh=1Kbd7sm7Zbyqlo6x4YK+d+CYx7oson7+JkQDay4g4qY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9ng9xddXAmC74Om4yAXaS3+M381NaTcFv7EuJXsD7J0zPVip8rYZIbvwNRK5gfTJIP/0qmBM3rIkIUAdcd6DeEI6dW/HvWRrxo6goO3b0esjDSV4HQF9iTIXrtxAO0wmuFzFcmTX0zDF5x/ihf9X9NAQXoZZTbpAr+AK0vfq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHGvWLZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHGvWLZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE5C1F000FF;
	Tue, 22 Sep 2026 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790075384;
	bh=ok+E57tMcdPlbnPCpn//RyvaUEA7/ZSu089lzHgUcg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iHGvWLZwVdc+7SjApax/W2LmI4Qqo8DoKplF/yiD4EMhw8G3IKIG31jV7e+VCjgaY
	 0fO1I7qnjF1Gxd8ZpLAmADefwEZCAbPXqah324ePSzEBxbG2awAUGDt0CIweXwC1n9
	 XRR9TJzt/DuodiqEyvrl+bD/0xIPHkZ+YCzlTF2gMOZFWjTu78lff6SqHx8QihqvxR
	 l4BQMFI9yd63e67CAagm6YRDLmKsRNcfS8f5VYVr224ZrgxAugKaCbAxopP4O0yWW5
	 j+fbWFfua3etR6jIAnJT45rpRH/qB3pYKIlz6e5+3WmM19vMFwJX1n/ns23wgh10ko
	 SNuGyjmXpWQxw==
Message-ID: <8205e3627e87cca7e59b22d45d60a8a4dfb25263.camel@kernel.org>
Subject: Re: [PATCH bpf-next v3] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
From: Geliang Tang <geliang@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bot+bpf-ci@kernel.org, 
	john.fastabend@gmail.com, jakub@cloudflare.com, edumazet@google.com, 
	ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org,
 martineau@kernel.org
Cc: tanggeliang@kylinos.cn, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	mptcp@lists.linux.dev, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, 	mason@kernel.org, ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 19:09:31 +0800
In-Reply-To: <08ff0ec5-55aa-46ae-a224-b2d02aa2979e@linux.dev>
References: 
	<85d9a0f138fa024354edde023a05f9d07b6ac87a.1789633546.git.tanggeliang@kylinos.cn>
	 <b39121f2d0860a81719fb0b3f9b16bde9157bc043d7cc918497afc6d896877de@mail.kernel.org>
	 <08ff0ec5-55aa-46ae-a224-b2d02aa2979e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiayuan,

On Mon, 2026-09-21 at 19:46 +0800, Jiayuan Chen wrote:
> 
> On 9/17/26 5:45 PM, bot+bpf-ci@kernel.org wrote:
> > > bpf: drop duplicate check_app_limited in tcp_bpf_push
> > > 
> > > Before commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to
> > > use
> > > MSG_SPLICE_PAGES"), do_tcp_sendpages() did not call
> > > tcp_rate_check_app_limited() internally, so callers needed an
> > > explicit
> > > tcp_rate_check_app_limited() to cover it. That commit replaced
> > > do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, which
> > > perform
> > > the check on every path that queues data. The outer call became
> > > redundant
> > > but was left in place.
> > This isn't a bug, but would it be clearer to cite ebf2e8860eea
> > ("tcp_bpf:
> > Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg")
> > as the
> > commit that left the outer tcp_rate_check_app_limited() in
> > tcp_bpf_push(),
> > with c5c37af6ecad9 mentioned as the commit that moved the check
> > inside
> > do_tcp_sendpages()?
> > 
> > Looking at the git history, c5c37af6ecad9 only touched
> > net/ipv4/tcp.c and
> > turned do_tcp_sendpages() into a wrapper that calls
> > tcp_sendmsg_locked().
> > The direct tcp_sendmsg_locked() call in tcp_bpf_push() was
> > introduced by
> > ebf2e8860eea, which kept the outer tcp_rate_check_app_limited(sk)
> > while
> > inlining the wrapper.
> > 
> 
> CI is right. ebf2e8860eea should be accurate.

You're right, thanks for the careful review. ebf2e8860eea is indeed the
commit that inlined the wrapper and left the outer check in place.
Updated in v4.

Thanks,
-Geliang

> 
> 
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's
> > not a bug.
> > See:
> > https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> > 
> > CI run summary:
> > https://github.com/kernel-patches/bpf/actions/runs/35203307255
