Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203C2153D3
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569985; cv=none; b=fndnoaaVbuGeT5zFvqpfGKufTj5YGeSHl+rz7CeVuSjrR3bmNxUc5X5oaMRE4qCuzemlwddBRXxRS6FB2gR5Xx0TVr6LhWRV4MYAijUWRW3GGBqkDU+ojUc/frgpTkN3xcyhdeykCoCYCpOTUZCapknOnneYttu4tZflcRBhb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569985; c=relaxed/simple;
	bh=Xs4uLIbeh1JLmIdW8BVqyVcHHxMkSxKjPWsQFhcw7c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P4KX3uioaSohebcrmCuSg8myEAER+j4LzPX4vT/A9DwxtpRG6klsyXvhQKQkr0f3sC63IKbc5Vzu9h4yguiMUUsJUkr5ozoQ80rANP+BCCdtGFqed3wSbLlmImiqJLWlJ9N1la3lj8xa2b0ly5yKJZ6aM7In2O3F2Rj0js8KPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2AWhWoi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2AWhWoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740569983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlt89mJBO3b9uClh1I9sqtR/rJX/WDJidyU7JrR5Yjo=;
	b=V2AWhWoi5okT/rKdPFE2O5niEkn1Ei4HzCTqRWvFIUlinGh89J2ye4KH5Y3viHl3a/T+pX
	4Fh0cR8lIy2Mn3+llf3WezC3isk/UXDujLTSxV5Da9gJqtAvNtY43wl9mM71t3RI12ROXt
	Ub5FmaL+TSAtrvr8+dRQOVdZkju2xrc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-M_uiUv8IMwGCYKyJofvhNg-1; Wed, 26 Feb 2025 06:39:41 -0500
X-MC-Unique: M_uiUv8IMwGCYKyJofvhNg-1
X-Mimecast-MFC-AGG-ID: M_uiUv8IMwGCYKyJofvhNg_1740569980
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43943bd1409so45549005e9.3
        for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 03:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569980; x=1741174780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jlt89mJBO3b9uClh1I9sqtR/rJX/WDJidyU7JrR5Yjo=;
        b=Iv3Xg1tMHQyN2O510hoQ25lmMVDQERljkMlzjuaowgUTaquvKhr/K0N24LKnfo5dko
         Y5M8l67c4k8FjHfLQZ2lMFc+svijQH3N777Cogyyvm2SIA6fg2dvDuwnwVlbC6lplPUe
         zL3bCB94p8s7oo4hnjB0Fzap6XSQgK3ReZilW1mUzx/IvvUZ1t2+7FFFxcugOBF4k2nw
         NnX/mllzMrl07tpK0DCjAymccZy4dVSfNYUQyO/WnjZ4mDjhjFoE2Kyrqc8anzJFSjHl
         /qD/yQt6juROZdUL9JfFrDO+d/dYx0S6FkYhq/XpH7rwMHpIjG6wgfpkNZ+uSDUTuozO
         aw9A==
X-Gm-Message-State: AOJu0YxAJF/r2RzbpgRG8nyKEoVLfoGM1yiIR6kb7Nn3RuOehvJvlSeM
	QDi1SplChx6XC+KOk1GYG0+c8rsQnjKGH0vZOcjCMla4GDhjems1rNz0H1fJ5FiEt/RAjGik5sW
	KA+Z5MQPLPbPBzpNYN3/fsq1tmOCtVFp+tVi+g7k6MDEM/8vCHTg+QsD5NpYAnWU=
X-Gm-Gg: ASbGncuNEOZy2T0PJK8q2OdHr+Y2mz+IpJXboCoqTKj6ik6ueSpLw40s9z0sDARUOGs
	SN543Rh4b7Yd3xIdE8OMZVeSzcAbxMpKm7KjZ8Ev60y/CKcx3V1sgl9JoJ4GK2ALy+PIpfDl/3X
	240GJSf8ofb6xAtK6Xasx0hP3MHUSFnBXufvEjHFCeXLp9BY7LAJ6YZI0GC4elalAy3IV0OQ/iI
	XMbKox3oF/LYHW5jwj7WcDGEqb4HdlZnfMttx8gdsy2+2xURyeDAZ16wBLPYIaX752XSTGXxqCo
	3SyiG4hL57XN+A==
X-Received: by 2002:a05:600c:3b83:b0:439:86fb:7328 with SMTP id 5b1f17b1804b1-43ab901559fmr21818385e9.24.1740569979857;
        Wed, 26 Feb 2025 03:39:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuGu9HKQ/RnBgzdirBxtvPXctqWB60tDw/ZLFHevPyi2Hi12pm6Soy+/UrteE9L4z3noJrHw==
X-Received: by 2002:a05:600c:3b83:b0:439:86fb:7328 with SMTP id 5b1f17b1804b1-43ab901559fmr21818275e9.24.1740569979560;
        Wed, 26 Feb 2025 03:39:39 -0800 (PST)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58713bsm18783495e9.34.2025.02.26.03.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:39:37 -0800 (PST)
Date: Wed, 26 Feb 2025 12:39:36 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] tcp: ulp: diag: remove net admin restriction
Message-ID: <Z779eOu4pVeIFy7A@dcaratti.users.ipa.redhat.com>
References: <20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250226-mptcp-tcp-ulp-diag-cap-v1-1-e1a003ad0606@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: omYfww34N8aEZNghOPuj6EuJcbArRUZWS9i7SS9phyo_1740569980
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi Matthieu, thanks for the patch!

On Wed, Feb 26, 2025 at 12:26:36PM +0100, Matthieu Baerts (NGI0) wrote:
> Since its introduction in commit 61723b393292 ("tcp: ulp: add functions
> to dump ulp-specific information"), the ULP diag info have been exported
> only if the requester had CAP_NET_ADMIN.
> 
> It looks like there is nothing sensitive being exported here by the
> MPTCP and KTLS layers. 

if I well remember, at the beginning we have been "cautious" about dumping
local/remote token value to unprivileged users (via 'get_info()' function).
But on a second thought this scrutiny makes no sense for values that travel
in cleartext inside MP_OPTIONS, so...

> So it seems safe to remove this restriction in
> order to ease the debugging from the userspace side without requiring
> additional capabilities.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Davide Caratti <dcaratti@redhat.com>

