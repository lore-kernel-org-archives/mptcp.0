Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB75173
	for <mptcp@lists.linux.dev>; Fri, 13 Aug 2021 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628864089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uwnx1sA4Nm3U/yPDVaxZdkTT2mpQ8JwwO/W+0vQdQHs=;
	b=ibE3WTllWoeUqz2cSieEJpRmIrIHsH/yK2NtnfwjHmKlu2tMIyzUbmONoqZnrCpK8AE6cT
	c2chwE3Lj9nc6RiGjnyLUBktrBgcc+2AUs73SUCoCBCYzQKzpFOON74Cl05RU65bO+Zv7T
	7whvUYKvB+9IAvHO3Oz3pvGyTMWLLBs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-FWVOXUlqPE2XEYgL1Gi3Lw-1; Fri, 13 Aug 2021 10:14:47 -0400
X-MC-Unique: FWVOXUlqPE2XEYgL1Gi3Lw-1
Received: by mail-wm1-f72.google.com with SMTP id g70-20020a1c20490000b02902e6753bf473so4793803wmg.0
        for <mptcp@lists.linux.dev>; Fri, 13 Aug 2021 07:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Uwnx1sA4Nm3U/yPDVaxZdkTT2mpQ8JwwO/W+0vQdQHs=;
        b=TOSVcjxe2wFXzVvdmE9IcZ1+7yfz4uMGrpozaZhI773b3ydELMYbxCVuzdmpQq/5J/
         ODuWE4Cp+e8GBe4xA0uyidqUlETVDyLFHxu0G1qIAlZy9qRG6k9qI55yNuVdGoSGTy0z
         2KYS384/snSg7RR0kHATHPddcBF16W/xEY03aHIAPhS9y05qXlfTHDfOKg0DlKI4NNyO
         U0cii3xvJpW0pqtD6hmVgGfJ+kNnOdrYI6vI5tiyVeelYVnm5r+9Nnrs8m7vRSeUAQbi
         VoiOEGvZ1ShcJxAwFZVInKug+D2y+rAgAVn40ExsGILMvWakTGWYCDJ+4cLPAhEmXqdg
         mEJQ==
X-Gm-Message-State: AOAM533K8CM6JBq5RWF9Wx0kB5lBkymk8JHEVWhcxW5nlXEfUE2NULyy
	OEd7Hd2OYE947ww8by8GrTXVzDc3n9WahvmaCS/+2RusN+tYwyZylBOZB9wcLKoRYW59ylfNj1W
	T0dzWuUikHjhwSmg=
X-Received: by 2002:a5d:680e:: with SMTP id w14mr3496813wru.57.1628864086608;
        Fri, 13 Aug 2021 07:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpjeRT2qoQOiBlkUr8nLkq60XkdOd0WUMLKBTj3OMLJO830lYP4tQqSU4aCzqu2EeAH9xVxQ==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr3496794wru.57.1628864086406;
        Fri, 13 Aug 2021 07:14:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id o17sm1433856wmp.13.2021.08.13.07.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 07:14:45 -0700 (PDT)
Message-ID: <5b996b3fc540926a129c2f0c45634def94074f01.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: full fully established support after
 ADD_ADDR
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 13 Aug 2021 16:14:44 +0200
In-Reply-To: <e8ce0aa4-c8a5-8907-396e-be420aec6fe4@tessares.net>
References: <20210812162757.282366-1-matthieu.baerts@tessares.net>
	 <cb97b91e-99d-d7b-4338-a83ddba4e83b@linux.intel.com>
	 <e8ce0aa4-c8a5-8907-396e-be420aec6fe4@tessares.net>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-08-13 at 13:06 +0200, Matthieu Baerts wrote:
> Hi Mat,
> 
> Thank you for your review!
> 
> On 13/08/2021 00:30, Mat Martineau wrote:
> > On Thu, 12 Aug 2021, Matthieu Baerts wrote:
> > 
> > > If directly after an MP_CAPABLE 3WHS, the client receives a valid
> > > ADD_ADDR from the server, it is enough to prove exchanged MPTCP options
> > > are valid. Indeed, the ADD_ADDR contains an HMAC generated using both
> > > the client and server keys.
> > 
> > The ADD_ADDR HMAC is validated after the call to
> > check_fully_established(), so I'm not sure this condition is fully met
> > with the patch as-is. Looks like an ADD_ADDR with a bad HMAC could
> > change the fully_established flag when it shouldn't.
> That's a very good point.
> 
> If I'm not mistaken, we have the same issue when receiving a DATA_ACK:
> here we just check if one is present, not if it is valid, no?
> 
> Should we delay when we mark subflows and msks as "fully established" or
> is it not an issue to be in "fully established" too soon?

I *think* we could/should start with this simpler implementation/fix -
eventually adding a comment explaining the problematic scenario.

A more correct state handling requires more extensive changes, likely
too invasive for a resonably timely fix.

Cheers,

Paolo

