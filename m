Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF710A48A
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671820171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxzk/o6zmeg/5Rgjm/IxSTMlD79/QWfIt1pylUEfQig=;
	b=Tb66tfov3KI5XrfVsO6SaLA0vL108pzqw6t0g23CgaUDsH/MRcu0l1InDTE9bhNWuaDpWJ
	3361eZVgMpBjp4WDhgb+tJR8SciPtcItAPKXDdO4hYdj8uEjXPt2EhrKUj/sAZ2st+gMmV
	ixhBjNcjSdLmxcuHUn7C4PFOdh1YUZw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-0Ryg6Uj3Mee57yEamEgUpg-1; Fri, 23 Dec 2022 13:29:30 -0500
X-MC-Unique: 0Ryg6Uj3Mee57yEamEgUpg-1
Received: by mail-qv1-f69.google.com with SMTP id lc30-20020a0562142c1e00b0052f5d835229so790789qvb.5
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 10:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mxzk/o6zmeg/5Rgjm/IxSTMlD79/QWfIt1pylUEfQig=;
        b=4h/wpA70juPPOo/2h1cQ+fwIhSWz8cqdHVEvBimirC159SZnHNSzGoGHI1rriwmCvb
         YI02e/rrdzJSV5Gj7ntdcOhxnv+Di2J8LI1iDuat2EuY5i2yJBWVQhzyc6ZKi3DGJ2Tf
         5ZkSkSgyG1IpYYIVDPKkE+1hJQw04h/pHTkVl3bMLtWwkrM8CFYAVhlF2p2k/LKE6sRm
         mLNK8Zmt/CKWaBYqdA6RJ6QfBvStJymZFUL4cDLia8NbUCBegVoipQ8tQ26iMJik4No2
         N0Zb8JtjDhRZbb+fLRaqz6+fDgiC2vtN8angdFGpqMUNo4l7y+5M6mm3BPYfBEvObX55
         fwLQ==
X-Gm-Message-State: AFqh2koNJt7CEmfOvoluPZdsFsKQ2T/aSBtd2qCQBBkN31FfCNcoTu0I
	yiBP9G1vL1wsBH+OnHAbehpeXODGGVfSx3BgmKfOOFUAo0+SgkMaRygGUs2Vt78NG474G9ezM0K
	dFUHOK/oiIWRocDE=
X-Received: by 2002:a05:622a:1b1e:b0:3a7:ef7b:6aac with SMTP id bb30-20020a05622a1b1e00b003a7ef7b6aacmr12256085qtb.11.1671820169339;
        Fri, 23 Dec 2022 10:29:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvEurzG8VXvn0y7vqiKFLqGd5JU0fZzwRhk+J/w2l22qkfAr5ZB0nCIt+6VaBVSzO2RxBPo3Q==
X-Received: by 2002:a05:622a:1b1e:b0:3a7:ef7b:6aac with SMTP id bb30-20020a05622a1b1e00b003a7ef7b6aacmr12256057qtb.11.1671820168903;
        Fri, 23 Dec 2022 10:29:28 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id cm27-20020a05622a251b00b0035d432f5ba3sm2293013qtb.17.2022.12.23.10.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:29:28 -0800 (PST)
Message-ID: <69b575721cd0164895fd634f93d2900485698999.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add test-cases for
 mixed v4/v6 subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 23 Dec 2022 19:29:25 +0100
In-Reply-To: <45315757-d5fc-8d90-39e1-d7fd8a7682a4@tessares.net>
References: <cover.1671799401.git.pabeni@redhat.com>
	 <c2b08053101c90d85634c95840e3a8a637fa8346.1671799401.git.pabeni@redhat.com>
	 <45315757-d5fc-8d90-39e1-d7fd8a7682a4@tessares.net>
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

