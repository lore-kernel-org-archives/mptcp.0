Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539EE71
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619167974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6iFOK6WJl/QPpMLeB3u9BxrSqCFN6/QuTJs4NcRazQ=;
	b=IGYrYCYeVcTdvTXfTfw5sMtaqZxfOZBQgSmGXe2m9vtvOCC4Pr6eHsrVxYMn0Hg8UUFFkC
	KH4dtOAaLGoxsJEfZI0Mqk2S6Wwa/v2NJQPYctsa9u1zopGfzPEbt8F3sKemuDGUkTHSXU
	L4jt9WlZGhbPJaZ3OcVJPaqjbd/Zanc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-SmyaLQEPMJ-7-lQ36zltmQ-1; Fri, 23 Apr 2021 04:52:51 -0400
X-MC-Unique: SmyaLQEPMJ-7-lQ36zltmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55C02802B56;
	Fri, 23 Apr 2021 08:52:50 +0000 (UTC)
Received: from ovpn-115-60.ams2.redhat.com (ovpn-115-60.ams2.redhat.com [10.36.115.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 726511037E80;
	Fri, 23 Apr 2021 08:52:49 +0000 (UTC)
Message-ID: <3c5d904e6e4da06c4066955f7a7f714cccc1f207.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 12/21] Squash-to: "mptcp: receive checksum
 for MP_CAPABLE with data"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 23 Apr 2021 10:52:48 +0200
In-Reply-To: <CA+WQbws0LhacR_RqaRBSasgwpFO8fwk57AzMHXHK52KBNL6bUQ@mail.gmail.com>
References: <cover.1619035356.git.pabeni@redhat.com>
	 <77387e8589417f2ccb445136c74d16ed44a344d1.1619035356.git.pabeni@redhat.com>
	 <CA+WQbws0LhacR_RqaRBSasgwpFO8fwk57AzMHXHK52KBNL6bUQ@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-04-23 at 11:17 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> Paolo Abeni <pabeni@redhat.com> 于2021年4月22日周四 上午4:20写道：
> > always parse any csum/nocsum combination and delay the
> > presence check to later code, to allow reset if missing.
> > 
> > Additionally, in the TX path, use the newly introduce ext
> > field to avoid MPTCP csum recomputation on tcp retransmission
> > and unneeded csum update on when setting the data fin_flag.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  include/net/mptcp.h  |  3 ++-
> >  net/mptcp/options.c  | 32 ++++++++++++++++++++------------
> >  net/mptcp/protocol.h |  2 ++
> >  3 files changed, 24 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 8f86c05ddbfd..bd272c34b53c 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -32,7 +32,8 @@ struct mptcp_ext {
> >                         mpc_map:1,
> >                         frozen:1,
> >                         reset_transient:1;
> > -       u8              reset_reason:4;
> > +       u8              reset_reason:4,
> > +                       csum_reqd:1;
> 
> I want to move these lines to the patch ([PATCH v3 mptcp-next 03/21]
> Squash-to: "mptcp: generate the data checksum") in the next version.

The 'csum_reqd' bit is used a validity status for the parsed csum: we
know a csum was present in the parsed DSS if and only if csum_reqd !=
0. I think it needs to stay here.

> >  };
> > 
> >  #define MPTCP_RM_IDS_MAX       8
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index cd205ad09c00..83a981684bbf 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -39,8 +39,6 @@ static void mptcp_parse_option(const struct sock *sk,
> >                 if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
> >                         if (skb->len > tcp_hdr(skb)->doff << 2) {
> >                                 expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
> > -                               if (READ_ONCE(msk->csum_enabled))
> > -                                       expected_opsize += TCPOLEN_MPTCP_DSS_CHECKSUM;
> >                         } else {
> >                                 expected_opsize = TCPOLEN_MPTCP_MPC_ACK;
> >                         }
> 
> I'll drop these braces '{}' too, it looks like:
> 
>                          if (skb->len > tcp_hdr(skb)->doff << 2)
>                                  expected_opsize = TCPOLEN_MPTCP_MPC_ACK_DATA;
>                          else
>                                  expected_opsize = TCPOLEN_MPTCP_MPC_ACK;

Agreed.

> > @@ -50,7 +48,20 @@ static void mptcp_parse_option(const struct sock *sk,
> >                         else
> >                                 expected_opsize = TCPOLEN_MPTCP_MPC_SYN;
> >                 }
> > -               if (opsize != expected_opsize)
> > +
> > +               /* Cfr RFC 8684 Section 3.3.0:
> > +                * If a checksum is present but its use had
> > +                * not been negotiated in the MP_CAPABLE handshake, the receiver MUST
> > +                * close the subflow with a RST, as it is not behaving as negotiated.
> > +                * If a checksum is not present when its use has been negotiated, the
> > +                * receiver MUST close the subflow with a RST, as it is considered
> > +                * broken
> > +                * We parse even option with mismatching csum presence, so that
> > +                * later in subflow_data_ready we can trigger the reset.
> > +                */
> > +               if ((opsize != expected_opsize) &&
> > +                   (expected_opsize != TCPOLEN_MPTCP_MPC_ACK_DATA ||
> > +                    opsize != TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM))
> >                         break;
> > 
> >                 /* try to be gentle vs future versions on the initial syn */
> > @@ -72,11 +83,6 @@ static void mptcp_parse_option(const struct sock *sk,
> >                  * host requires the use of checksums, checksums MUST be used.
> >                  * In other words, the only way for checksums not to be used
> >                  * is if both hosts in their SYNs set A=0."
> > -                *
> > -                * Section 3.3.0:
> > -                * "If a checksum is not present when its use has been
> > -                * negotiated, the receiver MUST close the subflow with a RST as
> > -                * it is considered broken."
> >                  */
> >                 mp_opt->csum_reqd = READ_ONCE(msk->csum_enabled);
> >                 if (flags & MPTCP_CAP_CHECKSUM_REQD)
> > @@ -103,8 +109,9 @@ static void mptcp_parse_option(const struct sock *sk,
> >                         mp_opt->data_len = get_unaligned_be16(ptr);
> >                         ptr += 2;
> >                 }
> > -               if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA + TCPOLEN_MPTCP_DSS_CHECKSUM) {
> > +               if (opsize == TCPOLEN_MPTCP_MPC_ACK_DATA_CSUM) {
> >                         mp_opt->csum = (__force __sum16)get_unaligned_be16(ptr);
> > +                       mp_opt->csum_reqd = 1;
> >                         ptr += 2;
> >                 }
> >                 pr_debug("MP_CAPABLE version=%x, flags=%x, optlen=%d sndr=%llu, rcvr=%llu len=%d csum=%u",
> > @@ -353,7 +360,6 @@ void mptcp_get_options(const struct sock *sk,
> >         mp_opt->mp_prio = 0;
> >         mp_opt->reset = 0;
> >         mp_opt->csum_reqd = 0;
> > -       mp_opt->csum = 0;
> 
> I want to keep this "mp_opt->csum = 0;" here.

No, this is not needed. zeoring the csum is not needed. The csum should
be accessed if and only if csum_reqd != 0, and in that case 'csum' will
always be initialized.

> >         length = (th->doff * 4) - sizeof(struct tcphdr);
> >         ptr = (const unsigned char *)(th + 1);
> > @@ -543,7 +549,8 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
> >                 ext->data_len++;
> > 
> >                 /* the pseudo header has changed, update the csum accordingly */
> > -               csum_replace2(&ext->csum, ext->data_len - 1, ext->data_len);
> > +               if (ext->csum_reqd)
> > +                       csum_replace2(&ext->csum, ext->data_len - 1, ext->data_len);
> 
> And I want to move these lines to the patch ([PATCH v3 mptcp-next 03/21]
> Squash-to: "mptcp: generate the data checksum") too.

Agreed.

Side note: I can send the relevant changes, n.p.

/P

