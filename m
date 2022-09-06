Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48077E
	for <mptcp@lists.linux.dev>; Tue,  6 Sep 2022 07:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662447775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=caiMWj7kissLoLR8KbqAK5Ap+BIXDNFbPV4Fgn7cTvo=;
	b=Zj0zo5SR3LtzUEHdnemLL2fL/9gEhWJaHUA/Orb4xfbKR1Ri0LIs5fU75jTodDFfNsaKTH
	mvdlTIBv2tZaG94wb3RgCzvAm9NKc1nZPIFpSvLY+EpfQ+UID2K5A1her03TU05D7OESuV
	YjKE29t4O34NuK301z7VzL8FrkNx/hQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372--nF4cJV1MT2V-8cgrRxJpA-1; Tue, 06 Sep 2022 03:02:54 -0400
X-MC-Unique: -nF4cJV1MT2V-8cgrRxJpA-1
Received: by mail-wm1-f71.google.com with SMTP id i7-20020a1c3b07000000b003a534ec2570so8376936wma.7
        for <mptcp@lists.linux.dev>; Tue, 06 Sep 2022 00:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=caiMWj7kissLoLR8KbqAK5Ap+BIXDNFbPV4Fgn7cTvo=;
        b=6X4QISyYkuOc9rj/rSkG7vl1YqylUZUy02YG4MOQ63X1xgXtv3/WR/25a//rhMwGCg
         iVHSEaREwKQI1HE/RQ7j/yvy7tPjLwUmZblQoRpx1DSt8Fj9dg6I2zZp302faMQ75ffM
         qK90mhhyX/U6bPx1xPNCWXT1S8l59e34YUNCF/aDqKGpflInDIZlO7FzR/Yb8l7hzBdG
         QTn3DFlHv6r7dzx5LnSu5ESbUubQa/kVOS87KGM8Wk8nrdJh0wm4shDIqbE8KrtcNdtR
         RN6EV4Dk+bH5drUh/ktaH5R59k5zCyCK6EziItjyOHAQSBDFAB7GfNbms5QW+SJ1XwXR
         UMvg==
X-Gm-Message-State: ACgBeo3aLT5Y1QYCwLHayV62kjEZpDhrUBov2dDC45MWsJmjSelhsdSo
	kUVxz6hdFZpPPNuPqvmCT3DvBRwaMqK5LSZvkjrWNISY/VFdDB5cNvbY5g8bvt3dN7ZPWGJQCoZ
	Mr2u/72gpiSIl6rY=
X-Received: by 2002:a05:6000:2c8:b0:221:7aea:c87f with SMTP id o8-20020a05600002c800b002217aeac87fmr24730970wry.242.1662447773119;
        Tue, 06 Sep 2022 00:02:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ZmSle1dv1s+lU9GYM3ItTuU9f+IG09LYuoLPgYQEDdFv42SwKl7Dvk2wH5naxB49JkETJTA==
X-Received: by 2002:a05:6000:2c8:b0:221:7aea:c87f with SMTP id o8-20020a05600002c800b002217aeac87fmr24730955wry.242.1662447772809;
        Tue, 06 Sep 2022 00:02:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it. [146.241.112.72])
        by smtp.gmail.com with ESMTPSA id k4-20020a7bc404000000b003a601a1c2f7sm19388512wmi.19.2022.09.06.00.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 00:02:52 -0700 (PDT)
Message-ID: <1bfe80691f6d7c1cf427e5fb979d5dd6f841a4f0.camel@redhat.com>
Subject: Re: [PATCH net] net: mptcp: fix unreleased socket in accept queue
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Date: Tue, 06 Sep 2022 09:02:50 +0200
In-Reply-To: <CADxym3agY5PmVOgCKpxO8mwrCTGnJ6BNvYZUcgu0jwRJEiawHw@mail.gmail.com>
References: <20220905050400.1136241-1-imagedong@tencent.com>
	 <da8998cba112cbdea9d403052732c794f3882bd2.camel@redhat.com>
	 <CADxym3agY5PmVOgCKpxO8mwrCTGnJ6BNvYZUcgu0jwRJEiawHw@mail.gmail.com>
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

