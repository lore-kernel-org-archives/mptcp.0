Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4A168
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642593699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91QgvQ+KuPsHMsA5veqTOLK25UYHykg9t+fU/7HmmHY=;
	b=CQKcmJg1eaBUmH8QDlBKw6RwHKXcgb6DzNCEXz6/UsYqzvOsPINwhoUPDk0wkZkdaancFL
	MVYUIVQhaTTwziXI+I0Oqzq/A0uLVz0dpiE5TZtBLLlO0O7u794+rxzupz8ihoc/7NQz3e
	CKuvnoeADA2t9qLLDYgz8E4DWXIXi04=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-fvuk7z1TMc27K3jMUz9yvA-1; Wed, 19 Jan 2022 07:01:35 -0500
X-MC-Unique: fvuk7z1TMc27K3jMUz9yvA-1
Received: by mail-qt1-f197.google.com with SMTP id y1-20020ac87041000000b002c3db9c25f8so1336467qtm.5
        for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 04:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=91QgvQ+KuPsHMsA5veqTOLK25UYHykg9t+fU/7HmmHY=;
        b=3xou8qt8ApTlhLk281CUqGsqPzmPfs0ZfXTkgxdowri5LbCtWz8TpX2DJwe7mdmsgN
         eMKV5F8JSRHfRSiI55R1G3qHGSuCg3ry7bqs9u4S6fHVH+8gZubsnYkl1qNw/BL/r5m9
         5+nm/2lgkLKWsSLkE7SI2itvyeg1k327ZSFjoCHKynPoS1ufqgdm1zdLJL+bAg4RYhga
         X2lf7P4BirD3zx0jynxCqnKDlQ/tbW88SZo1HSimzOBux9Sz4wgVbYz5LA1u4WXuCYNr
         hy60zME1W2A5Ak+GAWmUFJB+Sn3SAgBSPkO1KXK5EocF3favj4LyHnsFTyMG+9huVWpm
         VY5w==
X-Gm-Message-State: AOAM533L9jsCxvTNN1sOvfufQffVT7whRkQbe51gM17xY44NejDvHrw5
	6tx3nIaoUtJZ9rLTWVdW8fObm8GM3EcR1uySd8azdeCe81Fat3rOcKb36cqXLV8AzdJosTUL19P
	hrYIbesa0dEKzFGc=
X-Received: by 2002:a37:a7d4:: with SMTP id q203mr16545871qke.274.1642593694782;
        Wed, 19 Jan 2022 04:01:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWz/gWN4ulr/cWmyQKB09je7FrjAmvh5seHoW7lJWHKR3TgIzs+YDMYyVxrU96Tio00ybwvA==
X-Received: by 2002:a37:a7d4:: with SMTP id q203mr16545840qke.274.1642593694410;
        Wed, 19 Jan 2022 04:01:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id d15sm12438387qtd.70.2022.01.19.04.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:01:33 -0800 (PST)
Message-ID: <f161df56e10f36dc27403586793c367b29eb7066.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 04/21] mptcp: establish subflows from
 either end of connection
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 19 Jan 2022 13:01:30 +0100
In-Reply-To: <d3b555e1-752a-e125-1654-3d8cbdd20e4a@intel.com>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
	 <20220112221523.1829397-5-kishen.maloor@intel.com>
	 <83f91e9b-9c20-6e83-6442-41b87139f4eb@linux.intel.com>
	 <eb4affeebe3b03948a2252b0d6af852751c0ac1f.camel@redhat.com>
	 <d3b555e1-752a-e125-1654-3d8cbdd20e4a@intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
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

