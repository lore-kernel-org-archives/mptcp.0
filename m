Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288386F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616665874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3K8eB/AlnTTqsI9ZwC4+yFBq0F1OjwT2MrcxEr+ifk=;
	b=ci3FrCIJIYOGdeNVHMwNDpvhwL8bn0CZv1nX0yCJKFd0Q6xvnwx5tjnrXGnWHwH2QDWAQF
	BjzsHm19h1l3pacoLz1l7l6ugOR00vX0MPxFuq6wzR2X2ix1H2+loBTnbdtE8USItqyO7x
	Oq6QOKcQr/YfyuFC3HFZlcIdS8IN4Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-gPE-R43pOVGq5xYAuA8Aaw-1; Thu, 25 Mar 2021 05:51:11 -0400
X-MC-Unique: gPE-R43pOVGq5xYAuA8Aaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0292F108BD0A;
	Thu, 25 Mar 2021 09:51:10 +0000 (UTC)
Received: from ovpn-113-211.ams2.redhat.com (ovpn-113-211.ams2.redhat.com [10.36.113.211])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0EC12E09A;
	Thu, 25 Mar 2021 09:51:07 +0000 (UTC)
Message-ID: <2ee15b0397e7653f8d8cfd74d53398a6a5f0c19c.camel@redhat.com>
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, mptcp@lists.01.org
Date: Thu, 25 Mar 2021 10:51:06 +0100
In-Reply-To: <20210324200148.GL22603@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
	 <20210324131546.13730-2-fw@strlen.de>
	 <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
	 <20210324200148.GL22603@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-24 at 21:01 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > On Wed, 2021-03-24 at 14:15 +0100, Florian Westphal wrote:
> > > Handle following cases:
> > > 1. setsockopt is called with multiple subflows.
> > >    Change might have to be mirrored to all of them.
> > >    This is done directly in process context/setsockopt call.
> > > 2. Outgoing subflow is created after one or several setsockopt()
> > >    calls have been made.  Old setsockopt changes should be
> > >    synced to the new socket.
> > > 3. Incoming subflow, after setsockopt call(s).
> > > 
> > > Cases 2 and 3 are handled right after the join list is spliced to the
> > > conn list.
> > > 
> > > Because splicing is sometimes done from non-preemptible context, the
> > > sync action can be deferred to the work queue.
> > > 
> > > Add sequence numbers to subflow context and mptcp socket so
> > > synchronization functions know which subflow is already updated
> > > and which are not.
> > > 
> > > seqno is re-set to 1 in mptcp_sockopt_sync_all(), at this point
> > > the list of subflows is up to date.
> > > 
> > > A setsockopt sequence count of 0 means that no setsockopt call
> > > was made so no synchronization is needed.
> > > 
> > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > 
> > If I read correctly, each incoming subflow always get setsockopt_seq =
> > 0 at accept time, while outgoing subflow are always synced at creation
> > time.
> 
> Yes, outgoing are synced at creation time.
> 
> > It looks like we have 2 semantically different 'msk->setsockopt_seq'
> > values:
> > * 0 -> no sync required
> > * any value greater than 0 -> sync required for incoming subflows.
> > 
> > If so, setsockopt could always set msk->setsockopt_seq to 1 and no need
> > to reset after sync_all.
> 
> In the outgoing case, the subflow isn't linked to the conn_list yet.

My bad! I did not recall we use join_list even for outgoing subflows...
I'm wondering if we could move them directly in conn_list
inside __mptcp_subflow_connect()? I think it should not be problematic.

> It syncs current msk settings, but user could setsockopt() before
> the connect finishes, in that case another sync is needed after
> connection completes.  No idea how to handle this with single toggle
> bit.

Yep, with outgoing subflow in join_list the thing I suggested above is
not usable.

> > socket()
> > sesockopt()
> > listen()
> > // msks is accepted, msk->setsockopt_seq != 0
> > // mpj subflow is accepted, ssk->setsockopt_seq == 0, the mpj ssk
> > inherited from the listener socket the same sockoptions of the msk/mpc
> > subflow
> 
> I'm not sure all options have this 'inherited from listener' behaviour.

Why not? the subflow socket is cloned from the listener TCP subflow. 

If tcp_create_openreq_child() does not propagate some socket option,
then the expected behaviour is probably not propagating it.

WDYT?

Thanks!

Paolo




