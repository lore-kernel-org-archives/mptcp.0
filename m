Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A17E7
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655743601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dhmp0en1Fo20Ala+h4qiGgPkOF2kd+/ACWIvpdaMDeY=;
	b=TUR8xoNgoCBIYA4H1B5wEau2Yw1jmE7WEf5P2F5h8+n+BsKGIQ8rs+/R83yuTRnJZ39PQt
	9EX1iOTXGwn4hKbmQJxa/P1cCTYS/omsLLtFfxtD2QBGv7oQ18LL9roCwLWE3kuc/a/2j+
	4jskohd0fIaaXt1oDy625zJH7/Wntz8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-yJSUXMd2OOKSwIP9o1cpzQ-1; Mon, 20 Jun 2022 12:46:39 -0400
X-MC-Unique: yJSUXMd2OOKSwIP9o1cpzQ-1
Received: by mail-wm1-f70.google.com with SMTP id r4-20020a1c4404000000b0039c8f5804c4so87362wma.3
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 09:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Dhmp0en1Fo20Ala+h4qiGgPkOF2kd+/ACWIvpdaMDeY=;
        b=Ob0vkzJudhLLzVqxbjJ4RSv+a0C05aKuF57Qg4RY/ExVf+FMXy9ZLVbg6e76ERApS3
         qNRacvt9BGSJmDzL97bPhcQnNcr6iC2Fz/zaFyTqLvSKsfw0dV0naPqraU4kxcEZeOxR
         oX5ol16A+kleQy9/JLfEaTqVFxmpYupaLfhNP2bauCfyHu/jyum6OplK2Kxp+kphB8xF
         YBqZAG6ziZXMWd0BXgZbwNHA9NuH8aFCXkqlbIsZ1TFzO2hpNWjtkf69E+ZgDk37QMXO
         ZkhEdjrDCdPsxudQEGa7UCU/i0jgkP5GHT7H9WeicmYxf9DUlNe9S0/U24l9EGYiX2qk
         1sBA==
X-Gm-Message-State: AOAM533hqU4MaUBjHtO7ZQtp5iFK9pysh7h4JF1Ej+Bn2qYJZ2tNeXxw
	63ockpEZAuShMDiVTftYWR1clL+ooxSCbSbdfl8Rj2iYcYhRy6KfJmxreYP21/cyPt6B5wqG/bW
	2JHca0mrVuKvtvGjq9ipAtF6Qd8jRXzZTdEA3jqY/l0d5Qo+GLTiFmHxk1Gziff1p
X-Received: by 2002:a05:600c:1906:b0:39c:7f6c:ab3e with SMTP id j6-20020a05600c190600b0039c7f6cab3emr35554506wmq.205.1655743598650;
        Mon, 20 Jun 2022 09:46:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPNTT6Rr0B0B1q/nPU6CO/CnL1S70GS56zqNJmGkqofXsA/QKLf/I0pK2/fWG8B8lch0aBLQ==
X-Received: by 2002:a05:600c:1906:b0:39c:7f6c:ab3e with SMTP id j6-20020a05600c190600b0039c7f6cab3emr35554486wmq.205.1655743598383;
        Mon, 20 Jun 2022 09:46:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id c5-20020adffb45000000b0021b91d1ddbfsm2512818wrs.21.2022.06.20.09.46.37
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:46:38 -0700 (PDT)
Message-ID: <11ee2e3c17ef70255be80c87406178a9fa4e4eec.camel@redhat.com>
Subject: Re: [PATCH net-next v3 1/3] mptcp: never fetch fwd memory from the
 subflow
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 20 Jun 2022 18:46:37 +0200
In-Reply-To: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655741931.git.pabeni@redhat.com>
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655741931.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2022-06-20 at 18:19 +0200, Paolo Abeni wrote:
> The memory accounting is broken in such exceptional code
> path, and after commit 4890b686f408 ("net: keep sk->sk_forward_alloc
> as small as possible") we can't find much help there.
> 
> Drop the broken code.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

This is actually a "v2" ;)

The only change is the new patch 3/3 - I even kept the obsolete comment
after the commit message in patch 1/3 :)

/P

