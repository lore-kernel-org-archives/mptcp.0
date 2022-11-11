Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B824F4F
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 17:27:45 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id l14so7349777wrw.2
        for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 09:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j62TZXjmIPGiSXMCT2Z4TxvDqHOI8AHPN0gJ1v5PGQE=;
        b=yJNqhGET8ezFgtT1dZai780q1cKxGjofm97PuG3IleNny63611bZ9qAQEaa1lRLHAM
         dDyItliWUCR85kUmjcjWZH3rqw+d5Ka2kT9Qmx4pWA0LKALnGV6NXnO/C8UFZjpbJ2PK
         3YYlrwoIfhWqHHgS6ewfEYr1XNdzDs5P7vSvfaZbyvCia+aqpqxfFtz669SSZyOsqKyz
         5zm28YNcYRVRxb/41pO7s9Qh30MrNmnvfDyAc5EQ6qiBUngJp/Q6uUo7IyhVrs3BQWby
         yEFT+oLk4RS1wfX/nezLACl/okM8o+/b75XSJjVjxPa8NapwcfD+coX6YkDtzk8/yfNi
         hDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j62TZXjmIPGiSXMCT2Z4TxvDqHOI8AHPN0gJ1v5PGQE=;
        b=DAE6EgYKefSiQ4ZviHnoUgRlT4dd2JDj2Js7PGDpPlbv/XK8NZ40NmpwT2b3+xAPr+
         Dz1ExD17iypXWH1cn2Q7BT/p+RT3JH5PVuP9KIgpF4rfkStUopFlBpfpCa2wedOV7pFF
         I2ZnAc8NoAKctUVWIsWGRZddK2fOu1WldOJu3qaRechgRtCf9jo/OMidIwvc/LVzpe4S
         uFyNwxj9onjv9R54nYGJnZoQ4N/GCnuN5S7N1VSS+1ihOJIY4LGDxryu1+HLx/0/xqP7
         1jVqsyE0EiWbUClf4tMCqDqiyce+618gHqJ7EsOShkiKyWPCw1EvPerCSpaySEdUc3VQ
         iTqw==
X-Gm-Message-State: ANoB5pn+/BZ5vWMIDrVzEKFxtx6Cd2lCMYDY+jIMBuMBtzExAASQK/fA
	Z1KbDGkhqQ7NeQqmetak9oyCfw==
X-Google-Smtp-Source: AA0mqf4XawiDBOmK+t5hxqpcnrOvFFxdU5e1y/MXleKwlrOv8mNZ2PmsvQyoW/hOXUsZbAIEy9HKWQ==
X-Received: by 2002:a5d:5550:0:b0:22e:3f37:fdc with SMTP id g16-20020a5d5550000000b0022e3f370fdcmr1837811wrw.665.1668187663307;
        Fri, 11 Nov 2022 09:27:43 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:3b3c:e57d:4c0a:213e? ([2a02:578:8593:1200:3b3c:e57d:4c0a:213e])
        by smtp.gmail.com with ESMTPSA id y10-20020adff14a000000b00236860e7e9esm2332974wro.98.2022.11.11.09.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:27:42 -0800 (PST)
Message-ID: <c96865d3-aa68-02b2-a2c9-fa3dc9de936a@tessares.net>
Date: Fri, 11 Nov 2022 18:27:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 1/2] Squash-to: "mptcp: implement delayed seq
 generation for passive fastopen"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
References: <00a831a7ae3ffb0573dca58f270a98799f5230bf.1668165456.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <00a831a7ae3ffb0573dca58f270a98799f5230bf.1668165456.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo

On 11/11/2022 12:18, Paolo Abeni wrote:
> is_mptfo is only used/accessed at the subflow level, we are better
> off tracking it in the subflow struct and avoid the (currently missing)
> _ONCE() accessors.

Thank you for the patches!

Just applied:

- a1782d59d364: "squashed" patch 1/2 in "mptcp: implement delayed seq
generation for passive fastopen"
- 752de84899b6: "squashed" patch 2/2 in "mptcp: add
subflow_v(4,6)_send_synack()"
- f803b17a5f24: mptcp: fix "variable 'msk' set but not used" warning in
"mptcp: add subflow_v(4,6)_send_synack()"
- Results: df9ca8c514fa..e33b4398ef80 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221111T172639

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
