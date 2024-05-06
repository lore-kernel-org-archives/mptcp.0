Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA980C15
	for <mptcp@lists.linux.dev>; Mon,  6 May 2024 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003749; cv=none; b=sOjkwio8KGyOIwkbBDs/hdigIq7upMZ4CsK6GorKWRJRFuHaNBtB+HdOTt0cuQCoehh70qMGWqoKSjQZPsk/PyHZBYs/M6a7ib3HYu2l65ujKXP0Am3bM4+qdlLcBe/X8C1R9x9d8yZxMQOmsWog/Ujjxt9AVvz2MytzX7DdbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003749; c=relaxed/simple;
	bh=9VngIdPsbn6eUn76dUHNx/bO0YZnvwhrWlZFUsNRh8g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=g675JvkmU9tvahxwv6B1W+TXe3YtnKm9Yc8YmxtxADetGfRSuUNsjgR/awJdl5ZOmFd8YgZlLUmpBhhT2c5ZK4fHxTHcJYjyNJ4lEkvsbrKlOS54AYUXVjYKcGfL4lp0uykaAwavO+g8xhgiYEXTaMJKHyk/6iH+jsE4Q9iIlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LagnksGt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LagnksGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7DC116B1
	for <mptcp@lists.linux.dev>; Mon,  6 May 2024 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715003749;
	bh=9VngIdPsbn6eUn76dUHNx/bO0YZnvwhrWlZFUsNRh8g=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=LagnksGtW5qWARcwcZI0LgwMSKNmkkuKWqcWaIE04DIOj+QGMCQSvYmQQ4maKWnlL
	 EOHhR1qS9/B4w/MrX29e9D5TEj8dboZXNfYLZpjA33VwjNOLMe43OBccCotK2Ix+OQ
	 hjHnFg/25LGF6/PEwI/0yOwI7v29gLpB2OK4PgMgxds/YP8jvpYIuGoeBH4CXjedcl
	 10wDXArTscOwiNIgrT728VxFrFyhR4arKltwnABAuGxzaYZXQtZdBwipeeE0chnHuK
	 8/9ZUUlYZQcl3M/VAKMQpcrTNO/vLQCndFwgNa6RAV22FMDZaJOmVAun0OQWzsS+ik
	 4RmtOLXdXTz8g==
Message-ID: <5233639a-3d6f-4eab-8a7e-46a34a36a483@kernel.org>
Date: Mon, 6 May 2024 15:55:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] mptcp: fix possible NULL dereferences
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
References: <20240506135129.3528973-2-matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240506135129.3528973-2-matttbe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I forgot to add: this is just to have our CI checking this patch.

