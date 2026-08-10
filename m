Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5833BBFC5
	for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358874; cv=none; b=YOt4l5GxbJDuxNrKPdGPIOilIWGo/j582neg05Ynr4RvMezGa0p6AYcKpUpNRosACHIucpIjW2abYGAReZg07UA8l2T7bo85J4nLs0nIlEg3IlIjhMXUyveggzfpAiYflV4pwDYud4xl6nvpUCXEGyGmoiIfBH54tQ1pqowLAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358874; c=relaxed/simple;
	bh=meNf7+x8ONkI1UHgZWbnslFcjB9GTa13B68C9HYYvH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxnsMApp76nS50v4RynMhLstl0Sgtk0QMpWTOaM8IvYVPbGEFJMVWMwaTXkyKARtex+KPXvTimukPgdTBU87MQYVmuGd9w3HGdPwNln4LYRmg3nwqLHojaYuobyP0SDIOVyntCxOQWwmwx2qAHvYDLMHZoN+mzrZhirXHXp2ZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PF9GLfCP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PF9GLfCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786358872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoeY0NwHkX1PzwAI0P/PD5TTdIj3G9cAX1yqmI1hONs=;
	b=PF9GLfCPi5OoSLr8tcWy7QtxuDIPmyOWYpb+DUpBe1MBcQfUUi4c3wFfFVcCE1UPUx9SwU
	gjz9BR0e5tiUMGOQwrnSn6l7obONeYNsn1aGHEfhTPpL+huoI3v2IVlQol00HRuviiocpE
	JkzSlXj6Ihdrz2JrDtn6Hko4+ToPP90=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-nWfZ58xEP_GeDZwRp90zDQ-1; Mon, 10 Aug 2026 06:47:50 -0400
X-MC-Unique: nWfZ58xEP_GeDZwRp90zDQ-1
X-Mimecast-MFC-AGG-ID: nWfZ58xEP_GeDZwRp90zDQ_1786358869
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495569acf8dso10449915e9.1
        for <mptcp@lists.linux.dev>; Mon, 10 Aug 2026 03:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786358869; x=1786963669;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CoeY0NwHkX1PzwAI0P/PD5TTdIj3G9cAX1yqmI1hONs=;
        b=UEc2dPdxAzZZM0Uidbsr5IMjTlVrnw4sSoCccvFjBqvtu4iUUp5Jv3ox52RFFXMeaN
         6LThyeCUN/JEGEud+HZW12/gYq6an5LHiTWBYljKSxxiXICw4wzTtwP78CIm5h8r4HZh
         AgMMR1JKyz05zVDy6hsS2vUutxKlRJWAKzXa9IrHsWSatmIh7OXnQbgdRfVUwxJrL2G0
         TMsERth8ZAuAKgOm/MUFtZVzB5+YgXtmXtbVUE+yWtEp3YzI7rKbUdwYQTR1STYtGQfV
         O5lnwnk6UB7maKcPrH1lK1/ESvfTjJRZLNePyPun7dSVQWVwFvY2zTnAndbgIbSyTuKq
         HgXw==
X-Gm-Message-State: AOJu0Yxc2g6Pm3+ArYBoFQE6A+a51KgSStwdoUwjR5kQc8AfwZs2cr1J
	asYEUiwnqZ/3laGsUf0oR9zKc0JrFUEgiF29EavcOy9C/sDRNUppu05mVG94A21m4wBuE3JqbGY
	DWOjI4RAZKmKQBaKi2VjKG8AlnvPxIZCM11bFEwaGnTenIBGmPy680xx1
X-Gm-Gg: AR+sD12RnE9rIXwVvDiSO5cTiwFw65xvId7xSCaAeEB/Z+4aiQ8T58r3qDqfRXN97O7
	8Vd2yZBy9WPOlZ8SVjqX7SmTO6qLtDmCNRIHg5OroZdPUREjbfOtkn59Uy6QB8xjL2qcm/Rz+5a
	1QRdwBKjp9Ig9vWRaY7RopDe2JHyOj1baAsLLQnNcePgTuTsjd0NG9WhRMCSqSNodrwvDFP3vAs
	sY96SU4mEsAGyrPWmksh8pmwHoYDBWOnElUIOO25nLBPEHIFlyNhHBedciRfSCTeSzUEUkgJ2d2
	NLen5O0MwEgd5bCyNDLLQwYNfgmgQu1Gj1ivB6x9/GlbD1h90RqHSHV3TC3dvs/Z1wmqwIgA3VE
	/2JJcBM7Q8Bnn6WAldP69mTV3rNQ5ZDzRNXmZCCdkN1di6YgUagomNLN1dscp6Hl7TXSbytKk3z
	U=
X-Received: by 2002:a05:600c:c043:b0:495:7a5a:d96c with SMTP id 5b1f17b1804b1-4994e7d89cfmr433715515e9.18.1786358869170;
        Mon, 10 Aug 2026 03:47:49 -0700 (PDT)
X-Received: by 2002:a05:600c:c043:b0:495:7a5a:d96c with SMTP id 5b1f17b1804b1-4994e7d89cfmr433714915e9.18.1786358868722;
        Mon, 10 Aug 2026 03:47:48 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm411365895e9.10.2026.08.10.03.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 03:47:48 -0700 (PDT)
Message-ID: <353d21d0-1820-40cf-8854-a22622f75e09@redhat.com>
Date: Mon, 10 Aug 2026 12:47:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-next 7/7] mptcp: implemented OoO queue pruning
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1786026372.git.pabeni@redhat.com>
 <be9dcbef291a424fdd54d19fc72f9f28fb239b81.1786026372.git.pabeni@redhat.com>
 <80572775-6e76-4c79-83e2-efdedbd3f3b8@redhat.com>
 <b0d961b3-7a06-4237-92b2-67d8ab2ff28b@kernel.org>
 <a8cf012f365d1885f773d5959829cb42298477bb.camel@kernel.org>
 <eb437699-4e3a-422d-93fa-3efde2985189@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eb437699-4e3a-422d-93fa-3efde2985189@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a0yWkXlaTs1S8zPebTesPrwxjS6igeVEMEGKO3UinvI_1786358869
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/26 6:34 PM, Matthieu Baerts wrote:
> On 08/08/2026 04:31, Geliang Tang wrote:
>> It seems you forgot to update this on the export branch.
> 
> Arf, indeed I did, my bad... good catch!
> 
> I just fixed it in our tree (and the alignment of the next line), but I
> will wait for Paolo's feedback to know if he judges that a new version
> is needed for upstream, or if that can be done in follow-up patches.
> 
> Maybe only the comments on the last patch actually requires
> modifications? (but maybe can be done in a follow-up patch?)
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3%40kernel.org
I commented on the netdev thread. I would like to opt for the follow-up
strategy. I confirm opus-5 is too good for me. I'll try to cook and send
the series ASAP, but I suggest not rushing them to netdev, can go via
the net tree after the PR.

/P

