Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0B419FD4
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027944; cv=none; b=We5NmV265iAEWmmQFJrrAiUN+LDyYD0oOZLHAdb+gvBe2A5fJHkHPZIt1X0p8X0Vg/TulxtOdpeotP4V6Bz6lt62k8iYaioNqOhje+qQNVl378pIWVGLHo12HmxWscXkgBBgdd5KjPCKbgVE2CHUGEcXbivuNFZHf/Rvx4Rhw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027944; c=relaxed/simple;
	bh=WQe453I+O9kJM6b6zHQrmqWzKsZXSoS+9k6LVQH7nSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBMWVt/BIbhHlwogLymjoHpmWE0+DG5N+IQBWp10t3rF5xM7K6foOgiJUyiiWEyS1ZbwGu6qNUF3+hJSQb7CX1S6y48jWy7fi/X5noQ5s3I+sXfVOdXwcccoaksmrqa+C0YMyGE2RNS5xFN8ZxVMyXNZmTXBQwqOVfxxqCsGmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htABqrjR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htABqrjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789027941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7m86Nl0R/ApS0b4Hz6J+TM/No6iRyeaUTybs4HgQjpY=;
	b=htABqrjRc7babPA+cYKW4PdUTjsC/svjV0b/4tun4cxLY/o/x7ftPPV8AUZE4ggQh0vXJ/
	M3a6yIUHIkhe4qDaT+bgsNSWqhBR74C7bL2F99zCRVNVVfWK0Tff/m+mwxcu/3Ue9iEcpr
	Q0r/yf15CGCyKs1nHuF3KGBEWvZqmIM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-d7H6d446Nt25RE4IuxBpag-1; Thu, 10 Sep 2026 04:12:18 -0400
X-MC-Unique: d7H6d446Nt25RE4IuxBpag-1
X-Mimecast-MFC-AGG-ID: d7H6d446Nt25RE4IuxBpag_1789027937
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1c232fa136so90697966b.0
        for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 01:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789027937; x=1789632737;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7m86Nl0R/ApS0b4Hz6J+TM/No6iRyeaUTybs4HgQjpY=;
        b=sfzmNnyXuIC/QOIUu4Fr0iz9MZxZXcCpZUKs2bBxEUiW7HB2epstGX9FG+gpGDrxBR
         gAYAW4Vl/fnCCPkqs18gHs5bC5JcigXIfdaMbNBKY0Kol9tHnoQ1P86pjl0KmoQqZN3X
         TgxQPdJShhZfsn8QGhs24oD3bsLU3SKtjH3L2xxRAG/RivHEhygd8sFowYOU9xbVRReg
         Cts0griaxW51Xc30iKjgKOPVPtpphIqj8TjkDllgn0ra1ZM+vU99sBd111dfZP0jBna1
         7oWUOvTWICYmfQpLILgyh0+BMk2ocyvuW++unYRMUrbOgtPWlZeLWRBEZJThnMoDvB1T
         IpOQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/5LzrGfrUZmJMbpki0Gz3Uhq5h4WXc1EjDi71xYcnR3cOOEBbkw4iAU8NztdOdQ8Gi9F67g==@lists.linux.dev
X-Gm-Message-State: AFuF++mnUz7+f7mLoPNRD60A2AK/H4QBPQ8VHNL/Z5knFpFT+InurYaR
	+3VKFlOJtFsK2rMemIjgeh2MIJRlZ3gu48V+ePmdGsXir3ZpGC+pEdExxF22joKWJOcGzIjwgfx
	23n6phKri3DoBih8vWxARSBk2t+XP3e9k6c5NwqmLl/pP2qRS+R75rIT8
X-Gm-Gg: AYBFou0lS4W2cGKHfl3ELA4aMX4Mn31MSZbcyMIiCm7KkAucsFcItS31uc5pnSxrZ/O
	Yx7oVuoEd7shqfIiA9WH/k+VwbIr9SMAYhf6cy1QkBCulmwj47WSl7Ym1moBtN4aZCTt2YXwFbP
	d4bjflS+/kcbknzapGAOgwqIibHnzTUDai91AnNIoGMjF9pI3uyVWNytIUfbUpPPbJiWZPXYUp7
	SgVMDEUN8AQOMgfubgIK8gYAWBn7+baUEebaes7ZTJ1xv7/u5gMdVguKQxnVv/HRJxMLwu2au0I
	UBwCxaKrjZLKHcgxkVIL6Rd5GZE4p6folMCf34pJ2V8uX9gAMCvYDExrwfr067/DllcgHiiAEzH
	MwzVtWMuTqkmwXvEpVUqG5LUgdbYtS9mNgOfjtH6X8aWd93apGgHXcD3E3VL6I6dUnwg87Nnf8A
	==
X-Received: by 2002:a17:906:8f8a:b0:c25:f7db:4bed with SMTP id a640c23a62f3a-c2945efbe7emr176080166b.19.1789027937068;
        Thu, 10 Sep 2026 01:12:17 -0700 (PDT)
X-Received: by 2002:a17:906:8f8a:b0:c25:f7db:4bed with SMTP id a640c23a62f3a-c2945efbe7emr176077166b.19.1789027936516;
        Thu, 10 Sep 2026 01:12:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa01dsm882062666b.15.2026.09.10.01.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 01:12:15 -0700 (PDT)
Message-ID: <c95bc6f8-b8da-426f-a056-1c692559d14f@redhat.com>
Date: Thu, 10 Sep 2026 10:12:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcp: fastopen: check rsk_drop_req() in
 tcp_fastopen_create_child()
To: Yilin Zhang <yilinzhang@moonshot.ai>, Mat Martineau
 <martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 Kimi Security Team <bug-report@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SEV72mI5W8Q5EUL4rp78GFFhxRElG38wQkyu2leymkc_1789027937
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 11:40 AM, Yilin Zhang wrote:
> subflow_syn_recv_sock() sets drop_req when an MP_JOIN SYN takes the fatal
> fallback and destroys the cloned child. tcp_fastopen_create_child()
> ignored the flag and could queue the destroyed child.
> 
> With an MPTCP listener using server-side Fast Open, a valid-cookie
> MP_JOIN SYN could then expose the freed child through accept().
> 
> Release the locked child and drop the request before tcp_conn_request()
> sends a SYN-ACK. Initialize drop_req when allocating the request so the
> check cannot observe stale state after request-socket reuse.
> 
> Changes in v2:
> - unlock the child before dropping its reference
> - drop the request instead of sending a SYN-ACK after the MPTCP reset,
>   as suggested by Jiayuan Chen
> 
> Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
> Reported-by: Kimi Security Team <bug-report@moonshot.ai>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>

This looks like the wrong fix. IIRC fastopen is not compatible with MPJ
- as the latter must accept data only after the 4way handshake completion.

@Mat(s): could you please double check the above ^^^ statement???

If so mptcp should reject entirely MPJ + fastopen and no addtional code
required on the TCP side.

A minor process note: the changelog should come after the tag area and a
'---' separator.

/P

