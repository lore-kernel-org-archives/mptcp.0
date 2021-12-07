Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B352CA6
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 13:57:31 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id t5so57297023edd.0
        for <mptcp@lists.linux.dev>; Tue, 07 Dec 2021 05:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=vprzhpN52EBZCn5sJ9b8BSVi+9Rv+TlVlaxw/x4U2jA=;
        b=IvyW5TJNt02vz82v/Qrs4wYGmLe68Ag9LF4qwWGtwW09XUlnXfPKACjwVsTujxCdOi
         P//3WMuuhQM1KCzgOJu0BPmhPup/rmXLJD4qPuHMsBPhHj8wpNnjVjuZKmko3zxFLR1G
         BvsU0y3oPWQo1Bdv5mx6UXPW0ktOtfe6pRaUv27bcOcr5OvhLm1g/k6uFdwdc8TuYZFr
         /ZY1BzV2GL5sxEsbqBeLyFWOBz2Wz/T+6Xt/7rt+7UM1iwL1/hifQBw6Pn4sYdUIurfN
         oj/9DNVQv9tETbEhteiHc2Q8IKti2UDMzaM3MrOHDWqbc9t8VAucceZoReLyWSA4PNH3
         kF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=vprzhpN52EBZCn5sJ9b8BSVi+9Rv+TlVlaxw/x4U2jA=;
        b=lGjF2rhVvUusK36VOaj6sFHsWZ1fGtDYnLBZuOMlag8e2jOorcdqkJWgMgMOuq/1DY
         Y0AQADSA+nrHFsNOJezPH3GETpDr/zR8uKhTNVrZ3g/pfDQPIkIzGuI1br7iEDp3Xd14
         Nfnfbr27hV4W13fFaQbdCJpWei3HX9Oi8elYmS/yHzG7bq7nRwbEWKsuB1NuSWWBGpTV
         kVg+BOmO4Cq+CGTDQm9uUzrWcQITsvT3n4rRdDzuj2p35na4U071k5WQbnX0+bmwNRUf
         dBJww5EecSls7pfFyYqqaGsJ50KxXTqftmS5rB7GX7YPichBxy93avy6aShOvd/A3yWV
         6zrg==
X-Gm-Message-State: AOAM533C1Bb7smnwgNDgfcxxN/D5b0O3fKWV9XGuazS2IMwbDRCHhYdI
	p3awu9GGlRH7egVrK+kLN2T5e2FZug8wdArJ
X-Google-Smtp-Source: ABdhPJylX0Ky9C7F9X4fZ2I1MViwYc/V5XUJiSeFwlk9PchYmrkYXQ6eStV6xqn8ghnHaNiK+bIzCw==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr9441582edd.286.1638885450152;
        Tue, 07 Dec 2021 05:57:30 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id aq14sm8719845ejc.23.2021.12.07.05.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 05:57:29 -0800 (PST)
Message-ID: <8203ad6f-7cb6-3c91-c76e-11cbfa94995b@tessares.net>
Date: Tue, 7 Dec 2021 14:57:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp 0/2] mptcp: fix crash with mptcp-ulp on tcp sockets
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20211206155120.26929-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211206155120.26929-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 06/12/2021 16:51, Florian Westphal wrote:
> While working on the tls-ULP syzbot report I found that its also
> possible to set the "mptcp" ulp from userspace, iff the socket is a
> tcp socket returned via accept() on an mptcp listen socket.
> 
> First patch fixes this, second patch adds a test case.
>
> Florian Westphal (2):
>   mptcp: clear 'kern' flag from fallback sockets
>   selftests: mptcp: try to set mptcp ulp mode in different sk states

Thank you for the patches and the reviews!

- cf6bfb9af34f: mptcp: clear 'kern' flag from fallback sockets
 (v2)
- Results: 4be3d8d5b45c..23aff1c44f69

- 9a7f7dc671fc: selftests: mptcp: try to set mptcp ulp mode in different
sk states

- Results: 23aff1c44f69..1250e74665ba

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211207T135708

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
