Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982D2C80
	for <mptcp@lists.linux.dev>; Wed,  3 Nov 2021 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635939829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+bfkXS7IsU+7CwHWgYw9IQpsYEDDan18KAsNeWW4GKg=;
	b=iSpSmefo/Rqx4cSJPPeYjXsADeXJ2X4mXKhYOL9KDJ0V99PjieL71dHiL3v6u3zjLyO6aE
	WB7AJkaIlNP5UOjWJ8uUQGa7XRPc+wy3+Tt2qooEjj8fhxvCJ0Qe9vnK8a0a6pzqu1gNcR
	qKsUMiWxSBRXdH4xPJQn3KbBhw7+RGw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-8K3F6dsoNeeWeE6PlGXHWQ-1; Wed, 03 Nov 2021 07:43:42 -0400
X-MC-Unique: 8K3F6dsoNeeWeE6PlGXHWQ-1
Received: by mail-ed1-f71.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso2151033edj.20
        for <mptcp@lists.linux.dev>; Wed, 03 Nov 2021 04:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+bfkXS7IsU+7CwHWgYw9IQpsYEDDan18KAsNeWW4GKg=;
        b=qeVFMIkSwkwU2sdzQwXzfxsk+S1OREsfB7slTVSaDiFSUdlkFP4BKQt/QtAjrJ43x9
         GJc8GUZ6BztlibQ0zpJ3jwJakNgW5uhifXXc5YXoG0HpCICxpiUWIB8++LERH8E9ZPyi
         lEjyJYehcvrAdMntfnyG7TsGuLQtmDqz/WMrAsLRG0bPPa1ElI7IhLasGAxbBeH38AkX
         ZjtncplzGeVzCyM8KYe0GlSA3GiHx7hd0j5kYicv1qJougimn5HOK1VMkOfLKiZGhIKR
         Cu8jFu7TR6NEguKesxZcILwpWBUFsHzXMcT/bDv+EEJNUVOR1vlOzvvAUsQe63RHvH07
         MzfQ==
X-Gm-Message-State: AOAM530Q01gMd5as25sl6wI6XyuLD7nARA89L6Nv7TrIVaLLcWvpez/p
	w49V/XYyF1FtLVvABKumRqMX9cjTMCDinwXeprIKSqbH0JVjcb2oE8BVaD/5s8ghe3mKMB1912Q
	SdGRBg2/+QIZXkuU=
X-Received: by 2002:a50:d78c:: with SMTP id w12mr59816348edi.147.1635939821180;
        Wed, 03 Nov 2021 04:43:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFCdb8O9SiKwxn2uFFs0KJbmcyL4RaRY4mD2ig0hQWCwaTQOC6FDJ1Nc3u2Nh3ptcDYD9vZA==
X-Received: by 2002:a50:d78c:: with SMTP id w12mr59816301edi.147.1635939820796;
        Wed, 03 Nov 2021 04:43:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-116-40.dyn.eolo.it. [146.241.116.40])
        by smtp.gmail.com with ESMTPSA id u16sm1025163ejy.16.2021.11.03.04.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 04:43:40 -0700 (PDT)
Message-ID: <c59a50d92d0dc8b6381de96cd22883a56227f188.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] mptcp: enforce HoL-blocking estimation
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 03 Nov 2021 12:43:39 +0100
In-Reply-To: <a7127287-2a50-cd58-e82-4022ed399ad@linux.intel.com>
References: <d3477a25f27b733d33a85800713949dae0e1ea4a.1635241330.git.pabeni@redhat.com>
	 <8a4189c20285e73f1b4f51d4e442477003f40d1f.camel@redhat.com>
	 <a7127287-2a50-cd58-e82-4022ed399ad@linux.intel.com>
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

