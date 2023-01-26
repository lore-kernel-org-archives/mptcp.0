Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888846BF
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 17:22:14 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id q10so2501914wrm.4
        for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 09:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11J/7ZZmGDY2hRDr4lbnYul1IBDnou6zNVlIkTiz+d4=;
        b=6I2jG5jJgx062nV69nGIHczA9IuXdbmyhtkylAbtor1tafT625Pd0yvawTOpHGoQLw
         49Kw8ATqMXbbVTDIVfufkqau45dsiTiTBkHEjDgB2YJJDKTMdQnzVfJ56MPZQ89Kol+N
         LqmohfHxdmHOJtDGZ8qKX8qPqeCx/qXGQSp8hqSe8pBNLKpPKs2Ma0S/SnAMEVuXG4l7
         Cv4an6bAtRGoL5SQzvOxsA4kIW5hj/5fBZY3vtLW0upyl7O++JclZnVPLy6vplv8R7Y9
         IRdXsdNI8aULjO7Vr79PQnFJ2OIEsTpl+FYLBTCvKh0VtHuOEfWMJmlTiJCVuYIn7xq3
         nBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11J/7ZZmGDY2hRDr4lbnYul1IBDnou6zNVlIkTiz+d4=;
        b=ql69LmElbZ/9+4Cp7UcJYQL4tt6bI8KMSifG7uYeIrpmGldIqSyB+1XsYXHKamJNE6
         347sCfbAgrAoedMJVpcItNudpfAZU3UQ416ySJ7nNz+mdUK1KPa3kmlZNffJ4s9k/b2R
         pOXic87y+EPYCVKD7sHiaKcpiqo1DjwwPpr//kH+3q2uBVRLcrIQ2yUhcRDoWl7ixOZl
         UOVp7rKi9mjpbiI3CekQYLai26mNwEns8qB7uzLwTZf71zK/ftANwdVCBMb/FgFrCzsh
         4qXXXmtaN5C7lH2vzOBU4vaqeFXkn+qpKbKiKWIGILymEMdCILkiXTL8TU308bLW/1ox
         daHg==
X-Gm-Message-State: AO0yUKVQaJjYHrtXt/QbR5W9HVFi6We6L4SdPAXRrEhopCR9DIRAcp2C
	R6SCLxtg5dyOiYiVZT9IVx+6MSzrxPIh+JjPl9E=
X-Google-Smtp-Source: AK7set9DEAfLriWjb2OLhMVkcI0lMnuVduIxtnMMtLnRnw5PONFVpOD36Ek3WlEaFGW648tgev0aNQ==
X-Received: by 2002:a05:6000:1f8d:b0:2bf:ace0:a19b with SMTP id bw13-20020a0560001f8d00b002bface0a19bmr14966807wrb.45.1674753733167;
        Thu, 26 Jan 2023 09:22:13 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9734:4fc3:798b:7157? ([2a02:578:8593:1200:9734:4fc3:798b:7157])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b002bfc2d0eff0sm1818759wrs.47.2023.01.26.09.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 09:22:12 -0800 (PST)
Message-ID: <c4d0ff16-125f-4bd3-69aa-5034a36a977d@tessares.net>
Date: Thu, 26 Jan 2023 18:22:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH mptcp-next] mptcp: do not wait for bare sockets' timeout
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1f0aa2feba9240d202a087e60013c6ff8039897c.1674747837.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/01/2023 16:44, Paolo Abeni wrote:
> If the peer closes all the existing subflows for a given
> mptcp socket and later the application closes it, the current
> implementation let it survive until the timewait timeout expires.

Thank you for having looked at that and provided a solution!

> While the above is allowed by the protocol specification it
> consumes resources for almost no reason and additionally
> causes sporadic self-tests failures.

I guess if we are in __mptcp_close(), there is no reason to keep the
MPTCP socket alive if there is no more subflows: if there are new
subflows requests coming, they will not be accepted, right?

When the last subflow is closed without MPTCP DATA FIN, it might be good
to keep the MPTCP socket alive for a bit longer before closing the
socket to let the client joining from another network
(make-before-break?). (this should be controllable from the userspace
but that's another topic)

> Let's move the mptcp socket to the TCP_CLOSE state when there are
> no alive subflows at close time, so that the allocated resources
> will be freed immediately.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> --
> this could land either on -net or net-next, as it introduces
> a change of behavior that "fixes" self-tests.
> 
> The fix tag would be:
> 
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")

If I understand properly, this doesn't break any 'make-before-break'
feature but it clean resources quicker while there was no reason to
wait, right? In this case it makes sense to target the -net tree.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
