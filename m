Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C672
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618331414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQLRVvdW14BG4hIFWgkMUL1zOgQSIMFU1yhelTjLpBc=;
	b=dLA2lDGWZwJ9gid4sdw5s5TjgaJB09eQxOKj5JrKz5tcCFRBSHI90DjV8wqktxA727IIz1
	baUjvNh5vLLCbovrffGiuWyNk3IPpqRZFSSJrfH/qx1gkrRg9Mk5RpT077wkbrwY3Slz70
	k/VZsK2J3xVqonwOClH5Uy6LUciU+Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-UYTHsfYpN3S37rLhZE0yxw-1; Tue, 13 Apr 2021 12:30:11 -0400
X-MC-Unique: UYTHsfYpN3S37rLhZE0yxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40E9919251A1;
	Tue, 13 Apr 2021 16:30:06 +0000 (UTC)
Received: from ovpn-115-101.ams2.redhat.com (ovpn-115-101.ams2.redhat.com [10.36.115.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 54D2B69102;
	Tue, 13 Apr 2021 16:30:05 +0000 (UTC)
Message-ID: <59c8ecf46ff4cb38f00a22b1b6e6bae067e7bb74.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 00/10] mptcp: add SOL_SOCKET support
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Tue, 13 Apr 2021 18:30:04 +0200
In-Reply-To: <20210413155447.14043-1-fw@strlen.de>
References: <20210413155447.14043-1-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-04-13 at 17:54 +0200, Florian Westphal wrote:
> This patch set improves support for several SOL_SOCKET tuneables,
> addressing comments received for v1 patch set.
> 
> Changes since v1:
>  - In patch 1, move addition of a variable to patch 2 (Paolo)
>  - In patch 2, restrict overflow of sequence count to lower 24 bits (Mat)
>  - In patch 2, remove a obsolete check on msk->setsockopt_check (Paolo)
> 
> First patch adds skeleton synchronization functions to copy mptcp socket
> settings to a subflow socket.
> 
> Second patch adds sequence counting scheme to avoid re-sync when subflow
> and mptcp-level socket are known to have the same setting applied.
> 
> Notable changes:
> I removed the sequence number from patch 1 and split it into second
> patch to make those bits clearer.
> 
> TCP_CONGESTION is now applied to all subflows.
> 
> TCP_INFO retrieves info from the first subflow.  It seems better to
> add MPTCP_INFO from out-of-tree patch set in a future change for
> userspace that wants mptcp-level flow statistics.
> 
> I've not changed SO_LINGER either, this should be updated in a
> future change to send a FASTCLOSE when mptcp socket gets closed
> while the linger time is 0.
> 
> The last patch adds a simple test to check SO_MARK replication.
> 
> Florian Westphal (10):
>   mptcp: add skeleton to sync msk socket options to subflows
>   mptcp: tag sequence_seq with socket state
>   mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
>   mptcp: setsockopt: handle receive/send buffer and device bind
>   mptcp: setsockopt: support SO_LINGER
>   mptcp: setsockopt: add SO_MARK support
>   mptcp: setsockopt: add SO_INCOMING_CPU
>   mptcp: setsockopt: SO_DEBUG and no-op options
>   mptcp: sockopt: add TCP_CONGESTION and TCP_INFO
>   selftests: mptcp: add packet mark test case
> 
>  net/mptcp/protocol.c                          |  53 ++-
>  net/mptcp/protocol.h                          |  11 +
>  net/mptcp/sockopt.c                           | 404 ++++++++++++++++++
>  net/mptcp/subflow.c                           |   5 +
>  tools/testing/selftests/net/mptcp/Makefile    |   2 +-
>  .../selftests/net/mptcp/mptcp_connect.c       |  23 +-
>  .../selftests/net/mptcp/mptcp_sockopt.sh      | 276 ++++++++++++
>  7 files changed, 763 insertions(+), 11 deletions(-)
>  create mode 100755 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> 
LGTM, thanks Florian for the very quick turn-around!

/P

