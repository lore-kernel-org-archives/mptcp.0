Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88713126B7
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530695; cv=none; b=KDSkgA4d0m3vjehBFYeAa/3j7LCe6W4X84Eho+mF+50QCt36W8qw7zjy3Xlihe1Sg8Yndd1KzWeAvbtj0TxrUYQ2SQ0wkzgURx+sRax+n7Ti5/DZYzB5+B0u1FYjvWilX5FWBwd8nyLkZ9EglgR+gXToBHHYqqygA+uIkagUcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530695; c=relaxed/simple;
	bh=+E/ie/fFfzQzXCm+TC4/fngCcNBywLEYXgQBqOD4iUQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ku9SQ7C0hZ0zVSRmvQ3FhPQzrr/W4l0ZA5zsY/X9jpcHCUWrDLWOITvsw6q8BMCar//Z2BRpd5O57Q+RdburxgfQwmP27CSXx2+FE1ouU6CgOUiLUNhUMBx/Zd+328mYkisoGM+uegy2zD7euklozy/yw1tCnSx0ohpSHbDfYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkM7IOGc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkM7IOGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3F3C113D0;
	Fri, 12 Dec 2025 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765530693;
	bh=+E/ie/fFfzQzXCm+TC4/fngCcNBywLEYXgQBqOD4iUQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bkM7IOGcOuJgzvn8sBSdjoaDhgoLrolHR1FadLsHtBs1lzximc1DRpS34QW1q8L1e
	 Qxc8OhNVc5s4mNKOgQ1nXWXgJDNPV/IwqdhM6zuoNl9+3juWoGbOor1dw9H2RVVYoy
	 tbXyMvuznoUgW8a9163cdD7sfTnl5HJZbxnIoWxPcwhffEyq4+UnEcdmJV33/1paQ0
	 mxZEV/YentsK+9tU5Cuxe5VmU+anFmOcWTMgiykvK7gMH+Xu+mCRb2WChFDD4IlvYx
	 UKbgM1ILJaQiitlOLaBmiZWbnCg+FgDQKmpm1p4pt+Sx8yOEDwdW9ikEzuGheFEJMy
	 mfVkm3N2OfBKw==
Message-ID: <0840d15cd328e59d8d12dbd54224488f8f44813b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v15 2/6] mptcp: implement .read_sock
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Hannes Reinecke
 <hare@kernel.org>, 	mptcp@lists.linux.dev
Date: Fri, 12 Dec 2025 17:11:24 +0800
In-Reply-To: <a3838d83-64a5-4c6f-99a4-b69ad515836c@kernel.org>
References: <cover.1765023923.git.tanggeliang@kylinos.cn>
	 <6d5470547063a740c0eb2f80655fafd7dc47716e.1765023923.git.tanggeliang@kylinos.cn>
	 <a3838d83-64a5-4c6f-99a4-b69ad515836c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2025-12-11 at 19:22 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for working on that!
> 
> On 06/12/2025 13:33, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > nvme_tcp_try_recv() needs to call .read_sock interface of struct
> > proto_ops, but it's not implemented in MPTCP.
> > 
> > This patch implements it with reference to __tcp_read_sock() and
> > __mptcp_recvmsg_mskq().
> > 
> > Corresponding to tcp_recv_skb(), a new helper for MPTCP named
> > mptcp_recv_skb() is added to peek a skb from sk->sk_receive_queue.
> > 
> > Compared with __mptcp_recvmsg_mskq(), mptcp_read_sock() uses
> > sk->sk_rcvbuf as the max read length. The LISTEN status is checked
> > before the while loop, and mptcp_recv_skb() and
> > mptcp_cleanup_rbuf()
> > are invoked after the loop. In the loop, all flags checks for
> > __mptcp_recvmsg_mskq() are removed.
> 
> (...)
> 
> > +static int mptcp_read_sock(struct sock *sk, read_descriptor_t
> > *desc,
> > +			   sk_read_actor_t recv_actor)
> > +{
> > +	return __mptcp_read_sock(sk, desc, recv_actor, false);
> 
> In this series, it looks like __mptcp_read_sock() is only called
> here,
> always with noack == false then. Will you call this helper with noack
> set to true in another series?

Yes, indeed. This read_sock will be called in all three series that I
am currently developing.

1. In "NVME over MPTCP" series, mptcp_read_sock() will be used, see:

    consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);

in nvme_tcp_try_recv().

2. In "MPTCP sockmap support" series (issue #521),
mptcp_read_sock_noack() will be used, see:

    copied = tcp_read_sock_noack(sk, desc, recv_actor, true,
                                 &psock->copied_seq);

in tcp_bpf_strp_read_sock().

3. In "MPTCP KTLS support" series (issue #480), tcp_read_sock() is used
in tls_strp_read_copyin():

    tcp_read_sock(strp->sk, &desc, tls_strp_copyin);

I originally intended to use mptcp_read_sock() here, but it would cause
a deadlock, so I had to switch to using tcp_read_sock_noack() instead.

> 
> (Maybe the extension could be introduced later, but if the next
> series
> follows, that's fine to keep it like that.)

So I think it's better to keep this patch as is.

Thanks,
-Geliang

> 
> Cheers,
> Matt
