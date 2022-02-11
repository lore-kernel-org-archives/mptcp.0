Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6296D7E
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644605785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WN7jpit6QLVG3horYNSRlrIuyPaL5yV9igauegB9xiY=;
	b=iNzINfk7g2zmCSiaodoS6oAGRzDofJk1f4RU3z8dNW6lr8Ikpr7LEsn6xG01hrZhpu7Ime
	qOlNQ5saSigSBseFAHpdc/eapzZnyijxqk/o8/odo23mQlLTaCyZlZNF1dCdXOx+T+uUQR
	O6vWkng1a4TeR+NFyI4WuNR0xA4NDF0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-Rrrtmu3LONqdCiuMeZqP9g-1; Fri, 11 Feb 2022 13:56:24 -0500
X-MC-Unique: Rrrtmu3LONqdCiuMeZqP9g-1
Received: by mail-wr1-f70.google.com with SMTP id v9-20020adfa1c9000000b001e33e5dbd5fso4185633wrv.17
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 10:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WN7jpit6QLVG3horYNSRlrIuyPaL5yV9igauegB9xiY=;
        b=ZyJDmVmUuw9qGSBHm+TIRxInAFF4GUf3W38Mtd7OqLHmEYaswCT8vh7Em6n7P3QdWP
         pB2D+EekFDpXRw8jjiCT4xVTY3ZHea02dsLi/8YSlrvKLhZGBQvKNhNDcKpIcUB6Ua4t
         UMYBQmh36zvjmeXV7u43izjPTrwsRzaF+PTpuU50TP32eryd3+cTV3xTrKktB+ZrGuBm
         XaOYvI3VBA0rOS2qbrnPkC73z/93fert4e5sDVnelJlrhJorT+q3U2VeUw19zLDeJpGc
         mQmJ3Eav12NATi1b8dN32WfKTYJ/KGNeTD9kSjfrM1barGRcqhe8bD2NqMF2uJV/y9Ve
         VL+g==
X-Gm-Message-State: AOAM532cyhtrRaCuU0CZQ0twgKaiqqRPd/bBHx0uxpEvz240p5CX5kBl
	zilkRn2w77E1WJvvj6XPRJ12/j4l2ETW9Cp8LHgQ6/WVq0WrORzsLJFUj0iWmNZXlgTptbduPgI
	gCaZ6belDvjpgfms=
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr2415844wrc.138.1644605782645;
        Fri, 11 Feb 2022 10:56:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwO4vc8AoU/iqJzeGuCguuYANEunnqs3nghfs4FWWa76tZVkm4674xBNWgoYjT00hZ3vruwig==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr2415834wrc.138.1644605782391;
        Fri, 11 Feb 2022 10:56:22 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id z5sm5815754wmp.10.2022.02.11.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 10:56:22 -0800 (PST)
Message-ID: <b8ef1116dc2df3efdaa08a6236f7fe3bfdef6fdf.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/9] selftests: mptcp: join: allow running
 -cCi
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 11 Feb 2022 19:56:21 +0100
In-Reply-To: <46a0d57f-4f9e-1313-1b29-70cfc48aab42@tessares.net>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
	 <20220209212520.2989291-2-matthieu.baerts@tessares.net>
	 <71915c57b64e6f32480673c03a53a92a72f3fdd0.camel@redhat.com>
	 <46a0d57f-4f9e-1313-1b29-70cfc48aab42@tessares.net>
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

On Fri, 2022-02-11 at 18:30 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 10/02/2022 15:53, Paolo Abeni wrote:
> > On Wed, 2022-02-09 at 22:25 +0100, Matthieu Baerts wrote:
> > > Without this patch, no tests would be ran when launching:
> > > 
> > >   mptcp_join.sh -cCi
> > > 
> > > In any order or a combination with 2 of these letters.
> > > 
> > > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > index 66ac990415e6..9bbb95837f73 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -2242,7 +2242,7 @@ for arg in "$@"; do
> > >  	fi
> > >  
> > >  	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
> > > -	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ] && [ "${arg}" != "-i" ]; then
> > > +	if ! [[ "${arg}" =~ ^"-"[cCi]+$ ]]; then
> > >  		do_all_tests=0
> > >  	fi
> > >  done
> > 
> > At this point I think it would be better consolidate argument parsing
> > with getopts, and dropping the above regexp.
> > 
> > While parsing the test group selectors, we could build the list of 
> > groups to be executed (possibly a string contaning all the function to
> > be invoked), and run them after argument parsing - or run all if such
> > list (string) is empty
> 
> I just applied the patches in our tree and saw this message after, sorry
> about that.
> 
> Indeed, good idea, that would be the proper way to handle options!
> It would also be good not to do anything if the -h option is given with
> others.
> 
> I will try to remember about this idea next time I modify this part! I
> can also remove this commit from our tree if you prefer.

I think we can simply squash the suggested change into this commit

WDYT?

Cheers,

/P

