Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC25AD5B
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 15:48:22 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id a14so25000904wru.5
        for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 07:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ID1HLFCj0IBXTM546YWK8j4t2L2kbKD91RKY58PcjU=;
        b=V7EZL6EFKxz3kC/UWyCnSAPC9SoYgfNxQBjYUN329l4bcKIh2+coJLOKTKMWmDHf7N
         IzvdmqRlCFkB3Rnhe603Dy47e5Ymdxs7MWn6gOIS6zYSmWWP9VoTx4ehGMhfBgMBnPTp
         AZAJPKRkl3f3XDkC6tXgGtbvqpoYRjq54pAcCxDFjfez4fxQ//kEehC3/hdHaMICBGpN
         q0fv48K82igNFVN4+aRKhkYJhbHTGEBvdpkpmGVUnls6aFVDBFrcbvoWI50mfFeRGdng
         aVF330bP95aJ2YB2NR8oc9rQ3EFjy28BIu2AFzuvlufv5/1g/WAuCybRWjOYf5HYIi4y
         UQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ID1HLFCj0IBXTM546YWK8j4t2L2kbKD91RKY58PcjU=;
        b=ss67i/L4ZH5x0ZuDDMcNlIOPwGcNozwnJm9mV6iqObF/wde3ZHapYPpPprl6nYTzXy
         w/tttUiv5MbOXE+OdcdOXzN0jukzXqIUE983QY57swbUY7W5Y9Ng+8kckDYu1SFp4RYg
         FIZa9Ks7xRZ+gPGkLuFS3iJJe7tr5u9S6kifa2Z4rECOB5R7qMKhTEIucPDESloRpX+Y
         hsp+u9UYu5TI0CJ4MEtxJzBPc5BvASHPa5d3uw8G9tNsZCOiJsZL6/EX/0s+kAWV6TKm
         ZdE/XtiFrDEKh+0rozGFpcIJDUOzOM7DoqqOFEfvlCZwmOtfEjsXenkxH8bX5DjtPc/b
         2NXg==
X-Gm-Message-State: ANoB5pnyhIiW99tAHAkQ3Yzm9t3ETe5U8mVuWSq+wclp4vksFiGg+VIS
	VoKhwDUNY5tPVa1eUtK/RB+gDmo2amY5SkoR
X-Google-Smtp-Source: AA0mqf6ehqC4yXcAbOouXskacAgh8SHGSzWgF+M59YHEIY3XdS/KC1y5VY3JS1ZBdxdTW1YwjFwIgA==
X-Received: by 2002:adf:bb43:0:b0:22e:6f0d:d69 with SMTP id x3-20020adfbb43000000b0022e6f0d0d69mr11483713wrg.134.1668527300220;
        Tue, 15 Nov 2022 07:48:20 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:765b:95ed:f124:a78a? ([2a02:578:8593:1200:765b:95ed:f124:a78a])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05600c1f0a00b003cfbe1da539sm16874883wmb.36.2022.11.15.07.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:48:19 -0800 (PST)
Message-ID: <af6f7db3-d6b5-0e37-340e-8f5bfdaca808@tessares.net>
Date: Tue, 15 Nov 2022 16:48:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 0/5] mptcp: uniform code style and fix
 checkpatch splats
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
 <1a4372b7-3206-162c-c198-c16891391f01@tessares.net>
 <0a7f892acf37dfeea5f0ee072f76b526e9345c1f.camel@redhat.com>
 <f79c0855-7458-1e63-49fc-10b3168911b3@tessares.net>
 <d50628e44e6e6f8a6bc3e7150b027193cc3f45c5.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d50628e44e6e6f8a6bc3e7150b027193cc3f45c5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 15/11/2022 16:22, Paolo Abeni wrote:
> [browsers!] Sure, please go ahead. I have a couple of additional
> fastopen follow-ups pending...

Thank you for the review!

I just applied these patches in our tree:

- 30d542994e3b: "squashed" (with conflicts) patch 1/5 in "mptcp:
implement delayed seq generation for passive fastopen"
- da41e5fb2e69: conflict in t/mptcp-add-subflow_v-4-6-_send_synack
- 183032806905: "squashed" patch 2/5 in "mptcp: add
subflow_v(4,6)_send_synack()"
- 8e2de0e11c9c: "squashed" patch 3/5 in "mptcp: add
subflow_v(4,6)_send_synack()"
- 8e7208654410: "squashed" patch 4/5 in "mptcp: add
subflow_v(4,6)_send_synack()"
- a1456d147b4e: "squashed" patch 5/5 in "selftests: mptcp: mptfo
Initiator/Listener"
- Results: 90b37ad8479c..a3b1d1930a5c (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221115T154226

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
