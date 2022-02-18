Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC048C6
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 11:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645182280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8UFOZxmcbDIkM4mvLmIEaRdcKbZWjehPTqxetHDgak=;
	b=BnYYOmw54lZ5rK8+OIwowcgrfzqOpONPmJGI2JoIQd62EcZMaDSndVpjtkGrSSCU9qskyF
	qs9pXISYaVq60yNY5MAEwQG9H3nN3cWXXollbmowAnOzi+IYFtIo1/ezy0Q7gkHTu5KVj4
	Tgtv6VNq5Mi4P9Fk+xgSaL0ecL76aLA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-7BNJcBxnNcC8jHARzEfnzA-1; Fri, 18 Feb 2022 06:04:39 -0500
X-MC-Unique: 7BNJcBxnNcC8jHARzEfnzA-1
Received: by mail-qv1-f70.google.com with SMTP id k6-20020ad45be6000000b0042c82bd64deso8415306qvc.22
        for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=A8UFOZxmcbDIkM4mvLmIEaRdcKbZWjehPTqxetHDgak=;
        b=jKdtJAfwz0oiHF0DEuZwB7ilsCP2Y97wraGhyYjLCCInIygols0Nw637k7TmnRlGhN
         3ax3UrXbE0mdbJilsRC0vZfyjA8rtxR8xlo5zJjNKCUa5uefNGiD7QGaephpKo3noYnL
         37es3INxUHnSROm6LFRtXuG/xirfI5S55zCStx2rCpWfMiuyV8PuLdqWTP//X08wkhFu
         jcxPF4+DPPbwE71T4pFpL7TQr4gY/0gXtldF36SAu7pPXAJj+4q0qbf7Coom9s5vFdEt
         k5Q7v7igir9fACyT+kqSI4GQ3GBaQyT7y2P5ZjIN+sx3gJzMqRGZ7XWNJZtYjgFwp8KP
         fvNQ==
X-Gm-Message-State: AOAM5332NZ8j+w3uXSY66zRR0tIlTeokJMyryc81tCTiP1Znlz4HS/jK
	ddtlgU+Nnj4IVap13fvu/exQc3tiaghL6QCBJmI81qradFdiHFWuTj5p6G174U3CyecqfxEX7H9
	aSWIP8DhchSL6s4M=
X-Received: by 2002:ac8:7c4b:0:b0:2d1:bff6:e9ef with SMTP id o11-20020ac87c4b000000b002d1bff6e9efmr6192859qtv.22.1645182278857;
        Fri, 18 Feb 2022 03:04:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaXklQHn8WvBRPs1+8lLsph7MUuDEfE/KXoWKrB9vqc4HHxVe19d0Pc1wwR8WDL51490KKSA==
X-Received: by 2002:ac8:7c4b:0:b0:2d1:bff6:e9ef with SMTP id o11-20020ac87c4b000000b002d1bff6e9efmr6192834qtv.22.1645182278550;
        Fri, 18 Feb 2022 03:04:38 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id bs16sm21594668qkb.69.2022.02.18.03.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 03:04:38 -0800 (PST)
Message-ID: <808f443ae9db49c2e5bc69a2285f230d5369853c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 0/9] Refactor mptcp_join.sh
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Fri, 18 Feb 2022 12:04:35 +0100
In-Reply-To: <ffdf6780-5cc7-bde4-586e-eb36c7a409d@linux.intel.com>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
	 <ffdf6780-5cc7-bde4-586e-eb36c7a409d@linux.intel.com>
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

On Thu, 2022-02-17 at 16:33 -0800, Mat Martineau wrote:
> > Patch 4/9 is the updated version of the previous patch 3/9 from v1: mainly
> > rebased. I only added one line in the "usage()" function and use lower cases for
> > only_tests variable.
> > 
> > Patch 5/9 is new and similar to the previous patch: another way to execute a
> > specific test, useful when using 'git blame'. Also help to have patch 6/9.
> > 
> 
> These are running fine for me, it's just the issue of 2000+ lines of churn 
> and the potential (or even likely) net/net-next merge conflicts if we need 
> to modify mptcp_join.sh after the 5.18 merge window. Hopefully all the 
> work we're doing now to stabilize the tests means we will not have as many 
> -net mptcp_join.sh changes in the next cycle, but we would still probably 
> run in to some headaches. If we do apply these it would need to be right 
> before net-next closes for 5.18.
> 
> Since you've put this much work into this patch it implies that you think 
> the merge headaches would be worth it for the 5.18 development cycle :) 
> For the way I use the test script the ability to test by number is not 
> that critical - is anyone else (Paolo?) thinking you'll use this feature?

That feature would have saved a significant amount of my time in the
past weeks. I think the diffstat is a bit too much, and I still would
prefer the other approach of filtering out the test in each helper used
by the test themself.

Additionally, I think it would be nice replace the 'bare' ip netns exec
...' we still have in some the userspace tests with the appropriate
helpers - possibly worth a separate, independent patch.

/P
> 
> 
> > Patch 6/9 is a handy feature when trying to find which tests had issues when
> > executed on a CI or locally.
> > 
> 
> I like this! Highly dependent on previous patches though.
> 
> > Patch 7/9 was present in the v1. Non local variables have no longer been renamed
> > + a there were a few missing 'local' keywords.
> > 
> 
> This seems a lot more manageable than v1, thanks.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> > Patch 8/9 and 9/9 are the same as in v1 but rebased. We are still ShellCheck
> > compliant.
> > 
> 
> These look good too:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> > Matthieu Baerts (9):
> >  Squash to "selftests: mptcp: join: allow running -cCi"
> >  selftests: mptcp: join: define tests groups once
> >  selftests: mptcp: join: reset failing links
> >  selftests: mptcp: join: option to execute specific tests
> >  selftests: mptcp: join: alt. to exec specific tests
> >  selftests: mptcp: join: list failure at the end
> >  selftests: mptcp: join: clarify local/global vars
> >  selftests: mptcp: join: avoid backquotes
> >  selftests: mptcp: join: make it shellcheck compliant
> > 
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 2248 +++++++++--------
> > 1 file changed, 1202 insertions(+), 1046 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

