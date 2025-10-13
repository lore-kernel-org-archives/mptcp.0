Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC02FF642
	for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362168; cv=none; b=E10J/2W0pMNLcURRCm1bWIUw2/Mv+A2Y9/MfRjGoPlcOevpKfRVeb9f+0bMItz7mhKEvtzWVz8ozICWvRSp6aP63Jd0pohkD+r4KUKeeL2RPfPmwJAzkFeYJq64gyIEdHrDhnEpfvR8VwTzlC0+C5oTlNXP4BQL2InX1e9FRqus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362168; c=relaxed/simple;
	bh=N9f8Vifc4V9zzJVDf29yTDTbF6PJfq+97Gkmrz/N6mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hjfNSYbCynKyNOj/7XNvPWG8ItOUZozX6DdVM6bNOAhJ4SBoaUJzp8vXkhB/ZRjKhlcWArfIe1Rwmy7oGKHCmYAuYqXlVBku7u0NRrWItooVXdFkFJ/24x0iZHdWVEdCMat4nvgs09XOZYeaUpEJPP3Z6Ig5E94ZKGzw9hYca5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqBJwJTf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqBJwJTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760362166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AB95gDC1YlbGtcoYOEZ1QP5ik8SkttxaxFyj6+Gm9o0=;
	b=MqBJwJTfYVm0QCnZGJAz/Ni4FW5z4UqCeDJAZU1Ej91Elz3BuN9U52ZwU6pv3dBmHF1HIZ
	3DtFQZOX8aow8Hp8ldd6xV48TaGHG6Crqs5XN+XGoDvQcsi0WJ1Gj02RoWvJkYkTGPdsjZ
	kCvtbWaFIkBnAmQF51Od3DWAiPZHhxM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-5MIVOBXnO7q6yxCWSUuKmQ-1; Mon, 13 Oct 2025 09:29:24 -0400
X-MC-Unique: 5MIVOBXnO7q6yxCWSUuKmQ-1
X-Mimecast-MFC-AGG-ID: 5MIVOBXnO7q6yxCWSUuKmQ_1760362164
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee10a24246so3722998f8f.3
        for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 06:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362163; x=1760966963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AB95gDC1YlbGtcoYOEZ1QP5ik8SkttxaxFyj6+Gm9o0=;
        b=A9LUTn1uYxqJSFODVntQ1fQv45NUYk1GDsWEIxLBcW7BQAAa4km6xdT7CY7pIYU5Ur
         qO6Vft/TaJG1VfHjfgjmaG3/1qABR1jsaMPIY3YyixY7tGcJbS6VRHRQiu9L5behH2Eo
         K4cerNGVeFvAPVN0w9TaQjgQUCiQubCsp4uJOKvx4yVohU21fWe5BwONE39gugT+5e3S
         SiWWwu0Fl1GHo5Jsg+o3/nRGYdk+cwWrccZoKmvbWOyqa4xCVmMMBY4VsiCOWxLAo5YX
         6Xh4YoultNgc9PnTKaKO0DplsdSVMguf/Q8t+jfhOUrynEViNO6Nmlbn/qEH1aY2N2Gu
         fCug==
X-Forwarded-Encrypted: i=1; AJvYcCVLyOPDqXmt6v7g0PiCToytzXq65NobNonUWKH5do50WSFjRt0m3FJp3G7MvVcOkzMJIqZeNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQ34hLyVhSHql88UZe0mBnivn/IO88UJphandvRcxGN222oJOV
	7hODZOXe6TTtpg6QiITW/6kSukMunGCm4fM0/i8mpt5Vd4WbQc+SvfvUp9ooQHPSwEgikc5WzOe
	toeiDNwvEIka8gpyVHEnqPHl8p11tlJA1/1hWOQ/Ab+tNmc/8sM8FYqCN
X-Gm-Gg: ASbGncsJSq1foZlwoHAmepYqKjRCnfsugBGhKxGgMYuAL7v7gDUbhqV1aT4CrWsrSbx
	CAj59zpNj9CdutaNk0dK2NtMKwGA2qBcShe5Fu7zGqtnHdf4F5qLkuY+qNf/YSghkkf7QlmAzaX
	vritDDyHJ2O0dzifPuLJHPmCNCUKzeAjYJCIIwNzTXsbUKpg+zRSSkqm09CoB3QjsA6lLKlrfc5
	Qo3a9eNcqHx+TBw3+EwvPAGcFp+fR9TnfWwKMqFPmy/fXHroV8DBs4ix3j+b46hKxDXsSFr4Lki
	6ZNE5z9npR8FXEg4wioBqiYxDwbQESkdBmJoDDVPXrln
X-Received: by 2002:a05:6000:1888:b0:407:77f9:949d with SMTP id ffacd0b85a97d-4266e7e00a0mr12965794f8f.40.1760362163551;
        Mon, 13 Oct 2025 06:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9HLJJqaF6izScL0VyzwJ3ALqmowVY3CSWfHRrdRHnwrnBEntTNPJ8QEduoMD7l6qnD/1Kbg==
X-Received: by 2002:a05:6000:1888:b0:407:77f9:949d with SMTP id ffacd0b85a97d-4266e7e00a0mr12965766f8f.40.1760362162972;
        Mon, 13 Oct 2025 06:29:22 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf6b4sm18486565f8f.25.2025.10.13.06.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:29:22 -0700 (PDT)
Message-ID: <050ac2a0-0f8f-4f95-acd5-1a8f58f0d9d4@redhat.com>
Date: Mon, 13 Oct 2025 15:29:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1759737859.git.pabeni@redhat.com>
 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
 <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
 <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
 <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
 <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org>
 <6d3545fc-f342-4532-b1c3-fb96d9c79fe6@redhat.com>
 <e759f7f6-b90f-4663-9ab4-040f76c2bbba@redhat.com>
 <53ed629a-d364-470f-8a52-5a34692f0da7@redhat.com>
 <20a3df573803203df6b672d1ecd606e242e84b20.camel@kernel.org>
 <ef0495fe4e1012bb4b68a72361bdeb39872d96b6.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ef0495fe4e1012bb4b68a72361bdeb39872d96b6.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FZIi_a_8Hj7aBz6sUw7GeqHk_4r4WheBv9Mawd2-Q_g_1760362164
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/13/25 11:07 AM, Geliang Tang wrote:
> On Fri, 2025-10-10 at 20:22 +0800, Geliang Tang wrote:
>> On Fri, 2025-10-10 at 10:21 +0200, Paolo Abeni wrote:
>>> - Can you please share a pcap capture _and_ the selftest text
>>> output
>>> for
>>> the same failing  test?
> 
> The pcap captures (gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
> connector.pcap, gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
> listener.pcap) and the selftest text output (selftest_output) are
> attached.

I'm possibly low on coffee, but I see a single attachment here?

/P

