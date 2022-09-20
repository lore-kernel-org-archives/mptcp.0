Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521997462
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663686740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDg1EICkgK4WJRaIzBLpIh44il9ZMhpveSFF+cp8Ih4=;
	b=FCTXSlZzqBIgq6BbPxRMpu61LlBmsKVXQBMVUEegmbwNhOF878OD1eRb6G2cwCZbEvrswe
	sIL4GsuKI/nsAm4wfH57woXu00QOoYX3Fmuo4wsxYeQ5CC5rFqViYtN8o4AtPbaD01qi23
	dqbUaMvhmH2TOHiYKBaEwh9vB1T0VAw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-171-gE2ATD3WPwqLf-AC7axKiw-1; Tue, 20 Sep 2022 11:12:18 -0400
X-MC-Unique: gE2ATD3WPwqLf-AC7axKiw-1
Received: by mail-wr1-f71.google.com with SMTP id l5-20020adfa385000000b0022a482f8285so1278321wrb.5
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 08:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=qDg1EICkgK4WJRaIzBLpIh44il9ZMhpveSFF+cp8Ih4=;
        b=dG0jh3uZWXsNNEMV7yFx4OcIM9RbC4bl+suF6kZbxegwDiWZZMoJceXejUlYhHr5BK
         w0wiYw4NNHSY0FK6nW6MZ6X0daUf4Crd/9O8J9OYtlji1tXB9PprN1RTQlmZWS1i0kiH
         ixhaqIwFPatas0CBU/AFmraFdVXwemWHKBecbzEPdYqEJmiISzRwuWfXUN+0N6S5+vsx
         DhCJSOamoJaXnozHw2F2JZuiLIndF9LXjYRl/NV0tl/lPYGzhH/BHvq1GqKhTU1AY/2g
         wFJFv1swQu5j0REaZ/sZno3OkG+RwImyx7SgVZSIA1dlFRBohxWzNqVKlNWSXd5VNZQS
         ROdg==
X-Gm-Message-State: ACrzQf15oSm9B/nJMEf9s5sdyqp25KOgl9aVDVohm5zGo56RRh3OHwwH
	lOhV7DK49J7WAX4hTKsjjGFO6dAqDd1NyQqI1L7WyVC06O+wBTYvtB6dOonfRmMJ1R0Y5bheJqd
	JmKRyshb7zvZXJ6U=
X-Received: by 2002:a05:600c:1f0d:b0:3b4:ba4d:272a with SMTP id bd13-20020a05600c1f0d00b003b4ba4d272amr2903897wmb.105.1663686737437;
        Tue, 20 Sep 2022 08:12:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6R+n+CXqHFgG5/RPQc3sPJzuVBwkrnMhuVv8qOrHmTryo1IdaSEnbCixpT5M9DiydrJTxv5w==
X-Received: by 2002:a05:600c:1f0d:b0:3b4:ba4d:272a with SMTP id bd13-20020a05600c1f0d00b003b4ba4d272amr2903874wmb.105.1663686737086;
        Tue, 20 Sep 2022 08:12:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d504e000000b00228da396f9dsm244775wrt.84.2022.09.20.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:12:16 -0700 (PDT)
Message-ID: <9010c984f0d7a238087df9ede5e3a5d36b2ca96b.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v8 3/7] reuse tcp_sendmsg_fastopen()
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Dmytro Shytyi
	 <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Tue, 20 Sep 2022 17:12:15 +0200
In-Reply-To: <9f63a04a-7213-0757-2475-d09e74cdc54f@tessares.net>
References: <20220920125243.2880-1-dmytro@shytyi.net>
	 <20220920125243.2880-4-dmytro@shytyi.net>
	 <5bebaee5b0a6b183603d8c8428a01750b41df515.camel@redhat.com>
	 <9f63a04a-7213-0757-2475-d09e74cdc54f@tessares.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2022-09-20 at 17:02 +0200, Matthieu Baerts wrote:
