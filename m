Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BB3D952D;
	Mon, 10 Aug 2026 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365948; cv=none; b=PRHfemhbv4hABHp54084N021Tqf41YeTrsBGHk5r0Y6qH5UX2hM72Mv4biloYgV8SDC4S7ngoqGLc+JPODkAWZo7UypvbBxUoojjo/lHGPdV5HytuR5SKk3DPP6j36JylHLp2ZF822fSWW+kCQKmez1ZQrJEUwMV3u2yutHVV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365948; c=relaxed/simple;
	bh=ZWvvMLjvTWqhwpwTMBNxqZRYDMtpzCTp6gJisn/74g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDIheoeWbfjIyiBkwgDBouHqDd9x8UGl4uhQYx+qds9k4fTQaoF17bGgn1qLEQQrd71lmLF6N0TS79uI0I8Du2Qp6nv8MjBmgVg9hA50kd17QNu6cun8uInjoWXN8gmpVC+XIF/owSVkdTqGm89wC89Rb8GmXLFd2A9NRkPJBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfU2UZxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfU2UZxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000941F000E9;
	Mon, 10 Aug 2026 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786365946;
	bh=I5wEaWc4U+7KZtLpZjRcGt/xrB8BGrdsX1iOtZY0Ua4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jfU2UZxoHSmWm42YsYQXPQWZVs9aXphWKENvSI9WLZAnZ62inaCpEsxMi0e+KOh/R
	 vcIdx63ont0izUPzLj4ECuIVevdbKiZtKcNgJSC0WuztspWb+01oi2OvhbEx0B6Zi6
	 zvSXI0ddCcyHGguoybV4tPNjE1RlOXpjN59tehrz6o0CLEIIfpEu4uU+M9TMILmjGs
	 cTkQiefIQ4iwykeBqn0mpnTFoA9fLCuQBCgTm0akD4oIzMH1tI/TaGNa5JQKpuNvBo
	 h/0+syLYbIalZ4qHqHTHkqKB1y16HcrMFMubJfUNKShOgRco2N3q2wx9wNAiOjBAnm
	 3ImK/syf82S/w==
Message-ID: <adc624c6-6ebd-49d6-bba4-06319d86a492@kernel.org>
Date: Mon, 10 Aug 2026 14:45:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: reject a DSS option that follows an
 incompatible suboption
Content-Language: fr
To: Fourie Zhang <littleddfu@gmail.com>, martineau@kernel.org,
 mptcp@lists.linux.dev
Cc: Fourie Zhang <fouriezhang@tencent.com>, stable@kernel.org,
 TencentOS Corvus AI <corvus@tencent.com>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Peter Krystad <peter.krystad@linux.intel.com>,
 Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christoph Paasch <cpaasch@openai.com>
References: <20260810114616.2709245-1-fouriezhang@tencent.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260810114616.2709245-1-fouriezhang@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fourie,

Thank you for the patch.

On 10/08/2026 13:46, Fourie Zhang wrote:
> All file:line references below are against v7.2-rc4 (ac5b0e5651b1). The
> KMSAN trace was captured on 7.2.0-rc6-kmsan72rc6 (075b74841bd0), where the
> same lines apply.
> 
> mptcp_parse_option() writes the DSS status flags before it validates the
> option length. For MPTCPOPT_DSS it assigns dsn64, use_map, ack64 and
> use_ack at net/mptcp/options.c:160-163, computes expected_opsize at
> :165-180, and only then rejects a bad length with a plain break at
> :190-192. That break leaves use_map set.
> 
> OPTION_MPTCP_DSS is a separate, sticky bit set at :194, and the mapping
> fields data_seq, subflow_seq and data_len are written only inside the
> use_map branch at :207-220, i.e. after the length check.
> 
> mptcp_get_options() clears only the four-byte status group
> ("*(u32 *)&mp_opt->status = 0", :370). data_seq, subflow_seq and data_len
> are declared ahead of struct_group(status, ...) in struct
> mptcp_options_received (net/mptcp/protocol.h:145-177), so they are left
> uninitialised, and the caller declares "struct mptcp_options_received
> mp_opt;" on the stack (:1137).
> 
> So a single segment carrying two DSS options -- first a well-formed
> ACK32-only DSS, which sets OPTION_MPTCP_DSS but no mapping, then a
> truncated DSS whose flags claim a mapping, which sets use_map and then
> fails the length check -- ends parsing with OPTION_MPTCP_DSS set and
> use_map == 1 while the mapping fields were never written.
> mptcp_incoming_options() passes the OPTION_MPTCP_DSS test at :1210 and
> copies them into the skb extension at :1253-1258; get_mapping_status()
> then branches on the uninitialised data_len:
> 
>   BUG: KMSAN: uninit-value in mptcp_subflow_data_available+0x2428/0x4c70
>    get_mapping_status (net/mptcp/subflow.c:1152)
>    subflow_check_data_avail (net/mptcp/subflow.c:1369)
>    mptcp_subflow_data_available (net/mptcp/subflow.c:1466)
>    subflow_data_ready
>    tcp_data_queue
>    tcp_rcv_established
>    tcp_v4_do_rcv
> 
>   Uninit was stored to memory at:
>    mptcp_incoming_options (net/mptcp/options.c:1258)
>    tcp_data_queue
>    tcp_rcv_established
>    tcp_v4_do_rcv
> 
>   Local variable mp_opt created at:
>    mptcp_incoming_options (net/mptcp/options.c:1137)
> 
>   CPU: 0 UID: 1000 PID: 137 Comm: poc 7.2.0-rc6-kmsan72rc6 #1
> 
> Reject a DSS option when an incompatible suboption is already present. The
> test runs before any DSS flag is read, so a malformed duplicate can no
> longer mutate state retained from an earlier valid option. ADD_ADDR,
> RM_ADDR, MP_PRIO and MP_FAIL stay permitted alongside DSS: once
> mptcp_established_options_dss() has run, those are the only options
> mptcp_established_options() can still add (:843-878).

The fix is correct, but this patch is targeting 'net', but it doesn't
apply there. That's because commit b6ee36152464 ("mptcp: avoid combining
some incoming suboptions") is already addressing this bug (and others),
the same one:


https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=b6ee36152464

Plus, see below...

> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Assisted-by: tencentos-corvus-ai:kimi-k3
> Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
> ---
> A KMSAN reproducer for this issue is available if requested.
> 
>  net/mptcp/options.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c664023d37ba..7ec18fa1bef6 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -153,6 +153,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  		break;
>  
>  	case MPTCPOPT_DSS:
> +		/* Can be used with a restricted number of other options */
> +		if ((mp_opt->suboptions & ~(OPTION_MPTCP_ADD_ADDR |
> +					    OPTION_MPTCP_RM_ADDR |
> +					    OPTION_MPTCP_PRIO |
> +					    OPTION_MPTCP_FAIL)) != 0)
> +			break;

This chunk with the exact same comment corresponds to what I sent in my
v1, a month ago:


https://lore.kernel.org/mptcp/20260709-mptcp-harden-combine-opt-v1-1-378b0a47c1b5@kernel.org

That's not because it is generated by AI it can copy code without
mentioning the source... Please avoid this next time.
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
pw-bot: rejected

