Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91960486E4C
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997604; cv=none; b=Zj3ZBwE+LI/6oIn7XQO/WjD4ywVLcbXq8GGIAESp3GcSuFfdZO+YzBNC9u6D3qws4b8/fU4rh+FKMRDiS4gbuFDj1eqaqBVhv3TIclXMritrYhDTg9DI6VJgWZeVBDU5xF3WdoBz8rQc/Tw8BM+JGPcGi4VA6bC3u4T729RoF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997604; c=relaxed/simple;
	bh=o0kZXu9Wb1G8CQz8DpoK+reI0fJdDI+xMCUJ5PK/cvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0rvCzCpkat4Eac6Yd4PZkTZelLS7PGqCh+PFwagQqxncHyPyJL0Z22imJ7KjxHP3xqfnRoim6vSTq1QB1kjHZYfeZcJj1BVcVEYWNPmc7mqCsoqpX+qS8VRmnOJB1/okS7Wb+EeQBUZwiWWRkpgJgxBWImEpEUu/HWXVCVz+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aRbxGTxV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zLc37psQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CZNbe6dQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jBYuAX/k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aRbxGTxV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zLc37psQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CZNbe6dQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jBYuAX/k"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 533311F816;
	Mon, 21 Sep 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=;
	b=aRbxGTxV0zKGRo7+m1eVVPa+WVLjA7zvQPC6oPy9zBMzFkRB1beqggNfP9KpoPYJh9dPwG
	fLcFBSE2JIaXS/qBHIwEX7BD0C/Ohyfit+pZCbZDjcTw2CSCfy3vTyDf7qbeD1Tj1zJ6IC
	BiBoGwlL+OCYsmtj3oQFBO24blhNL80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=;
	b=zLc37psQuAOFVgFx+6gFQd+L38CJ2w4D6NSmkB0WrKzOzh9lIoUKYktUHbe7TxSdKfGGpB
	3K86gLRo+gVSAFDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=;
	b=CZNbe6dQLFbj1hlZanWBXqoUyA8BfWaZXRZS6XeiC9u5e1pEbIOA5blErM3v5E112jFqVw
	6h7hnM8Iy7YAvj2ATcbRSxGOlpGNju2lrm9u0C1wV+zOsSYd7ZN/HPTRhxrevYhyPP6D2u
	h1Ov6QtSsQHt+BO8SOIchY1yKyt+sEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsHgzpy/Sl3GscephIYavlJsW/MGoMLXO4ABREtdToo=;
	b=jBYuAX/k8anLjiURCgNeiLw+bGMSM0c5YRLTVngf01nm+7ewJkRDCHWySgxrxlKSGa1LJo
	+YrNojdZ/E/68fDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EE271368D;
	Mon, 21 Sep 2026 13:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JACjERYysWqrBQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 13:33:10 +0000
Message-ID: <deaf6eaf-3ee5-4d8c-bfed-ac3ab6298c9d@suse.de>
Date: Mon, 21 Sep 2026 15:33:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
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
 <d06dd395575d7f639cd8bc3f984692704fd40e56.1786841319.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <d06dd395575d7f639cd8bc3f984692704fd40e56.1786841319.git.tanggeliang@kylinos.cn>
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
> This patch consolidates socket option settings in nvmet-tcp by utilizing
> the generic do_sock_setsockopt() helper for options including SO_LINGER,
> SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change eliminates
> the need to export and use specialized helpers for each individual socket
> option.
> 
> A key benefit of this refactoring is that it decouples the socket option
> configuration from the underlying transport protocol. This makes it
> easier to extend nvmet-tcp to support other protocols, such as MPTCP, in
> the future, as do_sock_setsockopt() abstracts away protocol-specific
> differences without requiring per-option protocol-specific wrappers.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/target/tcp.c | 53 +++++++++++++++++++++++++++++++++------
>   1 file changed, 45 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
