Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E16D0E
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621346204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzKE0D56hHDYKsKck9FhSvZN5jkwrQ2TeeFOWGHrzQY=;
	b=aVN7txnjAdcPebBlcP7/1EbkFy3MqqaW6SZCib5kfOHlPDLYsmyP+7YgTgb6AlIu/NbQVp
	SEUX703AmxyuOa8seY5JavFmlKgro9NGucXvnB90ZNQKergXgxT+lSlC8XdNblg/ta7ret
	svVif8EiCqA5FNgv7Vccy4BQJxpVqi8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-B6yeA9N0MDydUkLp5tCckg-1; Tue, 18 May 2021 09:56:40 -0400
X-MC-Unique: B6yeA9N0MDydUkLp5tCckg-1
Received: by mail-wm1-f72.google.com with SMTP id n127-20020a1c27850000b02901717a27c785so573096wmn.9
        for <mptcp@lists.linux.dev>; Tue, 18 May 2021 06:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fzKE0D56hHDYKsKck9FhSvZN5jkwrQ2TeeFOWGHrzQY=;
        b=GtGxhdTzQaiijcAR9nY8uea3X49w2coVzej/PtcZuyf5NEQFy2AQotWKbCZk6xazE5
         DNyexP4xvq4ShORSDvpr9AxZttJ8gzn6v2F6mPqOBVD2F7VbSG2h1ScHSFDv1E5l919/
         9jP2G3ANuSd1ddtxjhoIn9hul4f+2bsTfwS6qEE76cEaeSDJ9863YquIoHlsTPR4E51E
         r3881R8cVetIlY0sYegkKqs7sPAgmqNJjWwNWTU7odc8bCoMQVLJt9QYFvMoyFpmg4mc
         ffyzqoGA2xUrE/lgSP+K2YmK+IgVzjYIAhbKugjjIe/xL+PuNJc6HlZ00yHckZflDfRF
         J2xQ==
X-Gm-Message-State: AOAM532yHDZVGE8FaUQLKZCY47PWqEIvitGIWpNRESvMxf+MEpLYww5E
	bTs+genfxcAXsiR3VnDcDdWn46ySFB9VDd721Mrcq2i5+Cd4CvJX/qzQtxUtj0jPthVdHSW8Ln0
	FFhJG9ZRaSKHmRJA=
X-Received: by 2002:a5d:5250:: with SMTP id k16mr7195986wrc.211.1621346198893;
        Tue, 18 May 2021 06:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwckf1d7EBvzx+DIoIG1BzgdjAK19sUz+OKZqlx8Okgm11VcSjEOnRF+vXNkEcnvdW72ooX+w==
X-Received: by 2002:a5d:5250:: with SMTP id k16mr7195955wrc.211.1621346198579;
        Tue, 18 May 2021 06:56:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-104.dyn.eolo.it. [146.241.245.104])
        by smtp.gmail.com with ESMTPSA id o1sm2658795wmc.6.2021.05.18.06.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 06:56:38 -0700 (PDT)
Message-ID: <ccc1707df9391e1552ac67f6b358e879ab3aed0a.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/6] add MP_CAPABLE 'C' flag
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Tue, 18 May 2021 15:56:36 +0200
In-Reply-To: <11169a25-2e4-a879-2c92-bad09a28a18@linux.intel.com>
References: <cover.1621002341.git.geliangtang@gmail.com>
	 <10c0783f0b81ab279dbbf202033295e7891c18d6.camel@redhat.com>
	 <11169a25-2e4-a879-2c92-bad09a28a18@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-05-17 at 12:59 -0700, Mat Martineau wrote:
