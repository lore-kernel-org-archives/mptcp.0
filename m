Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3391286A7
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764230239; cv=none; b=a3q64DEE4OJoda9Ys4zFTzgFWbEAX0hYT8F8FjOJuo+QuaIWZNMfI7u5szAwTgWarJBZtgNCF7B9q3z9DtUylosgg+cgybwA8S4vNdhmPedKIkawFMfkFi8mA4+rzdGmBryDM+OIzrXQR4+SCfWMj/EUrNJ0//jhxZJxZhzLykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764230239; c=relaxed/simple;
	bh=mMApEtmPcQsywul00rDkL18RgKHHzoLJOFk7PWsaof8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iaNJRS7pGC8C8N84stxypUVcvZhDebauZq/He4lGkIGfpv8q0yaRxXWLRXn6i9aI8/gklnHDN4jhQM/82EvyCI3T+CzGcY7D0fnn0bcOxhQmXMKAARCyYxoYeutICoP4Fb5A1zi7lqcXRFzrSt1/Y62IPni6K3dVutYedU3TUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e6l1d7DK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cICqbpa/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EI0tfIyg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kLsW5tsq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e6l1d7DK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cICqbpa/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EI0tfIyg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kLsW5tsq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA2A633682;
	Thu, 27 Nov 2025 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764230229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QI/zCArW5aQ4tEBRrxjXVaHAPztDvaWlVt8HQv2WgFA=;
	b=e6l1d7DKlvPzzNtB+lL3J+iM3C2rfVSyPnI9t5GEmhtPu01BRNuJD/W595vYCOt8B0f1eL
	X7wN+xflIiku0eM4HFjy08SLo9XRczMvXrv5gZHBlkhTxfMk/PnF6DuKVAJEnAvZ2jaNTL
	aT+wZVKtSBXb6be/A/xA4TDlesGWBa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764230229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QI/zCArW5aQ4tEBRrxjXVaHAPztDvaWlVt8HQv2WgFA=;
	b=cICqbpa/AswBinI8SQPpA00nq4z5SiJqQGRodDqUsGGVvpxC2N1ymxWs6bhil7K+aJTxYn
	ClPaWWAdZI7MZpAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764230228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QI/zCArW5aQ4tEBRrxjXVaHAPztDvaWlVt8HQv2WgFA=;
	b=EI0tfIygRKFyzuPCwPrNT/a29ch4Vu0xrIP+xxOr9Shjr98TGra3BXYcPTs73CccWUaxra
	mT4DW9WkPlmzNhsYLkXSokFVRewC/XN4/Fg9uLlUEX1K1lKifa6sRhTkxqKFRqaFAHrrIb
	GohWK58UzOG/yLnrsNCd1HODaGBzt2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764230228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QI/zCArW5aQ4tEBRrxjXVaHAPztDvaWlVt8HQv2WgFA=;
	b=kLsW5tsqEHWZ+dZASDXeeblt8m5Rw/2wJZm8AsxEHkBvnT7qvxcM+6hhSOPKer9qqQwrAR
	YozttqUS0wlblGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3DA3EA63;
	Thu, 27 Nov 2025 07:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UkEZKVQEKGnVCgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Nov 2025 07:57:08 +0000
Message-ID: <2055f284-2b8d-49af-b149-7b341e5d44d5@suse.de>
Date: Thu, 27 Nov 2025 08:57:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libnvme: add mptcp trtype
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <99f6e63b5c9677f29a9bc8cdd87b2064b258435f.1764206766.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <99f6e63b5c9677f29a9bc8cdd87b2064b258435f.1764206766.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,nvmexpress.org:url]
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 11/27/25 02:26, Geliang Tang wrote:
> A new NVMe target transport type NVMF_TRTYPE_MPTCP is defined for MPTCP in
> the kernel. Add it to libnvme as well.
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> ---
>   src/nvme/fabrics.c | 1 +
>   src/nvme/types.h   | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index b0821e96..d3a1c033 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -73,6 +73,7 @@ const char * const trtypes[] = {
>   	[NVMF_TRTYPE_RDMA]	= "rdma",
>   	[NVMF_TRTYPE_FC]	= "fc",
>   	[NVMF_TRTYPE_TCP]	= "tcp",
> +	[NVMF_TRTYPE_MPTCP]	= "mptcp",
>   	[NVMF_TRTYPE_LOOP]	= "loop",
>   };
>   
> diff --git a/src/nvme/types.h b/src/nvme/types.h
> index 4943e00f..2aa81938 100644
> --- a/src/nvme/types.h
> +++ b/src/nvme/types.h
> @@ -6823,6 +6823,7 @@ struct nvmf_disc_log_entry {
>    * @NVMF_TRTYPE_RDMA:		RDMA
>    * @NVMF_TRTYPE_FC:		Fibre Channel
>    * @NVMF_TRTYPE_TCP:		TCP
> + * @NVMF_TRTYPE_MPTCP:		MPTCP
>    * @NVMF_TRTYPE_LOOP:		Intra-host Transport (i.e., loopback), reserved
>    *				for host usage.
>    * @NVMF_TRTYPE_MAX:		Maximum value for &enum nvmf_trtype
> @@ -6832,6 +6833,7 @@ enum nvmf_trtype {
>   	NVMF_TRTYPE_RDMA	= 1,
>   	NVMF_TRTYPE_FC		= 2,
>   	NVMF_TRTYPE_TCP		= 3,
> +	NVMF_TRTYPE_MPTCP	= 4,
>   	NVMF_TRTYPE_LOOP	= 254,
>   	NVMF_TRTYPE_MAX,
>   };

Sorry, you can't do that. You'll need to register a new protocol number
from NVMexpress.org. And that would require a TPAR detailing out the
mapping between NVMe commands and MPTCP frames.
Which probably is a bit of an overhead.
Maybe it's easier to declare it as a TCP 'variant', keeping the protocol
number and 'just' modify the TCP driver.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
