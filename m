Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE11376
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 09:48:33 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id g7so15074145edb.5
        for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 01:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=S2UKdmsY0vPGMLWjGnnPqcwul/HmBRyyF11ZPrl2u4Q=;
        b=hzXxPMmQYaEEi+Rg2PY2s5x7vBFN2Grq+G99Dz8owQpM5sq4Jg/KxZs3BI19FKht/b
         9pImbfiT4kDf+AF/mLs+dq4dl4BoDbHNxM9fzlZuge4kd+WxxOosIUs5ZAydGAa4UG7E
         Dki0i6JtIJnTIYfyfZkYTA9BxHk/duz0o9hbMzSJE+8TCmusOWj2kWxwH34EIus/p5FH
         EhB9De1ekSCMzi9EEjjX+UAPRTN3ZySAH/nwxIQa3/HSJsDZcR7Vz/PRimDC3UnXSqgs
         jV5kj2coXwWM1exP8wFCe8AeoslHku6mFlFMWkiYBTExO3jfnQfQfVHXUwnbnKARocdF
         hgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S2UKdmsY0vPGMLWjGnnPqcwul/HmBRyyF11ZPrl2u4Q=;
        b=J9VHDIPM749OS9KeLW5TdNsoCric7xmIDCkHnXR/ANt8ns5fdIHDpJkKs+CHtV/5Jj
         119NiSQeeYtbqmyRXwXEo9M2z7GM2xuLEaUsh4Y0Njlb+nd6pT9XK5Qr26iKjAL/Du0i
         oXmOCnXCYE4x2qKLybkSPDT5suX6idi8cYFWihgi6fFS4aUTlvxOgxolRNGGeoYqFoyn
         348pKBWMGNnCFOuf9F73JvhcmpYuz0IsyIVz7/amNowx2gkqzlrtruAdnbq1OG49MgI+
         yvubjWCEqnt6XFuiPjPiTt0lmmBSojseTrFw9Wx4rUE12IaPwVCy3FIyngShUwJMohi9
         X9JA==
X-Gm-Message-State: AOAM530nx+0B3Zyjs+mHPMGg2h9424XO6X52FT/1zkj+wAHVC2jUShoA
	+A3oWFup/2EPB8AsFJuUPs/VUGGEsMhOy2vj
X-Google-Smtp-Source: ABdhPJxVnW2YJW4nwONfQJUasXlaa4foWVcarDgz/hLzT83NCFP3LgOE8xahkysL1sQXVV82bxwQ1Q==
X-Received: by 2002:a05:6402:35cd:: with SMTP id z13mr3053465edc.149.1644918512180;
        Tue, 15 Feb 2022 01:48:32 -0800 (PST)
Received: from [10.120.18.9] ([84.17.46.7])
        by smtp.gmail.com with ESMTPSA id i6sm11621725eja.132.2022.02.15.01.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 01:48:31 -0800 (PST)
Message-ID: <e9b2ae4e-dbf7-d5d0-a498-9a369ff22ef9@tessares.net>
Date: Tue, 15 Feb 2022 10:48:31 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 mptcp-next 1/3] Squash-to: "mptcp: constify a bunch of
 helpers"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1644852970.git.pabeni@redhat.com>
 <9dee703e18b0981aa85abc45c35143411695d9c4.1644852970.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9dee703e18b0981aa85abc45c35143411695d9c4.1644852970.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 14/02/2022 16:38, Paolo Abeni wrote:
> There are a few more helpers that can be const-ified and I missed
> in the previous patch, just squash these change into there.

I just applied this patch which was already OK in v3:

- ef783d7d6771: "squashed" patch 1/3 in "mptcp: constify a bunch of of
helpers"
- Results: a9327cdfe5bf..7cf2ef8f7b27

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220215T094543
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