On Tue, 2022-01-18 at 17:26 -0800, Kishen Maloor wrote:
> On 1/17/22 12:59 AM, Paolo Abeni wrote:
> > On Fri, 2022-01-14 at 14:43 -0800, Mat Martineau wrote:
> > > On Wed, 12 Jan 2022, Kishen Maloor wrote:
> > > 
> > > > This change updates internal logic to permit subflows to be
> > > > established from either the client or server ends of MPTCP
> > > > connections. This symmetry and added flexibility may be
> > > > harnessed by PM implementations running on either end in
> > > > creating new subflows.
> > > > 
> > > > The essence of this change lies in not relying on the
> > > > "server_side" flag (which continues to be available if needed).
> > > > 
> > > 
> > > After this patch, server_side is unused except for some debug output. If 
> > > it's really no longer referenced (see below first), may be better to just 
> > > remove it.
> 
> I think we'll need it. 
> 
> One possible use is to inform the PM daemon of the type of application 
> (client/server) associated with a connection.
> 
> As we're discussing the idea of creating listening sockets only upon request, the 
> knowledge that we are on the client end of a connection is something a PM daemon could
> use to request creation of listening sockets whenever it advertises an address.
> 
> > > 
> > > > v2: check for 3rd ACK retransmission only on passive side
> > > > of the MPJ handshake
> > > > 
> > > > Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> > > > ---
> > > > net/mptcp/options.c  | 2 +-
> > > > net/mptcp/protocol.c | 5 +----
> > > > net/mptcp/protocol.h | 2 --
> > > > 3 files changed, 2 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > > index cceba8c7806d..89808816db06 100644
> > > > --- a/net/mptcp/options.c
> > > > +++ b/net/mptcp/options.c
> > > > @@ -921,7 +921,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> > > > 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
> > > > 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
> > > > 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
> > > > -		    READ_ONCE(msk->pm.server_side))
> > > > +		    !subflow->request_join)
> > > > 			tcp_send_ack(ssk);
> > > > 		goto fully_established;
> > > > 	}
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index 4012f844eec1..408a05bff633 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -3248,15 +3248,12 @@ bool mptcp_finish_join(struct sock *ssk)
> > > > 		return false;
> > > > 	}
> > > > 
> > > > -	if (!msk->pm.server_side)
> > > > +	if (!list_empty(&subflow->node))
> > > > 		goto out;
> > > > 
> > > > 	if (!mptcp_pm_allow_new_subflow(msk))
> > > > 		goto err_prohibited;
> > > > 
> > > > -	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
> > > > -		goto err_prohibited;
> > > > -
> > > > 	/* active connections are already on conn_list.
> > > > 	 * If we can't acquire msk socket lock here, let the release callback
> > > > 	 * handle it
> > > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > > index e2a67d3469f6..c50247673c7e 100644
> > > > --- a/net/mptcp/protocol.h
> > > > +++ b/net/mptcp/protocol.h
> > > > @@ -908,10 +908,8 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
> > > > static inline bool subflow_simultaneous_connect(struct sock *sk)
> > > > {
> > > > 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> > > > -	struct sock *parent = subflow->conn;
> > > > 
> > > > 	return sk->sk_state == TCP_ESTABLISHED &&
> > > > -	       !mptcp_sk(parent)->pm.server_side &&
> > > > 	       !subflow->conn_finished;
> > > > }
> > > 
> > > Are changes in this function needed? This code was added to address
> > > https://github.com/multipath-tcp/mptcp_net-next/issues/35
> > > which was a weird case encountered with syzkaller where a socket tried to 
> > > connect to itself, triggering the "simultaneous open" code path. It 
> > > doesn't seem to be applicable to MP_JOINs.
> > 
> > I *think* we can reach here even with MPJ, e.g. if we have port-based
> > endpoint matching the src address/port - possibly syzkaller could be
> > able to reach such scenario.
> > 
> > Additionally I fear dropping the '!mptcp_sk(parent)->pm.server_side &&'
> > check could re-introduce the initial issue, at least for the MPC
> > handshake.
> 
> The purpose of this commit is to permit the MPJ sequence to happen at either end of 
> the connection. The change in mptcp_finish_join() had the most direct impact for enabling 
> this, so I looked at other server_side checks mostly in terms of establishing that
> bi-directional symmetry.
> 
> If the above condition holds only with MPCs, i.e. for the initial connection, then I think it would 
> be fine to preserve the server_side check. But if it also holds for MPJs, then we might
> have to account for both cases. Perhaps replace:
> 
> !mptcp_sk(parent)->pm.server_side)
> 
> with something like this?
> 
> ((subflow->request_mptcp && !mptcp_sk(parent)->pm.server_side) ||
> 	subflow->request_join)

It looks like 'request_mptcp' is 0 on passive sockets, so:

 	subflow->request_mptcp || subflow->request_join

should suffice.

Possibly factoring out an helper for the above condition would make the
code more readable.

/P

