Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC849D5A3
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997696; cv=none; b=C88VeoUDS+klmlIWItZxucd2WzD6HsD59YONqmLZ0pwAldXz979pMYmf08XSnhXNrdRZemdrUiJ8V2EmTsOvKBg55yNZvyQgToyB2b59/RN63rRk4lMluseUTcICw4AwlVHZKN86+t+/oKOg5pvEXDAuJU+S8YEaxJQrNv6MAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997696; c=relaxed/simple;
	bh=H5LA40f1WetS5i8CyVAeK6YQrsiVAQpb5jVV28HrRbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQYqRuFllPwEMfk40PF9MWMa0i/33Al3VbzxCZ/L71OLgGBq9Mvm3kcefqwA4AajyAlzRuAb2APVqbZ1QHiV1icb10u/18yAJ9TRhoKTnEc2HCnJwmbOrCY88ReCKUHasxilVOIMNsNSpAPY6P+aWQnnxDoyPCr+7QHdccyKgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oxo/8uXb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IwqXwSD9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gDkqCJTh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y3pcSdyA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oxo/8uXb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IwqXwSD9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gDkqCJTh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y3pcSdyA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A3E1A1F74A;
	Mon, 21 Sep 2026 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9ZZYkiuBFP23TLhQXBgnzQsZ+18uwIyDOHz8vFXWwU=;
	b=oxo/8uXb/8JiGHx9COZyqaB7B+R6xGOEvjn3/V+aO7hOwN+dCmRrfn07T5xOAdvj9tqOHV
	oZD3j/AtrnE/jJ0fmiTUGPH6PVFVExLltN3etwHxc8YJXvAr6my5k+0bCPs0TJkgDRoCqe
	kOsu4kH/hLHeSomNfVWTQ+/a6X46jXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9ZZYkiuBFP23TLhQXBgnzQsZ+18uwIyDOHz8vFXWwU=;
	b=IwqXwSD9yXpDRmSbKHC+waMAb/KVcJNDhy1WBjweFGWvmpa4dP4CavH7F5fWuQWmvzwB9d
	GCcIZqu4GRnk8TDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789997683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9ZZYkiuBFP23TLhQXBgnzQsZ+18uwIyDOHz8vFXWwU=;
	b=gDkqCJTh7JvyPIDk8iOXQGGiX5m1gL50pym7SajdYEKLNxW65d6BifScsk2MQ5vcle+v1T
	GZR1CTuQSOh0Fo2jRzrNdLCIq2gi2AUVjeGi+ycGMCzO66l/H8usSK4i9+SDR8ZPBv2+kh
	o+MutTeLJYh1m25mEMBVUTS1IukuMmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789997683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9ZZYkiuBFP23TLhQXBgnzQsZ+18uwIyDOHz8vFXWwU=;
	b=Y3pcSdyAMavVmRF3vDLfqAY/nw1QEoBlokMUlmpQSofr45mGz0fy5oFylQVznzmLUv5/6o
	BIfz2IsqHzSmazCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEE9C1368D;
	Mon, 21 Sep 2026 13:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3x47HXIysWpmBwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 13:34:42 +0000
Message-ID: <bb036bb6-0f65-44e7-a2b0-6ae2ee7b7c58@suse.de>
Date: Mon, 21 Sep 2026 15:34:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] nvme-tcp: support IPv6 traffic class
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
 <52c4840e36ee6016d18806c2d205f4f9fdc1e830.1786841319.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <52c4840e36ee6016d18806c2d205f4f9fdc1e830.1786841319.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhpsi56b8wki6rd8p6oz1itgg)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,kylinos.cn:email]
X-Spam-Flag: NO

On 8/16/26 3:00 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Currently, nvme-tcp host only supports setting the IPv4 TOS value when a
> TOS is specified, but does not handle the IPv6 traffic class.
> 
> Extend the queue socket setup to handle AF_INET6 sockets by applying the
> TOS value to both IPv4 and IPv6 sockets. For IPv6, the TOS value is set
> as the IPv6 traffic class via IPV6_TCLASS using do_sock_setsockopt().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/host/tcp.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
