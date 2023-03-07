Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D94BA3E
	for <mptcp@lists.linux.dev>; Tue,  7 Mar 2023 17:41:58 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id p16so8314939wmq.5
        for <mptcp@lists.linux.dev>; Tue, 07 Mar 2023 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678210917;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQreL2ynISz2UoL0yM6ntcNSjBiJNevhmpJnIe8wRFY=;
        b=Ft7RXX6TkT73Si/8Ktw10WSmiWsyiQQ3PYrbJtwXQjTObLfg9i8eVGToux/ToyUsP4
         qftg2mRIjsoPd+V9X0Nt09KsOmB6zFHAqATFnBvg9K5xYsYl6SCe3XRUJMsKPKiwOEAV
         2EN0KgyycB1t8Nynyxy/g8EGNlRCV6KN85qCKnQ3uVJNm6LuCWmmHldJUHdkiFHPudmP
         u4SU+EpoGIgFQxPQiAMeiiDSOd0OHlfXJ7xpfqI9NdHUrXWNdDVJjLnCWW9r7QgpKqm+
         6DWKmJvNvre23qTReJBOR+y2wfgc0ymJUnJ4Luq91GQv4OVcjeqhLWjGopCMj/az3BV5
         PUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210917;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQreL2ynISz2UoL0yM6ntcNSjBiJNevhmpJnIe8wRFY=;
        b=z//ZCL0woVbLdbVpiS1T+p7SV7DpB9nxzppNsokxbmeS3Ox/m/4tArpdKnPUOCDAJw
         nH8Om4RqRutOfLb0GlU6CjSJ74jcGPzbNBR5RflkLG+2OhrhlEuE4BAlT8fQpKOrhfL+
         jfsRTEramh8V/6vbhn42Ftc5h3EQEhJpcw1y3l8przvIAezX75ux7Pgo8ke9r0RqR0iz
         EsuS3rz5hLTe3GqU5+oENa7zJ/M+Cyi8Tu9dNV6g/Pd6Lgp+TPXeQs/Ux8M1sCC3LGuG
         yOcVTsUGW1C98TWdHT7f0rm0jnY/FgfpeqEoFVdAZPi55Mt8+4t5ek3HBfVyHklRqlZB
         Mdog==
X-Gm-Message-State: AO0yUKW6F1mpuEbjM9sPR8N/HdpuW0q0mcUjBt0oS5xfFhNm9rKOxhKz
	EJhu9xQPJ1p0F2Wo5Wl8TYHR3/IygAG2lEDfFx8Bhg==
X-Google-Smtp-Source: AK7set8T4vmAfSKT4Uz0XciozaXDZrPyT4XdGKZJhP2ZlXNx/5tj9umEB5+JvuD3eVAFdyoHVf3/nA==
X-Received: by 2002:a05:600c:1547:b0:3eb:3104:efe7 with SMTP id f7-20020a05600c154700b003eb3104efe7mr13448361wmg.23.1678210917141;
        Tue, 07 Mar 2023 09:41:57 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c308900b003dfe5190376sm13374024wmn.35.2023.03.07.09.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 09:41:56 -0800 (PST)
Message-ID: <589d3e73-007a-92d9-c80d-1ba32dbd40fe@tessares.net>
Date: Tue, 7 Mar 2023 18:41:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next 0/2] mptcp: a couple of cleanups
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1678122760.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1678122760.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/03/2023 19:30, Paolo Abeni wrote:
> After the recent fixes we have both a good changes and some
> needs to simplify subflow_syn_recv_sock().
> 
> A couple of patches in that direction, also addressing a long
> standing feature issue.

Thank you for the patches!

Now in our tree (feat. for net-next):

New patches for t/upstream:
- a8d0495b5733: mptcp: avoid unneeded address copy
- 7526f37142a5: mptcp: simplify subflow_syn_recv_sock()
- Results: c26d7d0e4343..6f879388dfd8 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230307T173437

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