> Hi Paolo, Dmytro,
> 
> On 20/09/2022 16:36, Paolo Abeni wrote:
> > On Tue, 2022-09-20 at 14:52 +0200, Dmytro Shytyi wrote:
> > > In the following patches we will reuse modified tcp_sendmsg_fastopen().
> > > We call it from mptcp_sendmsg().
> > > 
> > > Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> > > ---
> > >  include/net/tcp.h    |  3 +++
> > >  net/ipv4/tcp.c       | 18 +++++++++++++-----
> > >  net/mptcp/protocol.c | 11 +++++++++--
> > >  3 files changed, 25 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index 735e957f7f4b..a7d49e42470a 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -1754,6 +1754,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
> > >  			      struct request_sock *req,
> > >  			      struct tcp_fastopen_cookie *foc,
> > >  			      const struct dst_entry *dst);
> > > +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> > > +			 int *copied, size_t size,
> > > +			 struct ubuf_info *uarg);
> > >  void tcp_fastopen_init_key_once(struct net *net);
> > >  bool tcp_fastopen_cookie_check(struct sock *sk, u16 *mss,
> > >  			     struct tcp_fastopen_cookie *cookie);
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 9251c99d3cfd..d10a3cdae220 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -280,6 +280,9 @@
> > >  #include <asm/ioctls.h>
> > >  #include <net/busy_poll.h>
> > >  
> > > +#include <net/mptcp.h>
> > > +#include "../mptcp/protocol.h"
> > > +
> > >  /* Track pending CMSGs. */
> > >  enum {
> > >  	TCP_CMSG_INQ = 1,
> > > @@ -1162,9 +1165,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
> > >  	}
> > >  }
> > >  
> > > -static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> > > -				int *copied, size_t size,
> > > -				struct ubuf_info *uarg)
> > > +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> > > +			 int *copied, size_t size,
> > > +			 struct ubuf_info *uarg)
> > >  {
> > >  	struct tcp_sock *tp = tcp_sk(sk);
> > >  	struct inet_sock *inet = inet_sk(sk);
> > > @@ -1197,8 +1200,13 @@ static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> > >  		}
> > >  	}
> > >  	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
> > > -	err = __inet_stream_connect(sk->sk_socket, uaddr,
> > > -				    msg->msg_namelen, flags, 1);
> > > +	if (!sk_is_mptcp(sk))
> > > +		err = __inet_stream_connect(sk->sk_socket, uaddr,
> > > +					    msg->msg_namelen, flags, 1);
> > > +	else
> > > +		err = mptcp_stream_connect(sk->sk_socket, uaddr,
> > > +					   msg->msg_namelen, msg->msg_flags);
> > 
> > 
> > I guess the goal of the above change is let mptcp_stream_connect()
> > update the msk socket status, is that correct?
> > 
> > However there are a few problems with lock: you must acquite the
> > subflow socket lock before calling tcp_sendmsg_fastopen() - or will see
> > subflow state corruption - but that in turn will cause a deadlock as 
> >  mptcp_stream_connect() acquires the msk socket lock and then the
> > subflow socket lock.
> > 
> > I think it's better leave the tcp_sendmsg_fastopen() body unchanged...
> > 
> > > +
> > >  	/* fastopen_req could already be freed in __inet_stream_connect
> > >  	 * if the connection times out or gets rst
> > >  	 */
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 470045793181..8cf307e4e59c 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -1673,9 +1673,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> > >  	long timeo;
> > >  
> > >  	/* we don't support FASTOPEN yet */
> > > -	if (msg->msg_flags & MSG_FASTOPEN)
> > > -		return -EOPNOTSUPP;
> > > +	if (msg->msg_flags & MSG_FASTOPEN) {
> > > +		struct socket *ssock = __mptcp_nmpc_socket(msk);
> > 
> > ... acquire the subflow socket lock here...
> > 
> > >  
> > > +		if (ssock) {
> > > +			int copied_syn_fastopen = 0;
> > > +
> > > +			ret = tcp_sendmsg_fastopen(ssock->sk, msg, &copied_syn_fastopen, len, NULL);
> > > +			copied += copied_syn_fastopen;
> > > +		}
> > 
> > ... and additionally handle the sock state update here. Possibly you
> > can encapsulate all the fastopen code in a new function - say
> > __mptcp_sendmsg_fastopen(), as it will be called under the msk socket
> > lock.
> > 
> > 
> > Side note: you should enter the fastopen branch even when 
> > inet_sk(ssock->sk)->defer_connect is set
> 
> I think we should better discuss about that at the next meeting because
> all items you are asking here is what Benjamin did in [1]:
> 
> https://patchwork.kernel.org/project/mptcp/patch/20220908133829.3410092-4-benjamin.hesmans@tessares.net/

Almost. The above lacks the msk socket state update.

Cheers,

Paolo