On Tue, 2021-11-02 at 18:07 -0700, Mat Martineau wrote:
> On Tue, 2 Nov 2021, Paolo Abeni wrote:
> 
> > Hello,
> > 
> > On Tue, 2021-10-26 at 11:42 +0200, Paolo Abeni wrote:
> > > The MPTCP packet scheduler has sub-optimal behavior with asymmetric
> > > subflows: if the faster subflow-level cwin is closed, the packet
> > > scheduler can enqueue "too much" data on a slower subflow.
> > > 
> > > When all the data on the faster subflow is acked, if the mptcp-level
> > > cwin is closed, and link utilization becomes suboptimal.
> > > 
> > > The solution is implementing blest-like[1] HoL-blocking estimation,
> > > transmitting only on the subflow with the shorter estimated time to
> > > flush the queued memory. If such subflows cwin is closed, we wait
> > > even if other subflows are available.
> > > 
> > > This is quite simpler than the original blest implementation, as we
> > > leverage the pacing rate provided by the TCP socket. To get a more
> > > accurate estimation for the subflow linger-time, we maintain a
> > > per-subflow weighted average of such info.
> > > 
> > > Additionally drop magic numbers usage in favor of newly defined
> > > macros and use more meaningful names for status variable.
> > > 
> > > [1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v1 -> v2:
> > >  - fix checkpatch issue (mat)
> > >  - rename ratio as linger_time (mat)
> > 
> > As this patch empirically improves the situation quite a bit, what
> > about applying it on the export branch, and staging it for a bit?
> > 
> > If we find issues or improvements we can revert/drop/update. Otherwise
> > we can keep it. Meanwhile it will get a better testing...
> > 
> > WDYT?
> 
> Hi Paolo -
> 
> I finally (sorry about the delay) did capture some data to see what was 
> going on with the pacing rate. I added a pr_debug() in 
> mptcp_subflow_get_send() to dump the following:
> 
> timestamp
> socket ptr
> sk_pacing_rate
> sk_pacing_shift
> mss_cache
> snd_cwnd
> packets_out
> srtt_us
> 
> I chose those values based on what is used to calculate sk_pacing_rate - I 
> should have also included snd_wnd and sk_wmem_queued, since those are used 
> in the weighted average in this patch. But I ran out of time to update 
> everything today and still get this reply written.
> 
> The debug output didn't appear to interfere much with the simult_flows.sh 
> tests, they still completed in the normal time (except for one that ran 
> just a little long).
> 
> I observed some patterns with the output I captured during a 
> simult_flows.sh run:
> 
> 1. When snd_cwnd and srtt_us were small (when data had not been sent yet 
> or there was a time gap), sk_pacing_rate had very large spikes. Often 10x 
> higher or more.
> 
> 2. When packets were streaming out, sk_pacing_rate was quite consistent
> 
> 
> Some sockets just had a large initial value, then settled in to a stable 
> range. An example is the attached normal-stable.png graph (socket ecab33d5 
> in the attached data).
> 
> Here's the beginning of that "normal" case:
> 
> socket,timestamp,pacing_rate,pacing_shift,mss_cache,snd_cwnd,packets_out,srtt_us
> 
> 00000000ecab33d5	1115.798277	73877551	10	1448	10	0	3136
> 00000000ecab33d5	1115.859702	5711316	10	1448	21	17	51112
> 00000000ecab33d5	1115.8793	2691321	10	1448	22	18	113631
> 00000000ecab33d5	1115.888531	2428742	10	1448	22	22	125916
> 00000000ecab33d5	1115.905641	2048124	10	1448	23	22	156103
> 00000000ecab33d5	1115.952846	1687326	10	1448	25	14	205959
> 00000000ecab33d5	1115.972365	1731531	10	1448	26	26	208729
> 
> The average pacing rate settles in after the first few points. But when 
> snd_cwnd and srtt_us are small, the pacing rate was not reliable.
> 
> 
> Other sockets, which seemed to encounter gaps where packets were not sent, 
> had spikes in sk_pacing_rate each time sending resumed. pacing_spikes.png 
> shows this.
> 
> An excerpt of that (socket 59324953):
> 
> socket,timestamp,pacing_rate,pacing_shift,mss_cache,snd_cwnd,packets_out,srtt_us
> 
> 0000000059324953	1099.545071	1535124	10	1448	333	333	3015368
> 0000000059324953	1100.638369	28960000	10	1448	10	0	8000
> 0000000059324953	1108.17501	101614035	10	1448	10	0	2280
> 0000000059324953	1123.068772	212941176	10	1448	10	0	1088
> 0000000059324953	1123.277791	218360037	10	1448	10	7	1061
> 0000000059324953	1123.325756	5016147	10	1448	19	0	52653
> 0000000059324953	1123.406518	9498001	10	1448	20	1	29271
> 0000000059324953	1123.440064	4935750	10	1448	20	1	56327
> 
> Here, the pacing rate had settled to around 1.5 million, then suddenly 
> jumped to ~29 million and ~218 million. Two orders of magnitude is a 
> pretty huge change! If I had sampled sk_wmem_queued, I'm guessing that 
> would show a small (or zero) value which would minimize the impact of 
> these spikes on the weighted average.
> 
> 
> 
> If this data is representative of typical behavior of sk_pacing_rate (and 
> simult_flows.sh is representative enough of real-world behavior!), this 
> does definitely confirm that the way the existing upstream code uses 
> sk_pacing_rate is likely making some very sub-optimal choices when there 
> are outliers in sk_pacing_rate.
> 
> I think this also shows that we need to be careful about how these spikes 
> affect a weighted average, because one sk_pacing_rate spike could end up 
> influencing the scheduler for an even longer time depending on how it gets 
> weighted. 

Thank you for the detailed analisys and all the info shared!

I think there is an important point I was unable to clarify so far: the
average pacing rate is _NOT_ used to make any prediction or estimation
on the future.

It computes an approximation of the time to flush the queued data. Note
due to pacing and the mptcp scheduler enqueuing data only if the cwin
is open, we could compute such time with absolute accuracy, e.g. if the
packets present into the tx queue have the following data:

	pkt 	len	pacing
	1	2000	100K
	2	1000	1M
	3	500	10K

The time to flush will be:

	1000/ 10K + 2000/1M + 500/100K

regardless of the high fluctuation in the pacing rate. If the TCP code
selects a suboptimal pacing rate value, the _TCP_ tput will be
suboptimal, but the above equation will still be exact.

The average schema used here is an approximation of the above. Why
don't using the exact formula instead? it would require more overhead,
more accounting (we would need to store a timing or pace info in the CB
of each packet) and possibly even additional hooks (we would need to
update the accounting when a packet transmission completes).

Empirical results showed that the avg approximation is a good enough
approximation. 

> Before we merge a change here, we should develop a clear 
> understanding of what the data going in to the scheduling decision looks 
> like, and make sure that outliers in that input data are handled 
> appropriately in a variety of scenarios.

Due to the above, I still propose to go ahead with this version and
ev., as needed, improve incrementally.

Cheers,

Paolo

