Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010232AE97
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168221; cv=none; b=SxoqLJ4p2RBEAoquUCwsxlvJ1z/u5dy7Akcq+cXSdWxaW1q+NLrDE7V8mK68DsdO8ELRTXquWjzccU+U6CspFaavCVB895fxDYyywrziaVU6LeiaIUTveFuHl6vcKGiAZ4V5I3fiUmSqCKmsyOPM2PpeC8cFYtk0dSciEtiNa1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168221; c=relaxed/simple;
	bh=DhsWzRd/y1W9ugFZAexJhGqlHORUB2SvMNRdbrGUs3U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JluYTosGCDbAVGXqeunOZ47EzGKcUQ8D6BAaF6Am6B/oOZMAwwdu/Z9xN8MovoVcbR44CcT/pAxHBecvZfkIWK/XIDpIcyMqVFRSh+syMylxt3i59hcAR4eR3XeMw6te2cZmWvDkcAf920ezUUFtycgZf2TmorXVdAdePmcv19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhew9W45; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhew9W45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD78C4CEE7;
	Sat,  6 Sep 2025 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757168220;
	bh=DhsWzRd/y1W9ugFZAexJhGqlHORUB2SvMNRdbrGUs3U=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Yhew9W45voGuB0PWCS0R2zKffCxrQ9Sg1WXXCM9l+9hk+LfkoYaKMtc6Kud9XddRO
	 a2ccvWjpxcKbhpMryfTgcjUJkvW7oWAhadj7U/pfbDczxdWWGZAYNKdayy82sJn9iy
	 7LGSHpcGIg6T8iCw2eSbY19GOLcHmK3UJjmd3erUZrEWpMP/nCCpt35GMJEtDgsZr2
	 cyWXoSTUNFk/X1uqcEfcLFGp6VFxdhrx84VEIg2QabAUIMZyYMeZNPg7i9PFuhgsgF
	 ebd8p83bi1Y4cG2HdbuLgNRDpIYbZ8EQ/YIkvQ2votknHU9+o+XlNwgqhZr2DtftfJ
	 lVq7ExQ3enbyg==
Message-ID: <f6f2bdcba4fed92a6257c2faeafb65b570551773.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 4/7] netlink: specs: mptcp: fix if-idx
 attribute type
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sat, 06 Sep 2025 22:16:56 +0800
In-Reply-To: <20250829-mptcp-pm-user-c-flag-v1-4-78b25dda7708@kernel.org>
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
	 <20250829-mptcp-pm-user-c-flag-v1-4-78b25dda7708@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-08-29 at 22:33 +0200, Matthieu Baerts (NGI0) wrote:
> This attribute is used as a signed number in the code in
> pm_netlink.c:
> 
>   nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))
> 
> The specs should then reflect that. Note that other 'if-idx'
> attributes
> from the same .yaml file use a signed number as well.
> 
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for
> mptcp")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Patches 4-6 LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

[mptcp-net,4/7] netlink: specs: mptcp: fix if-idx attribute type
[mptcp-net,5/7] doc: mptcp: net.mptcp.pm_type is deprecated
[mptcp-net,6/7] selftests: mptcp: shellcheck: support v0.11.0 

These three patches are relatively independent and can be removed from
this series. They should be merged into the export branch first and do
not need to be included in the v2 iteration. I changed the states of
them as "Queued".

WDYT?

Thanks,
-Geliang

> ---
>  Documentation/netlink/specs/mptcp_pm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml
> b/Documentation/netlink/specs/mptcp_pm.yaml
> index
> 02f1ddcfbf1cfd81a398dd03c52bb9f281c1aa08..d15335684ec3d6256505f2b3887
> ce5818eb57462 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -256,7 +256,7 @@ attribute-sets:
>          type: u32
>        -
>          name: if-idx
> -        type: u32
> +        type: s32
>        -
>          name: reset-reason
>          type: u32
