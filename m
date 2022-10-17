Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB2E4699
	for <mptcp@lists.linux.dev>; Mon, 17 Oct 2022 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666027802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTH43r+gE6xxQ1iUCWv+eOe9EbXsx9r4FomMXQa1kXQ=;
	b=HHUh00u8YZ/pKDjzb6JLRYnXOnJRt1xHZS2ixnSNhay/Pv/pfu5dkLTd40ewp0HnP1hYUX
	Yuox0zwnWp+7tz2gz8+bn5e4HPuxdj4bM7pEZUVrnhgVdPGVmnpZMLlnFJCMtzgtOgxmMZ
	FYmDOmq9YepMorbHxOfyg6zNcz/Pt6g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-fGECJUPPMOWREkksKY0j-w-1; Mon, 17 Oct 2022 13:30:00 -0400
X-MC-Unique: fGECJUPPMOWREkksKY0j-w-1
Received: by mail-qt1-f199.google.com with SMTP id u11-20020a05622a198b00b0039cca1826c8so8867655qtc.11
        for <mptcp@lists.linux.dev>; Mon, 17 Oct 2022 10:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTH43r+gE6xxQ1iUCWv+eOe9EbXsx9r4FomMXQa1kXQ=;
        b=5x3ogd/QEYpLTsPL11b7x/TcqFWLdRGnJBURpD9DwLEYS0AVkXHaRoM95VSHn04j+S
         v+B4FUCkU7UDjqG9gqSM2NJu9FSd3C8nFmPMD0s3Fw4Eiqr8zpyDTmMDEgtYnaoNPQX/
         UlBmT4QrlvHomFPVB3NhTM0oxaoF5M0M3qz7GTuLuC+4ZMPOy0XGK4CFZA5IOz26PG4n
         L0z84Gc6Afn+PJSmV42PE2ajOv4n+O5MO9Y9okwncUMhXNFt/hCbkVJjYSRIiGDjOCCL
         CPn8H7P7nHncRZ2vTScmx4j8TztgH4k4zv50so8gorAWz2U9//S4SeNt+oEpUPdl4JAR
         X/Mg==
X-Gm-Message-State: ACrzQf3tL+gZ94WFVmfhB5cq97KZ9jKjUEOkWAn9VGsKKgYLf1ZROYXs
	aENmUPHN3ZyfgpIOB4m95E/KYP0g/lEVHHzLI5lbUpdCKAEhE9NDSNRuHhpI6/FP4czYl7AJ4dm
	X2Lk+TMoTlUxygZA=
X-Received: by 2002:a05:622a:51:b0:39a:3854:5a34 with SMTP id y17-20020a05622a005100b0039a38545a34mr9742068qtw.143.1666027799914;
        Mon, 17 Oct 2022 10:29:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7oxTEKm8SXpk2ElfNr54iCEflnZX0t2G+SDzA1j3O32lR2eswlep05S9FQQw9aldT94bencw==
X-Received: by 2002:a05:622a:51:b0:39a:3854:5a34 with SMTP id y17-20020a05622a005100b0039a38545a34mr9742038qtw.143.1666027799578;
        Mon, 17 Oct 2022 10:29:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id ay16-20020a05620a179000b006ee96d82188sm293153qkb.1.2022.10.17.10.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:29:59 -0700 (PDT)
Message-ID: <5bb5893162902b8c86cdf7a42af715a1b3631472.camel@redhat.com>
Subject: Re: [RFC PATCH] selftests: mptcp: set test-case parameters
 consistently
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Mon, 17 Oct 2022 19:29:57 +0200
In-Reply-To: <3d92e0ca-46dc-816f-87b2-17c32cd8993f@tessares.net>
References: <2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com>
	 <3d92e0ca-46dc-816f-87b2-17c32cd8993f@tessares.net>
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
Content-Transfer-Encoding: 8bit

On Mon, 2022-10-17 at 15:35 +0200, Matthieu Baerts wrote:
> On 14/10/2022 22:39, Paolo Abeni wrote:
> > The mptcp_join test-cases depend on several parameters. The caller
> > provide most of them as command line arguments for the main test
> > function. That makes the test-cases are do read.
> > 
> > Additionally we sometimes need to add more parameters, which currently
> > is currently error prone and makes the test-cases even more hard to
> > follow.
> > 
> > Refactor the infrastructure to pass test-case parameters as enviromental
> > variables, and update all the existing tests accordingly.
> 
> Thank you for this refactoring!
> 
> I have a few questions, please see below:
> 
> > Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 342 +++++++++++-------
> >  1 file changed, 215 insertions(+), 127 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index f3dd5f2a0272..4d1af42cb749 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -35,8 +35,6 @@ TEST_COUNT=0
> >  TEST_NAME=""
> >  nr_blank=40
> >  
> > -export FAILING_LINKS=""
> > -
> >  # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
> >  #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
> >  CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
> > @@ -80,7 +78,6 @@ init_partial()
> >  
> >  	check_invert=0
> >  	validate_checksum=$checksum
> > -	FAILING_LINKS=""
> >  
> >  	#  ns1         ns2
> >  	# ns1eth1    ns2eth1
> > @@ -393,13 +390,13 @@ link_failure()
> >  {
> >  	local ns="$1"
> >  
> > -	if [ -z "$FAILING_LINKS" ]; then
> > +	if [ -z "$failing_links" ]; then
> >  		l=$((RANDOM%4))
> 
> Not related to your modification but 'l' should be local here. Or we
> remove 'l':
> 
>   failing_links=$((RANDOM % 4 + 1))
> 
> > -		FAILING_LINKS=$((l+1))
> > +		failing_links=$((l+1))
> >  	fi
> >  
> >  	local l
> > -	for l in $FAILING_LINKS; do
> > +	for l in $failing_links; do
> >  		local veth="ns1eth$l"
> >  		ip -net "$ns" link set "$veth" down
> >  	done
> > @@ -663,11 +660,6 @@ do_transfer()
> >  	local cl_proto="$3"
> >  	local srv_proto="$4"
> >  	local connect_addr="$5"
> > -	local test_link_fail="$6"
> > -	local addr_nr_ns1="$7"
> > -	local addr_nr_ns2="$8"
> > -	local speed="$9"
> > -	local sflags="${10}"
> >  
> >  	local port=$((10000 + TEST_COUNT - 1))
> >  	local cappid
> > @@ -677,6 +669,12 @@ do_transfer()
> >  	local evts_ns2
> >  	local evts_ns2_pid
> >  
> > +	link_fail="${link_fail:-0}"
> > +	file_size="${file_size:-0}"
> > +	addr_nr_ns1="${addr_nr_ns1:-0}"
> > +	addr_nr_ns2="${addr_nr_ns2:-0}"
> > +	speed="${speed:-fast}"
> 
> It is not needed to have the rest working as it is now but may you
> declare them as "local" please?
> 
> Without this keyword, it is a bit confusing to me: I initially thought
> that if a test was setting one of them (e.g. link_fail=42), all the next
> tests would inherit this value. But no because if you declare a variable
> just for one function (link_fail=42 run_test (...)), the scope is
> limited to the execution of this function. The variables here that are
> not set will be defined with a global scope to their default value (e.g.
> link_fail=0) but that's fine because it is the default value (but it is
> confusing you have different scopes :) )
> 
> Still, if other functions use the same variable names, we might have
> some clashes. Safer to declare them as "local" I think.

