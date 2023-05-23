Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932E91F950
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 15:31:35 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f603d4bc5bso28228825e9.3
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684855894; x=1687447894;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjiGyguiEZ9kBx3jjjdalNwCPc5zOmNh5CPpWxe1vBk=;
        b=qS22CsJN8vJ6MhzULrVkCOL9vaMR6vRI62bJHTPxIVp4XyFcyP1nNJe/qHrBXqZnjD
         0KQFwgHVhaR9W8XTsk2asiRLrucGmUwA8LTzeuRjJhUlojZABStC48xqH/UgevRdPZSf
         kPEF9n4QOatvdsBW/O73+13uoD0LPODWt/4Civjx5lhEovfuiRRzNTyMShIjny04dBAy
         o0QpMUaH3WoB6zhnHKG3n5SHci0PoqkojiVxiMXKYlxjoMxtFfslJLSd+O9EOIRJaGb0
         kT8ZMaBxs2c2jr0V7Z5CWn/P8XF0PYAPQ9CdPgkiwfH5gTYPek9pGUAikU2ocefF0IeW
         42dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855894; x=1687447894;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjiGyguiEZ9kBx3jjjdalNwCPc5zOmNh5CPpWxe1vBk=;
        b=l35WrJqUEl+MGAxwLyBQRTiVMs0JMe5esDgSXgTcKQIb1ee/D6bDcH28M9mUygLPuD
         eW5PHP1JObXRFsTaWXFcwOpsnb7IrKa54V4lXx5LtubcOttaaldVKsDhKsFdAbW5EdUW
         8qNakhFvUE2N1BKS2mFCQr9l4oX4ridpmFJb0gdqnS0jjtTEOxQ5CJJpc/Rhq9JSBMx8
         gFvB9Lid/ys4la6i/OZtm5aUPAEZAgJHIYEiLxzVOV3cKH/BLlsacXQtiXMGjx0xEDQW
         S6THY3lyPNi02fDA6yx30OgAUpuHIKU6lPfLUF8xDs0rm9a9+4o0SPh6ccBe2OsCED/G
         88uw==
X-Gm-Message-State: AC+VfDz5HgqaJpOEhkC1+L6QTkerjMTtGeSgivFUk1rdXDsk9SiP1jkR
	i3U3GcnvdodxVHgepWPNT8IaR8arIFqa4NTrZiWfAFxi
X-Google-Smtp-Source: ACHHUZ4NwMU1Hn8g4O5QgsLvJwXHA9USFKcm47a1rvPS9RiA0GZDU5ohio8jne9TTrqvZlPiZWzq5A==
X-Received: by 2002:a1c:4b0b:0:b0:3f6:67a:8826 with SMTP id y11-20020a1c4b0b000000b003f6067a8826mr4798899wma.25.1684855893806;
        Tue, 23 May 2023 08:31:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d? ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c00cf00b003f4268f51f5sm12255708wmm.0.2023.05.23.08.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 08:31:33 -0700 (PDT)
Message-ID: <ee0d7408-4b5c-857f-10eb-02cb1162b5db@tessares.net>
Date: Tue, 23 May 2023 17:31:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v2 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1684763196.git.pabeni@redhat.com>
 <7caed74486cdeec1c929cd2b62d3f04dd67db46e.1684763196.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7caed74486cdeec1c929cd2b62d3f04dd67db46e.1684763196.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/05/2023 15:56, Paolo Abeni wrote:
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Do you mind motivating the addition of this new socket option? :)

Also, it is not clear how we manage the different size for struct
tcp_info and struct mptcp_subflow_addrs but I will look at that in more
details later.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
