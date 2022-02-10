Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DB2F20
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644505901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QcwtEU+xy9YwlxUuWuguqbk7DmfSgu+oYeeaFyfSKQc=;
	b=GJ7H/voOshSBFFnp0lQuIYNFiJMAFGmDXHiQm5jQTi/FfBil2A4LaDrNnoNhdg3BPZioLH
	syMN1fWG2YxbQgtffHftA8JqW1q/MRdGNbZjfNBJx5cmSsOzVnGFxHQtKe38+2E+kVHbMc
	vfUMw21Tfkzkl5M9duLD7Vi75SgzNEA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-nshQ0HmcNp-NAdq4DwPJAA-1; Thu, 10 Feb 2022 10:11:40 -0500
X-MC-Unique: nshQ0HmcNp-NAdq4DwPJAA-1
Received: by mail-qv1-f71.google.com with SMTP id jn13-20020ad45ded000000b0042c3394cafaso3103175qvb.22
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 07:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QcwtEU+xy9YwlxUuWuguqbk7DmfSgu+oYeeaFyfSKQc=;
        b=2+FX5BwWNY2dptCqyKMjqZfYEFe0f7UF2gn2gQ+/Mk6JAr5JtNEjnVFaR5m1Gxm57+
         QIuinNm7wdnqfIXx3xldfRs0zn7WwE5bts3eCQo8UEnlsM70M2/Y8lUoWy4yczhSGLfw
         rydUOvdLXLY+R3xpU1SzGVv6KGpjfWm8reAYX5t0frqmAC154pR5L46JOXgcvykb6xoP
         SG48bwLcR0npfpBF50lJu/7gQwZK71m47PLM6jX9+dG03uSs2/ioXhxEOWOmpcs3JcSg
         6X2n2TaHzlym8NAJWfSvqtkN36sTL2q1kxeZY9IHRugh56KEzNJTDISr/ivnJwy7UIHo
         DN0w==
X-Gm-Message-State: AOAM530XIhgqjfYb64MkwT4LoXFhbwEpn6GyzSZ7yXGcMx1qAYja4N10
	BWjb47ZWG+UYQLdSu1BrTiPD1hpFSbuDrgucWzoUhe2/lXhI42SkGDj/ratc0gO4eVSts1e4fxu
	rnP5jFldSmRAdLyM=
X-Received: by 2002:a37:e10d:: with SMTP id c13mr3988756qkm.708.1644505900147;
        Thu, 10 Feb 2022 07:11:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrmbIEZcsEMYsvzCKl1qCOWM1tpy27u3ncR/NCBDWhMHXtsr4ASyWTokEqJ5ywLb5G8yY/1A==
X-Received: by 2002:a37:e10d:: with SMTP id c13mr3988737qkm.708.1644505899812;
        Thu, 10 Feb 2022 07:11:39 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id f4sm10175289qko.72.2022.02.10.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 07:11:39 -0800 (PST)
Message-ID: <2ed54f9b4f33163372f368a881a31e71175ca475.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/9] selftests: mptcp: join: option to
 execute specific tests
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 10 Feb 2022 16:11:36 +0100
In-Reply-To: <8caf46ee-11b6-aefa-3edd-e17c0928efc7@tessares.net>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
	 <20220209212520.2989291-4-matthieu.baerts@tessares.net>
	 <199e2a26-da9-e79f-53c-50498fda97c@linux.intel.com>
	 <066bb7a33e8f2128968c4aec5ba57c38b2f2c4cd.camel@redhat.com>
	 <8caf46ee-11b6-aefa-3edd-e17c0928efc7@tessares.net>
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

On Thu, 2022-02-10 at 11:42 +0100, Matthieu Baerts wrote:
> On 10/02/2022 11:04, Paolo Abeni wrote:
> > On Wed, 2022-02-09 at 16:36 -0800, Mat Martineau wrote:
> > > On Wed, 9 Feb 2022, Matthieu Baerts wrote:
> > > 
> > > > Often, it is needed to run one specific test.
> > > > 
> > > > There are options to run subgroups of tests but when only one fails, no
> > > > need to run all the subgroup. So far, the solution was to edit the
> > > > script to comment the tests that are not needed but that's not ideal.
> > > > 
> > > > Now, it is possible to run one specific test by giving the ID of the
> > > > tests that are going to be validated, e.g.
> > > > 
> > > >  ./mptcp_join.sh 36 37
> > > > 
> > > > This is cleaner and saves time.
> > > > 
> > > > Technically, the reset* functions now return 0 if the test can be
> > > > executed. This naturally creates sections per test in the code which is
> > > > also helpful to understand what a test is exactly doing.
> > > > 
> > > 
> > > My sense is that this is primarily for development purposes since the test 
> > > numbers may shift as tests are added or modified. Is it worth the churn 
> > > when we have the subgroup functionality and could comment out chunks of 
> > > the test script that are not useful for running specific tests in a loop?
> 
> On my side, it would be helpful. On my side, I can edit the code but
> that's not nice, especially if you want to automate tests with and
> without a patch: you can have conflicts with the new comments, etc.
> 
> On the CI, I cannot easily modify the code so I end up testing more than
> expected, that's slow and sometimes hits other issues.
> 
> I guess on Paolo's side too as he complained about this missing feature :)
> 
> > > I'm not set against this change, but hoping to discuss it some more to 
> > > both understand the benefits (I assume for running CI in a loop?) and to 
> > > see if anyone has bright ideas for avoiding the whitespace churn.
> > > 
> > > ("Include a bash fork in our selftest code that implements 'goto'" seems 
> > > like overkill :) )
> > 
> > Perhapas something alike the following ?!? Not a complete solution:
> > - completely not tested
> > - we will first need to add some wrapper for iptables or even beffer
> > for ip netns exec, to be more generic
> > - possibly more 'skip_test && return' needed, but not many, I guess.
> > 
> > I hope should be enough demonstrate the idea...
> 
> If we really want to avoid modifying existing lines in selftests, I can
> also not add new tabs after the new "if reset" and drop patches 7-9. But
> that's a shame we cannot refactor the code in the selftests :-/
> 
> I don't think it is a good idea to add the skip_test everywhere: we will
> certainly forgot to add one somewhere until someone test the feature.

skip_test will be needed "only" in the helper called directly from the
test body. I think the shared chunk already touches all the existing
one.

Validating should be simple (assuming the current number of mpj
testacase is 100): 

---
for I in $(seq 1 100); do
	./mptcp_join.sh $I
done > out

test=$(grep -c "\d\d\d " out)
if [ $test = 100 ]; then
	echo ok
else
	echo paolo is dumb!
fi
---
/P

