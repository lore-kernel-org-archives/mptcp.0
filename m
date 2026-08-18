Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702547CA80
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069991; cv=none; b=avbX/3Hxi20MrTwaMjWnQ89l4WqgKr8P8Znjh7vkd8obHAMtn3rcLNCRN9ITVfo6IbuT9bKvR2dhQ2EJA9t7XB1MZbmP48T1KdJGhwVE/c6nobF3za+/16jFjj6dYePZ+eKVuttiRNmO3ui0BXD4wq9MU65UIaqE58t2x70gYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069991; c=relaxed/simple;
	bh=WY7m0uVjGu44sh593QNM/IcV1AZfA5FgZPsDu+hrWnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/kKUs4h9qJXLQYiLohscrBQPcmfU9C8LQi+uQtjpXgo8aTBbc/g6fHHZJii3KDGppij+l82OSn86TGPg2fif/rNZYMsV4OMvYRa740O/69CgAEwjlSBcXUUOZz6nNiGBFwO9PY2TcbvGq2PVPH6k/lAmWeULDTvK01pVeHhd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7JlKrQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7JlKrQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3971F000E9;
	Tue, 18 Aug 2026 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069990;
	bh=mJijs80dwZwNAgQzNaJWFi8oGTxb37UB8cS+kRBHPTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V7JlKrQ4KpY4RShtqJYnt6vJSkpvhAMF5zcbyrLIEO8C2yiidf7WcMnYIZcMJhAKa
	 85IZi7XCNslXhEZKR5k/j0msF/rG1cMtlONu3G6jxHJoMf5a6f9gBDHKwNXbRlVGPP
	 B77LZJko3T/etHjCeUzadGXhD0L1ySx4JfBTOaMA41UQv6qSbWzgNFQzckAZ1jw9+I
	 6ZmA5yYaNzKxxVh2iqrP6XUGfMMxTETky25m6NXSa+Zgu3Xbjq7eEuPio+fIOpN6MD
	 R4TJh/nQJSAIxdarJ6ZEU4jh+0mf7TqZhewy3aXwRvXkt486Nt3gi1MxxtCAEuplfH
	 MD4Nn6DB4a7Sw==
Message-ID: <68791a9e-9310-4368-854e-d379ce0b416c@kernel.org>
Date: Tue, 18 Aug 2026 18:19:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next RFC v4 2/2] mptcp: send MP_FAIL and infinite
 mapping on the same ACK
Content-Language: fr
To: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
 <20260818091417.2200986-3-chenguang.zhao@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260818091417.2200986-3-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Chenguang,

On 18/08/2026 11:14, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> On a single subflow, accepting MP_FAIL must leave MPTCP mode at once
> (RFC8684 §3.7). Emit the infinite mapping on the MP_FAIL reply ACK,
> then call mptcp_try_fallback() immediately after.

I think Sashiko is right about the issue of lacking option space to have
both the MP_FAIL and the infinite mapping sent together.

Please also note this from RFC 8684 §3.7.11 [1]:

> This infinite mapping will be a DSS option (Section 3.3) on the first
> new packet, containing a Data Sequence Mapping that acts retroactively

The "on the first new packet" seems to suggest the infinite mapping
shouldn't be attached to the MP_FAIL.

[1] https://datatracker.ietf.org/doc/html/rfc8684#section-3.7-11


Maybe a fallback for the single subflow without csum is enough? Or maybe
nothing needs to be done? Or maybe this fallback is just an
optimisation, and can be done in net-next (and both commits can be
combined)? WDYT?

> Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/mptcp/options.c  | 33 ++++++++++++++++++++++++++++++++-
>  net/mptcp/pm.c       |  5 +++++
>  net/mptcp/protocol.c |  8 +-------
>  3 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 97da22668dbe..ecf77e77d2de 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -638,7 +638,29 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>  	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
>  	mpext = skb ? mptcp_get_ext(skb) : NULL;
>  
> -	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
> +	if (unlikely(subflow->send_infinite_map)) {
> +		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
> +
> +		if (opts->csum_reqd)
> +			map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;
> +
> +		if (mpext) {
> +			opts->ext_copy = *mpext;
> +			opts->ext_copy.infinite_map = 1;
> +			opts->ext_copy.data_len = 0;
> +		} else {
> +			opts->ext_copy.use_map = 1;
> +			opts->ext_copy.dsn64 = 1;> +			opts->ext_copy.infinite_map = 1;
> +			opts->ext_copy.data_len = 0;
> +			opts->ext_copy.data_seq = READ_ONCE(msk->snd_nxt);
> +			opts->ext_copy.subflow_seq = subflow->rel_write_seq;
> +		}

You probably also need to reset "csum". Note that common fields
(infinite_map and data_len) can also be set once here.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

