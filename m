Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22024F4B
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 17:13:57 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id k8so7316644wrh.1
        for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TagGss3hFxK1fJfPvB6uiD2TI6fPzZA1E0Y0U3qaWsw=;
        b=sA62ujqkJMpPunSW4Jus6aMODugQdiLdW5Omuecvsr8RhE6Vj6RTMffmM+jAC5Hxfo
         dHYmPol6kUCwCDUEx11xfWCBnpeH9amz88oJlaB1aQrcRb2sFQEOK2Sp1S7rBihX0KIb
         ukW7FsmZ2ih6GgZSMAwXzFrWI0Fnlc9a4MGStsxzenZBYtsQinx1L+4oVzmrZJgLoi53
         D+xKZ4chbPWhY7HQw151rpuIC1wuURL0PW6tQrjnJoaNM/oXyJI7eGsBnnvjl0DyVjDG
         UxwYSFlKvl6RPXEG0ZrjS0q8Z7c4PyGgtxouvc/bV7OgoZ9DGlC5AAQ0lkc/HMh++DyF
         2QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TagGss3hFxK1fJfPvB6uiD2TI6fPzZA1E0Y0U3qaWsw=;
        b=lHKbZpfoHpi+O2tRkXlKN2Mc2MSPfr4Vzp1cMDPxPnDq6PgMWGe2JPyh6khNWKbFzF
         ELwldyam8hP4SQYrAJqaPOYXoiWsJgPvX0HKEF7RLigcZBH34DmYq2E8O+wzfP0RsvOW
         wSzXsfZ8sqZJdv9z1LSbqOqVaEM+GK2Q6KynID9F6gVmp40h1GylPLh8IpE94EY+WpkW
         ukIcmR9K7UpRaygGG3+D22HXsQiGm6MGeh9yuf5UqIm27PDUzCafAs+Ka8c38PfBEedz
         rzUWX+GMEj5ToxHoyh1vxw+iI0+SXmwa1KZeqNprVWXwJKOUE48zWvzMn+PfiNlI/Ivp
         AaTA==
X-Gm-Message-State: ANoB5pkSgauq6E1y6nyJzXv1SuoSM0wQXoHDl/9/R2qV6npLVRnfGzA1
	FDjHeaHF2iNFhpkPkh0PW6ofQb3G6RBUNZ5lg0g=
X-Google-Smtp-Source: AA0mqf4GSvfNee54WvK9/UGUUdbDK5kGrySb3B9mT8e2UUp8V/AE4YsJLw8F9l5KxfHvxc3OjA3zIw==
X-Received: by 2002:adf:fc8c:0:b0:235:9aae:35a6 with SMTP id g12-20020adffc8c000000b002359aae35a6mr1769683wrr.686.1668186835256;
        Fri, 11 Nov 2022 09:13:55 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:3b3c:e57d:4c0a:213e? ([2a02:578:8593:1200:3b3c:e57d:4c0a:213e])
        by smtp.gmail.com with ESMTPSA id e1-20020adfe381000000b0023662d97130sm2377939wrm.20.2022.11.11.09.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:13:54 -0800 (PST)
Message-ID: <639035e4-b76e-4e2a-0732-477bb3d68b25@tessares.net>
Date: Fri, 11 Nov 2022 18:13:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next] Squash-to: "selftests: mptcp: mptfo
 Initiator/Listener": fix mmap failure
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
References: <81db127b6a12947e39a6715d567e22c0bfd3d9b8.1668184713.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <81db127b6a12947e39a6715d567e22c0bfd3d9b8.1668184713.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/11/2022 17:39, Paolo Abeni wrote:
> In TFO scenarios we need to completelly spool the partially xmitted
> buffer (and accunt for that) before starting sendfile/mmap xmit,
> otherwise the relevant tests will fail.

Thank you for the patches!

Now in our tree, including a patch with the same prefix sent a few hours
ago and a small build fix from me:

- c97736cc702f: mptcp: fix compilation error in "mptcp: implement
delayed seq generation for passive fastopen"
- cb2b511f8d3d: "squashed" in "selftests: mptcp: mptfo Initiator/Listener"
- c335ade026e4: "squashed" in "selftests: mptcp: mptfo Initiator/Listener"
- Results: 0c67a168fcee..df9ca8c514fa (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221111T171239


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
