Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683032C82
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 10:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642071146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cW1Pmx3MeHzwgpEFmtSgP6i0yJgsEiqHjg8Is6BY86g=;
	b=cXCRrMmMi0fhyJd7WVKbxVdci60OqiG9Uv40KR06+Gm4k/dTOIdtL2IJCS5y07YEF5dQu1
	WqyG5u/Y8T8t4zRtYvXWRDnX6YLaUFDcvuloRiJ9vz3hcbf9/UU9sBbvDmB9BM2/o0BV22
	lmY7hrhZGy9GknzJ4R4E4DgLtZjttpQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-XIIgCrLqPH-22Fj9aqb8Vg-1; Thu, 13 Jan 2022 05:52:25 -0500
X-MC-Unique: XIIgCrLqPH-22Fj9aqb8Vg-1
Received: by mail-qt1-f197.google.com with SMTP id a14-20020aed278e000000b002c91399bf9eso28201qtd.7
        for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 02:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cW1Pmx3MeHzwgpEFmtSgP6i0yJgsEiqHjg8Is6BY86g=;
        b=bfG2oKAkbrOC2XTfhJm7Bntz0NAk+X3kHc8yPHHeW2Ltrf2RQS+sSEGXQL/MQUK98+
         Xc0YBb6t++ZUpBibbtTcbzCaXNH085U2ZCbInkn4hWdtD/TjWc763RDUIl7iD93M+pWz
         NvifWAWYkVWrz4KXUTjRXt4t/XJTlqoaBviu8xTXjVWCN+Tg2fny7U9LQtMOVJ2IKdbx
         jEHFIFNIZhgTBYNcEAxYLkP6NPw0KKKHftx1JrvITGx0pRowEhUIoPWuSaOknNNcp/Nt
         gy31EFVBiQykKVcIS2vdCLML/hU8N59nkluC+jK/zUXggPBwhOqQ5YJ5e3jkaZvRotTn
         LH+w==
X-Gm-Message-State: AOAM533y9gtHoz0vOtEyNEMilSjLa5c5waJvBAUFmKW922CJUoQ40ytw
	i4a1VwxSl31QI8PO2VskEUNm8jGjkxvNTu7kzxlfsxqW4lgpnqJLng4Fwsd/Umi2Gqnr15Xq/wO
	YiUupoEyFyf4zeps=
X-Received: by 2002:a05:6214:5288:: with SMTP id kj8mr3327045qvb.88.1642071144324;
        Thu, 13 Jan 2022 02:52:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGakihc42P44q33PJHfEzyF5/xxphR8mZscpE85+VelQuv0Vn1NhmU6ZyMOufAUb/Kc1ishQ==
X-Received: by 2002:a05:6214:5288:: with SMTP id kj8mr3327029qvb.88.1642071143999;
        Thu, 13 Jan 2022 02:52:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id y17sm1692109qkp.134.2022.01.13.02.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:52:23 -0800 (PST)
Message-ID: <06dfb6e37c6eeb34f4f9e0f23086486072e9c6ad.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable
 join tests-cases"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 13 Jan 2022 11:52:20 +0100
In-Reply-To: <20220113103534.GA16094@dhcp-10-157-36-190>
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
	 <263f77b0221bee6a9b99245e8c23f5ebafbe9137.camel@redhat.com>
	 <20220111034543.GA11026@dhcp-10-157-36-190>
	 <868181f675d5372fb202b4b81be690a8572988ec.camel@redhat.com>
	 <20220113103534.GA16094@dhcp-10-157-36-190>
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
Content-Transfer-Encoding: 8bit

