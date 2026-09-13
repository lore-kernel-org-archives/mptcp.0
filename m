Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18937C0ED
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789323731; cv=none; b=X8ZMI34fw1V9owcs/b/OowT02lRtGJyjJ9RWaoxNq12WlltJec5PynkfbQTY10meQHlONMfaj7tPb4Ly/CXcdCHeUNWQC6neYkjE6tCAkEyoRpQ1oBLWDj7xVZPk85aObD1WhWoBhHvDCybf9ZgtCqX0PFCnioXKLZglhh7QRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789323731; c=relaxed/simple;
	bh=WZirnNDgoFDNiazAypqF7+2tbxwY+mxFWceA4z5W96I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMmQszIij/hffFB+cWHZwTol7NlKvUQJKSo62nHnQ19r6I/r/kBX8d+8dFCbehXsIVLdgxVYJOxJ3PyzBiisOHQcxuABkqIgSBxs2uabVBEJMgP5kni8hDRm1CDuScFBUDT9XJnyt9PMXlHW4Wku6ht6LMDzG63cuRfkVvSY9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzRGuVMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzRGuVMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7211F000FF;
	Sun, 13 Sep 2026 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789323729;
	bh=nW/NXQsNlc0+QIzZk+s+cpLPERdLhXjwLd0iI1wp5aw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dzRGuVMYFZzOzFRtb8xekiyZv+1g+NvpDQsuuCf0qMhRS9J/QDZx5o9vAYRMnIqjZ
	 H2l6JhgRpCWENsQptk093kO9aJe7XHTB2aHOHEN+ORYtfYzNQ0TCran6vaBWj3qML4
	 a+Az7tKp5gEsHV8uWGife1qICbZ26sJgAdcmr5Fsi0diwMfzMBIWSy7fBra7Wd+fyp
	 U28qKC3ymr5DgZiY4+pRAIbH5Hbk2RqzjIOZkRbYAOrd/zOh5AotOV/R3BHAPcNHHq
	 5LLQfRwT3MMOboCZxezqzX12uoo9BYKf6tZCv0BLg8xwNpyiWGIFcwYbdNhK8jbi1K
	 zLK3shBzWhDBQ==
Message-ID: <0a4bbaf9-7cc0-4ec8-b630-261a0b324e86@kernel.org>
Date: Sun, 13 Sep 2026 20:22:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v5 06/16] mptcp: implement psock_update_sk_prot
 for sockmap
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, kernel test robot <lkp@intel.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
 <39ae7a2bebed6f38d02356c7e288a21a70bdd07f.1789294365.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <39ae7a2bebed6f38d02356c7e288a21a70bdd07f.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2026 12:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds basic MPTCP support for BPF sockmap by implementing the
> psock_update_sk_prot callback (mptcp_bpf_update_proto). This allows MPTCP
> sockets to be added to sockmap and enables the sk_skb stream_verdict
> redirect path via the read_skb callback. Separate protocol structures are
> maintained for IPv4/IPv6 and BASE/TX/RX/TXRX configurations, mirroring
> tcp_bpf_update_proto(). The IPv6 variant is lazily rebuilt via
> mptcp_bpf_check_v6_needs_rebuild() when the underlying protocol ops change.
> 
> MPTCP delegates to the original protocol operations so that MPTCP-specific
> logic (multi-path scheduling in sendmsg, ordered reassembly in recvmsg) is
> preserved. recvmsg is overridden in all BPF configurations with
> mptcp_bpf_recvmsg, which checks the psock ingress queue first and falls
> back to mptcp_recvmsg via the shared __tcp_bpf_recvmsg() helper. sendmsg
> is overridden in the TX/TXRX configurations with mptcp_bpf_sendmsg, which
> processes sk_msg redirect before delegating to mptcp_sendmsg via
> __tcp_bpf_sendmsg().
> 
> Export mptcp_sendmsg, mptcp_recvmsg and mptcp_prot from protocol.c so they
> can be referenced by bpf.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512261144.DxrvwMS3-lkp@intel.com/
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/tcp.h    |   5 ++
>  net/ipv4/tcp_bpf.c   |  29 +++++++---

Probably best to separate this change from the rest: TCP/BPF on one
side, then MPTCP/BPF (and eventually MPTCP only before, just to do the
exports.)

>  net/mptcp/bpf.c      | 129 +++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.c |  10 ++--
>  net/mptcp/protocol.h |  18 ++++++

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