On Fri, 2022-12-23 at 15:35 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 23/12/2022 13:51, Paolo Abeni wrote:
> > Note that we can't guess anymore the listener family based on the
> > client target address; use always IPv6.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 51 +++++++++++++++----
> >  1 file changed, 42 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index d11d3d566608..6ef4787ad244 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -774,24 +774,17 @@ do_transfer()
> >  		addr_nr_ns2=${addr_nr_ns2:9}
> >  	fi
> >  
> > -	local local_addr
> > -	if is_v6 "${connect_addr}"; then
> > -		local_addr="::"
> > -	else
> > -		local_addr="0.0.0.0"
> > -	fi
> > -
> >  	extra_srv_args="$extra_args $extra_srv_args"
> >  	if [ "$test_link_fail" -gt 1 ];then
> >  		timeout ${timeout_test} \
> >  			ip netns exec ${listener_ns} \
> >  				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> > -					$extra_srv_args ${local_addr} < "$sinfail" > "$sout" &
> > +					$extra_srv_args "::" < "$sinfail" > "$sout" &
> >  	else
> >  		timeout ${timeout_test} \
> >  			ip netns exec ${listener_ns} \
> >  				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> > -					$extra_srv_args ${local_addr} < "$sin" > "$sout" &
> > +					$extra_srv_args "::" < "$sin" > "$sout" &
> >  	fi
> >  	local spid=$!
> >  
> > @@ -2448,6 +2441,45 @@ v4mapped_tests()
> >  	fi
> >  }
> >  
> > +mixed_tests()
> > +{
> > +	# subflow IPv4-mapped to IPv4-mapped
> 
> (small detail: the comment is not adapted. I can remove it when applying
> the patch if no other modifications are needed. Same just below, the
> next test)
> 
> > +	if reset "simult IPv4 and IPv6 subflows, first is IPv4"; then
> > +		pm_nl_set_limits $ns1 0 1
> > +		pm_nl_set_limits $ns2 1 1
> > +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> > +		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> 
> (linked to my question from patch 1/3)
> 
> If I'm not mistaken, by default, mptcp_connect will create an MPTCP
> socket with AF_INET family if the initial destination is an IPv4
> address, no?
> Here should we not try to connect to ::ffff:10.0.1.1 instead (or pass -6
> option? Maybe not enough)?
> 
> Also, I guess we should have an extra test to make sure a v4 only
> sockets is not allowing extra subflows in v6, no?
> 
> > +		chk_join_nr 1 1 1
> > +	fi
> > +
> > +	# subflow IPv4-mapped to IPv4-mapped
> > +	if reset "simult IPv4 and IPv6 subflows, first is IPv6"; then
> > +		pm_nl_set_limits $ns1 0 1
> > +		pm_nl_set_limits $ns2 1 1
> > +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
> > +		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
> 
> Linked to the previous question: that makes me think we properly don't
> propagate the IPV6_V6ONLY socket option (sk_ipv6only) to new subflows
> (just before the connect). Now that we can connect to v4 addresses, it
> might be an issue. Easy to fix with this I guess:
> 
> --------------------- 8< ---------------------
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index 582ed93bcc8a..9986681aaf40 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -1255,6 +1255,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> >         ssk->sk_priority = sk->sk_priority;
> >         ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
> >         ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
> > +       ssk->sk_ipv6only = sk->sk_ipv6only;
> >         __ip_sock_set_tos(ssk, inet_sk(sk)->tos);
> >  
> >         if (sk->sk_userlocks & tx_rx_locks) {
> --------------------- 8< ---------------------
> 
> (+ a test checking that for v6 only socket as well I suppose)

This is an unrelated patch. Additionally, I think sk_ipv6only on
subflow other then the first one is not needed, as we already match
carefully the sk family and address family (we create ipv6 subflow for
ipv6 addr)

> > +		chk_join_nr 1 1 1
> > +	fi
> > +
> > +	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
> > +		pm_nl_set_limits $ns1 0 4
> > +		pm_nl_set_limits $ns2 1 4
> 
> Does the limit here mean 1 subflow or 1 extra subflow? (it might answer
> my question below)
> 
> > +		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
> > +		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
> > +		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
> > +		chk_join_nr 1 1 1
> 
> Why do you not have an extra subflow in IPv6 between the second IPv6 of
> ns2 (subflow,fullmesh) and the main IPV6 of the server on ns1?

becayse there is no second ipv6 address in ns2:  dead:beef:2::2 is used
as source by the first subflow (to connect towards dead:beef:2::1).

> > +	fi
> > +
> > +	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
> > +		pm_nl_set_limits $ns1 0 4
> > +		pm_nl_set_limits $ns2 2 4
> > +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> > +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> > +		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
> > +		chk_join_nr 4 4 4
> 
> Why do you have so many subflows here? The client has one IPv6 and the
> server 2, no?

Here the client has 2 IPv6 addresses: dead:beef:1::2 and the one added
by the 'fullmesh_1' argument (dead:beef:3::2, IIRC).

/P