> On Mon, 17 May 2021, Paolo Abeni wrote:
> 
> > Hello,
> > 
> > On Fri, 2021-05-14 at 22:32 +0800, Geliang Tang wrote:
> > > v6:
> > >  - rename mptcp_pm_add_entry to mptcp_pm_anno_entry
> > >  - update mptcp_pm_free_add_list
> > >  - update code in mptcp_pm_nl_add_addr_received
> > >  - tag: export/20210514T055902
> > > 
> > > v5:
> > >  - add a new patch "mptcp: add add_list in mptcp_pm_data"
> > >  - fix !CONFIG_SYSCTL case
> > >  - tag: export/20210507T174457
> > > 
> > > v4:
> > >  - rename mptcp_is_allow_join_id0 to mptcp_allow_join_id0
> > >  - rename deny_join_id0 in mptcp_pm_data to remote_deny_join_id0
> > >  - add comments for self test cases
> > >  - apply: export/20210504T064955 +
> > >           "data checksum support" +
> > >           "data checksum support cleanups"
> > > 
> > > v3:
> > >  - use 'u8 allow_join_initial_addr_port'
> > >  - drop the spinlock in patch 3
> > > 
> > > v2:
> > >  - rename join_denied to allow_join_id0 in mptcp_out_options
> > >  - rename join_denied to deny_join_id0 in mptcp_options_received
> > >  - add a new function mptcp_pm_deny_join_id0_received
> > >  - move deny_join_id0 flag from mptcp_sock to mptcp_pm_data
> > >  - check deny_join_id0 flag in mptcp_pm_create_subflow_or_signal_addr
> > > instead of in mptcp_syn_options.
> > > 
> > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183
> > > 
> > > Geliang Tang (6):
> > >   mptcp: add sysctl allow_join_initial_addr_port
> > >   mptcp: add allow_join_id0 in mptcp_out_options
> > >   mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
> > >   mptcp: add add_list in mptcp_pm_data
> > >   mptcp: add deny_join_id0 in mptcp_options_received
> > >   selftests: mptcp: add deny_join_id0 testcases
> > > 
> > >  Documentation/networking/mptcp-sysctl.rst     |  13 ++
> > >  include/net/mptcp.h                           |   3 +-
> > >  net/mptcp/ctrl.c                              |  16 ++
> > >  net/mptcp/options.c                           |  14 +-
> > >  net/mptcp/pm.c                                |   2 +
> > >  net/mptcp/pm_netlink.c                        | 151 ++++++++++++++----
> > >  net/mptcp/protocol.c                          |   1 +
> > >  net/mptcp/protocol.h                          |  21 ++-
> > >  net/mptcp/subflow.c                           |   3 +
> > >  .../testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++-
> > >  10 files changed, 238 insertions(+), 42 deletions(-)
> > > 
> > I'm very sorry to give feedback this late, but I was unable to review
> > this before.
> > 
> > I have some very generic/broad questions:
> > 1) shuold 'allow_join_initial_addr_port' be by default 0 for clients?
> > If I read correctly, will be 1 after this patch.
> 
> It should default to 1 because that is what keeps the current behavior.
> 
> The logic is flipped from the 'C' bit: C=1 in the header means "do not 
> connect to initial subflow addr/port", but allow_join_initial_addr_port=1 
> means "*do* connect to the initial subflow addr/port".
> 
> > 2) is the additional add_addr accounting required? I mean storing the
> > received addrs in the msk pm add_list (patch 4/6). Can we instead
> > simply enforce !allow_join_initial_addr_port looking up the relevant
> > address into the existing subflows? (or caching first subflow dst addr
> > and port in some new msk fields, whatever is simpler)
> > 
> > if !allow_join_initial_addr_port && <exists subflow with target
> > ip/port> && <such subflow is mp_capable/>
> > 	<do not create new subflow>
> > 
> 
> Caching the first subflow dst addr/port is enough to prevent sending a 
> MP_JOIN to that address, but I don't think it does quite enough.
> 
> Consider:
> 
> 1. Initial connection is made between Peer A and Peer B with C=1 (both 
> directions).
> 
> 2. Peer A sends ADD_ADDR. Peer B currently has limits set that don't allow 
> outgoing MP_JOINs.

Uhmmm.... Looking at the RFC, ADD_ADDR <MPC addr/MPC port> is a gray
area to me. My understanding is that with 'C' bit == 0 the peer is
allowed to create additional subflow towardst the initial subflow dst
addr/port, and such subflows are not allowed with C==1. 

But it looks like that ADD_ADDR should override that request. At the
very least an ADD_ADDR for the initial addr/port when the MPC handshake
completed with C==1 is weird.

> I've expected that we would add better tracking of ADD_ADDRs - 
> remember 
> that ADD_ADDR is an advertisement, not a request to "please connect 
> to 
> this address right now". Userspace path managers will certainly have 
> more 
> persistance of the peer's advertised addresses. Any more 
> comprehensive 
> in-kernel PM will also need the add_list. The main concern is that
> the 
> list doesn't consume excessive memory, and the add_list is not 
> expanded 
> when pm->accept_addr is false.

The in-kernel path manager is want to be as simple as possible. As soon
as we start allocating memory on peer req it's very easy to be prone to
DoS. Memory accounting and limits could save us or at least mitigate
the problem, but they will add more complexity.

> > 3) If I read correctly the series enforce the peer who could create the
> > new subflow to respect the 'allow_join_initial_addr_port' field, but
> > does not implement the corrsponding check on the other end. e.g. if a
> > server sets 'allow_join_initial_addr_port' to 0 and a client tries to
> > create additional subflows, the server will not forbit that. I
> > think/fear the missing complexity here is quite significant.
> > 
> > I think it would be nice avoid adding additional complexity for the 'C'
> > bit - currently even mptcp.org support it.
> > 
> 
> Assuming you intended to say "currently even mptcp.org does not support 
> it."
> 
> You're right: the incoming join address check is missing. But I'm not sure 
> the complexity is so bad, the PM can already reject joins. I think we 
> could pass enough information to mptcp_pm_allow_new_subflow() to implement 
> this check. Am I oversimplifying - is it harder to get at the dest 
> addr/port? Or is it something else?

What abot that setting C==0 on client sockets? does that imply that the
client will accept incoming connection on the src port/addr?

For the server case, even a list-based filter would add addtional
overhead and complexity for all setup.

AFAICS the RFC mentions this option as on optimization to avoid
connection attempts failing when something outside the endpoint
themself would prevent them from being succeful.

But this "optimization" has a cost in term of memory, complexity and
additional overhead for each connection/subflow. It will work only if
the administrator will configure the C bit properly. And that could be
non trivial, when load balancing and NAT are outside the mptcp host.

Just does not seam worthy to me, I really think we should start with
the bare minumum to respect the RFC itself, avoiding as much complexity
as possible:
- setting C always to 0 on server
- when the peer send C==1, cache the MPC addr/port, and do not attempt
other connection to such endpoint.

I'm not even sure the latter step is strictly necessary. Another option
would be passing the info to the user-space path manager - if available
- and let it deal with all the complexity. If no user-space path
manager is available just be dumb and simple ;)

> > Perhaps we could keep 'allow_join_initial_addr_port' constant (always 0
> > for client, always 0 for server) - avoding the additional complexity of
> > point 3) above.
> > 
> 
> Given the answer to #1 is this still what you'd propose? 
> allow_join_initial_addr_port=1 is unchanged behavior from the kernel 
> today, and is the simpler case.
> 
> --
> Mat Martineau
> Intel
> 

