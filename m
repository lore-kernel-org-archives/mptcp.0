Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F572
	for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623659448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2RNBjV2KxXT643lBCs2dY1vfHquQ0H7EXwdQYcfnco=;
	b=ZmLXstA7W4I9xRcH7wFbCzQfeZyX9VZ1pc+tZNSbrx8nMchQMqc3QvPlj869Ve6VECV1TW
	92kNauzIrLbuHPhbfhYMXllyT4zkxUUAaHqFsQUOnrFPi9QcdnJ3N2/nNdmU6mT36arUXT
	Z8WXu+gmeASCeTnkvAzXPaDBOYZN57I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-O_O5dd91MRyHES939bublA-1; Mon, 14 Jun 2021 04:30:44 -0400
X-MC-Unique: O_O5dd91MRyHES939bublA-1
Received: by mail-wr1-f69.google.com with SMTP id e9-20020a5d6d090000b0290119e91be97dso6742539wrq.1
        for <mptcp@lists.linux.dev>; Mon, 14 Jun 2021 01:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B2RNBjV2KxXT643lBCs2dY1vfHquQ0H7EXwdQYcfnco=;
        b=RnwCfdREPpUE4PzKkhqlj336W1p/FggSByQunWD9OXf7IKXJNSUTP2F1nOjRTkSdRs
         UQueeg9JWJWVAguDcy1JkbAtCgGsAMQqrjR9rYapOs2IT5bU9Xz4seFIu0Yg6CDmUG8o
         RNwbj5A1cLEtiTazGEL2ULCtV/EGOixYE+kw+eCueC07FQDBAGvTk3dEB58U3QA1wKS+
         utFw2ym6ukM+BtyO1OkM6r6L2TTeDQ4etRyIpMsLsLprPoOTTwfcLiGlhbK/1MZPssgO
         qHA/RUoQXIUQhCrjhpTqkRWtiOw2Ba6trutPgXyAqk2zcdLnC2N89ki9qmQBRz6OCGC0
         N3iQ==
X-Gm-Message-State: AOAM532rSUed9qIBMvH2I6GljZ2vH4OEXx+6Tz7rUh6P97Xk5esZ/bsg
	WDXJPCywx+iEveaOGS42JvqlXoc0HYOkTpqUyV9eBCOvdSeGfzQbd21t0JN5VQu+OPhGQSRtuIy
	XkCiC7dlr79qkXrk=
X-Received: by 2002:a1c:4606:: with SMTP id t6mr14949121wma.122.1623659443503;
        Mon, 14 Jun 2021 01:30:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxv63h6j0JNdpSf7WJpYWsiKuRXNyshBIlhMsaNM9z4vEFeaM9rwLPiaMbXdj1yxm90UttmA==
X-Received: by 2002:a1c:4606:: with SMTP id t6mr14949106wma.122.1623659443291;
        Mon, 14 Jun 2021 01:30:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id u16sm16442980wru.56.2021.06.14.01.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 01:30:43 -0700 (PDT)
Message-ID: <8cceb711ad974911da62d62a354e6569b573e0b2.camel@redhat.com>
Subject: Re: MPTCP checksum interop
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>, Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 14 Jun 2021 10:30:42 +0200
In-Reply-To: <aedffae2-61ad-eb44-c083-e674f736fd96@linux.intel.com>
References: <aedffae2-61ad-eb44-c083-e674f736fd96@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

Hello

On Fri, 2021-06-11 at 20:57 -0700, Mat Martineau wrote:
> I did some tests with connections with checksums enabled, between the 
> export branch and the multipath-tcp.org mptcp_trunk branch (v1 mode).

Thank you for checking!

> When the multipath-tcp.org kernel was listening, the connection would 
> always fall back to TCP when the first data was sent by the upstream 
> kernel. The multipath-tcp.org kernel was the first to fall back and stop 
> sending MPTCP headers.

This sounds like a csum error detected ??! What does wireshark say
about the MPTCP csum value?

> When the upstream kernel was listening, the multipath-tcp.org kernel would 
> send corrupt TCP options with the first data packet (the first time a DSS 
> option was sent). The upstream kernel would then send TCP RST.

How does TCP option look like? Could you please share a short pcap
snippet?

Thanks!

Paolo

