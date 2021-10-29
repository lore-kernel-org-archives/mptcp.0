Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076B72
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635518617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72KInipP3csI4csD5+koFwv2wllW8g60MS6Ov2JcEdI=;
	b=KrzFUNxnX+PviYl6pwGoRv7MbJ7+Y2D6EKiIMGgRXYx6ZVQuPWoLiCBUJfyOGe1MyeqMxO
	GltnsNYiKaa35fcpKVlBWde8sw73/pPAqVoAcNIsQIFSBWEeGHl5z3Vvcc/J/ebSir15v/
	MkyOOFk+oLMOop1yAqXBHLrN3HBfco4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-zjq-R1GwNTGppmRhG_wmfw-1; Fri, 29 Oct 2021 10:43:36 -0400
X-MC-Unique: zjq-R1GwNTGppmRhG_wmfw-1
Received: by mail-wr1-f70.google.com with SMTP id r12-20020adfdc8c000000b0017d703c07c0so143804wrj.0
        for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 07:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=72KInipP3csI4csD5+koFwv2wllW8g60MS6Ov2JcEdI=;
        b=N+aBpdYY1e9hJZgk+TAPSfURWbxtOwDMAZWyBUt9k2Zj6SHF+Kuq3OFbVGk37rtsWo
         YPsX569l5fiOgD5u6PBh3ihOEa4gZYFBItvHZlS1Zni3yswplwf2eL20YJkdwYWXWz/M
         45gsEogUWRCwO0eH87bC79eE1jRJHvJn8RKgSKRbQmBuTGB6ej/W2JiHanx4T5qXLYrp
         VoprvltyvWCnMweZ8nAdFvy6SsJdCvrnFkDDdZO6B+9Uaxo885ZBoXADyka9jLB+XwVq
         48ECyF9Zma44Msck3D1v4yTtY/zO458vV2DmSR2phumhTlw/j2rq1YK1StJHYZUD5vkw
         xhrg==
X-Gm-Message-State: AOAM532N0JUA9i3d/HTIVMI7yjy7SFLz2SzYdmX/G94rwfqa9h/3dixh
	/9S0YI/86qcuK1Hz0ZVmg/OYTSZIfiFSt+3rrCh7P3vi9e0kLRp00dHYvdbUQdt6tQ19E/P2m1b
	IKUeV7ag/F1ohx+c=
X-Received: by 2002:a5d:6351:: with SMTP id b17mr13772030wrw.151.1635518614774;
        Fri, 29 Oct 2021 07:43:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcFOS6/d0O1Tmu90JUiDS899y6JLSmAnR7ca8+PnxoLgJQoDRokjwKTOY43979VIddFH0zXg==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr13771996wrw.151.1635518614457;
        Fri, 29 Oct 2021 07:43:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-86.dyn.eolo.it. [146.241.240.86])
        by smtp.gmail.com with ESMTPSA id d24sm5147026wmb.35.2021.10.29.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 07:43:34 -0700 (PDT)
Message-ID: <62321b89a616b27bd9bd2eaf2a38e7f91f56cb55.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail
 testcases
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Fri, 29 Oct 2021 16:43:32 +0200
In-Reply-To: <20211029132155.GA4144@bogon>
References: <cover.1635481641.git.geliang.tang@suse.com>
	 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
	 <04774993-d824-0f62-c55d-bd21e46b99fb@tessares.net>
	 <20211029132155.GA4144@bogon>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Fri, 2021-10-29 at 21:21 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, Oct 29, 2021 at 12:02:47PM +0200, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > Thank you for the new version.
> > 
> > On 29/10/2021 06:40, Geliang Tang wrote:
> > > Added the test cases for MP_FAIL, use 'tc' command to trigger the
> > > checksum failure.
> > > 
> > > Suggested-by: Davide Caratti <dcaratti@redhat.com>
> > > Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > ---
> > >  tools/testing/selftests/net/mptcp/config      |  5 ++
> > >  .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
> > >  2 files changed, 72 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> > > index 0faaccd21447..f522288b2204 100644
> > > --- a/tools/testing/selftests/net/mptcp/config
> > > +++ b/tools/testing/selftests/net/mptcp/config
> > > @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
> > >  CONFIG_NETFILTER_XT_MATCH_BPF=m
> > >  CONFIG_NF_TABLES_IPV4=y
> > >  CONFIG_NF_TABLES_IPV6=y
> > > +CONFIG_NET_ACT_CSUM=m
> > > +CONFIG_NET_ACT_PEDIT=m
> > > +CONFIG_NET_CLS_ACT=m
> > > +CONFIG_NET_CLS_FLOWER=m
> > > +CONFIG_NET_SCH_INGRESS=m
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > index 2684ef9c0d42..d33cb5ce0ff3 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
> > >  	exit $ksft_skip
> > >  fi
> > >  
> > > +jq -V > /dev/null 2>&1
> > > +if [ $? -ne 0 ];then
> > > +	echo "SKIP: Could not run all tests without jq tool"
> > > +	exit $ksft_skip
> > > +fi
> > > +
> > >  print_file_err()
> > >  {
> > >  	ls -l "$1" 1>&2
> > > @@ -232,6 +238,28 @@ link_failure()
> > >  	done
> > >  }
> > >  
> > > +checksum_failure()
> > > +{
> > > +	i="$1"
> > > +
> > > +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> > > +	tc -n $ns2 filter add dev ns2eth$i egress \
> > > +		protocol ip prio 1000 \
> > > +		flower ip_proto tcp \
> > > +		action pedit munge offset 148 u32 invert \
> > > +		pipe csum tcp \
> > > +		index 100
> > > +
> > > +	while true; do
> > > +		local pkt=$(tc -n $ns2 -j -s action show action csum index 100 |
> > > +				jq '.[1].actions[0].stats.packets')
> > > +		if [ $pkt -gt 0 ]; then
> > The CI [1] is complaining about that line:
> > 
> > [09:34:44.063] # RTNETLINK answers: Operation not supported
> > [09:34:44.107] # ./mptcp_join.sh: line 256: [: null: integer expression
> > expected
> > [09:34:44.267] # RTNETLINK answers: Operation not supported
> > [09:34:44.332] # ./mptcp_join.sh: line 256: [: null: integer expression
> > expected
> > (...)
> > 
> > This is displayed in a loop as it is a "while true".
> > 
> > But just before the first one, we had this:
> > 
> > [09:34:43.859] # Error: Cannot find ingress queue for specified device.
> > [09:34:43.955] # Error: Parent Qdisc doesn't exists.
> > [09:34:43.959] # We have an error talking to the kernel
> > 
> > I guess the previous "tc" command failed and I also guess you don't have
> > that on your side, right?
> 
> Yes, it works on my side.
> 
> > Maybe a missing kconfig?
> 
> I think so. How can I get the kconfig of the CI?

The need kernel config flags are correctly specified into:

tools/testing/selftests/net/mptcp/config

In this case it looks like the CI is missing/not applying:

CONFIG_NET_SCH_INGRESS=y

@Mat, does the CI take properly in account the self-tests config?

I guess:

make kselftest-merge

would fix, but could also be overkill (pulling a lot of config for
other, non mptcp self-tests)

Paolo

