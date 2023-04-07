Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A25C2CA
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 09:23:38 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id sg7so7149594ejc.9
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680859417;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyV4ImR2YOf7uAXb7XAsaF6SGEbojchBWSG1ZF6Zy+8=;
        b=1JqG6cSVAVwWgJ1F1IbPhiX4pXNIT/Ptq954cRosDirFVDaeI2gjUgwG/kqffFJn2q
         PFarJCTdQgtxKs7eOL32ec6AiY9jfvzjLAOcHovggeFQhB8xV813aVNolAs9w87vm0JQ
         gi2xgrFgO1K3ltda+Q74L/gRY8i4VHxdtg+33AZPvp6CEPmATyHDLbsVp6pyR/MMhtMa
         injOcWah202fvYEbYPXMxNnBciM6QzqqsIFTNr3BaQ/3PLHpFrDoTA4Yn14dZ3M5AfNZ
         XPZVNZJWLykRd6QTNtp7TGMilL43HFxR6R1skABTf6qhLAxyPqTbdLrI3Ztij4ZKptbq
         VBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680859417;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyV4ImR2YOf7uAXb7XAsaF6SGEbojchBWSG1ZF6Zy+8=;
        b=0tXkHLw7rY3oO613tV4IvhVy1AiOEUc3uRaH12tNKw4s7Zq43oN1uZsFU2frYKzHO1
         35iRailrsBp4CnR8s/P3GEef7z5kouT3HEKavOBA/+0BiVyXL3ZpaIrn1gvGR28kE5nX
         qKq57ViMAZ0LOknA5XoA7zCJVFFztZVC0cmX3lgQj74NzpUn+CgJKJfc1JDo3gTFfxFo
         J1VjHnhPOHd6a94paT6/z9Q/vm9zvBEl5wRtEcak9ImYzYRugN+taUNTISGRRoac+B5q
         lUsUa253gjsD/13I4L48h6txJlg7hj4KOXIr2KwRQydXQRcrk43g2ejq2Is/bkfkkKhC
         J81Q==
X-Gm-Message-State: AAQBX9f2TArG0+2QoifKU3bU47lwZPw47tSBTbxMyh2kcfMD+2S4HeI5
	AFveqDIFBXlJDIk/Vy47eVztraMErtTQWT9A2CynfQ==
X-Google-Smtp-Source: AKy350bAYdqh8YPL2JNCvlOk3b9erS0vFam0C2HGIAPwE+FHAf+zIbYKRYQj9mmDhOQ1QYaBAmieKQ==
X-Received: by 2002:a17:907:d50d:b0:870:b950:18d4 with SMTP id wb13-20020a170907d50d00b00870b95018d4mr1723285ejc.5.1680859416919;
        Fri, 07 Apr 2023 02:23:36 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090695c300b0092f38a6d082sm1811167ejy.209.2023.04.07.02.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 02:23:36 -0700 (PDT)
Message-ID: <a5f9dfbe-5319-6836-2a7d-9ca33c02b05c@tessares.net>
Date: Fri, 7 Apr 2023 11:23:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH mptcp-net] Squash-to: "mptcp: fix accept vs worker race"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <a0b61938d72605d35cd4d988ac533b88f45d7f89.1680810015.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a0b61938d72605d35cd4d988ac533b88f45d7f89.1680810015.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 06/04/2023 21:41, Paolo Abeni wrote:
> Avoid the ugly timeout hack, we can rely simple on
> the in_accept_queue flag.

Thank you for this patch!

Indeed cleaner and good idea to have renamed the function.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Just applied:

New patches for t/upstream-net and t/upstream:
- e64fe31d095e: "squashed" in "mptcp: fix accept vs worker race"
- Results: db0ea133bb6b..38f9e8a70d76 (export-net)
- Results: 930f9c85e067..016e68a14412 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230407T092153
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230407T092153

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
