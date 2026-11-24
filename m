Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795518501;
	b=5gEhvvFeByRcJzLnjUV1YPGXMTpLbrFkUyECbLIbWN5dOupmoQR/mSdiCup3pLzuxcts
	 FNNjl+fndvPvTrRZcuSil6pRKiXDN6XtpSlpn+mfwV0B1zxDIsLz4EssVklaMvqRVBdJQ
	 cHcuRQfPgoJAm3HdO475sGBsQbTrVB7QAt9q4iWREKxC+5igND2od/9MdwIv4xIY2+r68
	 4nUhmAZixq+VHhqjNYWwvnVgw8Z28PbGDgjzd9N7Sckq7iKsVL+m/ueN3/YOcOvsdKELi
	 1yOMHcDyZ6jPqrS/cbKCgdD5b5ZRFA8HoOZ2vDmR2qkywUChATItNU3gf7mUR8o6nGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518501;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=5Q0nUsmS5dYPNLn3YcCxx6eDOdrN0AGP4TE6bHVglfI=;
	b=o96PlPI0I3mvMmR0korrEflkr7KpptOG3NEn4dwo24atsFU+WiVtLJOT+RUrGIOHFHHn
	 okRMCpJQG8LOXYkGlAp9g84v2QEQAwZrhhsbrI0KIqN8j305ct6C++XBX9TFG4QKUuUEi
	 tyfVcU7XbnpXBuBpZ3aEeJaNVh51QOGT0fjlyq8b6y6NFBbkH/LB7y5CCJvV3+p+SPFpQ
	 ZACLJQUf+gNnLhU7/1Ov48ZJ6ZFhcT8XF4wJTA/oYEfMJglNshhMsbCX0LPHyipvFS3EA
	 Y3m4YYttNUQEIUWu/lltVsZHQM8GzP/3sAy19jsu870FjUJ4CiJXQ4/LYyxfxIkHMVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59A606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 11:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E59A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795518497; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hQHEoekoMs4lc57XXa+dm4tri7mrGojYB/H+wNlOW5/mPWfEw1fYoPrPU+y650LfCzahwwlhamus0/kcybphBoeSJIAEeig6kDfcXQCBVGd4wrsVoZyJHQbdxEy7OMulNZIAGo+lEbv1CCv4k6sBN71MVmityyHQ/2D0op8ghag=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795518497; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5Q0nUsmS5dYPNLn3YcCxx6eDOdrN0AGP4TE6bHVglfI=; 
	b=A6ED0R3nz+w+bFmXb51yukP9Sl52Jnd9HWMiHU/3t2rzff6uRYVYMqK+lT9N7gvpnrVMjMl/RrLQdkGA5G1W3ThK8pw5mSs1Gn8UWvhQ4ix+PgQXikHajHvzX058CE6KG5Fcpp/ivg0Bg2IdDqAJ00o2rB8fqp81H3dunqPvUV8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=dwn8UKasrD9UkXH9t02+R1w+I5gohJViTIAlI7T3YZeJsZjr7vM+d2+IcH0q6cmdq+zEumzpKzvpzbBLYvGD6CTaf930QTwv/hLVG8NYMrML6bz8fsX/g0sZwtbJqhPFGj+icMTr/MgQn3J+A5EG56edKBYEeqnKQULJcTV0+KA=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=5Q0nUsmS5dYPNLn3YcCxx6eDOdrN0AGP4TE6bHVglfI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1795518492523393.4838538486845; Tue, 24 Nov 2026 03:08:12 -0800 (PST)
Date: Tue, 24 Nov 2026 16:38:12 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a20d3def10.5b910baf7779.702190847381737510@mpiricsoftware.com>
In-Reply-To: <5c2c389f-f669-4284-afbd-088d5324e1fa@kernel.org>
References: <20261124102214.3930527-1-kalpan.jani@mpiricsoftware.com> <5c2c389f-f669-4284-afbd-088d5324e1fa@kernel.org>
Subject: Re: [PATCH mptcp-next v8 0/2] mptcp: add core-enforced subflow
 avoid flag
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

Thank you for the feedback.

Understood. I'll keep the series title and individual patch titles consistent across future revisions, changing them only when the scope changes.

I'll follow this approach in the next version.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: <mptcp@lists.linux.dev>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>
Date: Tue, 24 Nov 2026 16:20:54 +0530
Subject: Re: [PATCH mptcp-next v8 0/2] mptcp: add core-enforced subflow avoid flag

 > Hi Kalpan,
 > 
 > On 24/11/2026 11:22, Kalpan Jani wrote:
 > > The MPTCP scheduler needs a persistent way for BPF schedulers to
 > > mark subflows that should be avoided across scheduling rounds.
 > 
 > Thank you for the new version. I didn't review this series yet, but just
 > a quick note: could you please not rename the patch series (here "mptcp:
 > add core-enforced subflow avoid flag" and before "mptcp: add
 > scheduler-owned subflow avoid flag") otherwise it is hard for us to
 > track versions, and it doesn't help to follow the modifications.
 > 
 > Ideally, try to do the same with the patches as well: change their
 > titles only when the scope changes.
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 


