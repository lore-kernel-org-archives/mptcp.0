Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96816F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616607544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMWlA6C38qnv5YRGDF3LCYlsA/b2GCTarCP/GmRvCew=;
	b=QYUKhnHcOLxYleOcN0eaNjYx1OZXsZ4vBGkROZF8oSC84KG3sZDKu+AaWPQElC6r5/ljAJ
	+iXDEd5yFE5IIC3qRPVegoipBWy36C81/oqHcj2SMaDunQNqumUKcTlFkDywY7xBJa8TvF
	KcfNIJ1PipLQ7z4M3GKW73VbtDy9+Qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-N9wy0HjtM0G6P1-EbUeOgw-1; Wed, 24 Mar 2021 13:39:01 -0400
X-MC-Unique: N9wy0HjtM0G6P1-EbUeOgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7666680006E;
	Wed, 24 Mar 2021 17:39:00 +0000 (UTC)
Received: from ovpn-114-21.ams2.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71AEB62677;
	Wed, 24 Mar 2021 17:38:59 +0000 (UTC)
Message-ID: <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Cc: mptcp@lists.01.org
Date: Wed, 24 Mar 2021 18:38:58 +0100
In-Reply-To: <20210324131546.13730-2-fw@strlen.de>
References: <20210324131546.13730-1-fw@strlen.de>
	 <20210324131546.13730-2-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-24 at 14:15 +0100, Florian Westphal wrote:
> Handle following cases:
> 1. setsockopt is called with multiple subflows.
>    Change might have to be mirrored to all of them.
>    This is done directly in process context/setsockopt call.
> 2. Outgoing subflow is created after one or several setsockopt()
>    calls have been made.  Old setsockopt changes should be
>    synced to the new socket.
> 3. Incoming subflow, after setsockopt call(s).
> 
> Cases 2 and 3 are handled right after the join list is spliced to the
> conn list.
> 
> Because splicing is sometimes done from non-preemptible context, the
> sync action can be deferred to the work queue.
> 
> Add sequence numbers to subflow context and mptcp socket so
> synchronization functions know which subflow is already updated
> and which are not.
> 
> seqno is re-set to 1 in mptcp_sockopt_sync_all(), at this point
> the list of subflows is up to date.
> 
> A setsockopt sequence count of 0 means that no setsockopt call
> was made so no synchronization is needed.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

If I read correctly, each incoming subflow always get setsockopt_seq =
0 at accept time, while outgoing subflow are always synced at creation
time.

It looks like we have 2 semantically different 'msk->setsockopt_seq'
values:
* 0 -> no sync required
* any value greater than 0 -> sync required for incoming subflows.

If so, setsockopt could always set msk->setsockopt_seq to 1 and no need
to reset after sync_all.

Somewhat related, in the following scenario:

socket()
sesockopt()
listen()
// msks is accepted, msk->setsockopt_seq != 0
// mpj subflow is accepted, ssk->setsockopt_seq == 0, the mpj ssk
inherited from the listener socket the same sockoptions of the msk/mpc
subflow

we will do an unneeded synchronization for the MPJ subflow.

I think we could avoid that, on top of the above. e.g. in setsockopt
setting msk->setsockopt_seq to some value depending on msk->sk_state,
and copying msk->setsockopt_seq into ssk->setsockopt_seq at accept
time.

Not sure if the latter would be overkill?!? the above scenario looks
like a common one.

Cheers,

Paolo


