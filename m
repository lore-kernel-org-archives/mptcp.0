Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF41D5CDB
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074615; cv=none; b=XhTi8yhj4nFQzvgnCdjPBVItV4Bfi7HMZS2UNCH794ukODjvAUQX9biRRasm8ZZ5QaWGNORJ12HOEpNeDLP44+IM13ka3OOJzd+UV/cY+1vgjt5DLFHor5ddXS5b4emc4umzy3OdtZU9kB7GosHX79WE5GGYOEEjF7CtovC+mOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074615; c=relaxed/simple;
	bh=IAO7E7lV/o0TGO8bKyBkr6Yg66WCjYjQjhBRkpUzAtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mPW5y4yOuRuBD0NDV5/5l0A+7kbwFmyDlGGpIHmnWXxUTRKhhOz5TgWIGtAbfUnmveGT41O2KFGuuALIFr7qoCYuiGMfzwiLGwWfR2bEo1ix5X7JR89tKFSD79PbhEyQ+Lj54IgS7kX7mPubQa7byYGjO96seIqu+dRxDNWb6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8Jtsl2y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8Jtsl2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740074611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLx1jNYZGrUJOwQgZTg1Zy7sYKVyL7Ghf+vsDc7HmIE=;
	b=E8Jtsl2yWthYgJ5mCcGp5EvBv9UjALpZjwpPSYQkV3+xQStHGxUTHUU5klFvNFHqKdkAC+
	cnhPfd0aOeIXkM9XdKvtfgHDOqQsb6j6Tej14yoIkDeN2xlRdS6uX5HpCWrfdTq3eVsDX/
	bokSFy9cW2as7yICmyiQY+D9WyRj5SI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-FBPxiECkMkSo-Ov8E8Nzjw-1; Thu, 20 Feb 2025 13:03:26 -0500
X-MC-Unique: FBPxiECkMkSo-Ov8E8Nzjw-1
X-Mimecast-MFC-AGG-ID: FBPxiECkMkSo-Ov8E8Nzjw_1740074605
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f39352f1dso475801f8f.0
        for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074604; x=1740679404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLx1jNYZGrUJOwQgZTg1Zy7sYKVyL7Ghf+vsDc7HmIE=;
        b=JV+vrchWYM9GyRIdME0gGw/1nG9uvy7NGxhFeDCZF5KUelOET/emYL3ue6uINDkQhw
         IlQroeoEmu5alW/YYEmXduV8Ujiu02DboYIkDov8He5lDpZ3L3YtLsNicr+OVzdNcjx1
         Lpldx0vTACbjmUVdRDh6fPDSvdOFcT6zh9s1Kl2itBO4QE1eKq1xV//1FQKz9j8rfPFF
         KhoDK8jPRzf6BTYhlcapFPThAa78J0nFU0X+36XSxcWUiPUKihUNsH9I2gNB38WDkV30
         1pcBoWJsMzyD1JRGMY3ZGDrnso4N+7ZmUzXd92Z7Vk9f7dZRm7DVbBgo1KNMqDTA+YuI
         Wz+A==
X-Forwarded-Encrypted: i=1; AJvYcCUCwL2JiiOi8QelsWSO5AfcbzRkJyYdg1XIygZXSv3VJCq6hGKkaTY2pbKX0/FBLHZ5s1l/vQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxC0etVxn4Z0TlGyDRGZgFwXPYizY/+RMcZkeV0dAEbWIezbVqW
	JJOfok3mXhORpehDh8tVzkaLpbNYya5uBRbUyUU8bh3LvmMngJ+ILwL+GrZHxT8jw7uUqlsCRFi
	YB87ArzCBjgwTTi5ikhpjCPKCV1Sc0vELGc4kXbTdQ18RGeluc4S5zoYIb3PQ
X-Gm-Gg: ASbGncsjsKBqP0VCksK+DbJ1ovBBuoN4ejAyXebAFbQbDwE4pubMKiR3HgKUs1gek+3
	72BVzuRp6iQbwIFagHVyqAMA1l6flqlWAZoCNrRylOraZeDcsElHCH91TMonHTpeQqAdVLigT8d
	UwJqLRMUQe/vNRFdnbya1zbnWzrmdBVxRIPYvPEBHMGDhgwNzYLalnBkBsvf0tvUDj4RHJhEqig
	Z/0Ia0RlNiNeuQr7jRvFQa4rSUh4+YlOJ3pQh8Uqnx9gNM6c6GLv4NytPvbPnN7IrMiQjKDuhLM
	ff0bJnUuRRL1sNvzhoZ/avROVEH9j/IJEOo=
X-Received: by 2002:a5d:6dd1:0:b0:38f:4f25:14a3 with SMTP id ffacd0b85a97d-38f6e979d1amr160495f8f.30.1740074602981;
        Thu, 20 Feb 2025 10:03:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC1j0o/+0/RB7HcPG/p8x84xz9azpIAmxmYQCatImfi2rSxQCT7SJDYW5Bsv9ptSE071gQ8g==
X-Received: by 2002:a5d:6dd1:0:b0:38f:4f25:14a3 with SMTP id ffacd0b85a97d-38f6e979d1amr160456f8f.30.1740074602512;
        Thu, 20 Feb 2025 10:03:22 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm20843564f8f.41.2025.02.20.10.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:03:22 -0800 (PST)
Message-ID: <b2799518-fcd4-451b-9e2b-b48f0a6635e4@redhat.com>
Date: Thu, 20 Feb 2025 19:03:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: always handle address removal under msk
 socket lock
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <61cded134e753976259b48a4269f203dcae6c8fa.1739969092.git.pabeni@redhat.com>
 <a103802c-90e2-4cda-86a4-6bde5bb28670@kernel.org>
 <2c71d642-cbd6-402c-8300-59f22533654c@redhat.com>
 <3a050151-d8ce-460e-a1a3-70c81b706083@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3a050151-d8ce-460e-a1a3-70c81b706083@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ALxr82vO3bhnGy97GMP9U5Z_Tm8muU_kSPgn8X2T9Ic_1740074605
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 11:40 AM, Matthieu Baerts wrote:
> On 20/02/2025 10:33, Paolo Abeni wrote:
>> I'm not 110% and I don't have the syzkaller log for the relevant splat
>> handy, but i.e. a passive socket at clone time does:
>>
>> 	list_add(&subflow->node, &msk->conn_list); // [1]
>> 	sock_hold(ssk);
>> 	mptcp_token_accept(subflow_req, msk); // [2]
>>
>> under the msk socket spin lock.
>>
>> After [2], the PM ops can find and operate on the newly accepted msk
>> socket, but lacking any lock protection and memory barriers could still
>> observe an empty conn_list, even given the prior [1].
>>
>> The race is tiny, thus is hard for syzkaller to find a repro.
> 
> I see, thank you for your reply and for having checked!
> 
> I will try to keep this in mind when looking at future potential issues.
> (And not always assuming there is at least one subflow in the list.)

To clarify: I think such assumption is true under the msk socket lock,
but it can't be asserted without the lock.

/P


