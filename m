Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA853A16A8
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645812; cv=none; b=XrQCj/2HYoRi0krYGZwKvqe0OvzEz0y0ibJ8T4EgeNWqmfbAfWiiuCgKZjBh9odT9uXy2a+yEeRnhnDePMN2FrpAU6p1xNLabCLLwfbN2AYzWkOVJUbpeJDIUs4h2a+61o42sGBfEhalE2KDb63Jwh+Z67ihmn1YkZqEyRJEa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645812; c=relaxed/simple;
	bh=pUWBlih9z956pCriVXB6GclQhA0+T9lUzOfBa2cnMdY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=qQXmWaVM3cJcv6kf+UqcQjHxssgfbAIusuXQZUie0EDJmxZvYXS0b208bu8mDXaJ4chfoBN/rjwrXgcolUOZeIybwiPGIH+LmKAoFzSZBk6cppHExTn/f8ctFvOME30Wr9R0MfFRMfPrMeh6Uqoxb8PU95phuRDImmUtDq35onI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EroRjIW/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EroRjIW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72391C2BCC4;
	Fri,  1 May 2026 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777645811;
	bh=pUWBlih9z956pCriVXB6GclQhA0+T9lUzOfBa2cnMdY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=EroRjIW/oGRdb6jFsp2B8itwmL7izbZ1nqxWBhrxZGFTZNDW4ZmTxrbRC8fMLMgMn
	 M5sRXfvwWfJ78l4v5iXIjLTdj0tqlQj6effcHKQHI5MgD+/dgf2sEoTZV34MzhNnwY
	 D+NUFzVDgm/4SZSPk3erdBJfb/S/8szInq01LaFCXsqKgkMRzr5VLUez59ldKVyEtg
	 nPCCtkym+2tEaBsYj/aPsWhCc2gV26Vfzd3CGNdAyfM9fE6LPWkDM6WBU/eqdMwMkO
	 PQyfAfdjQDlevAOljLM0vGHLWmqJcsDluSAu+PZxDaAcDTVqk1n0gjXJ05MttXkbKt
	 pp1ees3IqpoAw==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 mptcp] mptcp: Clear mptcp_out_options.ext_copy in
 mptcp_established_options_dss().
From: Matthieu Baerts <matttbe@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Keita Morisaki <kmta1236@gmail.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, mptcp@lists.linux.dev, 
 syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
In-Reply-To: <20260501061939.1808489-1-kuniyu@google.com>
References: <20260501061939.1808489-1-kuniyu@google.com>
Date: Fri, 01 May 2026 16:30:03 +0200
Message-Id: <177764580322.3218472.133815625568510242.b4-review@b4>
X-Mailer: b4 0.16-dev-76c3c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2481; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pUWBlih9z956pCriVXB6GclQhA0+T9lUzOfBa2cnMdY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/7PioVGV6bZlfcvj55sRAQWkNk2cL/c23er64tNVzw
 +yXM5liO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyio2RYZWD3OnUYh1JWeGK
 F/wKJ/c8OMFjfk/Vq6nizwOvch0uX0aGFjmjslVqUsryazv+Be+ean9QOexc5tPHR9yd21JKZ6p
 xAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Fri, 01 May 2026 06:19:35 +0000, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> syzbot reported read of uninit-value in mptcp_write_data_fin().
> 
> Since the cited commit, struct mptcp_out_options is not cleared
> in __tcp_transmit_skb().
> 
> Let's clear it in mptcp_established_options_dss().

Thank you for looking at that! I forgot to look at the bitfields that
can be half initialised when reviewing the cited commit...

> 
> Another option is to move struct mptcp_out_options to struct

Indeed.

>
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4cc583fdc7a9..ae1cb955035b 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -572,6 +572,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>  	bool ret = false;
>  	u64 ack_seq;
>  
> +	memset(&opts->ext_copy, 0, sizeof(opts->ext_copy));
>  	opts->csum_reqd = READ_ONCE(msk->csum_enabled);

Sashiko is saying:

  Will the bitfield assignment to opts->csum_reqd still trigger a KMSAN warning?

  Looking at struct mptcp_out_options in include/net/mptcp.h, there are several
  bitfields that reside outside the ext_copy union:

  	u8 reset_reason:4,
  	   reset_transient:1,
  	   csum_reqd:1,
  	   allow_join_id0:1;

  Because __tcp_transmit_skb() allocates the mptcp_out_options structure on the
  stack without zeroing it, the byte containing these bitfields remains
  uninitialized.

  The compiler translates the bitfield assignment into a read-modify-write
  operation on that uninitialized byte, which will cause KMSAN to still report a
  read of uninitialized memory.

  -> via: https://sashiko.dev/#/message/20260501061939.1808489-1-kuniyu@google.com

That's the only other bitfield in this structure, but it is not next to
the other one, and with all the unions and inner structures, it might be
harder to introduce a new struct_group().

Maybe safer and easier for the moment to memset mptcp_out_options struct
before calling mptcp_{syn,synack,established}_options() from
tcp_output.c? Or from these functions. This will then only be done when
the TCP sk is being used by MPTCP, so that doesn't impact "plain" TCP
connections. WDYT?

(Or using two new unions to clear these bitfields with
'opts->cleared = 0' from mptcp_{syn,synack,established}_options() and
'opts->ext_copy.cleared = 0' from mptcp_established_options_dss()?)

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