On Thu, 2022-01-13 at 18:35 +0800, Geliang Tang wrote:
> On Tue, Jan 11, 2022 at 01:02:15PM +0100, Paolo Abeni wrote:
> > On Tue, 2022-01-11 at 11:45 +0800, Geliang Tang wrote:
> > > Hi Paolo,
> > > 
> > > On Mon, Jan 10, 2022 at 12:11:38PM +0100, Paolo Abeni wrote:
> > > > Hello,
> > > > 
> > > > On Fri, 2022-01-07 at 17:51 +0800, Geliang Tang wrote:
> > > > > IPv6 removing test failed on my test every time, this patch fixed it.
> > > > > 
> > > > > 12 remove subflow and signal IPv6       syn[ ok ] - synack[fail] got 1 JOIN[s] synack expected 2
> > > > >  - ack[fail] got 1 JOIN[s] ack expected 2
> > > > > Server ns stats
> > > > > TcpPassiveOpens                 2                  0.0
> > > > > TcpAttemptFails                 1                  0.0
> > > > > TcpInSegs                       54                 0.0
> > > > > TcpOutSegs                      58                 0.0
> > > > > TcpRetransSegs                  2                  0.0
> > > > > TcpExtEmbryonicRsts             1                  0.0
> > > > > TcpExtDelayedACKs               15                 0.0
> > > > > TcpExtTCPPureAcks               23                 0.0
> > > > > TcpExtTCPTimeouts               1                  0.0
> > > > > TcpExtTCPSynRetrans             2                  0.0
> > > > > TcpExtTCPOrigDataSent           24                 0.0
> > > > > TcpExtTCPDelivered              24                 0.0
> > > > > MPTcpExtMPCapableSYNRX          1                  0.0
> > > > > MPTcpExtMPCapableACKRX          1                  0.0
> > > > > MPTcpExtMPJoinSynRx             2                  0.0
> > > > > MPTcpExtMPJoinAckRx             1                  0.0
> > > > > MPTcpExtEchoAdd                 1                  0.0
> > > > > MPTcpExtRmSubflow               1                  0.0
> > > > > Client ns stats
> > > > > TcpActiveOpens                  3                  0.0
> > > > > TcpInSegs                       58                 0.0
> > > > > TcpOutSegs                      53                 0.0
> > > > > TcpRetransSegs                  1                  0.0
> > > > > TcpOutRsts                      3                  0.0
> > > > > TcpExtDelayedACKs               3                  0.0
> > > > > TcpExtTCPPureAcks               29                 0.0
> > > > > TcpExtTCPTimeouts               1                  0.0
> > > > > TcpExtTCPSynRetrans             1                  0.0
> > > > > TcpExtTCPOrigDataSent           24                 0.0
> > > > > TcpExtTCPDelivered              26                 0.0
> > > > > TcpExtTcpTimeoutRehash          1                  0.0
> > > > > MPTcpExtMPCapableSYNTX          1                  0.0
> > > > > MPTcpExtMPCapableSYNACKRX       1                  0.0
> > > > > MPTcpExtMPJoinSynAckRx          1                  0.0
> > > > > MPTcpExtAddAddr                 1                  0.0
> > > > > MPTcpExtRmAddr                  1                  0.0
> > > > > MPTcpExtRmSubflow               1                  0.0
> > > > >                                         add[ ok ] - echo  [ ok ]
> > > > >                                         rm [fail] got 0 RM_ADDR[s] expected 1
> > > > >  - sf    [ ok ]
> > > > > Server ns stats
> > > > > TcpPassiveOpens                 2                  0.0
> > > > > TcpAttemptFails                 1                  0.0
> > > > > TcpInSegs                       54                 0.0
> > > > > TcpOutSegs                      58                 0.0
> > > > > TcpRetransSegs                  2                  0.0
> > > > > TcpExtEmbryonicRsts             1                  0.0
> > > > > 
> > > > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > > > ---
> > > > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > index e48ce23d2386..41a2510e2f97 100755
> > > > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > @@ -393,8 +393,8 @@ do_transfer()
> > > > >  				do
> > > > >  					id=${dump[$pos]}
> > > > >  					rm_addr=$(rm_addr_count ${connector_ns})
> > > > > -					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> > > > >  					wait_rm_addr ${connector_ns} ${rm_addr}
> > > > > +					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> > > > >  					let counter+=1
> > > > >  					let pos+=5
> > > > 
> > > > Uhmm.... this is equivalent to replacing 'wait_rm_addr()' with 'sleep
> > > > 1'. It defeats the purpouse of wait_rm_addr itself: reducing the delay
> > > > required for 'del address' related operation. Additionally, an
> > > > unconditional 'sleep 1' could impact negatively in other test-cases.
> > > > 
> > > > Possibly some alike:
> > > > 
> > > > ---
> > > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > index e48ce23d2386..b209a303d1fe 100755
> > > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > @@ -366,7 +366,7 @@ do_transfer()
> > > >  
> > > >         # let the mptcp subflow be established in background before
> > > >         # do endpoint manipulation
> > > > -       [ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
> > > > +       [ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 2
> > > >  
> > > >         if [ $addr_nr_ns1 -gt 0 ]; then
> > > >                 let add_nr_ns1=addr_nr_ns1
> > > > ---
> > > 
> > > This patch doesn't work on my test either. I changed it to "sleep 2",
> > > the "remove subflow and signal IPv6" test still failed.
> > > 
> > > > 
> > > > could be more appropriate, but 2secs to complete MPC + 2 MPJ HS looks
> > > > really too much...
> > > > 
> > > > Can you please capture a pcap trace with the failing test?
> > > 
> > > The pcap is attached.
> > 
> > Thank you! 
> > 
> > I'm really fail to understand why that happens, but the server replies
> > to the subflow endpoint MPJ syn with more than 1s delay, and that
> > causes the failure.
> > 
> > The interesting part is that the ipv6 routing configuration is actually
> > broken, as we lack an ipv6 route for the server on each link. The
> > following addresses the issue here, but I don't see how things were
> > somewhat working so far...
> > 
> > ---
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index e48ce23d2386..cdfb7da47384 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -76,6 +76,7 @@ init()
> >  
> >  		# let $ns2 reach any $ns1 address from any interface
> >  		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
> > +		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
> >  	done
> >  }
> >  
> > @@ -1545,7 +1546,7 @@ ipv6_tests()
> >  	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> >  	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> >  	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > -	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > +	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subflow
> >  	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> >  	chk_join_nr "remove subflow and signal IPv6" 2 2 2
> >  	chk_add_nr 1 1
> > ---
> 
> Hi Paolo,
> 
> This patch works on my test. Should we change this "single subflow IPv6" test too?

In theory, yes...
> 
> ---
> 
> @@ -1654,7 +1655,7 @@ ipv6_tests()
>         reset
>         pm_nl_set_limits $ns1 0 1
>         pm_nl_set_limits $ns2 0 1
> -       pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
> +       pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
>         run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
>         chk_join_nr "single subflow IPv6" 1 1 1
> 
> ---
> 
> This "single subflow IPv6" test passes every time with or without this
> change, 

... in pratice, as you noted, it's not needed.

> but the "remove subflow and signal IPv6" test fails. What's the
> difference between the two tests?

I'm wild guessing, as I still fail to understand the full picture
completely. In the "single subflow IPv6" test, is irrelevant if the
additional subflow uses the "wrong" interface, because we just need to
establish it.

In the "remove subflow and signal IPv6" we have additional time
constrains due to multiple subflow creation and removal, and the wrong
routing setup causes the large delay I mentioned before, ence the
failure.

I'm very suprised the wrong routing setup casues a delay instead of an
unreachable error and that puzzle me much. 

Do you prefer sending a new version of the squash-to patch, or do you
prefer I'll go ahead with that?

Please, let me know,

/P

