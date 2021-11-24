Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C968
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637748663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKdWXp0h/l/7Qm0sf1iuEefpFBqpNeigWVKwXjAp0yI=;
	b=Nwv8D1+FuWPAZ21jbphWFNyowZiiwcvQM8q/X23LKBLAbbqTbH1w3EpTXJvuuYtEefVEzF
	Ak+yFLZyQS5BHg8mrXPquEQi2cDirUOOZHMxdMJFJwPZ49lezVpJ+x9h0rrV12s+up9PPv
	b35QrKSE/pFVbjD5o5Nj2YkX+wCmV0o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-432-T_ozMhqPPl6rB90xL1dzlg-1; Wed, 24 Nov 2021 05:11:01 -0500
X-MC-Unique: T_ozMhqPPl6rB90xL1dzlg-1
Received: by mail-wm1-f72.google.com with SMTP id j193-20020a1c23ca000000b003306ae8bfb7so1067334wmj.7
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 02:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QKdWXp0h/l/7Qm0sf1iuEefpFBqpNeigWVKwXjAp0yI=;
        b=bJazWQHKWunA4jnQcABfvf/WZOLKuKxWBWBKJKTKYz0nNSsIUQb18UykPmUmGlLnDN
         OBYyIDfpuB7ZAKHBdR0nKq3NXhI8z7dBHmoye9iPa2zS554UtcEvClt5YmKi143RaTf8
         9whbOcUE1o4IKUknQqEEB2zIulNvd38iiBOYKPjluRIu7S+A2J/yPCNGKMyeLjhs6Pcg
         AF0f6O/hAwcc+Wq5/nFvLbPj5D7K5+PBiLMQLQtfiHhjLCeHVP/b01Qe5UqFWoSS4++3
         kcGsjbIoYF4uASvjAFacF0ufyh46wOZmBeCScLzYrij6Bi+dXbVrCP0mq6kGEaJY8TeO
         uthQ==
X-Gm-Message-State: AOAM533d6a8ECSZSXe82G43u7i5Pojs5lCvgxNJapXLW2JNS8q6rGA4T
	o7SYydTA0018vPZAcEf79F6wqXg1bdoOgacwmZVFv3z1cTplTjD7kUKTYc+KBj2KclJVawpTnwM
	DS4h91Yb5X6evDHI=
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr17161054wrq.161.1637748660438;
        Wed, 24 Nov 2021 02:11:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdM1WWXrpqalPimYsTlVLB0cVe+ASShRVo+Yl4Cfhbk5piepnxuMaKhi2LoXMvNN1HTyG2Pw==
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr17161026wrq.161.1637748660239;
        Wed, 24 Nov 2021 02:11:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id p62sm4050455wmp.10.2021.11.24.02.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 02:11:00 -0800 (PST)
Message-ID: <a10382334ba560c868e1284591d62ca0ae66a6b5.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add tests for subflow
 creation failure
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Phil Greenland <phil@quantulum.co.uk>
Date: Wed, 24 Nov 2021 11:10:59 +0100
In-Reply-To: <18e9514a-7cd1-97b7-9ebc-901f89f76612@tessares.net>
References: <cover.1637684792.git.pabeni@redhat.com>
	 <425cdb61dc939d86534843617150634869778909.1637684792.git.pabeni@redhat.com>
	 <18e9514a-7cd1-97b7-9ebc-901f89f76612@tessares.net>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Wed, 2021-11-24 at 10:56 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 23/11/2021 17:37, Paolo Abeni wrote:
> > Verify that, when multiple endpoints are available, subflows
> > creation proceed even when the first additional subflow creation
> > fails - due to packet drop on the relevant link
> 
> Here you don't drop the packet but you reset it. Should we have a test
> for both (REJECT/DROP) (or with an additional subflow where packets are
> dropped)?

I'll try to see if a drop test case will fit our infra. 

> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 2684ef9c0d42..dd4488746151 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -1023,6 +1023,16 @@ subflows_tests()
> >  	run_tests $ns1 $ns2 10.0.1.1
> >  	chk_join_nr "multiple subflows, limited by server" 2 2 1
> >  
> > +	# multiple subflows, with subflow creation error
> > +	reset
> > +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > +	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> 
> I guess we should then add "CONFIG_IP_NF_TARGET_REJECT" in the config
> file :)

Will add in v2.

Thanks!

Paolo