Yup, I will do.

> > +
> >  	:> "$cout"
> >  	:> "$sout"
> >  	:> "$capout"
> > @@ -721,30 +719,30 @@ do_transfer()
> >  	local extra_cl_args=""
> >  	local extra_srv_args=""
> >  	local trunc_size=""
> > -	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
> > -		if [ ${test_link_fail} -le 1 ]; then
> > -			echo "fastclose tests need test_link_fail argument"
> > +	if [[ -n "${fastclose}" ]]; then
> > +		if [ ${file_size} -eq 0 ]; then
> > +			echo "fastclose tests need file_size argument"
> >  			fail_test
> >  			return 1
> >  		fi
> >  
> >  		# disconnect
> > -		trunc_size=${test_link_fail}
> > -		local side=${addr_nr_ns2:10}
> > +		trunc_size=${file_size}
> >  
> > -		if [ ${side} = "client" ]; then
> > -			extra_cl_args="-f ${test_link_fail}"
> > +		if [ ${fastclose} = "client" ]; then
> > +			extra_cl_args="-f ${file_size}"
> >  			extra_srv_args="-f -1"
> > -		elif [ ${side} = "server" ]; then
> > -			extra_srv_args="-f ${test_link_fail}"
> > +		elif [ ${fastclose} = "server" ]; then
> > +			extra_srv_args="-f ${file_size}"
> >  			extra_cl_args="-f -1"
> >  		else
> > -			echo "wrong/unknown fastclose spec ${side}"
> > +			echo "wrong/unknown fastclose spec ${fastclose}"
> >  			fail_test
> >  			return 1
> >  		fi
> > -		addr_nr_ns2=0
> > -	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
> > +	fi
> > +
> > +	if [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
> 
> Should this be re-factored as well?
> 
>     userspace=1    \
>     addr_nr_ns2=1  \
>         run_tests (...)

> 
> Same for fullmesh below? And when arguments are negatives?
> This is maybe quite a bit of work and maybe not needed (at least not to
> reduce the number of parameters). That can also be done later (or never
> :) ).

I thought about things, too. But the current code I think it's clear
enough and the refactor would have been significantly more invasive.

> > @@ -1024,6 +1018,7 @@ do_transfer()
> >  	fi
> >  
> >  	cat "$capout"
> > +	fail_test
> 
> Does it mean some tests were maybe failing before and we didn't catch
> that? 

Exactly. While testing intermediate version of this patch I got a few
instances where the files did not match, but the test was succesful.

This perhaps deserves a separate patch.

> > @@ -1044,26 +1039,27 @@ run_tests()
> >  	local listener_ns="$1"
> >  	local connector_ns="$2"
> >  	local connect_addr="$3"
> > -	local test_linkfail="${4:-0}"
> > -	local addr_nr_ns1="${5:-0}"
> > -	local addr_nr_ns2="${6:-0}"
> > -	local speed="${7:-fast}"
> > -	local sflags="${8:-""}"
> >  
> >  	local size
> >  
> > -	# The values above 2 are reused to make test files
> > -	# with the given sizes (KB)
> > -	if [ "$test_linkfail" -gt 2 ]; then
> > -		size=$test_linkfail
> > +	file_size="${file_size:-0}"
> > +	link_fail="${link_fail:-0}"
> 
> Can you mark these variables as "local" too please?

I will do.
 
> > @@ -1828,7 +1816,7 @@ subflows_error_tests()
> >  		pm_nl_set_limits $ns1 0 1
> >  		pm_nl_set_limits $ns2 0 1
> >  		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
> > -		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > +		speed=slow run_tests $ns1 $ns2 10.0.1.1
> 
> detail: should we always move "run_tests" to the next line to make it
> clear it is run_tests which is executed? (I don't know if it would be
> better, just an idea :) )
> 
>     speed=slow    \
>         run_tests (...)

I tried that option, but it looked unnecessary noisy. Just my opinion!


Cheers,

Paolo

