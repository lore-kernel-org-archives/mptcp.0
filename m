Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9820C016
	for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621598; cv=none; b=lko16zfVAlU4I+AEtJRU5U5cfnjGlaB8Gs9ifj2x8qC+6xz8GTk70l3z/ioW/k6Ssg3Dl9MryO5p+hbrNtI2cQa7yWBkAJrwEIIx90ipIu1oNh9euti8IRydm1YrHPRNw8zm4owKxOBL4mQ/Eq6/a5i+WuTmlD3xc4mSTwMb+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621598; c=relaxed/simple;
	bh=YrJfmBJfRM5BJl7DU/6G4DUWFE24IFCnHoyZKUXHlas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=K/KcRg/FFw6UmNxKTHh8RhacvryZb8g+TKJZ9rm12OpPUQqY+NFN3fFR8bkRqrazAlX3GAv4CYJPFsTU49MU91BTbRfWNE28F2qH8+CaA4NVg5/huDJ7+I06OJFriahfSs/9rhtowC3oPMq3OE4vMQB5A6tHV3f5Hq64Oz7MkGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4fvgGUM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4fvgGUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737621595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GiFqxgggPoN9+s+nMZCrGcnPpT3g6d2dyyCadPevlp4=;
	b=I4fvgGUMlDguu+wQ7E8C88mJxXin37i/MNQOVdfO6NvWlpjjK6YIwitpXKjdIA/pbNbZ0F
	KHtDWBnyL6ACcW/z6y6hzCcIqqNnf0SpHFyz9bnudkOIgQSm6Qaco9Hv+1JFaP+bXjut77
	GKEEjs/lYpi3ZgISzpVCOOh7KlHGhqU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-AoNrRUjKNUmsxn5L9uFYfw-1; Thu, 23 Jan 2025 03:39:54 -0500
X-MC-Unique: AoNrRUjKNUmsxn5L9uFYfw-1
X-Mimecast-MFC-AGG-ID: AoNrRUjKNUmsxn5L9uFYfw
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so2368888a91.1
        for <mptcp@lists.linux.dev>; Thu, 23 Jan 2025 00:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621593; x=1738226393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiFqxgggPoN9+s+nMZCrGcnPpT3g6d2dyyCadPevlp4=;
        b=AxGLP0deNaTxAG6/npVn2hwtX5Z+ShTHwwYAoC+AlyvBnnzJVI/V/j4V0VNbd3Z4Jh
         EXX0Ix7jFyMLxCWfLJo7f6oyIOJn1fHfPfDrri9CH7XTBWBPtC26R+i6HRvoEp5dORyk
         Oiz9SN9o35+lC4My1poYWKMn5EKE4+e8Pd9FB/uY+5H8RHcc2GmhQTgvmzHBDrzwEV5i
         nplBYVnzSrBLltB8zYvg4DRtv2Xi+PofkcQXSTWqwHi6aK+bjyTnnSvO6W4SJ2n6Hc6+
         H2iwxMpUqE2xKiN2quVV9GR7fRd5TPVQqFPRi2VrLgIXIiR8gQAUZlDA6JN2VfioU/lG
         5jAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL+L1sbi4Yspb9IgwhfOohIthsbAlzBcyb3A+HAdRalPHHLlC8OEHxeA43H06GUTHdY1HJnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSF4QdbIOgfjWNyIDFSYz5zlAX8RgkAM8o+0SmlhxrCDeIyI4Z
	hhWTsvm0kK/qIPgt4Fq2DJUplLX00yASe5n3BVTsbbxzLISTsgTHYBa/Y7qlifGZHOeP1FSw48w
	CNKqwg93euXL41pu9wt0jlTMGNt/5X88HF2bp20BuK3vfSF0wlNA=
X-Gm-Gg: ASbGnctHPcx3E+WG5TXmybBwTTqfRF96yeNr2BwuWuI4VpJiyBMh0ksnnxn8RC2q4cH
	bcIWPNX17ERTFCX+xFYTJ0dnZv6cL+4PafUeSLaFTxYcZx2wgwoTpoT09eKUXnpm5UJTC7pks2u
	6I1R6D3mhm4c2xS2KHu1ixNRO07g6pRGDM8Y6zwIp0ED9X5EaGYTEFM1QzrwfCne9HQ50fugoOw
	TKkrsq71Mes6AkhHaSO5OiN8N62hTE/v/4qfg9ePxj2/r5fpT123ZPTiGGU3Xn85dee
X-Received: by 2002:a17:90b:1f92:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2f782d4ee70mr38271551a91.28.1737621593090;
        Thu, 23 Jan 2025 00:39:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhMZaYjsqNmySTRYcUMtYOJ74eIJfObrd1yiHY1EySAIXMN2gcyZKJ0eJU5K1ZveJIHc7pjw==
X-Received: by 2002:a17:90b:1f92:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2f782d4ee70mr38271536a91.28.1737621592831;
        Thu, 23 Jan 2025 00:39:52 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6b9b1desm3305192a91.47.2025.01.23.00.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:39:52 -0800 (PST)
Date: Thu, 23 Jan 2025 08:39:47 +0000
From: Hangbin Liu <haliu@redhat.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: matttbe@kernel.org, martineau@kernel.org, eliang@kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from
 environment
Message-ID: <Z5IAU4X1084EFrEd@fedora>
References: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9j2W48-bxY-w9_FsiBQCTinPdks6ngJ3xNsTjYmr61w_1737621593
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2025 at 09:35:42AM +0100, Jan Stancek wrote:
> Package build environments like Fedora rpmbuild introduced hardening
> options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> and LDFLAGS.
> 
> mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which leads
> to a mismatch and build failure, for example:
>   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/mptcp_sockopt] Error 1
>   /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
>   /usr/bin/ld: failed to set dynamic section sizes: bad value
>   collect2: error: ld returned 1 exit status
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 8e3fc05a5397..9706bc73809f 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -2,7 +2,7 @@
>  
>  top_srcdir = ../../../../..
>  
> -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
>  
>  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
>  	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

