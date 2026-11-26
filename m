Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735787;
	b=hVtS7UkWYZscLIcjBl4BvqbZ/zrB5vEuZlp1v4eCx2lqZVFEoOwCbjyb9LZM7n1YOlie
	 iBM6BQkAInBEj/vAw3G6h864INQXLsXGQD7f/+AGU2o/izKG0U40gFdKXvcliOiUeS3fo
	 1dvYXwhk/KCXNlfI+lO9/Xosg+qiJW3UbUN4MGIATpL4vqjmPnsCtLElgW0XtavaC6quD
	 bVSfvfspkUGoqwljh9hyM2siGwk2ISDIZF3WgmyyZyJ/jUoYcRlS5lKf8YFpkPaIeemGB
	 sJ16TGtl91W0MFgynCXpjGz4YG/Icd4OF1tJZkccxUqcTaev9s8H6fcrG5bAcATrTkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735787;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jNoFr8ZdBedQAATzXSVAtuhB6ZugoxoF8geKmRQtU3Y=;
	b=slWtZWAvAqV6is4RdfWxPfHh8kKvzmc4nKVaIUD36WruTBGeGUK6t330eZIfrbUiH4So
	 eEIPYAzaqhKpTTc1s6LTuh+uxtt2CqiVg6wNUclRO3v5Ej/EkHsLO2Hy1WVO6hSX2Kew0
	 z8J8M9RRyCkoKKG8pEdHRoOBIElZNkCQ+bIpJU02p7HYvXriu1vMAyzhP8GvAyNFvo428
	 L5mBJXIdXRaPglZaRnbHOcF49mn9XUC2VS+gNNDCRaPvV5RN409L61si5tacnH6moRjjD
	 okfe9YnFV3l9vU/zUlikPF/Z8IONH+S3gniOAfNfgg/85WeUvKlaPkpVL5lWbEeOdug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVGq4Yn0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBE9606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVGq4Yn0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E518C1F000C1;
	Thu, 26 Nov 2026 23:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735787;
	bh=jNoFr8ZdBedQAATzXSVAtuhB6ZugoxoF8geKmRQtU3Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MVGq4Yn036BzyByCwjmtIddy5BytcItr7jV4vdA4Z1f304ixX0kx4X8Br8plavwwO
	 NRKCl/o7ncmkxaM29uXSsUGGyVW3ebfzEbyfLvZXzapRIk9/4NgNZ8INQRXKSeCMqB
	 /f6Upy5NxmvJ9gyA/XSN8GcTWnKLe4EoIYWf5Ira6J+x0qw2cGYe/sqSw/kTjCx/bh
	 hvSnoYpU89apnZYpLguk3c7fQIT1iEgLY421FSHKPGmi249VaUUO3twFOVrQhT/I8m
	 1a/qBKN/8HUbRsyTHd1jjiuHQb8V9bXYLGNnTAyQKBMadeYeO+r+N6+oV1x4G3QfGZ
	 /0FWUKkRWYSTg==
Subject: Re: [PATCH mptcp-net v3 10/50] mptcp: process a DATA_FIN received
 with old data
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:46 +0000
Message-ID: <179573578651.3133.16486371070677916352@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-10-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-10-416c0920c73f@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In get_mapping_status() (net/mptcp/subflow.c), the patch moves
  `if (updated) mptcp_schedule_work((struct sock *)msk);` from the…

--

mptcp: process a DATA_FIN received with old data

A DATA_FIN can be recorded by get_mapping_status() while it arrives with
data that is old at the MPTCP level, or in the middle of such a mapping.
Because that data is never moved to the msk, the DATA_FIN was never
processed or acked. This patch schedules the MPTCP worker whenever the
DATA_FIN is first recorded, so mptcp_check_data_fin() can handle it.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 054ee992904e0..67a749643ad75 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1242,6 +1242,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>  			bool updated = mptcp_update_rcv_data_fin(msk, mpext->data_seq,
>  								 mpext->dsn64);
>  			pr_debug("DATA_FIN with no payload seq=%llu\n", mpext->data_seq);
> +			/* The current mapping can be old, and then not moved */
> +			if (updated)
> +				mptcp_schedule_work((struct sock *)msk);
> +
>  			if (subflow->map_valid) {

[Severity: Low]
This isn't a bug, but the new comment only seems to describe one of the
two paths that now run this mptcp_schedule_work() call.

In get_mapping_status(), the call has moved above the
if (subflow->map_valid) test. So it now covers the case where a
DATA_FIN-only DSS arrives in the middle of an existing mapping, and also
the !subflow->map_valid case that returns MAPPING_DATA_FIN.

In the !map_valid case there is no current mapping. The worker is
scheduled there because a DATA_FIN outside a mapping never reaches the
msk through the data-move path. Before this patch, that was the only
reason for the call.

Could the comment cover both cases? For example, "The current mapping,
if any, can be old ...", or a short note about the no-mapping case.
Otherwise a later reader might think the scheduling is only needed for
old mappings.

>  				/* A DATA_FIN might arrive in a DSS
>  				 * option before the previous mapping
> @@ -1252,9 +1256,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>  				return MAPPING_OK;
>  			}
>  
> -			if (updated)
> -				mptcp_schedule_work((struct sock *)msk);
> -
>  			return MAPPING_DATA_FIN;
>  		}
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
