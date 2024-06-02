Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB29370
	for <mptcp@lists.linux.dev>; Sun,  2 Jun 2024 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717292108; cv=none; b=NgH88Y03Gv1En02jOih3ATMBHGCVwzeF32CBjBbhx07tgIwaw5wjNhBgTcaajS3cbCCkDao4/aOabXVxivtYMWzt7QfF/EkM1l5v+Bas+D5RtChbNGR3tKO52FjoSx1iif7rxAOZi8Ls+g4IH6Cx5qi2hPoGCGYPyLuWbRXTCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717292108; c=relaxed/simple;
	bh=zOm8LsWoqxyyYNtXt1211IJq2j1oNCELPPYYsNwTw6E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lIROT6UWaKtzDzT5lDHB1ftN5p1CYPWH9L8CKDV13birz27a079AJVprH8k2hlzGxHKdR9j56wnnnQzZ4flHFaB50YxSM7D4THv82FXkXe2T3Tu4SYHIKwOYjKrG9Ic9/Pql9dIwS/eIYU8R7m3RSNZlyitKXSKcO9xg6K3F+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsNJwAxF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsNJwAxF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ae60725ea1so13073026d6.2
        for <mptcp@lists.linux.dev>; Sat, 01 Jun 2024 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717292106; x=1717896906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9ppVBOWciW7VBoZG//V8PspX74UoRB+vuqQeneEijQ=;
        b=JsNJwAxFOaHiyulwaMgpScl4yz2xb24Rz+b8Klm7UsBDvIa2Svuo1ZDNt8Rdkb/X8+
         UuYLdxNyERgf3rgpmJarbln0TR2/1pTx6sSXM5Ogb7pUmt6A+44t0Mkes79RoTLUCZ/n
         TPSjxZtwzNgfARLOqoWPRuLfbJIWw0rKMxW7PkELoRFGLXxi/hMuByx3pItZp8dmXBhp
         /5/ReFQyw1P1CHK4ny/wRGAcsww34oN+6TN/yIS4c2A4VNBhJFKTOrZIy7uAEIXM0LQX
         78YUOH7S3uidHkS7JXS1VevVEN/27IO0mV82WhtEVfikLVj763tFA+wUeYKAaclha0gl
         EN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717292106; x=1717896906;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o9ppVBOWciW7VBoZG//V8PspX74UoRB+vuqQeneEijQ=;
        b=soGW4JBJ+OnlTocC1sVxkfT6f+48/DkgJ3ez4zRzLvdG8CKzsWEBP7ZI8XDABG7Hn3
         RZcY83hksYExkpUKMLVNkCercp5SuazU9nA17Z7Y64LcXJZLfg9ZL0COoyiQGEVde39a
         6g0LIGKzNmkyHrzb8JSVXjsguxvzCmuKserP4pvsiAnWHofsBf7Dh37ji/KG9GvB7nNF
         phljLO0ydJ4O3pjTE1EjVra+5srW/gxWpS6pEzFWG6vKI1rfZo/nOUlNGgb6L9jQ8qF4
         UJJRKL1bY329g1w/G641vNjI/dPMbRF+UkFy5TWBkVXSrhkCQkhlql3HvAjhOQR+Nmf+
         1aTw==
X-Forwarded-Encrypted: i=1; AJvYcCUkAJGUfGpsMhmL8zUKvAM9qtaaBKTzB/UknOe/ghMJGvfYLPP36rXTJ3ZdGEjJWiJp40A4RChLAG1cct7/xPQ3t8obM2M=
X-Gm-Message-State: AOJu0Yw6rP+i8adm+Xc/JByatpLwRSSA5m5br51y42/IPDZ6MmlV3RGE
	ZdC6ZKEn3YkMRoNqmYwCKZSAc+vs4nK4vtCGPMPDIZ6JYujKVI18
X-Google-Smtp-Source: AGHT+IElFXjAaw0z5HqH5gIclh6dcm5V837UNKlZeT/cTKmlsFQ4NyXNqrVamMB3+jWq8tnRnjJO3A==
X-Received: by 2002:a0c:ef04:0:b0:6ae:d591:3a4 with SMTP id 6a1803df08f44-6aed5910519mr45849276d6.11.1717292105597;
        Sat, 01 Jun 2024 18:35:05 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6af3d644efbsm7047486d6.19.2024.06.01.18.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 18:35:04 -0700 (PDT)
Date: Sat, 01 Jun 2024 21:35:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, 
 pabeni@redhat.com, 
 davem@davemloft.net, 
 netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 matttbe@kernel.org, 
 martineau@kernel.org, 
 borisp@nvidia.com
Message-ID: <665bcc4869dc3_94803294e9@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240601145620.065e6a5d@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
 <20240530233616.85897-3-kuba@kernel.org>
 <6659d38ac31fa_3f8cab29482@willemb.c.googlers.com.notmuch>
 <20240601145620.065e6a5d@kernel.org>
Subject: Re: [PATCH net-next 2/3] tcp: add a helper for setting EOR on tail
 skb
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Fri, 31 May 2024 09:41:30 -0400 Willem de Bruijn wrote:
> > > +static inline void tcp_write_collapse_fence(struct sock *sk)
> > > +{  
> > 
> > const struct ptr?
> 
> Maybe just me, but feels kinda weird for the sole input to be const
> if the function does modify the object it operates on.

Ok. I can see that.
