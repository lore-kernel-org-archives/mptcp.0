Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD01BF50
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082618; cv=none; b=pC8KVKfJ81VkvVZK08Bfvw1zZCStfteqeNFCBkUyvrZfWN9MfqY2UK9eP0KnlQuI40kb331AikeiBkQQFFMlLupXfdRlMGZMxB5aPWds1c5vtmBd9iD7FBr1fJ9PAX4GcnVpmTKsFbtPr+cgisIRBG7r3An96fPYzKPU+UqCxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082618; c=relaxed/simple;
	bh=TSFA1We7nRa6b3Q4x2mgXtc3HUvZwJ9Ndh3cfxERbbk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZroqfmekyXSQCgJF6+wTMJYrkugrVKvCdzSaho076L2j45iBSFAew9ED4uB0cHix3vsvM22aXNoCWOoRvKEmxsEiyBJSM2/vPUrcI7K1Rrk+kjS6uqrBYsPRyX72ZMwuXVmBqr9QFPftiDJpE2TI1jNdslW0a8FJa/xDWz0LQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv3Jgpqd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv3Jgpqd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TSFA1We7nRa6b3Q4x2mgXtc3HUvZwJ9Ndh3cfxERbbk=;
	b=dv3Jgpqd8qWHEkgW8V0UTMjZ4HxxFlLQ1uOqKXA1Gvmrf9zcSe6tIPwp2wt3uq+ardWJxR
	/kJdh5neerL26OOvzOYEcvhDLYsDp9xpa4aX2Fr8GMROIihmAGDMaPDDgTaIFKLh1qQOGl
	uBSmj4Xe04EncyV4UGiKSkZhXcTvjNU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-1xDOWaKiNMeA4gg1C5GyxA-1; Fri, 16 Feb 2024 06:23:34 -0500
X-MC-Unique: 1xDOWaKiNMeA4gg1C5GyxA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33b226e710dso138445f8f.1
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 03:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082613; x=1708687413;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSFA1We7nRa6b3Q4x2mgXtc3HUvZwJ9Ndh3cfxERbbk=;
        b=U3k7PW6P35qlC21UIwJPjbRTFLAT2oUlnS1pnu+iv53nvHMRw3eKNjIBi0burQfEMn
         tdvUC3gmNhEm8CYAafpxDIAMEzmQnu0FZc1zJKS8eUWVjGbD4KVbJ6YnEhz5nIvQ5TL/
         LKT5EqTQmm5ab1zAOXXpLjknuXsiecNvsR4l7Mq5/ZnUvmavHbXjhv3qr9NLYgUAugZJ
         54kMACJzvaHFkeIs0uxjMYwY40ENrp3x/4PtOWUiYfVdLKBK0yZ0KZ1E0dio+pbeRisZ
         fp6mqlo4LudXZ+ELGgE/VtCmY1gYgUaFBKfJLegCDb8AdXvsbG9mQc/8/yL6OAGaJW8E
         yJKA==
X-Gm-Message-State: AOJu0Ywn0HLpNyYvx+/dUznQjvXJ1lbMPi1shHrEZD2wx7EYY/+Tmxmd
	rEJ+Xvw0FzdhTnKOsLm/sD32icJeC8Gt5Qz5nGiB5aYI+1nKYLeE+WrV/+X0aLWLy9lLftqVb+x
	AQiuB3sOBWV1rekZopRGhB+54rG3mVoNFwlPYipZIqSI1vxi/WJtaJm/lPX5c
X-Received: by 2002:a05:6000:1f09:b0:33b:88a0:a1e9 with SMTP id bv9-20020a0560001f0900b0033b88a0a1e9mr1215467wrb.4.1708082612820;
        Fri, 16 Feb 2024 03:23:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLRJHUfeg6nzwFtWyaiNIv0SjIqiSpeVybJ7Fmj/UT9NDM0zBV5QUx9FwJ4UNwf9289Uk5JQ==
X-Received: by 2002:a05:6000:1f09:b0:33b:88a0:a1e9 with SMTP id bv9-20020a0560001f0900b0033b88a0a1e9mr1215457wrb.4.1708082612446;
        Fri, 16 Feb 2024 03:23:32 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-239-108.dyn.eolo.it. [146.241.239.108])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d50cd000000b0033b8881f31dsm1903369wrt.68.2024.02.16.03.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:23:32 -0800 (PST)
Message-ID: <e7769e4c030b06c8ea4b14857a22eafeb9c93277.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: avoid printing warning once on client
 side
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Fri, 16 Feb 2024 12:23:30 +0100
In-Reply-To: <6b9c4a3e-3c30-4e7b-ab99-ed2e34e24015@kernel.org>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
	 <9502e96c-8a72-a6d4-ca2d-1c75c536bfa3@kernel.org>
	 <6b9c4a3e-3c30-4e7b-ab99-ed2e34e24015@kernel.org>
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

On Fri, 2024-02-16 at 11:42 +0100, Matthieu Baerts wrote:
> Hi Mat,
>=20
> On 16/02/2024 00:25, Mat Martineau wrote:
> > On Thu, 15 Feb 2024, Matthieu Baerts (NGI0) wrote:
> >=20
> > > After the 'Fixes' commit mentioned below, the client side might print
> > > the following warning once when a subflow is fully established at the
> > > reception of any valid additional ack:
> > >=20
> > > =C2=A0MPTCP: bogus mpc option on established client sk
> > >=20
> > > That's a normal situation, and no warning should be printed for that.=
 We
> > > can then skip the check when the label is used.
> > >=20
> > > Fixes: e4a0fa47e816 ("mptcp: corner case locking for rx path fields
> > > initialization")
> > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >=20
> > Looks good to me:
> >=20
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
>=20
> Thank you for the review!
>=20
> > > ---
> > > Notes:
> > > - Should we convert this pr_warn_once() to a WARN_ONCE()? Or just in
> > > =C2=A0 our tree? Or just in DEBUG mode?
> >=20
> > I think it makes sense to keep this patch minimal for -net and stable
> > (just moving the label).
> >=20
> > Also given the consequences of panic_on_warn, would be better to make
> > any changes to WARN_ONCE() in mptcp-next/net-next. I don't see extra
> > complexity to modify this warning in our tree or debug mode as being
> > worth it, do you think it would be valuable?
>=20
> Sorry, I'm a bit confused by your reply. For the moment, our CI
> complains when a "Call Trace:" is printed, but it doesn't complain when
> there is a pr_warn().
>=20
> If the warning here can be caused by interactions with a buggy host, it
> makes sense not to have a WARN() when used in production, but it would
> be good for our CI can catch that. If the warning can only be caused by
> an internal bug, then easier to use a WARN_ONCE().

We can trigger the warning due to either:
* local S/W bug
* bugged/malicious peer.

I think we should avoid a WARN there.

> So I think here, we could maybe convert it to a DEBUG_NET_WARN_ON_ONCE()
> and upstream that. WDYT?

DEBUG_NET is quite lightweight and could be enabled even in production,
that should be an export-branch only change.

Cheers,

Paolo