On 06/05/2024 15:51, Matthieu Baerts (NGI0) wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> subflow_add_reset_reason(skb, ...) can fail.
> 
> We can not assume mptcp_get_ext(skb) always return a non NULL pointer.
> 
> syzbot reported:
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 PID: 5098 Comm: syz-executor132 Not tainted 6.9.0-rc6-syzkaller-01478-gcdc74c9d06e7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>  RIP: 0010:subflow_v6_route_req+0x2c7/0x490 net/mptcp/subflow.c:388
> Code: 8d 7b 07 48 89 f8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 c0 01 00 00 0f b6 43 07 48 8d 1c c3 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 84 01 00 00 0f b6 5b 01 83 e3 0f 48 89
> RSP: 0018:ffffc9000362eb68 EFLAGS: 00010206
> RAX: 0000000000000003 RBX: 0000000000000018 RCX: ffff888022039e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffff88807d961140 R08: ffffffff8b6cb76b R09: 1ffff1100fb2c230
> R10: dffffc0000000000 R11: ffffed100fb2c231 R12: dffffc0000000000
> R13: ffff888022bfe273 R14: ffff88802cf9cc80 R15: ffff88802ad5a700
> FS:  0000555587ad2380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f420c3f9720 CR3: 0000000022bfc000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   tcp_conn_request+0xf07/0x32c0 net/ipv4/tcp_input.c:7180
>   tcp_rcv_state_process+0x183c/0x4500 net/ipv4/tcp_input.c:6663
>   tcp_v6_do_rcv+0x8b2/0x1310 net/ipv6/tcp_ipv6.c:1673
>   tcp_v6_rcv+0x22b4/0x30b0 net/ipv6/tcp_ipv6.c:1910
>   ip6_protocol_deliver_rcu+0xc76/0x1570 net/ipv6/ip6_input.c:438
>   ip6_input_finish+0x186/0x2d0 net/ipv6/ip6_input.c:483
>   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>   NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
>   __netif_receive_skb_one_core net/core/dev.c:5625 [inline]
>   __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5739
>   netif_receive_skb_internal net/core/dev.c:5825 [inline]
>   netif_receive_skb+0x1e8/0x890 net/core/dev.c:5885
>   tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1549
>   tun_get_user+0x2f35/0x4560 drivers/net/tun.c:2002
>   tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2048
>   call_write_iter include/linux/fs.h:2110 [inline]
>   new_sync_write fs/read_write.c:497 [inline]
>   vfs_write+0xa84/0xcb0 fs/read_write.c:590
>   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 3e140491dd80 ("mptcp: support rstreason for passive reset")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jason Xing <kernelxing@tencent.com>
> Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Link: https://lore.kernel.org/r/20240506123032.3351895-1-edumazet@google.com
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/subflow.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 7987342f4526..422aa06da93b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -287,6 +287,16 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  }
>  EXPORT_SYMBOL_GPL(mptcp_subflow_init_cookie_req);
>  
> +static enum sk_rst_reason mptcp_get_rst_reason(const struct sk_buff *skb)
> +{
> +	const struct mptcp_ext *mpext = mptcp_get_ext(skb);
> +
> +	if (!mpext)
> +		return SK_RST_REASON_NOT_SPECIFIED;
> +
> +	return sk_rst_convert_mptcp_reason(mpext->reset_reason);
> +}
> +
>  static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>  					      struct sk_buff *skb,
>  					      struct flowi *fl,
> @@ -308,13 +318,9 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
>  		return dst;
>  
>  	dst_release(dst);
> -	if (!req->syncookie) {
> -		struct mptcp_ext *mpext = mptcp_get_ext(skb);
> -		enum sk_rst_reason reason;
> -
> -		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
> -		tcp_request_sock_ops.send_reset(sk, skb, reason);
> -	}
> +	if (!req->syncookie)
> +		tcp_request_sock_ops.send_reset(sk, skb,
> +						mptcp_get_rst_reason(skb));
>  	return NULL;
>  }
>  
> @@ -381,13 +387,9 @@ static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
>  		return dst;
>  
>  	dst_release(dst);
> -	if (!req->syncookie) {
> -		struct mptcp_ext *mpext = mptcp_get_ext(skb);
> -		enum sk_rst_reason reason;
> -
> -		reason = sk_rst_convert_mptcp_reason(mpext->reset_reason);
> -		tcp6_request_sock_ops.send_reset(sk, skb, reason);
> -	}
> +	if (!req->syncookie)
> +		tcp6_request_sock_ops.send_reset(sk, skb,
> +						 mptcp_get_rst_reason(skb));
>  	return NULL;
>  }
>  #endif
> @@ -923,7 +925,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>  	tcp_rsk(req)->drop_req = true;
>  	inet_csk_prepare_for_destroy_sock(child);
>  	tcp_done(child);
> -	reason = sk_rst_convert_mptcp_reason(mptcp_get_ext(skb)->reset_reason);
> +	reason = mptcp_get_rst_reason(skb);
>  	req->rsk_ops->send_reset(sk, skb, reason);
>  
>  	/* The last child reference will be released by the caller */

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

