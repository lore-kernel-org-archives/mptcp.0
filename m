Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77A154B2
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687873419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKtvMyFdz7ytSPlZNbTNVmiVF1bHPaDol8lnLdtDG4M=;
	b=OMGGbZAUMeOUKad0L0ZzVyw/ar0B2DxdlmJUP5R+CBFtFd140pJfy0WBlZOYzQd5nwzxW9
	qb+7ehMJcQgOtprq3BRMpGLuVHPyqtfS8NH/nwXmuoctjW0K30sswk5NbYJALytnS5vuEH
	+pYyPoO9btmXPYv7TbNgia4vc6mtsz0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-tsZUtDnlOIulkdxLX-Mr0Q-1; Tue, 27 Jun 2023 09:43:37 -0400
X-MC-Unique: tsZUtDnlOIulkdxLX-Mr0Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635f63d0c1aso980246d6.3
        for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 06:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687873417; x=1690465417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKtvMyFdz7ytSPlZNbTNVmiVF1bHPaDol8lnLdtDG4M=;
        b=BmpFFcphK5EwqTEN3VSC6JAE+/wsfV2vXyquhjK84AUJ4QlZ59Wbr33nhRfKKRkS46
         3uaLStFlaBmWkdu1aIE057yxGCwL41cAPbdCwbhxTzmZAD9fj9YrV+BzaWBlKWTD+70X
         XYCNR6KyFXHtBkGB2cEVQXx5OLd23WA4Lb/yj2JnGkXthQEJFOEAU6/tPWwbHX4gmMIo
         16nTqfL/7R2dE1JNvAud3XVh917j0EqNQ1/eh7IpaI4s6MpQXjwa23WjTivaEewqkGyX
         5wXcdOjT7yXiFbbJ0QFiOno0glqrjvUGn78DXQIfOP/rUzEggfWZxja5qKrjVcqEKH7K
         RQ6w==
X-Gm-Message-State: AC+VfDzbnbl3z2KscAfGy7f+OW5d4BsHThkCfsDw8KReMYKz5KwG5Fgl
	KkBp2n+/SH+S1zceCq58rxNTdRoEhXd+WFUGa+nWwSVVAG86Qe8HNNXUDk7vlgdBtY3OznLVXZ5
	t6KdSj79F8i5SFEU=
X-Received: by 2002:a05:6214:230c:b0:635:de52:8383 with SMTP id gc12-20020a056214230c00b00635de528383mr7298750qvb.59.1687873416793;
        Tue, 27 Jun 2023 06:43:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yzq+WKACyKjBe6uuP12DNMwrt3sBtU0HrpKMYx7jmZ5Iz5joiWs7UE81/o+a8rL0OzUkGqA==
X-Received: by 2002:a05:6214:230c:b0:635:de52:8383 with SMTP id gc12-20020a056214230c00b00635de528383mr7298733qvb.59.1687873416536;
        Tue, 27 Jun 2023 06:43:36 -0700 (PDT)
Received: from localhost ([37.163.11.144])
        by smtp.gmail.com with ESMTPSA id ew13-20020a0562140aad00b0062168714c8fsm4544808qvb.120.2023.06.27.06.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 06:43:36 -0700 (PDT)
Date: Tue, 27 Jun 2023 15:43:30 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mptcp@lists.linux.dev,
	martineau@kernel.org, geliang.tang@suse.com
Subject: Re: [PATCH net 2/2] selftests: mptcp: join: fix 'implicit EP' test
Message-ID: <ZJrngsQIAI3ATrlU@renaissance-vector>
References: <cover.1687522138.git.aclaudi@redhat.com>
 <70e1c8044096af86ed19ee5b4068dd8ce15aad30.1687522138.git.aclaudi@redhat.com>
 <30ecb04c-47b1-fdf8-d695-e9b9b2198319@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <30ecb04c-47b1-fdf8-d695-e9b9b2198319@tessares.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2023 at 01:32:17PM +0200, Matthieu Baerts wrote:
> Hi Andrea,
> 
> On 23/06/2023 14:19, Andrea Claudi wrote:
> > mptcp_join '001 implicit EP' test currently fails because of two
> > reasons:
> 
> Same as on patch 1/2: can you remove "001" and mention it is only
> failing when using "ip mptcp" ("-i" option) please?
>

Sure, no problem.

> > - iproute v6.3.0 does not support the implicit flag, fixed with
> >   iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
> >   flag")
> 
> Thank you for that!
> 
> Out of curiosity: why is it in iproute2-next (following net-next tree,
> for v6.5) and not in iproute2 tree (following -net / Linus tree: for v6.4)?
> 

I usually target fixes to iproute2 and new stuff to iproute2-next, no
other reason than that. But I see your point here, having this on -net
may end up in the commit not landing in the same release cycle.

Should I send v2 for this series to mptcp-next, then?

Andrea

> > - pm_nl_check_endpoint wrongly expects the ip address to be repeated two
> >   times in iproute output, and does not account for a final whitespace
> >   in it.
> > 
> > This fixes the issue trimming the whitespace in the output string and
> > removing the double address in the expected string.
> > 
> > Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
> > Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 5424dcacfffa..6c3525e42273 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -768,10 +768,11 @@ pm_nl_check_endpoint()
> >  	fi
> >  
> >  	if [ $ip_mptcp -eq 1 ]; then
> > +		# get line and trim trailing whitespace
> >  		line=$(ip -n $ns mptcp endpoint show $id)
> > +		line="${line% }"
> >  		# the dump order is: address id flags port dev
> > -		expected_line="$addr"
> > -		[ -n "$addr" ] && expected_line="$expected_line $addr"
> > +		[ -n "$addr" ] && expected_line="$addr"
> >  		expected_line="$expected_line $id"
> >  		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
> >  		[ -n "$dev" ] && expected_line="$expected_line $dev"
> 
> It looks good, no need to change anything here but later (not for -net
> anyway), we should probably parse the JSON output of "ip -j mptcp" instead.
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

