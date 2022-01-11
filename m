Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E922C9D
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641902540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPp8jp+Xm8CZgBHUbK6ZR0cEMcimGE4sXDZSX45tCUM=;
	b=aM2ikMeY0qn64BMP6vQYcleOtMUfxQ8PaPT+gM4qOV5o86ivXrK2W8VtGiQm1Jhy5IRFx1
	9HPorWaNJt9vSNWivUrAc9joF671Zt8qTcCj7vx2NVECMeU1TeGZRNnprQx9d9eeUnnTuo
	C2+G5vziedKrG+ISrtQsQfLzLjACLlw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-HXOwyj0eOEeHF-JmAB6m6A-1; Tue, 11 Jan 2022 07:02:19 -0500
X-MC-Unique: HXOwyj0eOEeHF-JmAB6m6A-1
Received: by mail-qt1-f197.google.com with SMTP id m15-20020aed27cf000000b002c3def3eefdso13030593qtg.21
        for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 04:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qPp8jp+Xm8CZgBHUbK6ZR0cEMcimGE4sXDZSX45tCUM=;
        b=PTD+/xAgbkEy0StTCBNeWIDIx45ylpDLOLMHmWNffglWO2Ho7/sM3MUORIw6RcK5f6
         ky5RKFbrejSjYjM0B1/YxXkgf3IJVz2ZDax6sffkfmpbb3SJazlCYJ/P9dher/AKQ75c
         Rm+VgTbAMbjqQtVSbdd4Sxrjxrx8Mq9ErtIV3NZvPA88IT3b3r7db5+vyURvIU9SY4WD
         WJJwHl7pEoBF7ohs75/qxSmOg0pJnM1nsXYukEaYYkHJ4Qqwn1Uh0lMyg1AMKtc2iWU3
         4g/sAn7oVfGFm5hf7mJSvo34UkvszvNoMI6xqiHjagVGGvsWhvRFq/SVQm3NHCsqlWFw
         gxlw==
X-Gm-Message-State: AOAM530jiDIJz0SSDGeGOIm66csjaPiHPrNVjAbtHHUHQrB/+xvY6VoC
	8GlgAI5fhR7roZXOd4QAxGhBB6moqp1cUdIN3KLxreNO5wnJy4cLHJAaPrztLO1KLEhVLF2QDYw
	7ZPVBikBpncDoaxI=
X-Received: by 2002:ac8:7d83:: with SMTP id c3mr3311544qtd.607.1641902538928;
        Tue, 11 Jan 2022 04:02:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6gGWY4fc9zY5zevR+/PPDrrYQc+7Y9+f9sZA2GH+FTsUoQ1mmim3ZlSDLlZi1Jv0K1f2NyA==
X-Received: by 2002:ac8:7d83:: with SMTP id c3mr3311517qtd.607.1641902538636;
        Tue, 11 Jan 2022 04:02:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id a16sm6480060qta.13.2022.01.11.04.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 04:02:18 -0800 (PST)
Message-ID: <868181f675d5372fb202b4b81be690a8572988ec.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable
 join tests-cases"
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 11 Jan 2022 13:02:15 +0100
In-Reply-To: <20220111034543.GA11026@dhcp-10-157-36-190>
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
	 <263f77b0221bee6a9b99245e8c23f5ebafbe9137.camel@redhat.com>
	 <20220111034543.GA11026@dhcp-10-157-36-190>
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

