Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16C6376E0
	for <mptcp@lists.linux.dev>; Mon,  5 Feb 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148860; cv=none; b=ELm8zNtJYSant5c2c24ULjLnaUL3KJKQqENZsees9zna+AFIP1n/XDeFms3jeIZ1JxRMkhZl1s0fVFjEgeVWrzzurMGMQnqVHd2a9kHfkk8IkG57jL8Da5SSOwMUp0AgvcFOra6ukx3Ao1UMMbKps+rSDn5GAtUUzrScYpm2KJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148860; c=relaxed/simple;
	bh=WCHhBMH9D8J1UMQTkR+UPpQtXRRtLwk2AyIqPfd27ms=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0WrX2alZ4HsjENMObRkfJkWh54GFnkRDnZQandCbYH3m9l2OAB7vDGVJvoN2XFXfOtBnU0lamQuhfW6MWyOrqHhQhkHr0z7IC3NgbhaUx6XqgeXxuTsnXFps2xsTqnlsNYTe4xT3JxrfV0VbjLioI3cbozOfLox9lMZ4sj0bhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8JYvKrm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8JYvKrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707148857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WCHhBMH9D8J1UMQTkR+UPpQtXRRtLwk2AyIqPfd27ms=;
	b=I8JYvKrmTTH0DFh9aFACTTseR7tpwzIsGyopYYwM04g/GdeZjaZzzbz/aHO77e0tJ2CRNI
	TFgBQS+hJZZVRUmMVViVw46Z+OfY2/7AjF7i/HssswacoSmVoZnlllmu+ACq12q17pfsUZ
	14++10m9naCbVh+AFgI+ZiBXeD/prD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-_Pg0cAxqP1yserl6VYLPKg-1; Mon, 05 Feb 2024 11:00:56 -0500
X-MC-Unique: _Pg0cAxqP1yserl6VYLPKg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so10718165e9.1
        for <mptcp@lists.linux.dev>; Mon, 05 Feb 2024 08:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148854; x=1707753654;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCHhBMH9D8J1UMQTkR+UPpQtXRRtLwk2AyIqPfd27ms=;
        b=XlWeiM4b4O4+KOnS1Mw5S12lPcQTE29Uncml3pSyPIZmOpsoMc3ck58+n1tFz1OZn+
         OfF+PCAYWayF9Fp9bbwek1nvPRw3++3OzZOcmwmdJWsRz6Ie3zOzqIc8r/T/HQxNfdKF
         Iea70HOwaeh01LDcdOThHzYjGw8IZaf51khrlbrQr46AQHteOgeeNVVvvFq/7t2JtKXV
         TS1mp5s6sPyjH0Q+a9OXPhtWtWxn7fi5qZ7igUSX/h2QNguFF767X5r1FWrTVeXMNwGf
         h45YKEY/MJ3Oevq6Le3x/gIU0iXB2BTbE3Ql6pNeynbqdy9flTWVulB7uKJm3BvQf/D9
         sYuA==
X-Gm-Message-State: AOJu0YxNBAwJuiXm+587s1N2Bc6DzlMqhFD3GEqj4+nOer3jhQaqE+Wn
	tiGt0y028gA0mo5RX34+Tk1vNBM37MGT391zt2CUj+MTUMdtGPi5iSk4DqX1HOdueB6M6KTmo9A
	y2Lmrb4PjqUtH9967AED6Sdl/iEDa6gt51CW/DoV8322Cao0spxhHcvgeUanOtsh4puZXoK8yFg
	NjbqzEgNcRaDylsCBzKfIXSTl6xBTf6lsfbg==
X-Received: by 2002:a05:600c:3541:b0:40f:d0a2:e9e4 with SMTP id i1-20020a05600c354100b0040fd0a2e9e4mr137526wmq.4.1707148854311;
        Mon, 05 Feb 2024 08:00:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVnqC10674KGNLMPiwBqMkJBJ1E6YH8o06GL7rkXeqwM4qx6vAzLQi0t5OvdjMNt7aINM7Pw==
X-Received: by 2002:a05:600c:3541:b0:40f:d0a2:e9e4 with SMTP id i1-20020a05600c354100b0040fd0a2e9e4mr137502wmq.4.1707148853850;
        Mon, 05 Feb 2024 08:00:53 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-60.dyn.eolo.it. [146.241.230.60])
        by smtp.gmail.com with ESMTPSA id o6-20020a5d6486000000b0033b0992c364sm8359376wri.14.2024.02.05.08.00.53
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:00:53 -0800 (PST)
Message-ID: <e79d5c942e65c510c01e8e60c79087d7d696e2e5.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: really cope with fastopen race.
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 05 Feb 2024 17:00:52 +0100
In-Reply-To: <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
References: <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-01-24 at 22:36 +0100, Paolo Abeni wrote:
> Fastopen and PM-trigger subflow shutdown can race, as reported by
> syzkaller.
>=20
> In my first attempt to close such race, I missed the fact that
> the subflow status can change again before the subflow_state_change
> callback is invoked.
>=20
> Address the issue additionally copying with all the states directly
> reachable from TCP_FIN_WAIT1.
>=20
> Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
> Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
> Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com

Hopefully it's not too late...

The above should be:

Reported-by: syzbot+732ab7be796ec0d104ac@syzkaller.appspotmail.com

@Mat(s), could you please update the path directly in the export
branch?

Thanks!

Paolo

