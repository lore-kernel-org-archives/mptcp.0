Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422E173
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639482995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jq0BI+cSQjpKQ93cFbLJpzPazjOcdI++u9hZ6Sv/N6Q=;
	b=HKMFhtRZY0mwkvs7aIKCn+B+Q9HNM3Fo6iZkw5zS7YT1NMgo21lonFATEJq3PdZQ5+jSRU
	rgWEV0UvKYgIz6eFHvMeOfbaOnCx9DSmxxlB2QanKoPTdB/fitoBpNb8RPeGU/X4/giGX8
	XvUSDfYfKcOo7g/nq6mdu+mNd4uXdGg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-6t4QmCbENx2G8tu4-zHlRg-1; Tue, 14 Dec 2021 06:56:34 -0500
X-MC-Unique: 6t4QmCbENx2G8tu4-zHlRg-1
Received: by mail-wm1-f69.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso7826494wms.0
        for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 03:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Jq0BI+cSQjpKQ93cFbLJpzPazjOcdI++u9hZ6Sv/N6Q=;
        b=orIhYqJ5QOwKMMdXCDq5d5ZiVBrsC3SoV5EEg9fNyZnSdTLZ4NN09SquX3D50x+W26
         sY8rd8nLwAsmcU4T+eHeTAO8Y5UNH9s41A9VGGMwXy5wdQjPsrKG+bk8agwS3W8f/Neg
         +ejm8Qsf7yz6P02XWWuTojqxFtxzUsdAWF6pHvxL/3zSyo6yAF3MEEQhjY/Nx0RCI97Q
         KqRsEyGNgqExF3+I1pA81R0g629asP/3Zw2P9ijmHNLG+PMlso3AKzSftF5xozGBgqlM
         8YnJ1WHvJ07NKstz3tfhDQHud1BoMMKnlFyXiC12NiUgFCk2MCS+zQ3o94S99E5v7YO7
         ixJA==
X-Gm-Message-State: AOAM531cHessD67bKCHULLhZWYPngyGxnxfdrdU/iaAQ/h5s4eF5v7Ih
	OYynldp4DcNUczmCF9MYIr6N0Cu3WcVOu8eKypip8sqTPVmDXzfz1FbAWl3G8tPylsinhhbZLhG
	N3gmj7+PHZ8sCO6E=
X-Received: by 2002:a5d:4084:: with SMTP id o4mr5437283wrp.47.1639482993010;
        Tue, 14 Dec 2021 03:56:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/2phbEoTkTYq/YFxb1Jth+lmoR51XiJw3IlD07BLXlQAwI6fiIh9ERZJvpSVy0YZIdMAIQg==
X-Received: by 2002:a5d:4084:: with SMTP id o4mr5437269wrp.47.1639482992820;
        Tue, 14 Dec 2021 03:56:32 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-237-50.dyn.eolo.it. [146.241.237.50])
        by smtp.gmail.com with ESMTPSA id a1sm10881948wru.113.2021.12.14.03.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:56:32 -0800 (PST)
Message-ID: <cf3797800ec76c2bd94e248729e4e06da206d7ce.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 5/5] selftests: mptcp: add tests for
 subflow creation failure
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 14 Dec 2021 12:56:31 +0100
In-Reply-To: <e4f4f552-5c26-4a9c-9ab1-5dd2e8deb73@linux.intel.com>
References: <cover.1639070864.git.pabeni@redhat.com>
	 <bb1dc0bcbce70153d37c89969b82d3e9695acf4a.1639070864.git.pabeni@redhat.com>
	 <e4f4f552-5c26-4a9c-9ab1-5dd2e8deb73@linux.intel.com>
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

On Mon, 2021-12-13 at 15:12 -0800, Mat Martineau wrote:
> On Thu, 9 Dec 2021, Paolo Abeni wrote:
> 
> > Verify that, when multiple endpoints are available, subflows
> > creation proceed even when the first additional subflow creation
> > fails - due to packet drop on the relevant link
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v4 -> v5:
> > - new test checking for wrong MPC reuse
> > 
> > v3 -> v4:
> > - use $() where applicable - Matt
> > - fix typo in help() - Matt
> > 
> > v1 -> v2:
> > - add missing NF kconfig
> > - add more test-cases (drop, later subflow creation)
> > ---
> > tools/testing/selftests/net/mptcp/config      |  1 +
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 74 ++++++++++++++++++-
> > 2 files changed, 74 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> > index 419e71560fd1..41e94e004bdc 100644
> > --- a/tools/testing/selftests/net/mptcp/config
> > +++ b/tools/testing/selftests/net/mptcp/config
> > @@ -18,4 +18,5 @@ CONFIG_NFT_TPROXY=m
> > CONFIG_NFT_SOCKET=m
> > CONFIG_IP_ADVANCED_ROUTER=y
> > CONFIG_IP_MULTIPLE_TABLES=y
> > +CONFIG_IP_NF_TARGET_REJECT=m
> > CONFIG_IPV6_MULTIPLE_TABLES=y
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 526b05771d08..8f49bbd4a201 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -975,6 +975,22 @@ chk_link_usage()
> > 	fi
> > }
> > 
> > +wait_for_tw()
> > +{
> > +	local timeout_ms=$((timeout_poll * 1000))
> > +	local time=0
> > +	local ns=$1
> > +
> > +	while [ $time -lt $timeout_ms ]; do
> > +		local cnt=$(ip netns exec $ns ss -t state time-wait |wc -l)
> > +
> > +		[ "$cnt" = 1 ] && return 1
> > +		time=$((time + 100))
> > +		sleep 0.1
> > +	done
> > +	return 1
> > +}
> > +
> > subflows_tests()
> > {
> > 	reset
> > @@ -1032,6 +1048,57 @@ subflows_tests()
> > 	chk_join_nr "single subflow, dev" 1 1 1
> > }
> > 
> > +subflows_error_tests()
> > +{
> > +	# If a single subflow is configured, and matches the MPC src
> > +	# address, no additional subflow should be created
> > +	reset
> > +	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
> > +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > +	chk_join_nr "no MPC address reuse with single endpoint" 0 0 0
> > +
> > +	# multiple subflows, with subflow creation error
> > +	reset
> > +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > +	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> > +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > +	chk_join_nr "multiple subflows, with failing subflow" 1 1 1
> > +
> > +	# multiple subflows, with subflow timeout on MPJ
> > +	reset
> > +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
> > +	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
> > +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> > +	chk_join_nr "multiple subflows, with subflow timeout" 1 1 1
> > +
> > +	# multiple subflows, check that the endpoint corresponding to
> > +	# closed subflow (due to reset) is not reused if additional
> > +	# subflows are added later
> > +	reset
> > +	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> > +	ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> > +	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
> > +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
> 
> Still seeing the problem I reported in v4 where the test results are not 
> correctly numbered. I think $TEST_COUNT needs to be bumped here so the 
> next results are numbered correctly.

Oh, sorry, I missed that part. I'll cover in the next iteration.

Thanks,

Paolo

