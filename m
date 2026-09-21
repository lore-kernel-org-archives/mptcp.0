Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FA2110E
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997641; cv=none; b=CPQ/uw7piZxWE6PXJAhRAHNy2LXiEA+/TEXhi480NpVXbCaar+5+gvoOdrBrdmzT1OmXCky0U4KueKe2uiG/5QgDkXVIVQHKJOOrfAZi6IXB46NbwGmW6JxyE6E8DeIJyLut0mJUAyEjvcf3htPdJpN3lr+1isZGKWx5ecgLHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997641; c=relaxed/simple;
	bh=O8ANWVDD79OvK/U49MsA1VHeuB1xKL9D9XeQk7AasFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJiFh8aSyOv73BcszaEJFHEBEt2doCYaRzaoupCF1mnagkVm0A/IzWOgI/Oz/3jClInymz5sJ5B99zRDMw/J1jkbw1YIrvf+E8CBa4+cvflekH4WSyF5+cjFheSjWJ6e7gYKZm613vli1t7HE96MvkirSLIxEYBkfQSWt53ZMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nIfXaJkF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jWkle4BW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yc1SL0sk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xpuWKbQi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nIfXaJkF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jWkle4BW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yc1SL0sk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xpuWKbQi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C36A21A8D;
	Mon, 21 Sep 2026 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnOYyWOU5yOdklOhBtAmRV2izjT0ZXv7OgmfJqZjZVM=;
	b=nIfXaJkFVUoX/weHmZQrQKo1NF8eYVWHgR/D7HMkt4n+L50fvKxUTj2nMvm8cBI6Fgi1yt
	LA9WU64wetZO3RfibeXH4z2vn7wo+jCL2rBesCJVkk8NBVXcFqxQU/QyHfMMir0X7mBO2Q
	6GKkiNnUqjlhFGdUkbnj08alAm+b4CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnOYyWOU5yOdklOhBtAmRV2izjT0ZXv7OgmfJqZjZVM=;
	b=jWkle4BWaqpMFSqm2X9lUPishedxAoWRgFxzxlQp88/SFgSOuUADkyO88YZW5he1GLigYc
	9SloNoNZB3dRIGBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnOYyWOU5yOdklOhBtAmRV2izjT0ZXv7OgmfJqZjZVM=;
	b=yc1SL0skQlO9CQ3iEbOf8t9FCnOjExQ4XFNtlc2bkBVIP++3cZCLQkOsj/UyI+9NQJHb9r
	1eETgmik8XfE8JJdxr/N2QYbr9b52RjuZhakPLPOx/6M8LPIZK3lS0F+57zwEC7xQpE1sI
	aA2Schch//YEobPysOkvpaGCKFnZbV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnOYyWOU5yOdklOhBtAmRV2izjT0ZXv7OgmfJqZjZVM=;
	b=xpuWKbQiLde8vRdWfJWt+lT+gSIqMlJ66UFOj5r7ly/05MMj6szgcBfoE8qM3Cgu+JIjeO
	SUdzNmVDiDvjPBCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D34891368D;
	Mon, 21 Sep 2026 13:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XTn4KTcysWr5BgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 13:33:43 +0000
Message-ID: <cd68821d-e7d6-4294-8ea7-68b64d4915d3@suse.de>
Date: Mon, 21 Sep 2026 15:33:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] nvme-tcp: unify sockopt with do_sock_setsockopt
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <cover.1786841319.git.tanggeliang@kylinos.cn>
 <97e667df6c3755d1f9e2e709dfa1dc64903317e1.1786841319.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <97e667df6c3755d1f9e2e709dfa1dc64903317e1.1786841319.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,kylinos.cn:email]

On 8/16/26 2:59 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch consolidates socket option settings in nvme-tcp by utilizing
> the generic do_sock_setsockopt() helper for options including SO_LINGER,
> SO_PRIORITY, TCP_NODELAY, IP_TOS, SO_BINDTODEVICE, and TCP_SYNCNT.
> 
> Compared to the target-side implementation, this patch additionally
> converts SO_BINDTODEVICE and TCP_SYNCNT to use the same unified mechanism.
> This change eliminates the need to export and use specialized helpers for
> each individual socket option.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/host/tcp.c | 55 +++++++++++++++++++++++++++++++++++------
>   1 file changed, 47 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
