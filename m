Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3E2568
	for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 09:39:57 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id hw13so31519144ejc.9
        for <mptcp@lists.linux.dev>; Mon, 21 Feb 2022 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=zbUMYka4ufAcq6RcwKqfrBUs4SxXRpmE8rIaw6iErXo=;
        b=xFLYBpE3Z95f61Vakr61Qdxs9dAwMFaidLA+FOCB7NUOwN+9zcEH0tAuaoTOlmGYvj
         mqaK9fwNj/SwQh1jRleCD8oamlGrSrLpj6YOBCWuIr3bvj8ItmP9Pzbz5VqoceW3FPuu
         y4TPyRaw0JqNBvEtDmfkyQ6YlrT/OhMGvr0UMIlKKS/RhABQTKOkAD4rDc/wqkH7OiEG
         BjOZuZPwcJcPMDWWfiRt/Isq/gTqY2yuy6JaGixDQ6+ygUwg9yGbjGSd3dgTLAE7JJY3
         kvbAGEGizodyQiIt7uSNs/nxQOeT+bCLwH1IN33cRLi6MWZr1pA8uqta1Hjb2zq7UkKq
         QH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zbUMYka4ufAcq6RcwKqfrBUs4SxXRpmE8rIaw6iErXo=;
        b=lxWLA6J6FDht7vBVfCNsRTSd6JSdb1q7EgbE3vVXDcrwjKBLxIVEGznMiQg4vmzmXK
         MX4u/x8WBFmxBDGOYb5K6h1uQ4M1g/VPwqUd4JZ+5/S5VFW+z3jAqGBwRTOrFmxxn6W5
         uNgY5KTHgCQGRX+LB9mEmR4XwQUE9bkO/+76LsFZQ234rrPBPUJE7in/x9eLi7v1L54L
         lrm9S6ZltiPbcBJK2BeMqKZl9GHD9C4DlrFot5mbBXW8iwexGLSY5v089kz0VAennwN4
         2DlP2vL2/BulWqi5sK1VgUI1B6t8zD0EQ3XRmInJy0MiY88kn6nkBWMHEFSv6xucCxrT
         EaAg==
X-Gm-Message-State: AOAM533q7RAduBMPwrh/461d/3zMb/oxV+ot+W0CkLeCgi8qU0xZKZHN
	x/KrHJ03QVevX2x7LzP9L4az2Q==
X-Google-Smtp-Source: ABdhPJwj1Z/biIDA4OhRQVrmCjnb6H7AM4VICtHIKhupTjhxbd6mQo/LAUfV/FCf5StGiRbibdm8og==
X-Received: by 2002:a17:906:53c7:b0:6ce:6f32:ce53 with SMTP id p7-20020a17090653c700b006ce6f32ce53mr15143779ejo.352.1645436395534;
        Mon, 21 Feb 2022 01:39:55 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:6601:25da:b9c7:38ca? ([2a02:578:8593:1200:6601:25da:b9c7:38ca])
        by smtp.gmail.com with ESMTPSA id r3sm5047451ejd.129.2022.02.21.01.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 01:39:55 -0800 (PST)
Message-ID: <3a55fd1f-b87a-88f5-ea55-fa3498b1f793@tessares.net>
Date: Mon, 21 Feb 2022 10:39:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add implicit
 endpoint test case"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <3ea291cb4de94c65127fb78200fe4a121d584748.1645326965.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3ea291cb4de94c65127fb78200fe4a121d584748.1645326965.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/02/2022 04:17, Geliang Tang wrote:
> Use the newly defined nr_blank.

Good catch!

Just applied:

- 3707ddbee062: "squashed" in "selftests: mptcp: add implicit endpoint
test case"

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
