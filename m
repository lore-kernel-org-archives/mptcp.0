Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149320C023
	for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621833; cv=none; b=O6MX3tTFkjB+8ZtR2ODCbjH4+dFUXupjCYz25sTn8xg1K9E2dlpkftrV0s2tEJTUarusvRw1YtIj1lFZUSRykbk4jvlxIGgN/k+0K2FgWfk1odQsUf7CtGKnxLcushbZsxD54t36w02tAUcHV2XKhDVYgR6S9gaJyn5UosU/0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621833; c=relaxed/simple;
	bh=ha6b9ok5quAYeRP2tfX+AMmeuXgHarjxTmNfEbxLHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OkhjAWinHwjC05XUJ4mgzVvTq4fALOxfLAQzX3xeU4GY3BJglrc+k0fOpPuXXEolDQCaSIb1b6xkE/nOqnjHDQpf+hIv00n8gIi6hhD5Mnbg+NDYVt79+cF2F9TWu8MTVT3FUs+S3WIcvqFx5azJklKvaBlDIimJ5NrzaGiPNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAs6jkE/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAs6jkE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737621830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpWDV/ai6Ur+w1Blpv0i6Vc7rkxchZcIx8yap87Tpz8=;
	b=LAs6jkE/wAeK6OEv3T9bOhdGlPr/OAovUQW/pgSaSs81pV+1OI7EvCvkI4YwRbzU1lejRC
	i9Zx7VxhymnLlmWBF5x0JgArlGOtqFuGTsYihRHzuUqFpEaJY0AVyqLTNxAAUeCMlc4yop
	wSfMtcKhc8ITROSAWWR0ulWjl5a5mFc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-_b--FWpgMXKhlqduwCZMmA-1; Thu, 23 Jan 2025 03:43:47 -0500
X-MC-Unique: _b--FWpgMXKhlqduwCZMmA-1
X-Mimecast-MFC-AGG-ID: _b--FWpgMXKhlqduwCZMmA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21638389f63so10875315ad.1
        for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 00:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621826; x=1738226626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpWDV/ai6Ur+w1Blpv0i6Vc7rkxchZcIx8yap87Tpz8=;
        b=HOFSA3od83qbWThO+x9WfLfg9KkuNh+LoTSULiwjt/wR77OuA40G0bqimQl7HXPICm
         Aqa643Mp/+/dO1f5RsKteWqz1YL85NAiY1P+cmRJPt0jHkSFfWSnqZMOP1ZvQtEzi2Ho
         wkKNEhIbfJNdpzJRPzDGOSq5et3DUC/7t5x8OJ5MREpzSIKS8t8urOT/nAGegR0DL79R
         kOdP8LeoteghimKx19YnAQ2uD6n5Uyo1K7FVPPWoHsW+eXTttsgvxvpOj4+S6ykLKzoJ
         VrCc6DqqGImKt1107DHiFQFTni5HXo/VOpYeWNaswvnxPaO3efuWhD6kN6/i5cALSAYh
         QMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/R6IhivCbIe76zoL2A8wPSrgnUQ+V6W45rXIWob+8ACl51NWcZj8neOgeplruSXDRv20JUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDknIStfVvhtGyECNGC24cKwR7MmCvzj3bqfV77i7JXeBiN7NP
	owAzh+a0bAAjpqhF8zT7IH9W3OUHIsbXaeRwaPn3eYLzWXrWO+4qe9VWseLIrKaqpvJtTDJaCWW
	vd6NvYwd6UCKJZHVp2wXuKcYIU40M1xlIlSxw3NFJTB1SBQkV4MQ=
X-Gm-Gg: ASbGncsUnppGz9kFBYnri5jm2hUOB4qgJMiGIHq79RAFoNvbeS2mdkdhS7KJfER/6dq
	0SHFxnRYUWcc3PRo/1HUP/tKoBJsmDXLSNx5G0sT0v3Jf4b/bEj+/6alePYl5locIMH7ilHL5oe
	7kraoSRb2TT+5/dliDw4SFopfsKfu35l/t+pmyBQFc3/wQT9p26aOqhhzrjhYFV6A8kCHu/HfzA
	Q6/Q/1tb9Lr+LLTQgYq2QyHUGATY4+S14Wn2XSiq5PRthHkXEhoEk2aqNQcqx1ToS6h
X-Received: by 2002:a17:902:f68e:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21c355f040emr334907785ad.45.1737621826294;
        Thu, 23 Jan 2025 00:43:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoFyp8mUveTmi4te0YtMoaGtmQKXDYru3r0i2y43Wp7szaIptDNAzb2cDV4fRUJni9KmOC+Q==
X-Received: by 2002:a17:902:f68e:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21c355f040emr334907475ad.45.1737621825978;
        Thu, 23 Jan 2025 00:43:45 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba9a4sm107223715ad.69.2025.01.23.00.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:43:45 -0800 (PST)
Date: Thu, 23 Jan 2025 08:43:40 +0000
From: Hangbin Liu <haliu@redhat.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: matttbe@kernel.org, martineau@kernel.org, eliang@kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from
 environment
Message-ID: <Z5IBPOGvfPozjrl5@fedora>
References: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
 <Z5IAU4X1084EFrEd@fedora>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z5IAU4X1084EFrEd@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lWkOJcCeK3gdzL88QfgK7QnjLeUNnOCVY2I7gTbRDkU_1737621826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2025 at 08:39:53AM +0000, Hangbin Liu wrote:
> On Thu, Jan 23, 2025 at 09:35:42AM +0100, Jan Stancek wrote:
> > Package build environments like Fedora rpmbuild introduced hardening
> > options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> > and LDFLAGS.
> > 
> > mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which leads
> > to a mismatch and build failure, for example:
> >   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/mptcp_sockopt] Error 1
> >   /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
> >   /usr/bin/ld: failed to set dynamic section sizes: bad value
> >   collect2: error: ld returned 1 exit status
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  tools/testing/selftests/net/mptcp/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> > index 8e3fc05a5397..9706bc73809f 100644
> > --- a/tools/testing/selftests/net/mptcp/Makefile
> > +++ b/tools/testing/selftests/net/mptcp/Makefile
> > @@ -2,7 +2,7 @@
> >  
> >  top_srcdir = ../../../../..
> >  
> > -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> > +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> >  
> >  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
> >  	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
> > -- 
> > 2.43.0
> > 
> 
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Hmm, net-next is closed. Not sure if we can target this to net since it fixes
the build errors.

Thanks
Hangbin

