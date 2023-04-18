Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4322573
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 20:33:37 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id q5so16115032wmo.4
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681850015; x=1684442015;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9hFcZJhZ07WprbQJnJJgnPU1N4qEuZZbUhvjAkn5W8=;
        b=YnrHqW8tf6Q5XYMLVbVDoT1gj6w4jvgm71Go4q3VbsHs7H8ikhJEyFt0qO5/Lxo4sL
         w8r0FaBvhmRS4F4NcPD9m+gfsjgrbMk7iJwC2F08nADcsE3K4iyJmbr1NYHXNLgtl9fv
         PYU3zzmCFwSVYuFiysQ6d5UHMau9btzUfP4UL+k1/RjJ4WNytVunbgSeaKP6sN6uDb70
         0GXEZoM10ySYd02BgYN0Q0xoK50rAglcT6x2O/yOZC62clFeoIVLSU2IATun4Sk2a80F
         Q68ZgILIQYemNKGUaMTQcSrVEiTZQyvqgNb2ABvRNRdeFpNOZfgaXc3xQIIzhV/jsHZL
         vSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850015; x=1684442015;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s9hFcZJhZ07WprbQJnJJgnPU1N4qEuZZbUhvjAkn5W8=;
        b=i6qKZ/Jz421n4nxmgCdpuR7OnyA4mcL5H4XQJLWAF7ybFghTxPBvu1CxkXJZlLQSsD
         KH/RrMNe6VPUS0ZCchqgF23+fjPdMxrgsbLCh/715LkGtVi6EGLLZKcGpp73PLaUI2yW
         CMcWJsu36Ki1XNAEzOGNDgVjp4d1Jd+HNefxcTJq5V/gkuhAo8kGR1HjotB5aU0I5LF3
         7tfxz02ZrL1r+FrrTIJLWP0/AZVToZanpkRZBQoM/DWaMd/vlvURUwX069DvS5s9Ae6/
         q9dcSQVviGwgL/Aak4lKjZ9fEIvAZ8q7Ng4DX/uH9YRItwk6/d3YFaGJX0vow1UwncKS
         V68g==
X-Gm-Message-State: AAQBX9eabj978bwyIXo0ylbFZHThTFsWKfaaZaZf7z2pWDbwZJhOC7yl
	acaQ0HacNZLFZjayJauFxMwAe0g0nXmyNzK+SCk7+A==
X-Google-Smtp-Source: AKy350Z/0cITPHy0YBPKMYQGqNM1YioK6dIwOZqk8D9Sm9Vn6io88RVEkEHGKE2W+ImDSXzs+SlO1g==
X-Received: by 2002:a7b:c45a:0:b0:3f1:70e6:df66 with SMTP id l26-20020a7bc45a000000b003f170e6df66mr8297114wmi.36.1681850015310;
        Tue, 18 Apr 2023 13:33:35 -0700 (PDT)
Received: from [127.0.0.1] ([77.243.191.45])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003f1738e64c0sm29494wmq.20.2023.04.18.13.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 13:33:35 -0700 (PDT)
Date: Tue, 18 Apr 2023 22:33:34 +0200 (GMT+02:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Message-ID: <af85e467-8d0a-4eba-b5f8-e2f2c5d24984@tessares.net>
In-Reply-To: <20230418185730.40775-1-martineau@kernel.org>
References: <20230418185730.40775-1-martineau@kernel.org>
Subject: Re: [PATCH mptcp-next] MAINTAINERS: Resume MPTCP co-maintainer role
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <af85e467-8d0a-4eba-b5f8-e2f2c5d24984@tessares.net>

Hi Mat,

18 Apr 2023 20:57:41 Mat Martineau <martineau@kernel.org>:

> I'm returning to the MPTCP maintainer role I held for most of the
> subsytem's history. This time I'm using my kernel.org email address.

Welcome back! :-)

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thank you for the patch! Do you want to send it to netdev directly?

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
