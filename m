Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B606F30DEAA
	for <mptcp@lists.linux.dev>; Tue,  2 Dec 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668419; cv=none; b=E4HgicNsnbxlGWwpC41whLDqc516eeesinMMO0t26gT5xzwrAJSQaCMqL90MbJipn5BjqNOKc/P/zyhovH4+/x2FY5a4XSmqUOO5GAdX50TPjjk/zfhXIq/3Ad9cQjhr431rd/5UAPRQ5f32jZXG1SahatMkhZ6Sqw0dXjGENoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668419; c=relaxed/simple;
	bh=/aCIS3A44YVOT7Yt+v0rWfdkxLd4NUb9BnKrIXswz5A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X/bIbXpbyu7WO3WHOKu+B2pU2XXyp+5ynXlGuJaD8fPa6k7yrwsjwlibICK2Io/ZyjD/s9zKcB1HSNJ5mOX1X2jzXZtI3qSmhYFyzhbmsBk9xVVlTO3cQj16m7xI8zbDPQ581jquWDYm5PNrpOvyNYWF0TS73NAo/0/oZyXoqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJT+GEwk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJT+GEwk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0298C4CEF1;
	Tue,  2 Dec 2025 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764668419;
	bh=/aCIS3A44YVOT7Yt+v0rWfdkxLd4NUb9BnKrIXswz5A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hJT+GEwkEgx4+eJ1XR7OeBOj3KaN0rPKFRfZh9h85EVCTaIFMOLJ3MgjfL/Vj65Hu
	 d738XRot0WXGiaKEJdWT8pqtH0l9nWkQRfPcFH7EIUMAdwL6QYBLjXK1QwtGifwgmw
	 sxmBUYYfqhZ9yjsYnLd7J3FOuBVA092JMH2B3plV+NhGNoVdU4nqs/ptiC0XIskzjD
	 QQjg6N1cpxB5RsXZHge4pb9MhFyIp9dr/IhcEr3ejKEfhGW1z5SelGI5Y46LWSUqsv
	 +n1X22wzNyB7Jma0pJ/qFSWrC9AqQKwbDzhCtEItFcvDsGq0CgS6f0qcYzbrCgWkh6
	 RXBgURQQ9E75A==
Message-ID: <90461cd50133cd2b845a49dab7d3334aca4e0a15.camel@kernel.org>
Subject: Re: [PATCH net-next] tls: check return value of
 strp_load_anchor_with_queue
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 02 Dec 2025 17:39:06 +0800
In-Reply-To: <ad0fedfd-e25b-4054-aabf-ebac46dbbcd1@redhat.com>
References: 
	<ce74452f4c095a1761ef493b767b4bd9f9c14359.1764333805.git.tanggeliang@kylinos.cn>
	 <ad0fedfd-e25b-4054-aabf-ebac46dbbcd1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Paolo,

mptcp-list only.

On Fri, 2025-11-28 at 16:01 +0100, Paolo Abeni wrote:
> On 11/28/25 1:55 PM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > In tls_strp_load_anchor_with_queue(), when first is null, strp-
> > >anchor is
> > not successfully initialized. Accessing strp->anchor afterward will
> > result
> > in a memory access error (for example, BUG: KASAN: slab-use-after-
> > free in
> > skb_copy_bits).
> 
> tls_strp_load_anchor_with_queue() has:
> 
> 	WARN_ON_ONCE(!first)

I printed sk_state of strp->sk when first was null, and found it to be
8, which corresponds to TCP_CLOSE_WAIT.

Following further debugging, it was found that the issue lies in
tls_strp_read_sock() in [1] ("tls: add MPTCP protocol support"), where
I used mptcp_inq_hint() to replace tcp_inq() as follows:

-	inq = tcp_inq(strp->sk);
+	inq = strp->sk->sk_protocol == IPPROTO_MPTCP ?
+	      mptcp_inq_hint(strp->sk) :
+	      tcp_inq(strp->sk);
 	if (inq < 1)
 		return 0;

However, mptcp_inq_hint() returns 1 when sk->sk_state == TCP_CLOSE or
sk->sk_shutdown & RCV_SHUTDOWN, which is inconsistent with the behavior
of tcp_inq().

I can modify the condition here from 'if (inq < 1)' to 'if (inq <= 1)'
to fix the issue, but I know this isn't a good solution. I need to
reimplement an mptcp_inq() helper instead of directly using
mptcp_inq_hint(), right? Could you give me some advice?

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/2a0f438fbd4c5ddf7d8153bfc8aa44cfefa58c45.1763800601.git.tanggeliang@kylinos.cn/

> 
> and AFAICS all the tls_strp_load_anchor_with_queue() call sites
> ensure
> that the receive queue is not empty before invoking such function.
> 
> Hitting the above condition is a symtom of a prior issue that must be
> identified and fixed. Please try to solve such problem instead.




> 
> /P
