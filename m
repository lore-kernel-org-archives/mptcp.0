Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642534301C2
	for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133095; cv=none; b=n/F1fZFTKcnpqu7skH+oY2sDCEze2qUFNh2dMob3/FmwHUIRATPlY3Q1ExUw8w4+M1FBjzW669pJwtz+v+d3+TZtmpepF/FepcqPCPpoZc5bUndn7S65585Fgl7swKw02yF+Sd0/bxmwD2e1KB0TD5Ui3gMuTyEHBVhT2TOXD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133095; c=relaxed/simple;
	bh=PQp8DMIf16n9Q4WyqamERG099p/UWm8vclqnIXpsCxk=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Date:Content-Type; b=XKriYv30LIYIOA/WtdRc6/7XZCmG1sdekvkp0qzUzzAJ7OFXdHqgw6+dzaumNLX1JM3dWgVEL7kuSZVBfpsWhVs73SZthvWIDfrMlKnPmK5SB7lrxfLcFKIXC5DRzFobD0HZ72b/RK5ffKH1cqhzszKZ/J7BCmjZ1K7ldL1J0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdZLP+fm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdZLP+fm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773133092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W5ixMEPwXpO/+b+N1FZSIy8hHYQ/BR1nMYxWpusN4IQ=;
	b=SdZLP+fmI2XhOVd1rQJslvqAIf/lih57cvRePOQYzynQLJZHhD1MfhPDB44/7h/e96Ngxe
	TZv4CTqj6NlH4UE6ZyMgCx7Ac4iEoSwVttnrOV4d5qZaZmugHP+g8n4+uJJaB4bmunuUcg
	eW8z4DugOnHLGouSe1RccDIYlZRcV2s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-XKXcbAuVOJqVWG0Ryyuc1g-1; Tue, 10 Mar 2026 04:58:11 -0400
X-MC-Unique: XKXcbAuVOJqVWG0Ryyuc1g-1
X-Mimecast-MFC-AGG-ID: XKXcbAuVOJqVWG0Ryyuc1g_1773133090
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-485350666bfso19212235e9.3
        for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 01:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773133090; x=1773737890;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W5ixMEPwXpO/+b+N1FZSIy8hHYQ/BR1nMYxWpusN4IQ=;
        b=jwQPD4uS/DnhvxFkpUl/mDxAUSvSoK1KjJnr3RtL3HmPktHbY4YJd9Bzy1vfBlXTGV
         6VST1nW67njGSUscFzC0k9nc2wvEHE8ibZaQbAOGZ8rkA0M/I5Vst8Wx+tFKsKEYuiL5
         SDtekOASiLzpBVsmO9sZ2G83ES3CloOg2qsEGZ8bH4vxuQstbQVE4vcC64LxIEBZvodu
         e0UGxy+PfaTVDDWBBxff1GEjpbwyQp1BNU0oakyyBmMozmO5C4VVfyU++kFNdsL5UjrX
         INDHpjsnuq61NDa5v4jzH+SeB5bdGWSaYl8sVpbLU6B+xTy3lrzoXT4qlnYfuyods6RJ
         tpFg==
X-Forwarded-Encrypted: i=1; AJvYcCV6HeZ+nzHEhq8a3sMtFxQjMgnV9eno440K1RHH7uy7cdoX6YyoZef/NqKjqVo0qbNRcdI8nA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJoOU1O6nPNTBrQoeqHpxlMZeXL3GLfB/UUG7cKo/gWFq15BzZ
	PuSm+AHToPloYeg90xvoWFnmwCw/GvyEUoHSopsLa2Y+wjuqGcV7IkfcG2UaDC8/FUZjlE71OhN
	Q1T/fMrTuAiAy1gy/cfDWtZAFS5MU16v2x7EiA5xS22HJF1BSKAS1WxxV
X-Gm-Gg: ATEYQzzbzj5BelkkiUK79ew6OIf1EwN/sBRYxR4Kl0WuzoFNk0TQ2So0UZ80i4qdi5s
	xuP7bVfs+weDBilyfgGrYbAuRrq2/Sw/Txp/C+LWRYqoBebt4kjjtfSsHcuIMffaPLcYe6CXxDY
	jXxWO/9Tauy/Gp3fun+FZpPYGiAx+5C8+o/vNu8ut/xFFdy7ySHlgv3YGBz+cWvElIHTEB1Lqcx
	bsjqaVnP3pT4JAn5hndZ3Jyd1H76rl6e5EpqCxGQ+zidT2wgXb0OAZWDy3t6oQf/mhUi2oLNFzc
	bueInZ7xz+0QP/1MuFl3HUhnHcadSnQEBdQHpUvyyAsbSWz1ANLdladUTjrzomyLYeD/oopLC18
	MUFbgs5DRb7VK+dmGmOWIuKAlb2WQI28W/42phJi0Roiu42NqfA==
X-Received: by 2002:a05:600c:4712:b0:485:41c4:e2e5 with SMTP id 5b1f17b1804b1-48541c4e453mr36599905e9.27.1773133089734;
        Tue, 10 Mar 2026 01:58:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4712:b0:485:41c4:e2e5 with SMTP id 5b1f17b1804b1-48541c4e453mr36599305e9.27.1773133089122;
        Tue, 10 Mar 2026 01:58:09 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f3cdsm67159225e9.14.2026.03.10.01.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 01:58:08 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Cc: gmbnomis@gmail.com, Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, David Ahern
 <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, Jason Xing
 <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, Shuah Khan
 <shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <20260310095806.121d198f@elisabeth>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
	<20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 09:58:07 +0100 (CET)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1ssrZUPsjqU4NwZj9J6xWMlxN9PoIwbZL6k2zqMrg8E_1773133090
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Simon,

On Mon, 09 Mar 2026 09:02:26 +0100
Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org> wrote:

> [...]
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..73aa2e0ccd1d7a6314a00c27950b019b62a3851c 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -316,6 +316,9 @@ struct tcp_sock {
>  					*/
>  	u32	app_limited;	/* limited until "delivered" reaches this val */
>  	u32	rcv_wnd;	/* Current receiver window		*/
> +	u32	rcv_mwnd_seq;	/* Maximum window sequence number (RFC 7323,
> +				 * section 2.4, receiver requirements)
> +				 */

I didn't follow the rest of the discussion but, at this point, what
does this mean for applications (CRIU, passt) dumping/restoring socket
data? Do they have to adapt? I couldn't find this bit of information
anywhere in v3.

-- 
Stefano

