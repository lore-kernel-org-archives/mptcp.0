Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F028CF5D;
	Fri,  6 Mar 2026 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839541; cv=none; b=CvGjdSB4l18wpK2+b4oJz0aNld8wUl0Tu4OyyWW632TtRPDVfsCETrmSujfNVYvnu+j4jDsg3TAKcST1xhGo7D/UgZP+8IsjbZJxuOn23tXCPds52nWDldmA+IbtJ/ynfBvwGwHBIqaoWQPmjurksQhP0b42ZpLmMe4ysNvuwyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839541; c=relaxed/simple;
	bh=N31KokOy7H3hyufGhfTf8TppfdU2vFDr4N8hvP5RiCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8wkiiOm4rjh1e25N+VfW0sA6oL1jOLj7ANOcDsjLVqncILPcqrEr3IOsAfRkQ2jNUfdreIzVpZKrGsX0RxzOBhviu9VozOPdI3NVboDS73ZFKgLZWYYyrVa7NSqJdebJzWn/9YV6R7jCrHMEZ0aaBMFZm8pdIlU7g+TtBAkBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upK9pg0+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upK9pg0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DACC4CEF7;
	Fri,  6 Mar 2026 23:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772839541;
	bh=N31KokOy7H3hyufGhfTf8TppfdU2vFDr4N8hvP5RiCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=upK9pg0+/dg6I22RR4Y4rlGH2W9c9jFr+UTZaE2D1UBQnDjvcIg8uCpiT+r51Ytsq
	 Kwoefhyf03s13iLt65eMhelFOG1wnunqfBhDVWYQNo1kM6vjabadP0CRdms1bQLDJs
	 4wc6Gcmajk3oPvAJpHRqxx3vDJi+yYP/nbOwpvdhKSJgddGHK12URSd0HKmi0hiBuU
	 0V6ra6HsYviBUC30X/XzR0CKupDpBFJ13HCSX4kTpNnwZZkaXrE/KzxeGbW5K3aLIh
	 jYd5PrZwCpgxDDs3PWefTWVI9v7VnFEXqJiLcHhJdmKfMFa5Qj6VF7vt/TgHV9nrz7
	 uwvhWlLXhQyBA==
Date: Fri, 6 Mar 2026 15:25:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, Jakub
 Sitnicki <jakub@cloudflare.com>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in
 __tcp_transmit_skb()
Message-ID: <20260306152539.28f5a6f3@kernel.org>
In-Reply-To: <20260304111517.2088694-1-kmta1236@gmail.com>
References: <20260304111517.2088694-1-kmta1236@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Mar 2026 20:15:17 +0900 Keita Morisaki wrote:
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
> 
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=y (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
> 
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=y):
> 
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
> 
> Also add opts->options = 0 at the top of tcp_syn_options(), which
> already used |= without a prior clear. tcp_established_options() already
> clears opts->options at its top.
> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>

Applied (cfcceb7a39f), thanks!
-- 
pw-bot: accept
