Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B528E5
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645202642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7+JOx0jG/AdR2a4ULnfNUKcVEqp0RLAA9EUfo3jDYI=;
	b=W2Zdxb/HamKa8l24NqwT2cn1Np50JI+7nYjBxHRq/DbB5q02RJa5CqrGLMDbcFvm25YnIF
	8zybSViq1KvmwU9mw6GI+02aZa9StXer7WtDkp6CBHIz9NjJ5MEx7FAPMRit10cuxkUile
	B1uYTqKyWOOSIHJ7WbGjfhyo75kPCR4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-By3z1w5IPHivn8QGMptrcg-1; Fri, 18 Feb 2022 11:44:01 -0500
X-MC-Unique: By3z1w5IPHivn8QGMptrcg-1
Received: by mail-wm1-f71.google.com with SMTP id p13-20020a05600c204d00b0037ea24db798so1017059wmg.2
        for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 08:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=P7+JOx0jG/AdR2a4ULnfNUKcVEqp0RLAA9EUfo3jDYI=;
        b=ZOALjtiUYr8cWDN98DJTDeOZrkaVN+BBd+RzguS2N8tItKPVbImouGYaK/osa2phv9
         PzkO4DsAzii1lwD1+dlajGVVjZ6aksykzlum1FW7Ygt4vvfank2Y1jfN1caInuvS4j3c
         De7IOrcHv7fijQ+1pz9UxFKNCx7WJSbtD6AyjMXYgFgNJCzVhzR6QLwwxGblqaGPFxR+
         6odptfRYCkTtI6nMhrIlCDPPWDcOMUbUEivNS9JUhejie768So1bLqF09k49umQB+rTn
         wnOBwwiDc5o14AYJAIrfET5PuRvrEzvZqHRLzm931Hl4Yv6R0o+id6zmgWW5Soip449J
         /m4g==
X-Gm-Message-State: AOAM5315374D/MyOerjHvda9DB1cSD8iP22iQD5ng2htTgeU/Xy/A215
	8S6GytiJ8XBs3CM7NNV3Dju/O0SKf9d2+Sto3vB9+rdedK2C4pzyQohcEy0otPqGAvQke20Kvar
	DeTAR9Jc17oPUpAA=
X-Received: by 2002:a7b:cb90:0:b0:37b:b88b:b4a2 with SMTP id m16-20020a7bcb90000000b0037bb88bb4a2mr7964942wmi.148.1645202640110;
        Fri, 18 Feb 2022 08:44:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB1/JnadpaOFJ7Z8lrDnTtrAm9V7L5KbX1bREqMuYbxsMGFW4Ip9PtnYg28xysDBm9SO6xnw==
X-Received: by 2002:a7b:cb90:0:b0:37b:b88b:b4a2 with SMTP id m16-20020a7bcb90000000b0037bb88bb4a2mr7964930wmi.148.1645202639891;
        Fri, 18 Feb 2022 08:43:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id c3sm22556197wri.109.2022.02.18.08.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:43:59 -0800 (PST)
Message-ID: <a58fd624f7261abfe417f27b92dc906aab5fb22f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 0/9] Refactor mptcp_join.sh
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Fri, 18 Feb 2022 17:43:58 +0100
In-Reply-To: <808f443ae9db49c2e5bc69a2285f230d5369853c.camel@redhat.com>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
	 <ffdf6780-5cc7-bde4-586e-eb36c7a409d@linux.intel.com>
	 <808f443ae9db49c2e5bc69a2285f230d5369853c.camel@redhat.com>
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
Content-Transfer-Encoding: 7bit

On Fri, 2022-02-18 at 12:04 +0100, Paolo Abeni wrote:
> On Thu, 2022-02-17 at 16:33 -0800, Mat Martineau wrote:
> > > Patch 4/9 is the updated version of the previous patch 3/9 from v1: mainly
> > > rebased. I only added one line in the "usage()" function and use lower cases for
> > > only_tests variable.
> > > 
> > > Patch 5/9 is new and similar to the previous patch: another way to execute a
> > > specific test, useful when using 'git blame'. Also help to have patch 6/9.
> > > 
> > 
> > These are running fine for me, it's just the issue of 2000+ lines of churn 
> > and the potential (or even likely) net/net-next merge conflicts if we need 
> > to modify mptcp_join.sh after the 5.18 merge window. Hopefully all the 
> > work we're doing now to stabilize the tests means we will not have as many 
> > -net mptcp_join.sh changes in the next cycle, but we would still probably 
> > run in to some headaches. If we do apply these it would need to be right 
> > before net-next closes for 5.18.
> > 
> > Since you've put this much work into this patch it implies that you think 
> > the merge headaches would be worth it for the 5.18 development cycle :) 
> > For the way I use the test script the ability to test by number is not 
> > that critical - is anyone else (Paolo?) thinking you'll use this feature?
> 
> That feature would have saved a significant amount of my time in the
> past weeks. I think the diffstat is a bit too much, and I still would
> prefer the other approach of filtering out the test in each helper used
> by the test themself.

Uhmmm... my main argument vs the current version of patch 4 is defeated
by patches 5 && 6, which look useful. So I'm ok with patch 4 as is...

> Additionally, I think it would be nice replace the 'bare' ip netns exec
> ...' we still have in some the userspace tests with the appropriate
> helpers - possibly worth a separate, independent patch.

... still think it would be nice (almost necessary) cover the above ->
migrate all direct ip netns exec... usage to the appropriate helper.

/P

