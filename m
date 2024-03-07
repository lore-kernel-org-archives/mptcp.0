Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304712EBCB
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825944; cv=none; b=budmz4hoBVRsspZvK2iQ3SPz499wDMCXS/lW0eNLL0OoX3bvYuICnK/c2mVi5jRPu45DBvZwR9Jd97HSU+PJU1ggwgf194B5UGShueIEXzTqwuMDbR6O36ZF8C5YbUOlnFtRxuEwe7nlfgAiAiHMghxCTjR7i1vnL1yhbvxLvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825944; c=relaxed/simple;
	bh=6PaiWkkBPk+enwJIXWwSIh8BZE1LIfbDInf4oUkkKEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NtpPF2YK5qSQlB5HBYCG3CpBXEYtgD908rnKHup51b5zM/DDU/rFvCKJjpJWB7ctslmh9ZhkxXwnADLOIDTUqChs9vTeAOIh14RCzQrfhKQM9mDfpy8T/+eg1iTYyxweDefW/PgoorntFT7juCfxeRDN/etIgRWntXRej4LN1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3GZH70T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3GZH70T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709825941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0uXjfwpcGITHeypcYtX8fMcNXip0UK/o+DJrX0M7JAw=;
	b=V3GZH70TNNqPoIT4HiZ7PEdl45x0qlYN0z4+lwQwcC/uBhMFu3CG3wICM3rYeSX979m7Vr
	KfAhTk/qQux50ugDajGCphiFzypDSFyS+Ibvmrqao/jAyOEi9qq5Dlb4XkUuobCqEnY67I
	QrpIR+5Up/EcVqD3abpw0C/Y8wu0Hhk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-lT3sWtxYMmmnb8qyUobDNw-1; Thu, 07 Mar 2024 10:39:00 -0500
X-MC-Unique: lT3sWtxYMmmnb8qyUobDNw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412d433bba5so5874735e9.0
        for <mptcp@lists.linux.dev>; Thu, 07 Mar 2024 07:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825939; x=1710430739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uXjfwpcGITHeypcYtX8fMcNXip0UK/o+DJrX0M7JAw=;
        b=VFzsQ1E5MtrtdFrwOxT/W/VqBnF7TNF0LfHyA6v5A27EBLGYHZX328CojsffVFfyCW
         lQHBF5Ki+Z0J1RsK+3Yr0MRqvvaJmvyygK6BOSFEBjUn3HuDvTRGMXepPswq8atdNfmw
         X8NScvBsWKXEv/1JrhlXLqD5ibxKc9WvbgDNuE2QJOmoF3Mo13bRmZNf4Fgg2uribhFC
         czTkz+t62HOuaC7Erv4dJs2oHT7s8GRy2bDPbZzROm1E9C659pxbtv6VpzwrHWlygYAJ
         DkbXPvyE8b4BXgcHSdUDIRo9pg4I/xcv9sYyhZK2OxjwiIyUY6ojqUAXAUASSUG67IrK
         +gNA==
X-Forwarded-Encrypted: i=1; AJvYcCXGeVdmsBDNRftzP5WwETESoi9VvsT16tVwAvM3De3609feJl6gDY4vJ2Y5Uwv+vlzVY0Jewn0d/+QCdZTivNDmo1d3fKQ=
X-Gm-Message-State: AOJu0YzJYOz0xWCqVP6baYIh2o6ELhdlRIductKxXjrU+i0R/IK9cObb
	QNu03yGbqC8ETAH3/Tkd3JFvdHEQ/p3AWICKFSsqJvb16vg5jF/t2im+4JUzBG6TIqLQhuYwClG
	HoGtqubQcEqsXz+DgzRvHLsb0i7SuYYOYj2zVElptyqHlUVFvuCMW
X-Received: by 2002:a05:600c:4691:b0:412:c809:5421 with SMTP id p17-20020a05600c469100b00412c8095421mr14207315wmo.2.1709825939198;
        Thu, 07 Mar 2024 07:38:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9yJYpK9oaB3omPY0hCo/ew1mhiK/J0aeUczDhjo7BZQ+kNoYl5Mb/KWlY55941hIFWoyc0A==
X-Received: by 2002:a05:600c:4691:b0:412:c809:5421 with SMTP id p17-20020a05600c469100b00412c8095421mr14207296wmo.2.1709825938645;
        Thu, 07 Mar 2024 07:38:58 -0800 (PST)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id e18-20020adfef12000000b0033cf5094fcesm20523478wro.36.2024.03.07.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:38:58 -0800 (PST)
Date: Thu, 7 Mar 2024 16:38:57 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
Message-ID: <ZenfkXU_zYb0AcR8@dcaratti.users.ipa.redhat.com>
References: <be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com>
 <62dd5009-fd83-4cd6-b7b1-8afff28a575c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <62dd5009-fd83-4cd6-b7b1-8afff28a575c@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthieu!

On Thu, Mar 07, 2024 at 11:05:10AM +0100, Matthieu Baerts wrote:
> Hi Davide,
> 
> On 05/03/2024 16:19, Davide Caratti wrote:
> > currently, inbound TCP connections increment MPTcpExtMPCapableFallbackACK
> 
> Maybe clearer with 'inbound "plain" TCP connections'?

maybe it's better to say "non-MPC": see below

> 
> > when the server accepts them. As Christoph reported, this is "surprising"
> > because the counter becomes greater than MPTcpExtMPCapableSYNRX when many
> > non-MPC TCP connections are accepted.
> 
> (detail: maybe add an empty line here, and start the sentence above with
> a capital letter :) )

right, I always forget the capital letter.

> 
> > Change the semantic of MPTcpExtMPCapableFallbackACK to increment when the
> > subflow context of an inbound MPC connection attempt is dropped.
> 
> Detail: I don't know if 'change the semantic' would be OK for a patch
> for -net. Maybe more:
> 
>   MPTcpExtMPCapableFallbackACK counter's name suggests it should only be
>   incremented when a connection was seen using MPTCP options, then a
>   fallback to TCP has been done. Let's do that by incrementing it when
>   the subflow context of an inbound MPC connection attempt is dropped.
> 
> > v2: fix reporter name

this was meant for net-next, but I can find a suitable Fixes tag.

[...]
 
> > index 1626dd20c68f..6e3fe38f057d 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -905,6 +905,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> >  	return child;
> >  
> >  fallback:
> > +	if (child)
> 
> Why do you need to check that? It is not supposed to be NULL if you are
> here, no?

Ouch, this is wrong and unintentional. The correct test is
if (fallback)
	SUBFLOW_REQ_INC_STATS(blah);

and I mixed variable names while cleaning up pr_debug()s. Non-MPC connection
attempts (pure TCP, but also MPTCP with pathological MP_CAPABLE
sub-options) have fallback equal to false here. Will fix this in v3.

-- 
davide
 

