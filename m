Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B327CCE0
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041857; cv=none; b=NLtilxghxW8Z1AwFYcQn7+/90cy6gH017S5kcXUVeF4fNBBWsThvNYnPFm5XGdYQnVtgG1ZTLjktLeJ6Uv1BKnmDYA/x43wvBlXMi7ma7kVVXHUV+ulj1nx8WXFewLWETfjJ2LdDtpgRtuDzDlpljKy9TVNMUwJA5LioRiZowTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041857; c=relaxed/simple;
	bh=xn/TxI2znnfibGUCIUwxQOB0lL1ox8xLpKtO2eOZroE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiiAuklPumuncmvXLiKeCZsjhOM+sDOLs/eY9yHGZ3bISWcXJ3DSi2nFKFHz5BwDNXY29favIrlWorrRx0DnOuMgNz0QQshAJ5vPLX8fY0G7hNhrrVf/8YLntzlod7JWzt1D8RgUbxxeKzYkxsQ8bpmNUD/Cg0BK/kWK7gskG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XDiOre/y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0IZhV93O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EZngj0rY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=owyGSqk2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XDiOre/y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0IZhV93O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EZngj0rY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="owyGSqk2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49F6D80B08;
	Tue, 18 Aug 2026 08:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787041849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24/2aQz5l5a41rQtk3SmZrJu4fVfSu26nqSjAFK1CXw=;
	b=XDiOre/yuvVvUzpD+9bcFQAEWdOfqQWz5JBGJRjQPSDyCQpMp41GzQTWvHTFePOjV+TQ/w
	3NXOiB+GYiKVWlnyinE97QUR3aduZ/CMhbQJL31l7IUKOF+AUMFuun56tRPVvuldhmy5aK
	OVqTMS9Q3C06NhCIQMDtK3GtuqhKjsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787041849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24/2aQz5l5a41rQtk3SmZrJu4fVfSu26nqSjAFK1CXw=;
	b=0IZhV93OSw/KB1euF0qJP6S3pwvKId1rg+aOhkCSBcm3nERKMcAJbOQ95OHzxIP9qDpBZj
	duGQukY7mRsYToCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EZngj0rY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=owyGSqk2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787041845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24/2aQz5l5a41rQtk3SmZrJu4fVfSu26nqSjAFK1CXw=;
	b=EZngj0rY9A5YurfUzi10TiddoqsBJah2M0gYnDroLR2/6+hI5dKqq45ltg9dTTCwkwQYzl
	TlcpL4edoTps4tyvA060TOtopjSunQCcqJedun6klGJXshLeZYjvjrpeOsxBpxRvB7HYcS
	GLHQZJ55eR4e/HVV8+AQcJUSVoy3aY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787041845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=24/2aQz5l5a41rQtk3SmZrJu4fVfSu26nqSjAFK1CXw=;
	b=owyGSqk2G8OTb4dpg1q8IwMRbWj0MP8K7zcu4Kovz/6KHl47ZmpMlqSmugaJRRLLMRqQZy
	ogk0phVx6CtmC5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 234BF22BA;
	Tue, 18 Aug 2026 08:30:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u/kpCDUYhGq6GAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Aug 2026 08:30:45 +0000
Message-ID: <1469cd69-ab6f-4263-8c2f-fce17ecb0115@suse.de>
Date: Tue, 18 Aug 2026 10:30:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
 <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 49F6D80B08
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On 8/18/26 8:03 AM, Geliang Tang wrote:
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
>   drivers/nvme/target/tcp.c | 82 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 72 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
