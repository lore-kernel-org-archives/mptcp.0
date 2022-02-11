Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1E2F26
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644579848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7K1GuSGCZr/GHWURko5EAduNpDpATOySbMNaOJpT2e4=;
	b=fx0x7nY5IEW+fRbWQCOvAVKQp8uHgKHSKjNZsp1qE0iwcNEMRkvqCkkU18zNHYhyEe+SEQ
	RzxNHYzdBr5zyWpHh4vmV57Zt8B1647zey2+3hM5vYyGd92uPp6dRrHyER9qWtk7XeVJVl
	vzCP6QSMBHW+wUNXainu9QXDDoqoR3I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-urj7k_w-OKOSE1r_5ACMrw-1; Fri, 11 Feb 2022 06:44:06 -0500
X-MC-Unique: urj7k_w-OKOSE1r_5ACMrw-1
Received: by mail-qt1-f197.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso6579787qtm.8
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 03:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7K1GuSGCZr/GHWURko5EAduNpDpATOySbMNaOJpT2e4=;
        b=ay0XziEXqWGJXRwJxo24V9VE33u4/gYwhCACXIUVEqfnslNaizKxyzXq9PPUuh471j
         xcKA3ZhhEobtX/FruJasGO4zEWKDQDyPCLBbvRSSfz3CQZKHe0H2HX/qyrOWQ0Zge9Tn
         rSKpvOd2EHD1wcAn3TocLbZke8dDedZXOgWcfWAXXf9tRowg8AqXgrd5eAgvDDmR/Iek
         In3i54TQZNL5YXFhfGNFoNmeob4/+lNhmxYl9rbfonxyCX4mc1+voNtjSaXyhP3R4ign
         3kJ7Xol9Enwezkd7NFZLZ3IExBTaY5se2Wgca8S7Xq7pwT9aixJRlr7O3EkaoMZVWs5P
         oTZg==
X-Gm-Message-State: AOAM5332nUmwlMQ4FjfkMwn6IixOQhUumv3n4T4MYm9TLtx+AxFUKluN
	nzybxn6ASYEc6w3Ac1Vzfbiozf7tLVsPN5YJwgSo4L5xqsrZDqaMN2hcBQmQAAi1e77gt9SWT4g
	bQRNThsILt7uRs1c=
X-Received: by 2002:a05:6214:c89:: with SMTP id r9mr682579qvr.117.1644579845659;
        Fri, 11 Feb 2022 03:44:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaLoifVpOi/ObZactXFQC3B70EDhPZdF8pbdgGLOWNrWMSUbWRLbxD3LI/gU0SSmeqwLqXcA==
X-Received: by 2002:a05:6214:c89:: with SMTP id r9mr682570qvr.117.1644579845435;
        Fri, 11 Feb 2022 03:44:05 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id s11sm12896664qtk.82.2022.02.11.03.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 03:44:05 -0800 (PST)
Message-ID: <51d05579aeab035e459a525c605ad319abd6f016.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 0/3] mptcp: more self-tests improvements
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 11 Feb 2022 12:44:02 +0100
In-Reply-To: <ff4789e4-40d9-1374-53e3-c47954129776@tessares.net>
References: <cover.1644518737.git.pabeni@redhat.com>
	 <ff4789e4-40d9-1374-53e3-c47954129776@tessares.net>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Fri, 2022-02-11 at 11:33 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 10/02/2022 19:49, Paolo Abeni wrote:
> > This is the new iteration of "mptcp: strict local address ID selection."
> > should hopefully fix the last self-test failure.
> 
> Thank you for this v3!
> 
> I don't know if there is a link but the CI seems to take longer than
> usual with these 3 patches.
> 
> With a debug kernel config, it even reached the timeout of 55min I set
> to start the VM and run all tests:
> 
> - KVM Validation: debug:
>   - Critical: Global Timeout ❌:
>   - Task: https://cirrus-ci.com/task/6256933542821888
>   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/6256933542821888/summary/summary.txt
> 
> So I restarted it and I didn't reach the timeout:
> 
> - KVM Validation: debug:
>   - Unstable: 1 failed test(s): selftest_mptcp_connect 🔴:
>   - Task: https://cirrus-ci.com/task/5212186606829568
>   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/5212186606829568/summary/summary.txt
> 
> Still taking longer than usual I think. But that's hard to be sure about
> that with these public CI as we don't control where it is executed and
> which other tasks are ran in parallel.
> Do you observe the same on your side?

Uhmmm... I did not look closely to the running time. Nothing in the
patch should change it significantly. The successful run for v2 took
1h10':

https://cirrus-ci.com/task/5430100798734336

do you know which is the average runtime for a dbg build? It looks like
> 50' was not uncommon at all... 

I'll try to have a look at the runtime here, but not very soon.

It does look something to be coped by with a suitable timeout.

> BTW, you can see that on this last build, it detected an issue with
> mptcp_connect.sh. It didn't detect that with the previous job. That's
> probably not related to your modifications. I just noticed it is not the
> first time we got the issue (I didn't see it due to the other issues):
> 
> - https://cirrus-ci.com/task/6348125144088576
> - https://cirrus-ci.com/task/6565756707012608
> - https://cirrus-ci.com/task/5501584690905088
> - https://cirrus-ci.com/task/6734301743022080
> - https://cirrus-ci.com/task/6064315366113280
> - etc.
> 
> I'm going to create a new issue for that.
> 
uhm... too much job security hurts ;)

Everyone of such failures is on disconnect test, in the fallback
scenario.

/P

