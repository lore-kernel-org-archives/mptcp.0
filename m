Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1E40DFAA
	for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182084; cv=none; b=NwX4Kb5kO0uQBUYB4IqZezNL16VJjUyq1GOlPqQnq4ktzkB9eW4y9Kw1qZPKTyP5nxqFz/RXnpTVzYsKYMnGkRb+J+V8QGYGh5kMF7HmTr5asbhwL8X2iu4fvXtPatqgvSl3M33+zBgWWc+c0zy8Uy0I1mhIZxj69fufEE1ueDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182084; c=relaxed/simple;
	bh=gA1+6V/KieO2PhMuLUC9X+yRGVh4ZS5XyQKNHLvoAmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+Y4PI/tWKXN+i5ltvqUxxmHley2XQI2QPwwuekJYzUN6+x42bM2NXxqojxYF43kzwaBp4zo4+suRDrPKq/AJ7x9fFoW4ytbi0sQW15+dOodJpJYeOSm+bWwhG8Bobx4rEBv8wBfkQzUALNonL5K9kH2egLgvoHNoQ/4oFzPT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2ZHhkHi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2ZHhkHi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso109907845e9.1
        for <mptcp@lists.linux.dev>; Tue, 10 Mar 2026 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773182081; x=1773786881; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXU4YewdIeXEw5CIQLJ4hSfe0f5ekUOc0dg0Lb4JccA=;
        b=h2ZHhkHiXUr0UzERGctXtr/zpoxSWLGo/BUibmy1KmiNwyfd5jK7GTHpDNcbKNRgO7
         X6CdXjvYDLNs0/DIuQZrHHDhVBT18P5177blITb4cRcFIFLKDA0FiPMrz3bHQRwcZLyl
         Szx34ELUXNOSIokfNYL+hzjkEbgajSCfVeN5dcH/B3Q9DnSzPlBipDcqfhjWrriFC6Jk
         +Q0K2sECcv/RIWvHxQLhVL3bRIUlfkYe/cEkUVV3T66a/W9jV+Ynk9g33OdTODQK7gGH
         ALV1EV+rQa+6CwzI0R5MLhsxO4D3trqm82QVTdMQAC3O5zHQ4bzHDItj2tD4L10hMD8j
         /uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182081; x=1773786881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXU4YewdIeXEw5CIQLJ4hSfe0f5ekUOc0dg0Lb4JccA=;
        b=VgZ4X+aE5cL50tr7oTDmtn4DVzDOYMgoYRYp71zJkg50XaysFOv3ovOmD09/rnEleF
         2k7iYrSpC57oRXxhGAphXHXMPOGR8MaXloKEtNr3hrn5oOGRT2hDnaSS1zvkH2j3NfVW
         GzJ4SQwOwYG9WjeDv6yjCzc9ArRVxfTipt76B707c8BCMr3RkNj5Jg5xndkomFO81M1f
         HB5sHF6wY/vKcV4DrMXkuLh8fOtgN7J4+ybBssoSZTcWgYaQye9K57e5V2/bVSQOs0kL
         fsUgU2xdMRW6hZvv2YwtD+Mi8uEcKv6OAafv60UKa3KRIkCKIs0fq0UxwqhcuPaFFdx1
         VB2w==
X-Forwarded-Encrypted: i=1; AJvYcCUkTwCJHqSZJWzekVat/4FbIOlG1eg1nYhXZsZe2U1WlAOBrGoqqitajg24vAKeLzPmneDhXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0eBkvoyENTPOkW/QM9Lv5fCMMhQpilPQp0X5mdImYU9kiIwXv
	zytb3e8QNIMseX5PihjbiBJsEIbwNE0kivSyjcX5njV3JB2wPk7XhsKv
X-Gm-Gg: ATEYQzw0J9q27hiQKRCO+aPnBTR/wmE5uYco1iQM8Yhb8GUjl2qMC51QcewY4IMi8A/
	PPuVMpWt9LO2R+bD3OKdw3RhFyaRVny2oSM8EWmWS0u2qhYNPGcO5gnswF9j9kQFWHa866PaVPh
	icnFYeKQChk56KFF05GeTB5bShMDk1zYSCXNrCHMjvmn7UUIZ44IxrlPY003yfVtrshMNXmumu4
	vQLkKe3toBDcgFd8EtSMxDi+LMxzRs4WUjQWGKxAIRp+VunoUDSBN8AdTVwmtseM+AAbEsrS/3Q
	3e9UT4OH/Nq4Tl2hbTw9IU/Qwhz29RLoSwL6eoaABI5PU8gM1Zo7YzfyaE2aSRymujgFt7jXJ1J
	nFI/19oze3LniC69s7Sc8W/hOzRoKWWtfMKvnLv8VNxt+go+YG9Gw4ikZzx06CAnkv7M6I8KfYx
	A8aYyYMzeliqvGhlfCUJ1syeeUZhQg9POMRZIR2YjqegWm528g71lKIFxekjGPrYseNvVk/oW9B
	NWdchIcIReTkg9PQ2f6EuU=
X-Received: by 2002:a05:600c:1f8e:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4854b0ca217mr8508535e9.11.1773182080137;
        Tue, 10 Mar 2026 15:34:40 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a307bc4sm7973655e9.3.2026.03.10.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:34:39 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 21673302C729; Tue, 10 Mar 2026 23:34:39 +0100 (CET)
Date: Tue, 10 Mar 2026 23:34:39 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/6] tcp: implement RFC 7323 window
 retraction receiver requirements
Message-ID: <abCcf1opVAr8CvpL@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-1-4c7f96b1ec69@gmail.com>
 <20260310095806.121d198f@elisabeth>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310095806.121d198f@elisabeth>

Hi Stefano,

On Tue, Mar 10, 2026 at 09:58:07AM +0100, Stefano Brivio wrote:
> Simon,
> 
> On Mon, 09 Mar 2026 09:02:26 +0100
> Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> 
> > [...]
> >
> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..73aa2e0ccd1d7a6314a00c27950b019b62a3851c 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -316,6 +316,9 @@ struct tcp_sock {
> >  					*/
> >  	u32	app_limited;	/* limited until "delivered" reaches this val */
> >  	u32	rcv_wnd;	/* Current receiver window		*/
> > +	u32	rcv_mwnd_seq;	/* Maximum window sequence number (RFC 7323,
> > +				 * section 2.4, receiver requirements)
> > +				 */
> 
> I didn't follow the rest of the discussion but, at this point, what
> does this mean for applications (CRIU, passt) dumping/restoring socket
> data? Do they have to adapt? I couldn't find this bit of information
> anywhere in v3.

Based on our discussion, the "Setting the TCP_REPAIR_WINDOW socket
option initializes rcv_mwnd_seq" v2 change addresses TCP window
restoration.  As we said that information about window retraction is
not crucial, the window will be restored as "non-retracted", matching
prior behavior.  Therefore, there is no change to the information
that applications need to dump or restore.

-- 
Simon Baatz <gmbnomis@gmail.com>