On Mon, 2022-09-05 at 17:03 +0800, Menglong Dong wrote:
> On Mon, Sep 5, 2022 at 4:26 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > Hello,
> > 
> > On Mon, 2022-09-05 at 13:04 +0800, menglong8.dong@gmail.com wrote:
> > > From: Menglong Dong <imagedong@tencent.com>
> > > 
> > > The mptcp socket and its subflow sockets in accept queue can't be
> > > released after the process exit.
> > > 
> > > While the release of a mptcp socket in listening state, the
> > > corresponding tcp socket will be released too. Meanwhile, the tcp
> > > socket in the unaccept queue will be released too. However, only init
> > > subflow is in the unaccept queue, and the joined subflow is not in the
> > > unaccept queue, which makes the joined subflow won't be released, and
> > > therefore the corresponding unaccepted mptcp socket will not be released
> > > to.
> > > 
> > > This can be reproduced easily with following steps:
> > > 
> > > 1. create 2 namespace and veth:
> > >    $ ip netns add mptcp-client
> > >    $ ip netns add mptcp-server
> > >    $ sysctl -w net.ipv4.conf.all.rp_filter=0
> > >    $ ip netns exec mptcp-client sysctl -w net.mptcp.enabled=1
> > >    $ ip netns exec mptcp-server sysctl -w net.mptcp.enabled=1
> > >    $ ip link add red-client netns mptcp-client type veth peer red-server \
> > >      netns mptcp-server
> > >    $ ip -n mptcp-server address add 10.0.0.1/24 dev red-server
> > >    $ ip -n mptcp-server address add 192.168.0.1/24 dev red-server
> > >    $ ip -n mptcp-client address add 10.0.0.2/24 dev red-client
> > >    $ ip -n mptcp-client address add 192.168.0.2/24 dev red-client
> > >    $ ip -n mptcp-server link set red-server up
> > >    $ ip -n mptcp-client link set red-client up
> > > 
> > > 2. configure the endpoint and limit for client and server:
> > >    $ ip -n mptcp-server mptcp endpoint flush
> > >    $ ip -n mptcp-server mptcp limits set subflow 2 add_addr_accepted 2
> > >    $ ip -n mptcp-client mptcp endpoint flush
> > >    $ ip -n mptcp-client mptcp limits set subflow 2 add_addr_accepted 2
> > >    $ ip -n mptcp-client mptcp endpoint add 192.168.0.2 dev red-client id \
> > >      1 subflow
> > > 
> > > 3. listen and accept on a port, such as 9999. The nc command we used
> > >    here is modified, which makes it uses mptcp protocol by default.
> > >    And the default backlog is 1:
> > >    ip netns exec mptcp-server nc -l -k -p 9999
> > > 
> > > 4. open another *two* terminal and connect to the server with the
> > >    following command:
> > >    $ ip netns exec mptcp-client nc 10.0.0.1 9999
> > >    input something after connect, to triger the connection of the second
> > >    subflow
> > > 
> > > 5. exit all the nc command, and check the tcp socket in server namespace.
> > >    And you will find that there is one tcp socket in CLOSE_WAIT state
> > >    and can't release forever.
> > 
> > Thank you for the report!
> > 
> > I have a doubt WRT the above scenario: AFAICS 'nc' will accept the
> > incoming sockets ASAP, so the unaccepted queue should be empty at
> > shutdown, but that does not fit with your description?!?
> > 
> 
> By default, as far as in my case, nc won't accept the new connection
> until the first connection closes with the '-k' set. Therefor, the second
> connection will stay in the unaccepted queue.

I missed the fact you opened 2 connections. I guess that is point 4
above. Please rephrase that sentence with something alike:

---
4. open another *two* terminal and use each of them to connect to the
server with the following command:
...
So that there are two established mptcp connections, with the second
one still unaccepted.
---
> 
> > > There are some solutions that I thought:
> > > 
> > > 1. release all unaccepted mptcp socket with mptcp_close() while the
> > >    listening tcp socket release in mptcp_subflow_queue_clean(). This is
> > >    what we do in this commit.
> > > 2. release the mptcp socket with mptcp_close() in subflow_ulp_release().
> > > 3. etc
> > > 
> > 
> > Can you please point to a commit introducing the issue?
> > 
> 
> In fact, I'm not sure. In my case, I found this issue in kernel 5.10.
> And I wanted to find the solution in the upstream, but find that
> upstream has this issue too.
> 
> Hmm...I am curious if this issue exists in the beginning? I
> can't find the opportunity that the joined subflow which are
> unaccepted can be released.

It looks like the problem is there since MPJ support, commit
f296234c98a8fcec94eec80304a873f635d350ea

> 
> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > ---
> > >  net/mptcp/subflow.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index c7d49fb6e7bd..e39dff5d5d84 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -1770,6 +1770,10 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
> > >               msk->first = NULL;
> > >               msk->dl_next = NULL;
> > >               unlock_sock_fast(sk, slow);
> > > +
> > > +             /*  */
> > > +             sock_hold(sk);
> > > +             sk->sk_prot->close(sk);
> > 
> > You can call mptcp_close() directly here.
> > 
> > Perhaps we could as well drop the mptcp_sock_destruct() hack?
> 
> Do you mean to call mptcp_sock_destruct() directly here?

I suspect that with this change setting msk->sk_destruct to
mptcp_sock_destruct in subflow_syn_recv_sock() is not needed anymore,
and the relevant intialization (and callback definition) could be
removed.

> 
Cheers,

Paolo

