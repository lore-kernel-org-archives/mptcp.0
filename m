Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B17C
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 09:18:20 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id m3so7651188eda.12
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=g9hIzzknQ13g39V8zpuvSuUDV45dCJUmErfkHCUCb8c=;
        b=NYwy1GLqAsBJD7t33Akjui0Lw79QpqGY9V+l6RjjMPtpTrZIwVW4J6FsuZE1LR+0Cm
         V/L4MrzwTLRWYQHh03VZOL40WVAGx+gzyqOiZjNjUlNPXTBjSUoeqd+gKcv6UQqPFH0U
         MEgcuRJUKE+bpTD9v4bchtMJ2aeD4Db35Lo7cFro9DbaVLz9rNlEbuyuqCgJmAXrvOQy
         chSq+cYuDwRVxlmguvhBFI51ZvSVMokkZD/xX7pGlV/SWYj+/nsv12Grztrraj0LemLX
         BC7u0mGI0Jdo0RzaEeHGoxKIgSXDEH3dYe33H1S4lhrYx/HH+0KmXLZVGJ6lAeVN5J2k
         sPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=g9hIzzknQ13g39V8zpuvSuUDV45dCJUmErfkHCUCb8c=;
        b=FHOMj7+ugXCwfPmdKOfLjDff47bwrl3sGXnidBhWSrYuc6D6K1PBt0VvXkAy8EsiKw
         FS6vpNbIeeH4m7hV96szoviOJd41tfNkpxEwCPfFem2MvHep911Hmi8ZPw5wy1IUrt+P
         PAu+fRB0D8DOTkWurPOLhb3fP5He3aiZ9Vf328KZbcMrdL5hHi8VRgGPa7g9SKnd+LLi
         Y7AEOzTkj3MzQL3ehOYiHoL3joBV+Wkof2pW2P6mM3qynRwd2yBnQ0HR0YEHXJQkkfbI
         YxRNlZR87mp1KkPaLmpkPUmqu54Q2mQ/bvl/AWoRhrkY714GT+CuXWIu6sl3qND7hVuL
         rByQ==
X-Gm-Message-State: ACrzQf19WXw74EyeDGcrf3r6g1YOuTdyJXjwZw/IsqGbObF7IwRFK/Vm
	lF/7WNB4U0Qmx0IwJeNFqIm4Vg==
X-Google-Smtp-Source: AMsMyM6bPQ7zayJ+9UZNoM2Gek0kEtRZlXiCyyRJsqf5v+folfznpu2y8B5YkymscGMGAOTjv8C3Bg==
X-Received: by 2002:aa7:c415:0:b0:44d:f432:3e84 with SMTP id j21-20020aa7c415000000b0044df4323e84mr24335129edq.56.1663751898858;
        Wed, 21 Sep 2022 02:18:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e650:9a94:d180:442c? ([2a02:578:8593:1200:e650:9a94:d180:442c])
        by smtp.gmail.com with ESMTPSA id gs13-20020a170906f18d00b007724b8e6576sm1073164ejb.32.2022.09.21.02.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:18:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------PnZdDX0mbgnHJpzmr15LlbVj"
Message-ID: <2b4722a2-04cd-5e8f-ee09-c01c55aee7a7@tessares.net>
Date: Wed, 21 Sep 2022 11:18:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Content-Language: en-GB
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>
Cc: Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220921110437.5b7dbd82@canb.auug.org.au>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220921110437.5b7dbd82@canb.auug.org.au>

This is a multi-part message in MIME format.
--------------PnZdDX0mbgnHJpzmr15LlbVj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stephen,

On 21/09/2022 03:04, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   tools/testing/selftests/drivers/net/bonding/Makefile
> 
> between commit:
> 
>   bbb774d921e2 ("net: Add tests for bonding and team address list management")
> 
> from the net tree and commit:
> 
>   152e8ec77640 ("selftests/bonding: add a test for bonding lladdr target")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.
Thank you for sharing this fix (and all the others!).

I also had this conflict on my side[1] and I resolved it differently,
more like what is done in the -net tree I think, please see the patch
attached to this email.

I guess I should probably use your version. It is just I saw it after
having resolved the conflict on my side :)
I will check later how the network maintainers will resolve this
conflict and update my tree if needed.

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/c02e0180887c
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------PnZdDX0mbgnHJpzmr15LlbVj
Content-Type: text/x-patch; charset=UTF-8;
 name="c02e0180887cdb8c2bc98fcbb0ad6a6d7c68578c.patch"
Content-Disposition: attachment;
 filename="c02e0180887cdb8c2bc98fcbb0ad6a6d7c68578c.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2JvbmRpbmcv
TWFrZWZpbGUKaW5kZXggMGY5NjU5NDA3OTY5LGQyMDlmN2E5OGI2Yy4uMWVkMDFlOTYwZDUx
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2JvbmRpbmcvTWFr
ZWZpbGUKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvYm9uZGlu
Zy9NYWtlZmlsZQpAQEAgLTEsOSAtMSw3ICsxLDEwIEBAQAogICMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAKICAjIE1ha2VmaWxlIGZvciBuZXQgc2VsZnRlc3RzCiAgCiAt
VEVTVF9QUk9HUyA6PSBib25kLWJyZWFrLWxhY3BkdS10eC5zaAogLVRFU1RfUFJPR1MgKz0g
Ym9uZC1sbGFkZHItdGFyZ2V0LnNoCiArVEVTVF9QUk9HUyA6PSBib25kLWJyZWFrLWxhY3Bk
dS10eC5zaCBcCisrCSAgICAgIGJvbmQtbGxhZGRyLXRhcmdldC5zaCBcCiArCSAgICAgIGRl
dl9hZGRyX2xpc3RzLnNoCiArCiArVEVTVF9GSUxFUyA6PSBsYWdfbGliLnNoCiAgCiAgaW5j
bHVkZSAuLi8uLi8uLi9saWIubWsK

--------------PnZdDX0mbgnHJpzmr15LlbVj--
