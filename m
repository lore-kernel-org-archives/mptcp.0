Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266193E00B8
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130583; cv=none; b=hz6QVXf+Km7sedegygkw6UKFGFhzUHxpZiHuiKIYPo1UFaXHR721NI+RAl/iwhQhbAGhFJq8JkUlfKyo0sAGG5OorR+6lxA3E34gusKX2yZYyTLtLnZ++cj1iYcpNvRsFPvVnn1fZeXKUe+JJimBC9cohf75kC0tj59l+KzX4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130583; c=relaxed/simple;
	bh=1JJNjkpzzvoKjnToEbDNBDktC0k0c9ki+h9ZLgWSITE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOmx2ayvDW2XW/86Dld6N+m0nYRNdUbSRDESQXlcS2iAGTGDSTnwQ3CARmsI9dL2lBfhTwDi8z/GXNpb2JImLOPLAZbX67NcJ4Vrk8PWB1iTr1ASd4NP+e56K0cvshO80KKSFDRQiUSllbzOdSil9ozj64W1LKp2H9iVV+ttWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V422oCym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V422oCym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551741F000E9;
	Wed, 19 Aug 2026 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130582;
	bh=fRsHonOR0pnszOm+BcCN6EZPzBv5ZbT4noezKt7OCCw=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=V422oCymSbKoelGzsraPOtZTOFqgBOGo8YZSTgxeeq6guTuGbTK6hUbKt/xAyDqgz
	 Qw6a0LdcG0zfkiRBa6EjaY/Ofz28rzQs/uV6N9Gq4rkRk6QcOq3SwcseIBk3LJNWib
	 WULEk7zYh+GzrOVXfjGU4l53EcC2AwsGRmcaBBcVDhbeopHWvZrHOzxts7EGj2fa4H
	 +kyhm/q08Z4HdQ9l7C6bFmixN675nHIPRdgz7VCE8pjIVuoyil+03c5KhWrWrkV19g
	 L+w8B1qyh0TbtzDj4uwPtOwJ00JLFaHmhrn9HFs7nGCAXE8b37TcfbXHZC+9TOXkE9
	 +0fzF49MzJz4A==
Message-ID: <0680b4cbbcb963684af9101936825fa09b71a335.camel@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: options: fix uninit-value in
 mptcp_write_data_fin
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Wed, 19 Aug 2026 17:09:37 +0800
In-Reply-To: <20260814-mptcp-dfin-csum-v1-1-08d0b9b86bb7@kernel.org>
References: <20260814-mptcp-dfin-csum-v1-1-08d0b9b86bb7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2026-08-14 at 23:38 +0200, Matthieu Baerts (NGI0) wrote:
> When sending a DATA_FIN without data, and because the DATA_FIN
> occupies
> 1 octet of the connection-level sequence space [1], it is then
> required
> to add a DSS mapping with specific values.
> 
> If the checksum has been negotiated, it also needs to be computed,
> and
> included in the outgoing packet, and thus the initial csum data needs
> to
> be reset to 0 as well. This is no longer the case since commit
> cfcceb7a39fc ("tcp: shrink per-packet memset in
> __tcp_transmit_skb()"),
> because the whole ext_copy structure is no longer zeroed by default.
> 
> This seems to be the only case where use_map is changed and set
> afterwards, so initialising the csum field only in this case, along
> with
> other fields for this specific case.

Initially, I was wondering if we could skip calling mptcp_make_csum()
for data_fin in mptcp_write_options(), similar to how we skip it for
the infinite mapping:

        /* data_len == 0 is reserved for the infinite mapping,
         * the checksum will also be set to 0.
         */
        put_len_csum(mpext->data_len,
                     (mpext->data_len ? mptcp_make_csum(mpext) : 0),
                     ptr);

But I realized that your modification is more straightforward.

> 
> Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in
> __tcp_transmit_skb()")
> Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.3.3 [1]
> Link:
> https://sashiko.dev/#/patchset/20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb%40kernel.org?part=2
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me!

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  net/mptcp/options.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1bb486daf56a..9f6b4358e564 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -611,6 +611,7 @@ static void mptcp_write_data_fin(struct
> mptcp_subflow_context *subflow,
>  		ext->data_seq = data_fin_tx_seq;
>  		ext->subflow_seq = 0;
>  		ext->data_len = 1;
> +		ext->csum = 0;
>  	} else if (ext->data_seq + ext->data_len == data_fin_tx_seq)
> {
>  		/* If there's an existing DSS mapping and it is the
>  		 * final mapping, DATA_FIN consumes 1 additional
> byte of
> 
> ---
> base-commit: ab76ed72e0bed8352d3b8e2b4d1be7c823e5fba3
> change-id: 20260814-mptcp-dfin-csum-d39bce4e9eb7
> 
> Best regards,
> --  
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
