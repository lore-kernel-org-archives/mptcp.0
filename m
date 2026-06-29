Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2775C3B7742
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726648; cv=none; b=qu2yk1EDt9E1z3xEPuj+sBLkKpjN9BPFMm+yWF4tV3511bBhLKrZIX7kmdysENTke1CaphmHEQQIBZuAQRy+RW34sdJwQ9DARF3noSh2M/3GFxPfIpYgG/HXzvA3Mc2fjgUrUKEc++3d/+H32OjVm2A64oCEMhCGJwWzs8duMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726648; c=relaxed/simple;
	bh=ACyWfY2kPQJljL8+3rbVUnFnxv3dYfoIVpzokml3Mws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZE37XDzDjIURy6EGI2snlOg7yC1M5D042B+4kWB/Dkfi124IZU4ZciUlCkfLrEMx4KZSjeLkQJEYVPqFe74/s7LPSIq9Dmgj9YD4h1ANez9k81pNx+amAKx8fBmTd5Y23EdEsI1Yti14F+DxMitF0Lm72hs9GE4V3E+NUSt/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cd3nirr0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cd3nirr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782726645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/M9+nQY4UUFkdH/+tXgorDJKcJ/lXoZMGO1FuRWX8k=;
	b=cd3nirr0FJ0ni/Se55C+kFNvfqWzTfnRYJH096tgml744nCSJwQJbRfViRwO1h9Ktw4JGL
	+wVD/r83q7iTCqsXPCWA8f8XlY1e51q68fQrFud1tnRPv4vstiwK7R/+DIKutSlrf5/e1F
	O3LpECGoLcyreKLogiali0u6oXnr03c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-mKm79-8PO5q_wOQbLBkYOA-1; Mon, 29 Jun 2026 05:50:43 -0400
X-MC-Unique: mKm79-8PO5q_wOQbLBkYOA-1
X-Mimecast-MFC-AGG-ID: mKm79-8PO5q_wOQbLBkYOA_1782726642
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-474170b59dfso255872f8f.3
        for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 02:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726642; x=1783331442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/M9+nQY4UUFkdH/+tXgorDJKcJ/lXoZMGO1FuRWX8k=;
        b=TfgWlGrZE0+TrnoFBKtU25lhFX62z8FGk6VkbY4tzwZrNVhR0CWhtHcvx8GPoH5skD
         c856wLCFSfm9oiDfDqWOAGBhid7NCaUdbFj6EhzkDCeiPfsEt4TNjNtk3F1we2Dt2Ks2
         iTXNxW0M9KLhf+2Giq0SOB4E3WsmVmEgXi7V5sW8jiJmQqvnUxYqqZGRmJq+hJY9yJYo
         aZVJjLgPv3bLHjHdioZGtBLssTjXkIgFl0ScXJHbIKx2nj15EMdbd1eqfMoqxlAUNImn
         INYniPV68f867KqdXL4abGfRWQwoFGQuP1LcgUnrm4LFAjjwQ3aX/PbQ+q0Ngw9RCxYt
         NUnA==
X-Forwarded-Encrypted: i=1; AHgh+RoSmxst6qnn5bhn1jAO64neXN9TYqf+Em31UA7BPsCI43+1C08qHEhgJTdVe7JdRKmh5cDyiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxua5yU3RUSKActU3IwFJdvbB2RwwrU+6Ao5zaFXFTOBhWHZVBr
	WEBryAkgVbaN9hEPpF8nxw/8ec6vlpmLj18Q6h+BTO8fpKhE98UoA6bqgsVj3stXLAYowWO0v/n
	39TkYviua/IS7UJWL4nCujS7pTpN+htPOG5L/gLDjjxjrOor+bawZV/y3
X-Gm-Gg: AfdE7ckfOdrfWJmtVizxvn5NArYUMoJmYIVL5zXtGEHKk/+xMDES4pPqIkgXWkmmqg0
	3H/bv4e6UaKVakHa0KaI/c4wRRktl7HizHBMVw6sagsCF8L9PakH7rSFOLWlvXS1NMJACtXo1xS
	8a2y1/OWduR4zKWqY3VlJC0y1WYgguZdBfrLkKidADtiQ/y8dSS2QFTMLIpwKqLXg9b1WEcsu4L
	qkH38tq+DaJ0yYqDhWEw0CrtUvPjtQsxJSR7lJVapKebD3zTsr9kUdXRG2KIIRyXAb6MwopzrO9
	MiW0i1kQESKLhubP5pfNv1l6Ujo3KW5R70j4iVq36kSihssP6nqudhviaV4EMNeo9+a51nWX9FW
	hER2xYpoK9zfxQclSt8lSoZjZANWWSCHDksgyzkMsUGINof8iZnl2hVeaXXqzqpdHQJIz8SVRmS
	d9i9qoAHzDEw==
X-Received: by 2002:a05:6000:29db:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-46dc14cbf6emr18737561f8f.33.1782726642085;
        Mon, 29 Jun 2026 02:50:42 -0700 (PDT)
X-Received: by 2002:a05:6000:29db:b0:45d:3aa3:7f76 with SMTP id ffacd0b85a97d-46dc14cbf6emr18737529f8f.33.1782726641633;
        Mon, 29 Jun 2026 02:50:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f9db29a94sm27551970f8f.22.2026.06.29.02.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 02:50:40 -0700 (PDT)
Message-ID: <3ad5bba8-18b9-48a6-94e0-99d958f23984@redhat.com>
Date: Mon, 29 Jun 2026 11:50:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping is
 present
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260617215725.1116295-1-michael.bommarito@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260617215725.1116295-1-michael.bommarito@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rHszhWt5U498bk2dCXAWXpmKeWH5NEShPh_yuWUKOiM_1782726642
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 11:57 PM, Michael Bommarito wrote:
> mptcp_get_options() initializes only the status group of struct
> mptcp_options_received; data_seq, subflow_seq and data_len are set by
> mptcp_parse_option() only inside the DSS mapping block, which runs when
> the DSS M (mapping present) bit is set.
> 
> A peer can send a DSS option with DATA_FIN set but the mapping bit clear.
> The parser then sets mp_opt.data_fin while leaving data_len and data_seq
> uninitialized, and for a zero-length segment mptcp_incoming_options()
> reads them; KMSAN reports an uninit-value in mptcp_incoming_options().
> 
> Impact: a remote peer that has completed the MPTCP handshake makes
> mptcp_incoming_options() read uninitialized data_len and data_seq (KMSAN
> uninit-value) by sending a DSS option with DATA_FIN set and the mapping
> bit clear.
> 
> A DATA_FIN is always sent with a mapping (mptcp_write_data_fin()), so
> gating this path on the mapping bit drops only the malformed no-map case
> and leaves valid DATA_FIN handling unchanged.
> 
> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Isn't this fixed by commit 5e939544f9d2 ("mptcp: fix uninit-value in
mptcp_established_options") ?

/P

