Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C381361
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 16:27:38 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so2474961wmr.1
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=uIbOPq0O424khPcnjJs3Rf5IHsbUdPJ3oT7Ob9q+qUw=;
        b=xnE6XzfGM38fYXnSRjdhtn144pE/xLcbpsAtEl1cf4P5jyTUt6QFwmSSqAqR8mEKAb
         JBE79QmwnUlACaIrjEoKa+LOP7aoM4fy9X5CcrhYwrxuTgkmQMi1nrnYgiWzAx7ie2e0
         2BxvruluOYodH5jLbQds+ePaFoKLyET2iZMR/Dw5XakpMxehXnXFZuCgDPIpMvtFb+hJ
         YI5671CA816V5Ru0IziVANH2YKQrmjj8DGF+5WldqRcldkFqJP3KjgTVrF80s3hLmLie
         0sQ1lRNviic7WrZHqU/bsQIYz7kNK1d/wEABYitImb76DunxmFCTrECWCVuGtVqNCj+c
         DEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uIbOPq0O424khPcnjJs3Rf5IHsbUdPJ3oT7Ob9q+qUw=;
        b=DfdhSze/YEMKGl0mbnIWclcjewj5RFSGJS2mCFwQlJ5NQg6Q2VWJ1wwRwF19TtCzRh
         zIGsrSBtc6NcSxYu1ZCksjakP/1VCTnxK3oNJzBPG2yo4F2qogc/DvIQVW1rEp8J3QKD
         UpGWc30s3na6bl3BwDiqY8DuvM2jk8MtfHjQe0gk8Qxz+qLh/D2t5eidaO2bPfn4NwHy
         EfiaHO1uvxVm5h+QSvW9yBcvgINhSvkVJF7kIFKIcDNTM/I9D0FJfSdFOGnN3Yhjynru
         3b5aTQcBxm69Es97SnMHtg4VBKaPje/zlaM4KRg/Q6Ob81h2sry/rf1qnrkyL8Jd9SNY
         vV5w==
X-Gm-Message-State: AOAM533JJMniSvFzlrBs+AjiNaqSWU1sgdJzNBawr2kAkhiTu8dEDNuE
	l9djpB7Bby1PK3O0K47HmuBVkfzbOz6WOv5j
X-Google-Smtp-Source: ABdhPJxf4lFeLCX7/Y+rjR74XFis3mQ6gk70J8nMYq31Kr/Ww5RbNwJJwzMJ/+5oPT1UtiGrkkQE/A==
X-Received: by 2002:a05:600c:3542:b0:394:6e2f:ffa2 with SMTP id i2-20020a05600c354200b003946e2fffa2mr17706445wmq.132.1652718456785;
        Mon, 16 May 2022 09:27:36 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c348400b003942a244ec4sm10563015wmq.9.2022.05.16.09.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 09:27:36 -0700 (PDT)
Message-ID: <e1b5d2cc-1b33-90d6-7d99-27f8a4673eaf@tessares.net>
Date: Mon, 16 May 2022 18:27:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add sched in mptcp_sock"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <550c72ef0be9d4c25874c997370dbe541d2b28fd.1652667282.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <550c72ef0be9d4c25874c997370dbe541d2b28fd.1652667282.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 16/05/2022 04:16, Geliang Tang wrote:
> Keep the alignment of members of mptcp_sock in bpf_tcp_helpers.h as the
> same as the alignment of mptcp_sock in net/mptcp/protocol.h.

Thank you for the patch, I didn't know you were following this
alignment, fine for me.

- 99c3f5a71174: "squashed" in "mptcp: add sched in mptcp_sock"
- Results: c53189ad917e..fb1b9f5009c4 (export)

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220516T162639

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
