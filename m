Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5F2F20
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 14:49:38 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so3466507wmq.3
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=VM/xURqC5Jt7vcdxFvq4vdWz7/L+rC6OEgNKlLuRAnI=;
        b=VJUXKYS+HrwUJQFLOI4IkLa607y1dLmwDryDLGNR9solh0+7Z70nZZv/S6nj+V2i05
         Fpc3CsCcTXPBh5gy8Xn+b9ja9i3xF0i5mOEIzZpUxOVBIDlLCR+P3PZYJquzowa6osIY
         JKfVjdJYHxcVk0f1nc/nTYUtRmlvC2cKqG90/CRFaSBZZqsRsIAROn1xGEWcOYBwL7P2
         MDNUGjw6aY0vSporV5zOz4Z+85NILkM6/1lVjiBkGU16ZGzjTNScuFwFAJBZmwJR3ZRY
         xhtPraCErD0KFWycVKBnSL8y64TZOuV9LOykct9uO1HavKSlopsDmhB6+6auAt+d0mDt
         hdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=VM/xURqC5Jt7vcdxFvq4vdWz7/L+rC6OEgNKlLuRAnI=;
        b=7yOhEUZAbRgipUdu/TeunB2JTkBYPvyxbIY3owKK3dsafzo+usVtCjdwRYy/UQ4g8K
         nQXOr0FwNu2uh/8nCdL3aG51PtFv5H+JbgwFuse9vocTclUZgP1oSZdqF7leA8gTFey0
         LSqEE/ma8dMomoBG7/Jc8eHtq9Xzf2iwFl/ytYfR93Y89MmtTVcvZ+eubvoIhqMIz5Qw
         KcssunT9RSymFNsq4qX4DOSoTbXuZ5+IPV5a5mrqCJZ/7J1Ralu2/GFO/DHAHzxApRPv
         80E/ON8dQqU9f00iXuCgMUaxppl4wESreQOp8X03+i8tcsLve9kPykHgCW8CdbElzIve
         hkqQ==
X-Gm-Message-State: AOAM532g92d42STThnPAzqRCN1r/scI0ULRkzy3gphTrHR+c2g39gxMB
	ncBITAaPYGp3oYQcu1dQv7supg==
X-Google-Smtp-Source: ABdhPJx56ja1pohUWb0OO6+7WSjOmNDjTiPvSz2YoOeGgg2Wpk0VAAOlfl81molqfjVFTYTTv2TKXw==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr2507501wmq.13.1644504577345;
        Thu, 10 Feb 2022 06:49:37 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p32sm1623290wms.1.2022.02.10.06.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:49:36 -0800 (PST)
Message-ID: <53b45b01-0ef1-389b-7d84-75f2de192010@tessares.net>
Date: Thu, 10 Feb 2022 15:49:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] mptcp: constify a bunch of of helpers
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <8d4babebbd177de911a30c256b0b68742b09f607.1644400229.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8d4babebbd177de911a30c256b0b68742b09f607.1644400229.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 09/02/2022 10:50, Paolo Abeni wrote:
> A few pm-related helpers don't touch arguments which lacking
> the const modifier, let's constify them.

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

- b50db6b53771: mptcp: constify a bunch of of helpers
- Results: 7de35173cc33..bfba92ddd537

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220210T144922
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