On Tue, 2022-01-11 at 11:45 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> On Mon, Jan 10, 2022 at 12:11:38PM +0100, Paolo Abeni wrote:
> > Hello,
> > 
> > On Fri, 2022-01-07 at 17:51 +0800, Geliang Tang wrote:
> > > IPv6 removing test failed on my test every time, this patch fixed it.
> > > 
> > > 12 remove subflow and signal IPv6       syn[ ok ] - synack[fail] got 1 JOIN[s] synack expected 2
> > >  - ack[fail] got 1 JOIN[s] ack expected 2
> > > Server ns stats
> > > TcpPassiveOpens                 2                  0.0
> > > TcpAttemptFails                 1                  0.0
> > > TcpInSegs                       54                 0.0
> > > TcpOutSegs                      58                 0.0
> > > TcpRetransSegs                  2                  0.0
> > > TcpExtEmbryonicRsts             1                  0.0
> > > TcpExtDelayedACKs               15                 0.0
> > > TcpExtTCPPureAcks               23                 0.0
> > > TcpExtTCPTimeouts               1                  0.0
> > > TcpExtTCPSynRetrans             2                  0.0
> > > TcpExtTCPOrigDataSent           24                 0.0
> > > TcpExtTCPDelivered              24                 0.0
> > > MPTcpExtMPCapableSYNRX          1                  0.0
> > > MPTcpExtMPCapableACKRX          1                  0.0
> > > MPTcpExtMPJoinSynRx             2                  0.0
> > > MPTcpExtMPJoinAckRx             1                  0.0
> > > MPTcpExtEchoAdd                 1                  0.0
> > > MPTcpExtRmSubflow               1                  0.0
> > > Client ns stats
> > > TcpActiveOpens                  3                  0.0
> > > TcpInSegs                       58                 0.0
> > > TcpOutSegs                      53                 0.0
> > > TcpRetransSegs                  1                  0.0
> > > TcpOutRsts                      3                  0.0
> > > TcpExtDelayedACKs               3                  0.0
> > > TcpExtTCPPureAcks               29                 0.0
> > > TcpExtTCPTimeouts               1                  0.0
> > > TcpExtTCPSynRetrans             1                  0.0
> > > TcpExtTCPOrigDataSent           24                 0.0
> > > TcpExtTCPDelivered              26                 0.0
> > > TcpExtTcpTimeoutRehash          1                  0.0
> > > MPTcpExtMPCapableSYNTX          1                  0.0
> > > MPTcpExtMPCapableSYNACKRX       1                  0.0
> > > MPTcpExtMPJoinSynAckRx          1                  0.0
> > > MPTcpExtAddAddr                 1                  0.0
> > > MPTcpExtRmAddr                  1                  0.0
> > > MPTcpExtRmSubflow               1                  0.0
> > >                                         add[ ok ] - echo  [ ok ]
> > >                                         rm [fail] got 0 RM_ADDR[s] expected 1
> > >  - sf    [ ok ]
> > > Server ns stats
> > > TcpPassiveOpens                 2                  0.0
> > > TcpAttemptFails                 1                  0.0
> > > TcpInSegs                       54                 0.0
> > > TcpOutSegs                      58                 0.0
> > > TcpRetransSegs                  2                  0.0
> > > TcpExtEmbryonicRsts             1                  0.0
> > > 
> > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > index e48ce23d2386..41a2510e2f97 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -393,8 +393,8 @@ do_transfer()
> > >  				do
> > >  					id=${dump[$pos]}
> > >  					rm_addr=$(rm_addr_count ${connector_ns})
> > > -					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> > >  					wait_rm_addr ${connector_ns} ${rm_addr}
> > > +					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> > >  					let counter+=1
> > >  					let pos+=5
> > 
> > Uhmm.... this is equivalent to replacing 'wait_rm_addr()' with 'sleep
> > 1'. It defeats the purpouse of wait_rm_addr itself: reducing the delay
> > required for 'del address' related operation. Additionally, an
> > unconditional 'sleep 1' could impact negatively in other test-cases.
> > 
> > Possibly some alike:
> > 
> > ---
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index e48ce23d2386..b209a303d1fe 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -366,7 +366,7 @@ do_transfer()
> >  
> >         # let the mptcp subflow be established in background before
> >         # do endpoint manipulation
> > -       [ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
> > +       [ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 2
> >  
> >         if [ $addr_nr_ns1 -gt 0 ]; then
> >                 let add_nr_ns1=addr_nr_ns1
> > ---
> 
> This patch doesn't work on my test either. I changed it to "sleep 2",
> the "remove subflow and signal IPv6" test still failed.
> 
> > 
> > could be more appropriate, but 2secs to complete MPC + 2 MPJ HS looks
> > really too much...
> > 
> > Can you please capture a pcap trace with the failing test?
> 
> The pcap is attached.

Thank you! 

I'm really fail to understand why that happens, but the server replies
to the subflow endpoint MPJ syn with more than 1s delay, and that
causes the failure.

The interesting part is that the ipv6 routing configuration is actually
broken, as we lack an ipv6 route for the server on each link. The
following addresses the issue here, but I don't see how things were
somewhat working so far...

---
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..cdfb7da47384 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -76,6 +76,7 @@ init()
 
 		# let $ns2 reach any $ns1 address from any interface
 		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
+		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
 	done
 }
 
@@ -1545,7 +1546,7 @@ ipv6_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
 	chk_add_nr 1 1
---
/P

